use strict;
use warnings;
use utf8;
use 5.10.1;

use Data::Dumper;
use DBI qw(:utils);
use IO::CaptureOutput qw/capture_exec/;
use POSIX;

local $| = 1;

use FindBin qw($RealScript $Script $RealBin $Bin);
FindBin::again();
##################################################################
my $PROJECT_NAME = "Zonemaster-Backend";

my $SCRITP_DIR = __FILE__;
$SCRITP_DIR = $Bin unless ($SCRITP_DIR =~ /^\//);

#warn "SCRITP_DIR:$SCRITP_DIR\n";
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

unshift(@INC, $PROD_DIR."Zonemaster-Backend") unless $INC{$PROD_DIR."Zonemaster-Backend"};
require BackendConfig;

my $JOB_RUNNER_DIR = $PROD_DIR."Zonemaster-Backend/JobRunner";
my $LOG_DIR = BackendConfig->LogDir();

my $perl_command = BackendConfig->PerlIntereter();

my $connection_string = BackendConfig->DB_connection_string();
my $dbh = DBI->connect($connection_string, BackendConfig->DB_user(), BackendConfig->DB_password(), {RaiseError => 1, AutoCommit => 1});

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

#TODO: read paths from config file
my $start_time = time();
do {
	my $query = "SELECT id FROM test_results WHERE progress=0 AND priority=10 ORDER BY id LIMIT 10";
	my $sth1 = $dbh->prepare($query);
	$sth1->execute;
	while (my $h = $sth1->fetchrow_hashref) {
		if (can_start_new_worker(10, $h->{id})) {
			my $command = "$perl_command $JOB_RUNNER_DIR/execute_zonemaster_P10.pl $h->{id} > $LOG_DIR/execute_zonemaster_P10_$h->{id}_$start_time.log 2>&1 &";
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
			my $command = "$perl_command $JOB_RUNNER_DIR/execute_zonemaster_P5.pl $h->{id} > $LOG_DIR/execute_zonemaster_P5_$h->{id}_$start_time.log 2>&1 &";
			say $command;
			system($command);
		}
	}
	$sth1->finish();
	say '----------------------- '.strftime("%F %T", localtime()).' ------------------------';
	sleep (10);
} while (time() - $start_time < (15*60 - 15));

say "WORKED FOR 15 minutes LEAVING";
