package Engine v0.0.1;

use strict;
use warnings;
use utf8;
use 5.14.0;

# Public Modules
use Data::Dumper;
use Encode;
use Net::DNS;
use Net::DNS::SEC;
use Net::DNS::Keyset;
use JSON;
use DBI qw(:utils);
use Digest::MD5 qw(md5_hex);
use String::ShellQuote;
use File::Slurp qw(append_file);
use Net::LDNS;
use Net::IP qw(:PROC);
use HTML::Entities;

use FindBin qw($RealScript $Script $RealBin $Bin);
##################################################################
my $PROJECT_NAME = "Zonemaster-Backend";

my $SCRITP_DIR = __FILE__;
$SCRITP_DIR = $Bin unless ($SCRITP_DIR =~ /^\//);

#warn "SCRITP_DIR:$SCRITP_DIR\n";
#warn "RealScript:$RealScript\n";
#warn "Script:$Script\n";
#warn "RealBin:$RealBin\n";
#warn "Bin:$Bin\n";
#warn "__PACKAGE__:".__PACKAGE__;
#warn "__FILE__:".__FILE__;

my ($PROD_DIR) = ($SCRITP_DIR =~ /(.*?\/)$PROJECT_NAME/);
#warn "PROD_DIR:$PROD_DIR\n";

my $PROJECT_BASE_DIR = $PROD_DIR.$PROJECT_NAME."/";
#warn "PROJECT_BASE_DIR:$PROJECT_BASE_DIR\n";
unshift(@INC, $PROJECT_BASE_DIR);
##################################################################

unshift(@INC, $PROD_DIR."Zonemaster/lib") unless $INC{$PROD_DIR."Zonemaster/lib"};
# Zonemaster Modules
require Zonemaster;
require Zonemaster::Nameserver;
require Zonemaster::DNSName;

unshift(@INC, $PROD_DIR."Zonemaster-Backend") unless $INC{$PROD_DIR."Zonemaster-Backend"};
require BackendConfig;
require BackendTranslator;

sub new{
	my($type, $params) = @_;
	
	my $self = {};
	bless($self, $type);
	
	if ($params && $params->{db}) {
		eval{
			say "using DB:[$params->{db}]";
			eval "require $params->{db}";
			die $@ if $@;
			$self->{db} = "$params->{db}"->new();
		};
		die $@ if $@;
	}
	else {
		eval{
			my $backend_module = "ZonemasterDB::".BackendConfig->BackendDBType();
			say "using BackendDBType:[$backend_module]";
			eval "require $backend_module";
			die $@ if $@;
			$self->{db} = $backend_module->new();
		};
		die $@ if $@;
	}

	return($self);
}

sub version_info {
	my($self) = @_;

	warn "Engine::1\n";
	
	return "Zonemaster ".$Zonemaster::VERSION.", Engine ".$Engine::VERSION;
}

sub get_ns_ips {
	my($self, $ns_name) = @_;

	my @adresses;
    my $res   = Net::DNS::Resolver->new;
	
	my $query4 = $res->search($ns_name, 'A');
	if ($query4) {
		foreach my $rr ($query4->answer) {
			push(@adresses, {$ns_name => $rr->address});
		}
	} 

	my $query6 = $res->search($ns_name, 'AAAA');
	if ($query6) {
		foreach my $rr ($query6->answer) {
			push(@adresses, {$ns_name => $rr->address});
		}
	} 
	
	push(@adresses, {$ns_name => '0.0.0.0'}) unless(@adresses);
	
	return \@adresses;
}

sub get_data_from_parent_zone {
	my($self, $domain) = @_;

	my @ns_names;
	my @result;
    my $res   = Net::DNS::Resolver->new;
	
	my $query = $res->search($domain, 'NS');
	if ($query) {
		foreach my $rr ($query->answer) {
			push(@ns_names, $rr->nsdname);
		}
		
		foreach my $ns_name (@ns_names) {
			push(@result, @{ $self->get_ns_ips($ns_name)});
		}
	} 
	
	push(@result, {'NOT FOUND' => '0.0.0.0'}) unless(@result);
	
	return \@result;
}

sub get_data_from_parent_zone_1 {
	my($self, $domain) = @_;

	my %result;
	
	my ($dn, $dn_syntax) = $self->_check_domain($domain, 'Domain name');
	return $dn_syntax if ($dn_syntax->{status} eq 'nok');

	my @ns_list;
	my @ns_names;
	
	my $r = Net::LDNS->new();
	$r->cd(1);
	$r->dnssec(0);
	my $p = $r->query($domain,"NS"); 
	
	if ($p) {
		foreach my $ns ($p->answer()) {
			push(@ns_names, $ns->nsdname());
		}
		
		foreach my $ns_name (@ns_names) {
			foreach my $ns_ip_pair (@{ $self->get_ns_ips($ns_name)}) {
				push(@ns_list, { ns => (keys %$ns_ip_pair)[0], ip => $ns_ip_pair->{(keys %$ns_ip_pair)[0]} });
			}
		}
	} 
	push(@ns_list, { ns => 'NOT FOUND', ip => '0.0.0.0'}) unless(@ns_list);
	
	
	my %algorithm_ids = ( 
		8 => 'sha1',
	);
	my @ds_list;
	
	my $r_ds = Net::LDNS->new();
	$r_ds->cd(1);
	$r_ds->dnssec(0);
	my $p_ds = $r_ds->query($domain,"DNSKEY"); 

	if ($p_ds) {
		foreach my $dnssec ($p_ds->answer()) {
			push(@ds_list, { algorithm => $algorithm_ids{$dnssec->ds('sha1')->algorithm()}, digest => $dnssec->ds('sha1')->hexdigest() });
		}
	}
	
	$result{ns_list} = \@ns_list;
	$result{ds_list} = \@ds_list;
	
	return \%result;
}

sub _check_domain {
	my($self, $dn, $type) = @_;

	if (!defined($dn)) {
		return ($dn, { status => 'nok', message => encode_entities("$type required") });
	}
	
    if ($dn =~ m/[^[:ascii:]]+/) {
		if (Net::LDNS::has_idn()) {
			$dn = Net::LDNS::to_idn(encode_utf8($dn));
		}
		else {
			return ($dn, { status => 'nok', message => encode_entities("$type contains non-ascii characters and IDN conversion is not installed") });
		}
    }

	if (length($dn) < 2 && $dn ne '.') {
		return ($dn, { status => 'nok', message => encode_entities("$type name too short") });
	}
	
	$dn =~ s/\.$// unless($dn eq '.');
	
	if (length($dn) > 253) {
		return ($dn, { status => 'nok', message => encode_entities("$type name too long") });
	}

	foreach my $label (split(/\./, $dn)) {
		if (length($label) > 63) {
			return ($dn, { status => 'nok', message => encode_entities("$type name label too long") });
		}
	}

	foreach my $label (split(/\./, $dn)) {
		if ($label =~ /[^0-9a-zA-Z\-]/) {
			return ($dn, { status => 'nok', message => encode_entities("$type name contains invalid characters") });
		}
	}
	
	return ($dn, { status => 'ok', message => 'Syntax ok' });
}

sub validate_syntax {
	my($self, $syntax_input, $is_internal_check) = @_;
	
	my @allowed_params_keys = ('domain', 'ipv4', 'ipv6', 'ds_digest_pairs', 'nameservers', 'profile', 'advanced');

	foreach my $k (keys %$syntax_input) {
		return { status => 'nok', message => encode_entities("Unknown option in parameters") } unless (grep { $_ eq $k } @allowed_params_keys );
	}
	
	if ( ( defined $syntax_input->{nameservers} && @{$syntax_input->{nameservers}} )) {
		foreach my $ns_ip (@{$syntax_input->{nameservers}}) {
			foreach my $k (keys %$ns_ip) {
				delete($ns_ip->{$k}) unless ($k eq 'ns' || $k eq 'ip')
			}
		}
	}

	if ( ( defined $syntax_input->{ds_digest_pairs} && @{$syntax_input->{ds_digest_pairs}} )) {
		foreach my $ds_digest (@{$syntax_input->{ds_digest_pairs}}) {
			foreach my $k (keys %$ds_digest) {
				delete($ds_digest->{$k}) unless ($k eq 'algorithm' || $k eq 'digest')
			}
		}
	}

	return { status => 'nok', message => encode_entities("At least one transport protocol required (IPv4 or IPv6)") } unless ( $syntax_input->{ipv4} || $syntax_input->{ipv6});

	if ( defined $syntax_input->{advanced} ) {
		return { status => 'nok', message => encode_entities("Invalid 'advanced' option format") } unless ( $syntax_input->{advanced} ne JSON::false || $syntax_input->{advanced} ne JSON::true );
	}

	if ( defined $syntax_input->{ipv4} ) {
		return { status => 'nok', message => encode_entities("Invalid IPv4 transport option format") } unless ( $syntax_input->{ipv4} ne JSON::false || $syntax_input->{ipv4} ne JSON::true || $syntax_input->{ipv4} ne '1' || $syntax_input->{ipv4} ne '0' );
	}
	
	if ( defined $syntax_input->{ipv6} ) {
		return { status => 'nok', message => encode_entities("Invalid IPv6 transport option format") } unless ( $syntax_input->{ipv6} ne JSON::false || $syntax_input->{ipv6} ne JSON::true || $syntax_input->{ipv6} ne '1' || $syntax_input->{ipv6} ne '0' );
	}
	
	if ( defined $syntax_input->{profile} ) {
		return { status => 'nok', message => encode_entities("Invalid profile option format") } unless ( $syntax_input->{profile} ne 'default_profile' || $syntax_input->{profile} ne 'test_profile_1' || $syntax_input->{profile} ne 'test_profile_2');
	}

	my ($dn, $dn_syntax) = $self->_check_domain($syntax_input->{domain}, 'Domain name');

	return $dn_syntax if ($dn_syntax->{status} eq 'nok');

	if ( ( defined $syntax_input->{nameservers} && @{$syntax_input->{nameservers}} ) || $is_internal_check ) {
		foreach my $ns_ip (@{$syntax_input->{nameservers}}) {
			my ($ns, $ns_syntax) = $self->_check_domain($ns_ip->{ns}, "NS [$ns_ip->{ns}]");
			return $ns_syntax if ($ns_syntax->{status} eq 'nok');
		}
		
		foreach my $ns_ip (@{$syntax_input->{nameservers}}) {
			return { status => 'nok', message => encode_entities("Invalid IP address: [$ns_ip->{ip}]") } unless (ip_is_ipv4($ns_ip->{ip}) || ip_is_ipv6($ns_ip->{ip}));
		}

		foreach my $ds_digest (@{$syntax_input->{ds_digest_pairs}}) {
			return { status => 'nok', message => encode_entities("Invalid algorithm type: [$ds_digest->{algorithm}]") } unless ($ds_digest->{algorithm} eq 'sha1' || $ds_digest->{algorithm} eq 'sha256');
		}

		foreach my $ds_digest (@{$syntax_input->{ds_digest_pairs}}) {
			if ($ds_digest->{algorithm} eq 'sha1') {
				return { status => 'nok', message => encode_entities("Invalid digest format: [$ds_digest->{digest}]") } 
					if (length($ds_digest->{digest}) != 40 || $ds_digest->{digest} =~ /[^A-Fa-f0-9]/ );
			}
			elsif ($ds_digest->{algorithm} eq 'sha256') {
				return { status => 'nok', message => encode_entities("Invalid digest format: [$ds_digest->{digest}]") } 
					if (length($ds_digest->{digest}) != 64 || $ds_digest->{digest} =~ /[^A-Fa-f0-9]/ );
			}
		}
	}
	else {
		my $r = Net::LDNS->new();
		$r->cd(1);
		$r->dnssec(0);
		my $p = $r->query($dn,"NS");
		if (!$p) {
			return { status => 'nok', message => encode_entities('Domain doesn\'t exist') };
		}
	}

	return { status => 'ok', message => encode_entities('Syntax ok') };
}

sub start_domain_test {
	my($self, $params) = @_;
	my $result = 0;
	
	my $syntax_result = $self->validate_syntax($params);
	die $syntax_result->{message} unless ($syntax_result && $syntax_result->{status} eq 'ok');
	
	die "No domain in parameters\n" unless ($params->{domain});
	
	$result = $self->{db}->create_new_test($params->{domain}, $params, 10, 10);
	
	return $result;
}

sub test_progress {
	my($self, $test_id) = @_;

	my $result = 0;

	$result = $self->{db}->test_progress($test_id);

	return $result;
}

sub get_test_params {
	my($self, $test_id) = @_;

	my $result = 0;

	$result = $self->{db}->get_test_params($test_id);

	return $result;
}

sub get_test_results {
	my($self, $params) = @_;
	my $result;
	
#	my $syntax_result = $self->validate_syntax($params);
#	die $syntax_result->{message} unless ($syntax_result && $syntax_result->{status} eq 'ok');

	my $translator;
    $translator = BackendTranslator->new;
#    $translator->locale('fr');
    eval { $translator->data } if $translator;    # Provoke lazy loading of translation data

    my $test_info = $self->{db}->test_results($params->{id});
	my @zm_results;
	foreach my $test_res ( @{ $test_info->{results} } ) {
		my $res;
		if ($test_res->{module} eq 'NAMESERVER') {
			$res->{ns} = ($test_res->{args}->{ns})?($test_res->{args}->{ns}):('All');
		}
		$res->{module} = $test_res->{module};
		$res->{message} = $translator->translate_tag( $test_res )."\n";
		$res->{message} =~ s/,/, /isg;
		$res->{message} =~ s/;/; /isg;
		$res->{level} = $test_res->{level};
		push(@zm_results, $res);
	}

	$result = $test_info;
	$result->{results} = \@zm_results;
	
	return $result;
}

sub get_test_history {
	my($self, $p) = @_;
	
	my $results = $self->{db}->get_test_history($p);
	
	return $results;
}

sub add_api_user {
	my($self, $params, $procedure, $remote_ip) = @_;
	my $result;
	
	my $allow = 0;
	if (defined $procedure && defined $remote_ip) {
		$allow = 1 if ($remote_ip eq '::1');
	}
	else {
		$allow = 1;
	}
	
	if ($allow) {
		$result = $self->{db}->add_api_user($params);
	}
}

sub add_batch_job {
	my($self, $params) = @_;
	my $batch_id;

	if ($self->{db}->user_authorized($params->{username}, $params->{api_key})) {
		$params->{batch_params}->{client_id} = 'Zonemaster Batch Scheduler';
		$params->{batch_params}->{client_version} = '1.0';
		
		my $domains = $params->{batch_params}->{domains};
		delete($params->{batch_params}->{domains});
		
		$batch_id = $self->{db}->create_new_batch_job($params->{username});
		
		my $minutes_between_tests_with_same_params = 5;
		foreach my $domain (@{$domains}) {
			$self->{db}->create_new_test($domain, $params->{batch_params}, $minutes_between_tests_with_same_params, $batch_id);
		}
	}
	else {
		die "User $params->{username} not authorized to use batch mode\n";
	}
	
	return $batch_id;
}


sub api1 {
	my($self, $p) = @_;
	
	return "$]";
}

1;
