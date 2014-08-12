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
ok( $res{NAMES_MATCH},      q{NAMES_MATCH} );
ok( $res{REFERRAL_SIZE_OK}, q{REFERRAL_SIZE_OK} );

%res = map { $_->tag => 1 } Zonemaster->test_module( q{delegation}, q{crystone.se} );
ok( !$res{SAME_IP_ADDRESS},    q{SAME_IP_ADDRESS} );
ok( $res{EXTRA_NAME_PARENT},   q{EXTRA_NAME_PARENT} );
ok( $res{EXTRA_NAME_CHILD},    q{EXTRA_NAME_CHILD} );
ok( $res{TOTAL_NAME_MISMATCH}, q{TOTAL_NAME_MISMATCH} );

%res = map { $_->tag => $_ } Zonemaster->test_module( q{delegation}, q{bao.tf} );
ok( $res{IS_NOT_AUTHORITATIVE}, q{IS_NOT_AUTHORITATIVE} );

if ( $ENV{ZONEMASTER_RECORD} ) {
    Zonemaster::Nameserver->save( $datafile );
}

done_testing;
