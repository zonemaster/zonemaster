use Test::More;

BEGIN {
    use_ok( q{Zonemaster} );
    use_ok( q{Zonemaster::Nameserver} );
    use_ok( q{Zonemaster::Test::Connectivity} );
}

my $datafile = q{t/Test-connectivity.data};
if ( not $ENV{ZONEMASTER_RECORD} ) {
    die q{Stored data file missing} if not -r $datafile;
    Zonemaster::Nameserver->restore( $datafile );
    Zonemaster->config->no_network( 1 );
}

my %res = map { $_->tag => 1 } Zonemaster->test_module( q{connectivity}, q{afnic.fr} );
ok( $res{NAMESERVER_HAS_UDP_53}, q{Nameserver has UDP port 53 reachabale} );
ok( $res{NAMESERVER_HAS_TCP_53}, q{Nameserver has TCP port 53 reachabale} );
ok( $res{NAMESERVERS_WITH_MULTIPLE_AS}, q{Nameservers with multiple AS} );

%res = map { $_->tag => 1 } Zonemaster->test_module( q{connectivity}, q{001.tf} );
ok( $res{NAMESERVERS_IPV6_WITH_UNIQ_AS}, q{Nameservers IPv6 with Uniq AS} );

%res = map { $_->tag => 1 } Zonemaster->test_module( q{connectivity}, q{go.tf} );
ok( $res{NAMESERVERS_WITH_UNIQ_AS}, q{Nameservers with Uniq AS} );
ok( !$res{NAMESERVERS_WITH_MULTIPLE_AS}, q{Nameservers with Uniq AS (double check)} );

%res = map { $_->tag => 1 } Zonemaster->test_module( q{connectivity}, q{manley.se} );
ok( $res{NAMESERVER_NO_UDP_53},   q{Nameserver UDP port 53 unreachabale} );
ok( $res{NAMESERVER_NO_TCP_53},   q{Nameserver TCP port 53 unreachabale} );

%res = map { $_->tag => 1 } Zonemaster->test_module( q{connectivity}, q{zut-root.rd.nic.fr} );
ok( $res{NAMESERVERS_WITH_UNIQ_AS}, q{Nameservers with Uniq AS} );
ok( $res{NAMESERVERS_IPV4_WITH_UNIQ_AS}, q{Nameservers IPv4 with Uniq AS} );

if ( $ENV{ZONEMASTER_RECORD} ) {
    Zonemaster::Nameserver->save( $datafile );
}

done_testing;
