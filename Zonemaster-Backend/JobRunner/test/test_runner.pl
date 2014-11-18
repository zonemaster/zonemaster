use strict;
use warnings;
use utf8;

use lib '/home/toma/PROD/zonemaster/Zonemaster-Backend/JobRunner';
use Runner;

my $r = Runner->new({ db => 'ZonemasterDB::CouchDB'});
$r->run('648390b633d671440378100c9d00bb95');