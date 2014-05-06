use Test::More;

use Zonemaster;
use Zonemaster::Nameserver;

my $datafile = 't/consistency.data';
if ( not $ENV{ZONEMASTER_RECORD} ) {
    die "Stored data file missing" if not -r $datafile;
    Zonemaster::Nameserver->restore( $datafile );
    Zonemaster->config->{no_network} = 1;
}

my %res = map {$_->tag => 1} Zonemaster->test_module('consistency', 'iis.se');
ok($res{ONE_NS_SET}, 'One NS set');
ok($res{ONE_SOA_SERIAL}, 'One SOA serial');

%res = map {$_->tag => 1} Zonemaster->test_module('consistency', 'com');
ok($res{ONE_NS_SET}, 'One NS set');
ok($res{MULTIPLE_SOA_SERIALS}, 'One SOA serial');
ok($res{SOA_SERIAL}, 'SOA serial');

if ( $ENV{ZONEMASTER_RECORD} ) {
    Zonemaster::Nameserver->save( $datafile );
}

done_testing;