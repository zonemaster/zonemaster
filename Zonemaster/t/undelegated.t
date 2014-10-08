use Test::More;

use 5.12.4;

use Zonemaster;
use Zonemaster::Nameserver;
use Zonemaster::Util;

###
my $datafile = 't/undelegated.data';
if ( not $ENV{ZONEMASTER_RECORD} ) {
    die "Stored data file missing" if not -r $datafile;
    Zonemaster::Nameserver->restore( $datafile );
    Zonemaster->config->no_network( 1 );
}
###

my $plain_p = Zonemaster->recurse( 'www.lysator.liu.se', 'AAAA' );
isa_ok( $plain_p, 'Zonemaster::Packet' );

Zonemaster->add_fake_delegation(
    'lysator.liu.se.' => {
        'ns.nic.se'  => [ '212.247.7.228',  '2a00:801:f0:53::53' ],
        'i.ns.se'    => [ '194.146.106.22', '2001:67c:1010:5::53' ],
        'ns3.nic.se' => [ '212.247.8.152',  '2a00:801:f0:211::152' ]
    }
);

my $fake_happened = 0;
Zonemaster->logger->callback( sub {
        $fake_happened = 1 if $_[0]->tag eq 'FAKE_DELEGATION';
    } );

my $fake_p = Zonemaster->recurse( 'www.lysator.liu.se', 'AAAA' );
ok( $fake_happened, 'Fake delegation logged' );
ok($fake_p, 'Got answer');
is( $fake_p->rcode, 'REFUSED', 'expected RCODE' );

Zonemaster->add_fake_ds( 'lysator.liu.se' => [ { keytag => 4711, algorithm => 17, type => 42, digest => 'FACEB00C' } ],
);

my $lys = Zonemaster->zone( 'lysator.liu.se' );
my $ds_p = $lys->parent->query_one( 'lysator.liu.se', 'DS' );
isa_ok( $ds_p, 'Zonemaster::Packet' );
my ( $ds ) = $ds_p->answer;
isa_ok( $ds, 'Net::LDNS::RR::DS' );
is( $ds->hexdigest, 'faceb00c', 'Correct digest' );

if ( $ENV{ZONEMASTER_RECORD} ) {
    Zonemaster::Nameserver->save( $datafile );
}

done_testing;
