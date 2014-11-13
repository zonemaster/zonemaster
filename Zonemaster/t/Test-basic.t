use Test::More;

BEGIN {
    use_ok( q{Zonemaster} );
    use_ok( q{Zonemaster::Nameserver} );
    use_ok( q{Zonemaster::Test::Basic} );
}

sub name_gives {
    my ( $test, $name, $gives ) = @_;

    my @res = Zonemaster->test_method( q{Basic}, $test, $name );
    ok( ( grep { $_->tag eq $gives } @res ), "$name gives $gives" );
}

sub name_gives_not {
    my ( $test, $name, $gives ) = @_;

    my @res = Zonemaster->test_method( q{Basic}, $test, $name );
    ok( !( grep { $_->tag eq $gives } @res ), "$name does not give $gives" );
}

sub zone_gives {
    my ( $test, $zone, $gives ) = @_;

    my @res = Zonemaster->test_method( q{Basic}, $test, $zone );
    ok( ( grep { $_->tag eq $gives } @res ), $zone->name->string." gives $gives" );
}

sub zone_gives_not {
    my ( $test, $zone, $gives ) = @_;

    my @res = Zonemaster->test_method( q{Basic}, $test, $zone );
    ok( !( grep { $_->tag eq $gives } @res ), $zone->name->string." does not give $gives" );
}

my $datafile = q{t/Test-basic.data};
if ( not $ENV{ZONEMASTER_RECORD} ) {
    die q{Stored data file missing} if not -r $datafile;
    Zonemaster::Nameserver->restore( $datafile );
    Zonemaster->config->no_network( 1 );
}

my $ns_ok       = Zonemaster::DNSName->new( q{ns1.nic.fr} );
my $ns_too_long = Zonemaster::DNSName->new(
q{ns123456789012345678901234567890123456789012345678901234567890.dom123456789012345678901234567890123456789012345678901234567890.dom123456789012345678901234567890123456789012345678901234567890.tld123456789012345678901234567890123456789012345678901234567890}
);
my $ns_ok_long = Zonemaster::DNSName->new(
q{ns23456789012345678901234567890123456789012345678901234567890.dom123456789012345678901234567890123456789012345678901234567890.dom123456789012345678901234567890123456789012345678901234567890.tld123456789012345678901234567890123456789012345678901234567890}
);
name_gives( q{basic00}, $ns_too_long, q{DOMAIN_NAME_TOO_LONG} );
name_gives_not( q{basic00}, $ns_ok, q{DOMAIN_NAME_TOO_LONG} );
name_gives_not( q{basic00}, $ns_ok_long, q{DOMAIN_NAME_TOO_LONG} );

my $ns_label_too_long =
  Zonemaster::DNSName->new( q{ns1234567890123456789012345678901234567890123456789012345678901234567890.nic.fr} );
name_gives( q{basic00}, $ns_label_too_long, q{DOMAIN_NAME_LABEL_TOO_LONG} );
name_gives_not( q{basic00}, $ns_ok, q{DOMAIN_NAME_LABEL_TOO_LONG} );

my $ns_null_label = Zonemaster::DNSName->new( q{dom12134..fr} );
name_gives( q{basic00}, $ns_null_label, q{DOMAIN_NAME_ZERO_LENGTH_LABEL} );

my $zone = Zonemaster->zone( q{001.tf} );
zone_gives( q{basic01}, $zone, q{HAS_GLUE} );
zone_gives( q{basic01}, $zone, q{PARENT_REPLIES} );
zone_gives( q{basic02}, $zone, q{NS_FAILED} );
zone_gives( q{basic02}, $zone, q{NS_NO_RESPONSE} );

%res = map { $_->tag => 1 } Zonemaster->test_module( q{basic}, q{aff.tf} );
ok( $res{HAS_NAMESERVERS}, q{HAS_NAMESERVERS} );
ok( $res{HAS_NAMESERVER_NO_WWW_A_TEST}, q{HAS_NAMESERVER_NO_WWW_A_TEST} );

$zone = Zonemaster->zone( q{svtbarn.se} );
zone_gives( q{basic01}, $zone, q{NO_DOMAIN} );

Zonemaster->config->ipv4_ok( 1 );
Zonemaster->config->ipv6_ok( 1 );
$zone = Zonemaster->zone( q{afnic.fr} );
zone_gives( q{basic02}, $zone, q{IPV4_ENABLED} );
zone_gives( q{basic02}, $zone, q{IPV6_ENABLED} );
zone_gives_not( q{basic02}, $zone, q{IPV4_DISABLED} );
zone_gives_not( q{basic02}, $zone, q{IPV6_DISABLED} );
zone_gives( q{basic03}, $zone, q{IPV4_ENABLED} );
zone_gives( q{basic03}, $zone, q{IPV6_ENABLED} );
zone_gives_not( q{basic03}, $zone, q{IPV4_DISABLED} );
zone_gives_not( q{basic03}, $zone, q{IPV6_DISABLED} );

Zonemaster->config->ipv4_ok( 1 );
Zonemaster->config->ipv6_ok( 0 );
$zone = Zonemaster->zone( q{afnic.fr} );
zone_gives( q{basic02}, $zone, q{IPV4_ENABLED} );
zone_gives( q{basic02}, $zone, q{IPV6_DISABLED} );
zone_gives_not( q{basic02}, $zone, q{IPV4_DISABLED} );
zone_gives_not( q{basic02}, $zone, q{IPV6_ENABLED} );
zone_gives( q{basic03}, $zone, q{IPV4_ENABLED} );
zone_gives( q{basic03}, $zone, q{IPV6_DISABLED} );
zone_gives_not( q{basic03}, $zone, q{IPV4_DISABLED} );
zone_gives_not( q{basic03}, $zone, q{IPV6_ENABLED} );

%res = map { $_->tag => 1 } Zonemaster->test_module( q{basic}, q{melbourneit.com.au} );
ok( $res{NO_GLUE}, q{NO_GLUE} );
ok( $res{NO_GLUE_PREVENTS_NAMESERVER_TESTS}, q{NO_GLUE_PREVENTS_NAMESERVER_TESTS} );

%res = map { $_->tag => 1 } Zonemaster->test_module( q{basic}, q{maxan.se} );
ok( $res{HAS_A_RECORDS}, q{HAS_A_RECORDS} );

%res = map { $_->tag => 1 } Zonemaster->test_module( q{basic}, q{birgerjarlhotel.se} );
ok( $res{A_QUERY_NO_RESPONSES}, q{A_QUERY_NO_RESPONSES} );

TODO: {
    local $TODO = "Need to find domain name with that error";

    ok( $res{NO_PARENT_RESPONSE}, q{NO_PARENT_RESPONSE} );
};

if ( $ENV{ZONEMASTER_RECORD} ) {
    Zonemaster::Nameserver->save( $datafile );
}

done_testing;

