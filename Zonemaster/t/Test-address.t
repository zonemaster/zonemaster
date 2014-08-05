use Test::More;

use Net::IP;

BEGIN {
    use_ok( q{Zonemaster} );
    use_ok( q{Zonemaster::Nameserver} );
    use_ok( q{Zonemaster::Test::Address} );
}

my $datafile = q{t/Test-address.data};
if ( not $ENV{ZONEMASTER_RECORD} ) {
    die "Stored data file missing" if not -r $datafile;
    Zonemaster::Nameserver->restore( $datafile );
    Zonemaster->config->no_network(1);
}

ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP->new( q{0.255.255.255} ) ) ),   q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP->new( q{10.255.255.255} ) ) ),  q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP->new( q{192.168.255.255} ) ) ), q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP->new( q{172.17.255.255} ) ) ),  q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP->new( q{100.65.255.255} ) ) ),  q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP->new( q{127.255.255.255} ) ) ), q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP->new( q{169.254.255.255} ) ) ), q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP->new( q{192.0.0.255} ) ) ),     q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP->new( q{192.0.0.7} ) ) ),       q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP->new( q{192.0.0.170} ) ) ),     q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP->new( q{192.0.0.171} ) ) ),     q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP->new( q{192.0.2.255} ) ) ),     q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP->new( q{198.51.100.255} ) ) ),  q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP->new( q{203.0.113.255} ) ) ),   q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP->new( q{192.88.99.255} ) ) ),   q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP->new( q{198.19.255.255} ) ) ),  q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP->new( q{240.255.255.255} ) ) ), q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP->new( q{255.255.255.255} ) ) ), q{bad address} );

ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP->new( q{::1} ) ) ),              q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP->new( q{::} ) ) ),               q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP->new( q{::ffff:cafe:cafe} ) ) ), q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP->new( q{64:ff9b::cafe:cafe} ) ) ),
    q{bad address} );
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP->new( q{100::cafe:cafe:cafe:cafe} ) ) ),
    q{bad address} );
ok(
    defined(
        Zonemaster::Test::Address->find_special_address( Net::IP->new( q{2001:1ff:cafe:cafe:cafe:cafe:cafe:cafe} ) )
    ),
    q{bad address}
);
ok(
    defined(
        Zonemaster::Test::Address->find_special_address( Net::IP->new( q{2001::cafe:cafe:cafe:cafe:cafe:cafe} ) )
    ),
    q{bad address}
);
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP->new( q{2001:2::cafe:cafe:cafe:cafe:cafe} ) ) ),
    q{bad address} );
ok(
    defined(
        Zonemaster::Test::Address->find_special_address( Net::IP->new( q{2001:db8:cafe:cafe:cafe:cafe:cafe:cafe} ) )
    ),
    q{bad address}
);
ok(
    defined( Zonemaster::Test::Address->find_special_address( Net::IP->new( q{2001:1f::cafe:cafe:cafe:cafe:cafe} ) ) ),
    q{bad address}
);
ok(
    defined(
        Zonemaster::Test::Address->find_special_address( Net::IP->new( q{2002:cafe:cafe:cafe:cafe:cafe:cafe:cafe} ) )
    ),
    q{bad address}
);
ok(
    defined(
        Zonemaster::Test::Address->find_special_address( Net::IP->new( q{fdff:cafe:cafe:cafe:cafe:cafe:cafe:cafe} ) )
    ),
    q{bad address}
);
ok(
    defined(
        Zonemaster::Test::Address->find_special_address( Net::IP->new( q{febf:cafe:cafe:cafe:cafe:cafe:cafe:cafe} ) )
    ),
    q{bad address}
);
ok( defined( Zonemaster::Test::Address->find_special_address( Net::IP->new( q{::cafe:cafe} ) ) ), q{bad address} );
ok(
    defined(
        Zonemaster::Test::Address->find_special_address( Net::IP->new( q{5fff:cafe:cafe:cafe:cafe:cafe:cafe:cafe} ) )
    ),
    q{bad address}
);
ok(
    defined(
        Zonemaster::Test::Address->find_special_address( Net::IP->new( q{ffff:cafe:cafe:cafe:cafe:cafe:cafe:cafe} ) )
    ),
    q{bad address}
);

ok( !defined( Zonemaster::Test::Address->find_special_address( Net::IP->new( q{192.134.4.45} ) ) ), q{good address} );

my %res = map { $_->tag => 1 } Zonemaster->test_module( q{address}, q{nic.fr} );
ok( $res{NAMESERVER_IP_PTR_MISMATCH}, q{Nameserver IP PTR mismatch} );

%res = map { $_->tag => 1 } Zonemaster->test_module( q{address}, q{bisexualmenace.org} );
ok( $res{NAMESERVER_IP_WITHOUT_REVERSE}, q{Nameserver IP without PTR} );

%res = map { $_->tag => 1 } Zonemaster->test_module( q{address}, q{afnic.fr} );
ok( $res{NAMESERVER_IPV6_ADDRESSES_NOT_BOGON}, q{Nameserver IPv6 addresses not bogon} );
ok( !$res{NAMESERVER_IPV6_ADDRESS_BOGON},      q{Nameserver IPv6 addresses not bogon (double check)} );

# Add test case for NAMESERVER_IP_PRIVATE_NETWORK

if ( $ENV{ZONEMASTER_RECORD} ) {
    Zonemaster::Nameserver->save( $datafile );
}

done_testing;
