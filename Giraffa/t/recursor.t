use Test::More;

use 5.14.2;
use strict;
use warnings;
use List::Util qw[max];

use Giraffa::Nameserver;
use Giraffa::Util;
BEGIN { use_ok( 'Giraffa::Recursor' ) }

# my $datafile = 't/recursor.yaml';
# if ( not $ENV{GIRAFFA_RECORD} ) {
#     die "Stored data file missing" if not -r $datafile;
#     Giraffa::Nameserver->restore( $datafile );
#     config->{no_network} = 1;
# }

my $p = Giraffa::Recursor->recurse( 'www.iis.se' );
isa_ok( $p, 'Giraffa::Packet' );
ok( $p->answer > 0, 'answer records' );
my ( $rr ) = $p->answer;
is( name($rr->name), 'www.iis.se', 'RR name ok' );

my $p2 = Giraffa::Recursor->recurse( 'www.wiccainfo.se' );
isa_ok( $p2, 'Giraffa::Packet' );
is( scalar( $p2->answer ), 2, 'answer records' );

is_parent( 'iis.se',                                                                   'se' );
is_parent( 'www.iis.se',                                                               'iis.se' );
is_parent( 'pp.se',                                                                    'se' );
is_parent( 'sno.pp.se',                                                                'se' );
is_parent( '2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.4.9.5.0.7.2.0.0.0.7.4.0.1.0.0.2.ip6.arpa', '0.7.4.0.1.0.0.2.ip6.arpa' );
is_parent( '.',                                                                        '.' );
is_parent( 'foo.bar.baz.example.org',                                                  'example.org' );

sub is_parent {
    my ( $name, $pname ) = @_;

    my $pn = Giraffa::Recursor->parent( $name );
    is( $pn, $pname, "parent for $name is $pn" );
}

my ( $name, $packet ) = Giraffa::Recursor->parent( 'www.iis.se' );
isa_ok( $packet, 'Giraffa::Packet' );
is( $name, 'iis.se', 'name ok' );
ok( $packet->no_such_record, 'expected packet content' );

my @addr = Giraffa::Recursor->get_addresses_for( 'ns.nic.se' );
isa_ok( $_, 'Net::IP' ) for @addr;
is( $addr[0]->short, '212.247.7.228',      'expected address' );
is( $addr[1]->short, '2a00:801:f0:53::53', 'expected address' );

# if ( $ENV{GIRAFFA_RECORD} ) {
#     Giraffa::Nameserver->save( $datafile );
# }

done_testing;
