use Test::More;

use strict;
use 5.14.2;

use Giraffa;
use Giraffa::Nameserver;
# my $datafile = 't/zone.yaml';
# if ( not $ENV{GIRAFFA_RECORD} ) {
#     die "Stored data file missing" if not -r $datafile;
#     Giraffa::Nameserver->restore( $datafile );
#     Giraffa->config->{no_network} = 1;
# }

BEGIN { use_ok( 'Giraffa::Zone' ) }

my $zone = new_ok( 'Giraffa::Zone' => [ { name => 'iis.se' } ] );

isa_ok( $zone->parent, 'Giraffa::Zone' );
is( $zone->parent->name, 'se' );

my $root = new_ok( 'Giraffa::Zone' => [ { name => '.' } ] );
is( $root->parent, $root );

isa_ok( $zone->glue, 'ARRAY' );
ok( @{ $zone->glue } > 0, 'glue list not empty' );
isa_ok( $_, 'Giraffa::Nameserver' ) for @{ $zone->glue };

isa_ok( $zone->ns, 'ARRAY' );
ok( @{ $zone->ns } > 0, 'NS list not empty' );
isa_ok( $_, 'Giraffa::Nameserver' ) for @{ $zone->ns };

isa_ok( $zone->glue_addresses, 'ARRAY' );
isa_ok( $_, 'Net::LDNS::RR' ) for @{ $zone->glue_addresses };

my $p = $zone->query_one( 'www.iis.se', 'A' );
isa_ok( $p, 'Giraffa::Packet' );
my @rrs = $p->get_records( 'a', 'answer' );
is( scalar( @rrs ), 1, 'one answer A RR' );
is( $rrs[0]->address, '91.226.36.46', 'expected address' );

my $ary = $zone->query_all( 'www.iis.se', 'A' );
isa_ok( $ary, 'ARRAY' );
foreach my $p ( @$ary ) {
    isa_ok( $p, 'Giraffa::Packet' );
    my @rrs = $p->get_records( 'a', 'answer' );
    is( scalar( @rrs ), 1, 'one answer A RR' );
    is( $rrs[0]->address, '91.226.36.46', 'expected address' );
}

ok($zone->is_in_zone('www.iis.se', 'www.iis.se is in zone iis.se'));
ok(not $zone->is_in_zone('www.google.se','www.google.se is not in zone iis.se'));

my $net = Giraffa::Zone->new({name => 'net'});
ok(not($net->is_in_zone('k.gtld-servers.net.')), 'k.gtld-servers.net is not in zone');
ok(Giraffa::Zone->new({name => 'gtld-servers.net'})->is_in_zone('k.gtld-servers.net.'), 'k.gtld-servers.net is in zone');

# if ( $ENV{GIRAFFA_RECORD} ) {
#     Giraffa::Nameserver->save( $datafile );
# }

done_testing;
