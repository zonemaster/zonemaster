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
use lib '/home/toma/REPOSITORY/zonemaster/Zonemaster/lib';
use Zonemaster;
use Zonemaster::Nameserver;
use Zonemaster::DNSName;

# Engine Modules
use ZonemasterDB::PostgreSQL;
use ZonemasterDB::CouchDB;

my $connection_string = "DBI:Pg:database=zonemaster;host=localhost";
my $dbh = DBI->connect($connection_string, "zonemaster", "zonemaster", {RaiseError => 1, AutoCommit => 1});

sub new{
	my($type, $params) = @_;
	
	my $self = {};
	bless($self, $type);
	
	if ($params && $params->{db}) {
		eval{
			$self->{db} = "$params->{db}"->new();
		};
	}
	else {
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

=coment
	my $command = 'perl -I/home/toma/REPOSITORY/zonemaster/Zonemaster-CLI/lib -I/home/toma/REPOSITORY/zonemaster/Zonemaster/lib /home/toma/REPOSITORY/zonemaster/Zonemaster-CLI/script/zonemaster-cli --show_module --level=INFO --lang=json --test=syntax ';
	print "$command\n";
	$command .= shell_quote($domain);
	my $zm_results = decode_json(`$command`);
	
	print Dumper($zm_results);
	
	foreach my $zm_result (@$zm_results) {
		$result = 'syntax_not_ok' if ($zm_result->{tag} ne 'ONLY_ALLOWED_CHARS');
	}
=cut

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
	
	my %pure_params = %$params;
	delete($pure_params{client_id});
	delete($pure_params{client_version});
	
	my $js = JSON->new;
	$js->canonical(1);
	my $test_params_deterministic_hash = md5_hex($js->encode(\%pure_params));
	
	my $query = "INSERT INTO test_results (params_deterministic_hash, params) SELECT ".
										"'$test_params_deterministic_hash' AS params_deterministic_hash, ".
										$dbh->quote($js->encode($params))." AS params ".
										" WHERE NOT EXISTS (SELECT * FROM test_results WHERE params_deterministic_hash='$test_params_deterministic_hash')";
#	print "query: $query\n\n";
	my $nb_inserted = $dbh->do($query);

	my $sth1 = $dbh->prepare("SELECT * FROM test_results WHERE params_deterministic_hash='$test_params_deterministic_hash' ");
	$sth1->execute;
	if (my $h = $sth1->fetchrow_hashref) {
		$result = $h->{id};
	}

	return $result;
}

sub test_progress {
	my($self, $test_id) = @_;
	
	my $result = 0;
	
	my $sth1 = $dbh->prepare("SELECT EXTRACT(EPOCH FROM (now() - creation_time)) AS t from test_results WHERE id=$test_id");
	$sth1->execute;
	if (my $h = $sth1->fetchrow_hashref) {
		my $time_from_test_start = ($h->{t}>60)?(60):($h->{t});
		$result = int($time_from_test_start/60*100);
	}

	return $result;
}

sub get_test_results {
	my($self, $params) = @_;
	my $result;
	
#	my $zm_results = read_file('/home/toma/TEMP/test_json_rpc/zm_results.json');
#	my $query = "UPDATE test_results SET results=".$dbh->quote($zm_results)." WHERE id=$params->{id}";
#	my $query = "UPDATE test_results SET results=".$dbh->quote($zm_results);
#	$dbh->do($query);

	my $sth1 = $dbh->prepare("SELECT * from test_results WHERE id=$params->{id} AND progress=100");
	$sth1->execute;
	if (my $h = $sth1->fetchrow_hashref) {
		my @zm_results;
		foreach my $test_res (@{decode_json($h->{results})}) {
			my $res;
			if ($test_res->{module} eq 'NAMESERVER') {
				$res->{ns} = $test_res->{args}->{ns};
			}
			$res->{module} = $test_res->{module};
			$res->{message} = "Messsage for $test_res->{module}/$test_res->{tag} in the language:$params->{language}";
			$res->{level} = $test_res->{level};
			push(@zm_results, $res);
		}
	
		$result = {
			id => $h->{id}, 
			params => decode_json($h->{params}), 
			results => \@zm_results,
			creation_time => $h->{creation_time},
		};
	}
	else {
		die "ERROR 001: Test not yet finished, check the progress";
	}
	
	return $result;
}

sub get_test_history {
	my($self, $p) = @_;
	
	my @results;
	my $query = "SELECT id, creation_time, params->>'advanced_options' AS advanced_options from test_results WHERE params->>'domain'=".$dbh->quote($p->{frontend_params}->{domain})." ORDER BY id DESC OFFSET $p->{offset} LIMIT $p->{limit}";
	print "$query\n";
	my $sth1 = $dbh->prepare($query);
	$sth1->execute;
	while (my $h = $sth1->fetchrow_hashref) {
		push(@results, { id => $h->{id}, creation_time => $h->{creation_time}, advanced_options => $h->{advanced_options} });
	}
	
	return \@results;
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
