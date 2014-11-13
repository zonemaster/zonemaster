use Test::More;

use Net::IP::XS;

BEGIN {
    use_ok( q{Zonemaster} );
    use_ok( q{Zonemaster::Nameserver} );
    use_ok( q{Zonemaster::Test::Address} );
}

my $datafile = q{t/Test-address.data};
if ( not $ENV{ZONEMASTER_RECORD} ) {
    die "Stored data file missing" if not -r $datafile;
    Zonemaster::Nameserver->restore( $datafile );
    Zonemaster->config->no_network( 1 );
}

ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP::XS->new( q{0.255.255.255} ) ) ),   q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP::XS->new( q{10.255.255.255} ) ) ),  q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP::XS->new( q{192.168.255.255} ) ) ), q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP::XS->new( q{172.17.255.255} ) ) ),  q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP::XS->new( q{100.65.255.255} ) ) ),  q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP::XS->new( q{127.255.255.255} ) ) ), q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP::XS->new( q{169.254.255.255} ) ) ), q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP::XS->new( q{192.0.0.255} ) ) ),     q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP::XS->new( q{192.0.0.7} ) ) ),       q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP::XS->new( q{192.0.0.170} ) ) ),     q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP::XS->new( q{192.0.0.171} ) ) ),     q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP::XS->new( q{192.0.2.255} ) ) ),     q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP::XS->new( q{198.51.100.255} ) ) ),  q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP::XS->new( q{203.0.113.255} ) ) ),   q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP::XS->new( q{192.88.99.255} ) ) ),   q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP::XS->new( q{198.19.255.255} ) ) ),  q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP::XS->new( q{240.255.255.255} ) ) ), q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP::XS->new( q{255.255.255.255} ) ) ), q{bad address} );

ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP::XS->new( q{::1} ) ) ),              q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP::XS->new( q{::} ) ) ),               q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP::XS->new( q{::ffff:cafe:cafe} ) ) ), q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP::XS->new( q{64:ff9b::cafe:cafe} ) ) ), q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP::XS->new( q{100::cafe:cafe:cafe:cafe} ) ) ), q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP::XS->new( q{2001:1ff:cafe:cafe:cafe:cafe:cafe:cafe} ) )), q{bad address});
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP::XS->new( q{2001::cafe:cafe:cafe:cafe:cafe:cafe} ) )), q{bad address});
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP::XS->new( q{2001:2::cafe:cafe:cafe:cafe:cafe} ) ) ), q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP::XS->new( q{2001:db8:cafe:cafe:cafe:cafe:cafe:cafe} ) )), q{bad address});
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP::XS->new( q{2001:1f::cafe:cafe:cafe:cafe:cafe} ) ) ), q{bad address});
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP::XS->new( q{2002:cafe:cafe:cafe:cafe:cafe:cafe:cafe} ) )), q{bad address});
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP::XS->new( q{fdff:cafe:cafe:cafe:cafe:cafe:cafe:cafe} ) )), q{bad address});
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP::XS->new( q{febf:cafe:cafe:cafe:cafe:cafe:cafe:cafe} ) )), q{bad address});
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP::XS->new( q{::cafe:cafe} ) ) ), q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP::XS->new( q{5fff:cafe:cafe:cafe:cafe:cafe:cafe:cafe} ) )), q{bad address});
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP::XS->new( q{ffff:cafe:cafe:cafe:cafe:cafe:cafe:cafe} ) )), q{bad address});

ok( !defined( Zonemaster::Test::Address->find_special_address( Net::IP::XS->new( q{192.134.4.45} ) ) ), q{good address} );

my %res;

%res = map { $_->tag => 1 } Zonemaster->test_module( q{address}, q{nic.fr} );
ok( $res{NAMESERVER_IP_PTR_MISMATCH}, q{Nameserver IP PTR mismatch} );
ok( $res{NO_IP_PRIVATE_NETWORK}, q{All Nameserver addresses are in the routable public addressing space} );
ok( $res{NAMESERVERS_IP_WITH_REVERSE}, q{Reverse DNS entry exist for all Nameserver IP addresses} );

%res = map { $_->tag => 1 } Zonemaster->test_module( q{address}, q{bisexualmenace.org} );
ok( $res{NAMESERVER_IP_WITHOUT_REVERSE}, q{Nameserver IP without PTR} );

%res = map { $_->tag => 1 } Zonemaster->test_module( q{address}, q{is.se} );
ok( $res{NAMESERVER_IP_PTR_MATCH}, q{All reverse DNS entry matches name server name} );

%res = map { $_->tag => 1 } Zonemaster->test_module( q{address}, q{address01.zut-root.rd.nic.fr} );
ok( $res{NAMESERVER_IP_PRIVATE_NETWORK}, q{Nameserver address in non routable public addressing space} );

%res = map { $_->tag => 1 } Zonemaster->test_module( q{address}, q{molndal.se} );
ok( $res{NO_RESPONSE_PTR_QUERY}, q{No response from nameserver(s) on PTR query} );

if ( $ENV{ZONEMASTER_RECORD} ) {
    Zonemaster::Nameserver->save( $datafile );
}

done_testing;
