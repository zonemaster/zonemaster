use Test::More;

use strict;
use 5.14.2;

use Zonemaster;
use Zonemaster::Nameserver;
my $datafile = 't/zone.data';
if ( not $ENV{ZONEMASTER_RECORD} ) {
    die "Stored data file missing" if not -r $datafile;
    Zonemaster::Nameserver->restore( $datafile );
    Zonemaster->config->no_network( 1 );
}

BEGIN { use_ok( 'Zonemaster::Zone' ) }

my $zone = new_ok( 'Zonemaster::Zone' => [ { name => 'iis.se' } ] );

isa_ok( $zone->parent, 'Zonemaster::Zone' );
is( $zone->parent->name, 'se' );

my $root = new_ok( 'Zonemaster::Zone' => [ { name => '.' } ] );
is( $root->parent, $root );

isa_ok($zone->glue_names, 'ARRAY');
is_deeply($zone->glue_names, [qw(i.ns.se ns.nic.se ns3.nic.se)]);

isa_ok( $zone->glue, 'ARRAY' );
ok( @{ $zone->glue } > 0, 'glue list not empty' );
isa_ok( $_, 'Zonemaster::Nameserver' ) for @{ $zone->glue };

isa_ok( $zone->ns_names, 'ARRAY');
is_deeply($zone->ns_names, [qw(i.ns.se ns.nic.se ns3.nic.se)]);
isa_ok( $zone->ns, 'ARRAY' );
ok( @{ $zone->ns } > 0, 'NS list not empty' );
isa_ok( $_, 'Zonemaster::Nameserver' ) for @{ $zone->ns };

isa_ok( $zone->glue_addresses, 'ARRAY' );
isa_ok( $_, 'Net::LDNS::RR' ) for @{ $zone->glue_addresses };

my $p = $zone->query_one( 'www.iis.se', 'A' );
isa_ok( $p, 'Zonemaster::Packet' );
my @rrs = $p->get_records( 'a', 'answer' );
is( scalar( @rrs ), 1, 'one answer A RR' );
is( $rrs[0]->address, '91.226.36.46', 'expected address' );

my $ary = $zone->query_all( 'www.iis.se', 'A' );
isa_ok( $ary, 'ARRAY' );
foreach my $p ( @$ary ) {
    isa_ok( $p, 'Zonemaster::Packet' );
    my @rrs = $p->get_records( 'a', 'answer' );
    is( scalar( @rrs ), 1, 'one answer A RR' );
    is( $rrs[0]->address, '91.226.36.46', 'expected address' );
}

$ary = $zone->query_all( 'www.iis.se', 'A', { dnssec => 1 } );
isa_ok( $ary, 'ARRAY' );
foreach my $p ( @$ary ) {
    isa_ok( $p, 'Zonemaster::Packet' );
    my @a_rrs = $p->get_records( 'a', 'answer' );
    is( scalar( @a_rrs ), 1, 'one answer A RR' );
    my @sigs = $p->get_records( 'RRSIG', 'ANSWER' );
    is( scalar( @sigs ), 1, 'one signature for A RR' );
}

ok( $zone->is_in_zone( 'www.iis.se', 'www.iis.se is in zone iis.se' ) );
ok( not $zone->is_in_zone( 'www.google.se', 'www.google.se is not in zone iis.se' ) );

my $net = Zonemaster::Zone->new( { name => 'net' } );
ok( not( $net->is_in_zone( 'k.gtld-servers.net.' ) ), 'k.gtld-servers.net is not in zone' );
ok( Zonemaster::Zone->new( { name => 'gtld-servers.net' } )->is_in_zone( 'k.gtld-servers.net.' ),
    'k.gtld-servers.net is in zone' );

if ( $ENV{ZONEMASTER_RECORD} ) {
    Zonemaster::Nameserver->save( $datafile );
}

done_testing;
