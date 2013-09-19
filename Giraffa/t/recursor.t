use Test::More;

use 5.14.2;
use strict;
use warnings;
use List::Util qw[max];

BEGIN { use_ok( 'Giraffa::Recursor' ) }

my $p = Giraffa::Recursor->recurse( 'www.iis.se' );
isa_ok( $p, 'Giraffa::Packet' );
ok( $p->answer > 0, 'answer records' );
my ( $rr ) = $p->answer;
is( $rr->name, 'www.iis.se', 'RR name ok' );

my $p2 = Giraffa::Recursor->recurse( 'www.wiccainfo.se' );
isa_ok( $p2, 'Giraffa::Packet' );
is( scalar( $p2->answer ), 2, 'answer records' );

is_parent( 'iis.se',                                                                   'se' );
is_parent( 'www.iis.se',                                                               'iis.se' );
is_parent( 'pp.se',                                                                    'se' );
is_parent( 'sno.pp.se',                                                                'se' );
is_parent( '2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.4.9.5.0.7.2.0.0.0.7.4.0.1.0.0.2.ip6.arpa', '0.7.4.0.1.0.0.2.ip6.arpa' );
is_parent( '.',                                                                        '.' );

sub is_parent {
    my ( $name, $pname ) = @_;

    my $pn = Giraffa::Recursor->parent( $name );
    is( $pn, $pname, "parent for $name is $pn" );
}

my ($name, $packet) = Giraffa::Recursor->parent( 'www.iis.se');
isa_ok($packet, 'Giraffa::Packet');
is($name, 'iis.se', 'name ok');
ok($packet->no_such_record, 'expected packet content');

my @addr = Giraffa::Recursor->get_addresses_for( 'ns.nic.se' );
isa_ok($_, 'Net::IP') for @addr;
is($addr[0]->short, '212.247.7.228', 'expected address');
is($addr[1]->short, '2a00:801:f0:53::53', 'expected address');

done_testing;
