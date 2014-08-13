use strict;
use warnings;
use utf8;
use 5.10.1;

use Data::Dumper;
use DBI qw(:utils);
use IO::CaptureOutput qw/capture_exec/;
use POSIX;

local $| = 1;

my $connection_string = "DBI:Pg:database=zonemaster;host=localhost";
my $dbh = DBI->connect($connection_string, "zonemaster", "zonemaster", {RaiseError => 1, AutoCommit => 1});

my ($frontend_slots, $batch_slots) = (2, 4);

sub can_start_new_worker {
	my ($priority, $test_id) = @_;
	my $result = 0;
	
	my @nb_instances = split(/\n+/, `ps -ef | grep "execute_zonemaster_P$priority.pl" | grep -v "sh -c" | grep -v grep | grep -v tail`);
	my @same_test_id = split(/\n+/, `ps -ef | grep "execute_zonemaster_P$priority.pl $test_id " | grep -v "sh -c" | grep -v grep | grep -v tail`);
	
	my $max_slots = 0;
	if ($priority == 5) {
		$max_slots = $batch_slots;
	}
	elsif ($priority == 10) {
		$max_slots = $frontend_slots;
	}
	
	$result = 1 if (scalar @nb_instances < $max_slots && !@same_test_id);
}

my $start_time = time();
do {
	my $query = "SELECT id FROM test_results WHERE progress=0 AND priority=10 ORDER BY id LIMIT 10";
	my $sth1 = $dbh->prepare($query);
	$sth1->execute;
	while (my $h = $sth1->fetchrow_hashref) {
		if (can_start_new_worker(10, $h->{id})) {
			my $command = "/home/toma/perl5/perlbrew/perls/perl-5.20.0/bin/perl  /home/toma/TEMP/test_json_rpc/execute_zonemaster_P10.pl $h->{id} > /home/toma/LOGS/execute_zonemaster_P10_$h->{id}_$start_time.log 2>&1 &";
			say $command;
			system($command);
		}
	}
	$sth1->finish();

	$query = "SELECT id FROM test_results WHERE progress=0 AND priority=5 ORDER BY id LIMIT 10";
	$sth1 = $dbh->prepare($query);
	$sth1->execute;
	while (my $h = $sth1->fetchrow_hashref) {
		if (can_start_new_worker(5, $h->{id})) {
			my $command = "/home/toma/perl5/perlbrew/perls/perl-5.20.0/bin/perl  /home/toma/TEMP/test_json_rpc/execute_zonemaster_P5.pl $h->{id} > /home/toma/LOGS/execute_zonemaster_P5_$h->{id}_$start_time.log 2>&1 &";
			say $command;
			system($command);
		}
	}
	$sth1->finish();
	say '----------------------- '.strftime("%F %T", localtime()).' ------------------------';
	sleep (10);
} while (time() - $start_time < (15*60 - 15));

say "WORKED FOR 15 minutes LEAVING";
