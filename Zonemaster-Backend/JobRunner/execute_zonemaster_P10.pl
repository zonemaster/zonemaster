use strict;
use warnings;
use utf8;
use 5.10.1;

use Data::Dumper;

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

unshift(@INC, $PROD_DIR."Zonemaster-Backend/JobRunner") unless $INC{$PROD_DIR."Zonemaster-Backend/JobRunner"};
require Runner;

Runner->new()->run($ARGV[0]);
