use Test::More;

BEGIN {
    use_ok( q{Zonemaster} );
    use_ok( q{Zonemaster::Nameserver} );
    use_ok( q{Zonemaster::Test::Basic} );
}

my $datafile = q{t/Test-basic.data};
if ( not $ENV{ZONEMASTER_RECORD} ) {
    die q{Stored data file missing} if not -r $datafile;
    Zonemaster::Nameserver->restore( $datafile );
    Zonemaster->config->no_network( 1 );
}

my %res = map { $_->tag => 1 } Zonemaster->test_module( q{basic}, q{001.tf} );
ok( $res{HAS_GLUE},  q{HAS_GLUE} );
ok( $res{NS_FAILED}, q{NS_FAILED} );

%res = map { $_->tag => 1 } Zonemaster->test_module( q{basic}, q{bisexualmenace.org} );
ok( $res{NS_NO_RESPONSE}, q{NS_NO_RESPONSE} );

%res = map { $_->tag => 1 } Zonemaster->test_module( q{basic}, q{airfree.tf} );
ok( $res{NO_GLUE}, q{NO_GLUE} );
ok( $res{NO_GLUE_PREVENTS_NAMESERVER_TESTS}, q{NO_GLUE_PREVENTS_NAMESERVER_TESTS} );

%res = map { $_->tag => 1 } Zonemaster->test_module( q{basic}, q{aff.tf} );
ok( $res{HAS_NAMESERVERS}, q{HAS_NAMESERVERS} );
ok( $res{HAS_NAMESERVER_NO_WWW_A_TEST}, q{HAS_NAMESERVER_NO_WWW_A_TEST} );

%res = map { $_->tag => 1 } Zonemaster->test_module( q{basic}, q{yes.tf} );
ok( $res{NO_DOMAIN}, q{NO_DOMAIN} );

TODO: {
    local $TODO = "Need to find domain name with that error";

    ok( $res{HAS_A_RECORDS}, q{HAS_A_RECORDS} );

    ok( $res{NO_PARENT_RESPONSE}, q{NO_PARENT_RESPONSE} );

    ok( $res{IPV4_DISABLED}, q{IPV4_DISABLED} );

    ok( $res{IPV6_DISABLED}, q{IPV6_DISABLED} );

    ok( $res{IPV4_ENABLED}, q{IPV4_ENABLED} );

    ok( $res{IPV6_ENABLED}, q{IPV6_ENABLED} );

    ok( $res{NO_A_RECORDS}, q{NO_A_RECORDS} );

};

if ( $ENV{ZONEMASTER_RECORD} ) {
    Zonemaster::Nameserver->save( $datafile );
}

done_testing;

