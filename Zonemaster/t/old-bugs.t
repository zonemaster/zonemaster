use Test::More;

use Zonemaster;
use Zonemaster::Nameserver;

my $datafile = q{t/old-bugs.data};
if ( not $ENV{ZONEMASTER_RECORD} ) {
    die q{Stored data file missing} if not -r $datafile;
    Zonemaster::Nameserver->restore( $datafile );
    Zonemaster->config->no_network( 1 );
}

my @res = Zonemaster->test_method( q{basic}, q{basic01}, Zonemaster->zone( q{001.tf} ) );
is( $res[0]->tag, q{PARENT_REPLIES}, 'Running single tests in Basic works.' );

@res = Zonemaster->test_method( 'Syntax', 'syntax03', 'XN--MGBERP4A5D4AR' );
is( $res[0]->tag, q{NO_DOUBLE_DASH}, 'No complaint for XN--MGBERP4A5D4AR' );

my $zft_zone = Zonemaster->zone('zft.rd.nic.fr');
is(scalar(@{$zft_zone->ns}), 2, 'Two nameservers for zft.rd.nic.fr.');

if ( $ENV{ZONEMASTER_RECORD} ) {
    Zonemaster::Nameserver->save( $datafile );
}

done_testing;
