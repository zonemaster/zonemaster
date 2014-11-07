use Test::More;

BEGIN {
    use_ok( q{Zonemaster} );
    use_ok( q{Zonemaster::Test::Delegation} );
}

my $datafile = q{t/Test-delegation.data};
if ( not $ENV{ZONEMASTER_RECORD} ) {
    die q{Stored data file missing} if not -r $datafile;
    Zonemaster::Nameserver->restore( $datafile );
    Zonemaster->config->no_network( 1 );
}

my $iis = Zonemaster->zone( q{iis.se} );
my %res = map { $_->tag => $_ } Zonemaster::Test::Delegation->all( $iis );
ok( $res{ENOUGH_NS},        q{ENOUGH_NS} );
ok( $res{ENOUGH_NS_GLUE},   q{ENOUGH_NS_GLUE} );
ok( $res{ENOUGH_NS_TOTAL},  q{ENOUGH_NS_TOTAL} );
ok( $res{NAMES_MATCH},      q{NAMES_MATCH} );

LDNS: {
    local $TODO = 'Waiting for next release of the ldns C library.';
    ok( $res{REFERRAL_SIZE_OK}, q{REFERRAL_SIZE_OK} );
}

%res = map { $_->tag => 1 } Zonemaster->test_module( q{delegation}, q{crystone.se} );
ok( $res{SAME_IP_ADDRESS},    q{SAME_IP_ADDRESS} );
ok( $res{EXTRA_NAME_PARENT},   q{EXTRA_NAME_PARENT} );
ok( $res{EXTRA_NAME_CHILD},    q{EXTRA_NAME_CHILD} );
ok( $res{TOTAL_NAME_MISMATCH}, q{TOTAL_NAME_MISMATCH} );
ok( !$res{DISTINCT_IP_ADDRESS}, q{No DISTINCT_IP_ADDRESS} );
ok( $res{NS_RR_NO_CNAME}, q{NS_RR_NO_CNAME} );
ok( $res{SOA_EXISTS}, q{SOA_EXISTS} );
ok( $res{ARE_AUTHORITATIVE}, q{ARE_AUTHORITATIVE} );

%res = map { $_->tag => 1 } Zonemaster->test_module( q{delegation}, q{delegation02.zut-root.rd.nic.fr} );
ok( $res{NOT_ENOUGH_NS_TOTAL}, q{NOT_ENOUGH_NS_TOTAL} );
ok( $res{NOT_ENOUGH_NS}, q{NOT_ENOUGH_NS} );
ok( $res{NOT_ENOUGH_NS_GLUE}, q{NOT_ENOUGH_NS_GLUE} );

TODO: {
    local $TODO = "Need to find domain name with that error";

    ok( $res{IS_NOT_AUTHORITATIVE}, q{IS_NOT_AUTHORITATIVE} );

    ok( $res{NS_RR_IS_CNAME}, q{NS_RR_IS_CNAME} );

    ok( $res{REFERRAL_SIZE_LARGE}, q{REFERRAL_SIZE_LARGE} );

    ok( $res{SOA_NOT_EXISTS}, q{SOA_NOT_EXISTS} );

    ok( $res{IS_NOT_AUTHORITATIVE}, q{IS_NOT_AUTHORITATIVE} );

};

if ( $ENV{ZONEMASTER_RECORD} ) {
    Zonemaster::Nameserver->save( $datafile );
}

done_testing;
