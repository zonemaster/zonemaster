use Test::More;

use Zonemaster;
use Zonemaster::Nameserver;

my $datafile = q{t/old-bugs.data};
if ( not $ENV{ZONEMASTER_RECORD} ) {
    die q{Stored data file missing} if not -r $datafile;
    Zonemaster::Nameserver->restore( $datafile );
    Zonemaster->config->{no_network} = 1;
}

my @res = Zonemaster->test_method( q{basic}, q{basic01}, Zonemaster->zone(q{001.tf}));
is($res[0]->tag, q{HAS_GLUE}, 'Running single tests in Basic works.' );

if ( $ENV{ZONEMASTER_RECORD} ) {
    Zonemaster::Nameserver->save( $datafile );
}

done_testing;