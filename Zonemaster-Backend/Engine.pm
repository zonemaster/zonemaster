 package Engine v0.0.1;

use strict;
use warnings;
use utf8;
use 5.14.0;

# Public Modules
use Data::Dumper;
use Net::DNS;
use Net::DNS::SEC;
use Net::DNS::Keyset;
use JSON;
use DBI qw(:utils);
use Digest::MD5 qw(md5_hex);
use String::ShellQuote;
use File::Slurp;

# Zonemaster Modules
use Zonemaster;
use Zonemaster::Nameserver;
use Zonemaster::DNSName;

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
		require ZonemasterDB::PostgreSQL;
		$self->{db} = ZonemasterDB::PostgreSQL->new();
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
	
	
	my @ns_list;
	my @ns_names;
	my $res_ns   = Net::DNS::Resolver->new;
	my $query = $res_ns->search($domain, 'NS');
	if ($query) {
		foreach my $rr ($query->answer) {
			push(@ns_names, $rr->nsdname);
		}
		
		foreach my $ns_name (@ns_names) {
			foreach my $ns_ip_pair (@{ $self->get_ns_ips($ns_name)}) {
				push(@ns_list, { ns => (keys %$ns_ip_pair)[0], ip => $ns_ip_pair->{(keys %$ns_ip_pair)[0]} });
			}
		}
	} 
	push(@ns_list, {'NOT FOUND' => '0.0.0.0'}) unless(@ns_list);
	
	
	my %algorithm_ids = ( 
		1 => 'sha1',
		2 => 'sha1',
		3 => 'sha1',
		4 => 'sha1',
		5 => 'sha1',
		6 => 'sha1',
		7 => 'sha1',
		8 => 'sha1',
		9 => 'sha1',
		10 => 'sha1',
	);
	my @ds_list;
	my $res_ds = Net::DNS::Resolver->new;

	$res_ds->dnssec(1);
	my $packet = $res_ds->query($domain, 'DNSKEY', 'IN');

	if (defined $packet) {
		my $keyset=Net::DNS::Keyset->new($packet) ;

		if ( $keyset ){
			my @ds=$keyset->extract_ds;
			foreach my $ds ( @ds ) {
				my ($dn, $num, $in, $type, $key_tag, $algorithm, $digest_type, $digest) = split(/\s+/, $ds->string);
				push(@ds_list, { algorithm => $algorithm_ids{$algorithm}, digest => $digest });
			}
		}
	}
	
	$result{ns_list} = \@ns_list;
	$result{ds_list} = \@ds_list;
	
	return \%result;
}

sub validate_domain_syntax {
	my($self, $domain) = @_;

	my $result = 'syntax_not_ok';

	my $dn = Zonemaster::DNSName->new( $domain );

	my @test_syntax01 = Zonemaster->test_method('Syntax', 'syntax01', $dn);
	print Dumper(\@test_syntax01);
	if ($test_syntax01[0]->{tag} eq 'ONLY_ALLOWED_CHARS') {
		my @test_syntax02 = Zonemaster->test_method('Syntax', 'syntax02', $dn);
		print Dumper(\@test_syntax02);
		unless (@test_syntax02) {
			my @test_syntax03 = Zonemaster->test_method('Syntax', 'syntax03', $dn);
			print Dumper(\@test_syntax03);
			unless (@test_syntax03) {
				my @test_syntax04 = Zonemaster->test_method('Syntax', 'syntax04', $dn);
				print Dumper(\@test_syntax04);
				unless (@test_syntax04) {
					$result = 'syntax_ok';
				}
			}
		}
	}
		
	return $result;
}

sub start_domain_test {
	my($self, $params) = @_;
	my $result = 0;
	
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

sub get_test_results {
	my($self, $params) = @_;
	my $result;
	
    my $translator;
    $translator = Zonemaster::Translator->new;
#    $translator->locale('fr-FR');
    eval { $translator->data } if $translator;    # Provoke lazy loading of translation data

    my $test_info = $self->{db}->test_results($params->{id});
	my @zm_results;
	foreach my $test_res ( @{ $test_info->{results} } ) {
		my $res;
		if ($test_res->{module} eq 'NAMESERVER') {
			$res->{ns} = $test_res->{args}->{ns};
		}
		$res->{module} = $test_res->{module};
		$res->{message} = $translator->translate_tag( $test_res )."\n";
		$res->{level} = $test_res->{level};
		push(@zm_results, $res);
	}

	$result = $test_info;
	$result->{params} = \@zm_results;
	
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
