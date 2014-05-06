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
    config->{no_network} = 1;
}
###

my $plain_p = Zonemaster->recurse( 'www.lysator.liu.se', 'AAAA' );
isa_ok( $plain_p, 'Zonemaster::Packet' );

Zonemaster->add_fake_delegation(
    'lysator.liu.se' => {
        'ns.nic.se'  => [ '212.247.7.228',  '2a00:801:f0:53::53' ],
        'i.ns.se'    => [ '194.146.106.22', '2001:67c:1010:5::53' ],
        'ns3.nic.se' => [ '212.247.8.152',  '2a00:801:f0:211::152' ]
    }
);

my $fake_happened = 0;
Zonemaster->logger->callback(sub { $fake_happened = 1 if $_[0]->tag eq 'FAKE_DELEGATION'});

my $fake_p = Zonemaster->recurse( 'www.lysator.liu.se', 'AAAA' );
is($fake_p->rcode, 'REFUSED', 'expected RCODE');
ok( $fake_happened, 'Fake delegation logged');

if ( $ENV{ZONEMASTER_RECORD} ) {
    Zonemaster::Nameserver->save( $datafile );
}

done_testing;
