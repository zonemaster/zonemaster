use Test::More;

BEGIN {
    use_ok( q{Zonemaster} );
    use_ok( q{Zonemaster::Nameserver} );
    use_ok( q{Zonemaster::Test::Zone} );
}

my $datafile = q{t/Test-zone.data};
if ( not $ENV{ZONEMASTER_RECORD} ) {
    die q{Stored data file missing} if not -r $datafile;
    Zonemaster::Nameserver->restore( $datafile );
    Zonemaster->config->no_network( 1 );
}

my %res = map { $_->tag => 1 } Zonemaster->test_module( q{zone}, q{afnic.fr} );
ok( $res{MNAME_NO_RESPONSE}, q{SOA 'mname' noe response} );
ok( $res{MNAME_NOT_IN_GLUE}, q{SOA 'mname' not listed as NS} );

%res = map { $_->tag => 1 } Zonemaster->test_module( q{zone}, q{add.tf} );
ok( $res{REFRESH_MINIMUM_VALUE_LOWER},         q{SOA 'Refresh' value is too low} );
ok( $res{RETRY_MINIMUM_VALUE_LOWER},           q{SOA 'Retry' vakue is too low} );
ok( $res{SOA_DEFAULT_TTL_MAXIMUM_VALUE_LOWER}, q{SOA 'minimum' value is too low} );
ok( $res{MX_RECORD_IS_CNAME},                  q{MX record is CNAME} );
ok( $res{NO_MX_RECORD},                        q{No MX records} );

%res = map { $_->tag => 1 } Zonemaster->test_module( q{zone}, q{google.tf} );
ok( $res{SOA_DEFAULT_TTL_MAXIMUM_VALUE_HIGHER}, q{SOA 'minimum' value is too high} );

if ( $ENV{ZONEMASTER_RECORD} ) {
    Zonemaster::Nameserver->save( $datafile );
}

done_testing;
