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
    Zonemaster->config->no_network(1);
}

my %res = map { $_->tag => 1 } Zonemaster->test_module( q{basic}, q{001.tf} );
ok( $res{HAS_GLUE},  q{HAS_GLUE} );
ok( $res{NS_FAILED}, q{NS_FAILED} );

%res = map { $_->tag => 1 } Zonemaster->test_module( q{basic}, q{bisexualmenace.org} );
ok( $res{NS_NO_RESPONSE}, q{NS_NO_RESPONSE} );

%res = map { $_->tag => 1 } Zonemaster->test_module( q{basic}, q{airfree.tf} );
ok( $res{NO_GLUE}, q{NO_GLUE} );

%res = map { $_->tag => 1 } Zonemaster->test_module( q{basic}, q{aff.tf} );
ok( $res{HAS_NAMESERVERS}, q{HAS_NAMESERVERS} );

%res = map { $_->tag => 1 } Zonemaster->test_module( q{basic}, q{yes.tf} );
ok( $res{NO_DOMAIN}, q{NO_DOMAIN} );

if ( $ENV{ZONEMASTER_RECORD} ) {
    Zonemaster::Nameserver->save( $datafile );
}

done_testing;

