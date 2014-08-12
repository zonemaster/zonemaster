#!/usr/bin/perl -w
use strict;
use warnings;
use LWP::UserAgent;
use JSON;
use Carp;
use Data::Dumper;

use lib qw/ lib /;

use Api;
use Environment;

my $api = Api->new(Environment->new);


# call version_info
print "Api version: " . $api->version_info . "\n";

# call validate_domain_syntax
foreach(qw/ abc ns1.nic.fr www.google.com googlecom google.com fknic.fr /){
	print 'Valid domain: ' . $_ . "\n" if $api->validate_domain($_);
	print 'Domain invalid: ' . $_ . "\n" unless $api->validate_domain($_);
}

# call get_ns_ips
foreach(qw/ abc ns1.nic.fr  www.google.com googlecom google.com /){
	my @ns_ips = $api->get_ns_ips($_);
	print 'Invalid domain name: ' . $_ . "\n" unless scalar @ns_ips;
	print "Ips for nameserver $_: @ns_ips \n" if scalar @ns_ips;
}

#call get_data_from_parent_zone
foreach(qw/ abc ns1.nic.fr  ns3.nic.fr nic.fr /){
	my @zone_info = $api->get_data_from_parent_zone($_);
	print 'Invalid parent zone: ' . $_ . "\n" unless scalar @zone_info;
	if (scalar @zone_info){
		print 'Information for parent zone: ' . $_ . "\n";
		foreach my $info (@zone_info){
			print $_ . ':' . $info->{$_} . "\n" foreach (keys %$info);
		}
	}
}

my $test_id = $api->start_domain_test({domain => 'fknic.fr'});

if(defined($test_id) && length($test_id)){
	print 'Test successfully submited, test id: ' . $test_id . "\n";
	my $test_progress;
	do{
		$test_progress = $api->test_progress($test_id);
		print $test_progress . '% current completion of test id: ' . $test_id . "\n";
		sleep(1);
	}while($test_progress ne '100');
	my $test_results = $api->get_test_results({id => $test_id, language => 'en'});
	my @results = @{$test_results->{results}};
	print 'test id:' . $test_results->{id} . "\n";
	print 'test date:' . $test_results->{creation_time} . "\n";
	print Data::Dumper::Dumper(\@results) if scalar @results;
}

my @results = $api->get_test_history({domain => 'fknic.fr'});
print Data::Dumper::Dumper(\@results) . "\n" if scalar @results;
@results = $api->get_test_history({domain => 'google.com'});
print Data::Dumper::Dumper(\@results) . "\n" if scalar @results;

#print $api->test_progress(12) . "\n";
#print $api->test_progress(15) . "\n";

#print $api->get_test_results(12) . "\n";
#print $api->get_test_results(15) . "\n";
