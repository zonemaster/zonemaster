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

my %res;
my $zone;

%res = map { $_->tag => 1 } Zonemaster->test_module( q{Zone}, q{afnic.fr} );
ok( $res{MX_RECORD_EXISTS},                 q{Target found to deliver e-mail for the domain name} );
ok( $res{RETRY_MINIMUM_VALUE_LOWER},        q{SOA 'Retry' vakue is too low} );
ok( $res{REFRESH_MINIMUM_VALUE_LOWER},      q{SOA 'Refresh' value is too low} );
ok( $res{MNAME_NO_RESPONSE},                q{SOA 'mname' nameserver does not respond} );
ok( $res{MNAME_IS_NOT_CNAME},               q{SOA 'mname' value refers to a NS which is not an alias} );
ok( $res{MNAME_NOT_IN_GLUE},                q{SOA 'mname' nameserver is not listed in "parent" NS records for tested zone} );
ok( $res{SOA_DEFAULT_TTL_MAXIMUM_VALUE_OK}, q{SOA 'minimum' value is between the recommended ones} );
ok( $res{REFRESH_HIGHER_THAN_RETRY},        q{SOA 'refresh' value is higher than the SOA 'retry' value} );
ok( $res{EXPIRE_MINIMUM_VALUE_OK},          q{SOA 'expire' value is higher than the minimum recommended value and lower than 'refresh' value} );
ok( $res{MX_RECORD_IS_NOT_CNAME},           q{MX record for the domain is not pointing to a CNAME} );

$zone = Zonemaster->zone( q{zone01.zut-root.rd.nic.fr} );
%res = map { $_->tag => 1 } Zonemaster->test_method( q{Zone}, q{zone01}, $zone );
ok( $res{MNAME_RECORD_DOES_NOT_EXIST},    q{SOA 'mname' field does not exist} );

%res = map { $_->tag => 1 } Zonemaster->test_module( q{Zone}, q{add.tf} );
ok( $res{SOA_DEFAULT_TTL_MAXIMUM_VALUE_LOWER}, q{SOA 'minimum' value is too low} );
ok( $res{MX_RECORD_IS_CNAME},                  q{MX record is CNAME} );
ok( $res{NO_MX_RECORD},                        q{No MX records} );

%res = map { $_->tag => 1 } Zonemaster->test_module( q{Zone}, q{zone02.zut-root.rd.nic.fr} );
ok( $res{MNAME_NOT_AUTHORITATIVE}, q{SOA 'mname' nameserver is not authoritative for zone} );
ok( $res{RETRY_MINIMUM_VALUE_OK}, q{SOA 'retry' value is more than the minimum recommended value} );
ok( $res{REFRESH_MINIMUM_VALUE_OK}, q{SOA 'refresh' value is higher than the minimum recommended value} );
ok( $res{EXPIRE_LOWER_THAN_REFRESH}, q{SOA 'expire' value is lower than the SOA 'refresh' value} );
ok( $res{EXPIRE_MINIMUM_VALUE_LOWER}, q{SOA 'expire' value is less than the recommended one} );

%res = map { $_->tag => 1 } Zonemaster->test_module( q{Zone}, q{zone03.zut-root.rd.nic.fr} );
ok( $res{MNAME_IS_CNAME}, q{SOA 'mname' value refers to a NS which is an alias (CNAME)} );
ok( $res{REFRESH_LOWER_THAN_RETRY}, q{SOA 'refresh' value is lower than the SOA 'retry' value} );

%res = map { $_->tag => 1 } Zonemaster->test_module( q{Zone}, q{google.tf} );
ok( $res{SOA_DEFAULT_TTL_MAXIMUM_VALUE_HIGHER}, q{SOA 'minimum' value is too high} );
ok( $res{MNAME_IS_AUTHORITATIVE}, q{SOA 'mname' nameserver is authoritative zone} );

%res = map { $_->tag => 1 } Zonemaster->test_module( q{Zone}, q{zone04.zut-root.rd.nic.fr} );
ok( $res{MNAME_HAS_NO_ADDRESS},           q{No IP address found for SOA 'mname' nameserver} );

$zone = Zonemaster->zone( 'flen.se' );
%res = map { $_->tag => 1 } Zonemaster->test_method( q{Zone}, q{zone07}, $zone );
ok( $res{NO_RESPONSE_SOA_QUERY}, q{No response from nameserver(s) on SOA queries} );

%res = map { $_->tag => 1 } Zonemaster->test_method( q{Zone}, q{zone08}, $zone );
ok( $res{NO_RESPONSE_MX_QUERY}, q{No response from nameserver(s) on MX queries} );

if ( $ENV{ZONEMASTER_RECORD} ) {
    Zonemaster::Nameserver->save( $datafile );
}

done_testing;
