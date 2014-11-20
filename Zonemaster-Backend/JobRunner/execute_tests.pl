use strict;
use warnings;
use utf8;
use 5.10.1;

use Data::Dumper;
use DBI qw(:utils);
use IO::CaptureOutput qw/capture_exec/;
use POSIX;
use Time::HiRes;
use Proc::ProcessTable;

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
my $polling_interval = BackendConfig->PollingInterval();
my $zonemaster_timeout_interval = BackendConfig->MaxZonemasterExecutionTime();
my $frontend_slots = BackendConfig->NumberOfProfessesForFrontendTesting();
my $batch_slots = BackendConfig->NumberOfProfessesForBatchTesting();

my $connection_string = BackendConfig->DB_connection_string();
my $dbh = DBI->connect($connection_string, BackendConfig->DB_user(), BackendConfig->DB_password(), {RaiseError => 1, AutoCommit => 1});


sub clean_hung_processes {
	my $t = new Proc::ProcessTable;

	foreach my $p (@{$t->table}) {
		if (($p->cmndline =~ /execute_zonemaster_P10\.pl/ || $p->cmndline =~ /execute_zonemaster_P5\.pl/) && $p->cmndline !~ /sh -c/) {
			if (time() - $p->start > $zonemaster_timeout_interval) {
				say "Killing hung Zonemaster test process: [".$p->cmndline."]";
				$p->kill(9);
			}
		}
	}
}

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

sub process_jobs {
	my ($priority, $start_time) = @_;

	my $query = "SELECT id FROM test_results WHERE progress=0 AND priority=$priority ORDER BY id LIMIT 10";
	my $sth1 = $dbh->prepare($query);
	$sth1->execute;
	while (my $h = $sth1->fetchrow_hashref) {
		if (can_start_new_worker($priority, $h->{id})) {
			my $command = "$perl_command $JOB_RUNNER_DIR/execute_zonemaster_P$priority.pl $h->{id} > $LOG_DIR/execute_zonemaster_P$priority"."_$h->{id}_$start_time.log 2>&1 &";
			say $command;
			system($command);
		}
	}
	$sth1->finish();
}

my $start_time = time();
do {
	clean_hung_processes();
	process_jobs(10, $start_time);
	process_jobs(5, $start_time);
	say '----------------------- '.strftime("%F %T", localtime()).' ------------------------';
	Time::HiRes::sleep($polling_interval);
} while (time() - $start_time < (15*60 - 15));

say "WORKED FOR 15 minutes LEAVING";
