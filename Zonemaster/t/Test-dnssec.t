use Test::More;

BEGIN {
    use_ok( 'Zonemaster' );
    use_ok( 'Zonemaster::Test::DNSSEC' );
}

my $checking_module = q{DNSSEC};

sub zone_gives {
    my ( $test, $zone, $gives ) = @_;

    my @res = Zonemaster->test_method( $checking_module, $test, $zone );
    ok( ( grep { $_->tag eq $gives } @res ), $zone->name->string." gives $gives" );
    return scalar( @res );
}

sub zone_gives_not {
    my ( $test, $zone, $gives ) = @_;

    my @res = Zonemaster->test_method( $checking_module, $test, $zone );
    ok( !( grep { $_->tag eq $gives } @res ), $zone->name->string." does not give $gives" );
    return scalar( @res );
}

my $datafile = 't/Test-dnssec.data';
if ( not $ENV{ZONEMASTER_RECORD} ) {
    die "Stored data file missing" if not -r $datafile;
    Zonemaster::Nameserver->restore( $datafile );
    Zonemaster->config->no_network( 1 );
}

my $zone;
my @res;
my %tag;

$zone = Zonemaster->zone( 'nic.se' );

@res = Zonemaster->test_method( 'DNSSEC', 'dnssec01', $zone );
foreach my $msg ( @res ) {
    is( $msg->tag, 'DS_DIGTYPE_OK', 'DS_DIGTYPE_OK' );
}

my $zone2 = Zonemaster->zone( 'seb.se' );
is (zone_gives( 'dnssec01', $zone2, 'NO_DS' ), 1, 'Only one message' );

zone_gives( 'dnssec02', $zone, 'DS_MATCHES_DNSKEY' );
zone_gives( 'dnssec02', $zone, 'COMMON_KEYTAGS' );
zone_gives( 'dnssec02', $zone, 'DS_MATCH_FOUND' );
zone_gives( 'dnssec02', $zone, 'DS_FOUND' );

is (zone_gives( 'dnssec02', $zone2, 'NO_DS' ), 1, 'Only one message' );

my $zone3 = Zonemaster->zone( 'com' );
is (zone_gives( 'dnssec03', $zone3, 'ITERATIONS_OK' ), 1, 'Only one message' );

@res = Zonemaster->test_method( 'DNSSEC', 'dnssec04', $zone );
%tag = map { $_->tag => 1 } @res;
ok( ($tag{DURATION_OK} || $tag{REMAINING_SHORT} || $tag{RRSIG_EXPIRED}), 'DURATION_OK (sort of)' );

zone_gives( 'dnssec05', $zone, 'ALGORITHM_OK' );

zone_gives( 'dnssec06', $zone, 'EXTRA_PROCESSING_OK' );

zone_gives( 'dnssec07', $zone, 'DNSKEY_AND_DS' );

zone_gives( 'dnssec08', $zone, 'DNSKEY_SIGNATURE_OK' );
zone_gives( 'dnssec08', $zone, 'DNSKEY_SIGNED' );

zone_gives( 'dnssec09', $zone, 'SOA_SIGNATURE_OK' );
zone_gives( 'dnssec09', $zone, 'SOA_SIGNED' );

zone_gives( 'dnssec10', $zone, 'HAS_NSEC' );
zone_gives( 'dnssec10', $zone, 'NSEC_SIGNED' );
zone_gives( 'dnssec10', $zone, 'NSEC_COVERS' );

zone_gives( 'dnssec10', $zone3, 'HAS_NSEC3' );
zone_gives( 'dnssec10', $zone3, 'NSEC3_SIGNED' );
zone_gives( 'dnssec10', $zone3, 'NSEC3_COVERS' );

@res = Zonemaster->test_module( 'DNSSEC', 'loopia.se' );
%tag = map { $_->tag => 1 } @res;
ok( $tag{NO_DS}, 'NO_DS' );

# dnssec01
$zone = Zonemaster->zone( 'dnssec01-ds-digtype-not-ok.zut-root.rd.nic.fr' );
zone_gives( 'dnssec01', $zone, q{DS_DIGTYPE_NOT_OK} );
zone_gives_not( 'dnssec01', $zone, q{DS_DIGTYPE_OK} );
zone_gives_not( 'dnssec01', $zone, q{NO_DS} );

# dnssec02
$zone = Zonemaster->zone( 'dnssec02-no-dnskey.zut-root.rd.nic.fr' );
zone_gives( 'dnssec02', $zone, q{NO_DNSKEY} );

$zone = Zonemaster->zone( 'dnssec02-ds-does-not-match-dnskey.zut-root.rd.nic.fr' );
zone_gives_not( 'dnssec02', $zone, q{NO_DS} );
zone_gives( 'dnssec02', $zone, q{DS_FOUND} );
zone_gives( 'dnssec02', $zone, q{DS_MATCH_NOT_FOUND} );
zone_gives( 'dnssec02', $zone, q{DS_DOES_NOT_MATCH_DNSKEY} );

$zone = Zonemaster->zone( 'dnssec02-no-common-keytags.zut-root.rd.nic.fr' );
zone_gives( 'dnssec02', $zone, q{DS_FOUND} );
zone_gives( 'dnssec02', $zone, q{NO_COMMON_KEYTAGS} );

# dnssec03
$zone = Zonemaster->zone( 'dnssec03-many-iterations.zut-root.rd.nic.fr' );
zone_gives( 'dnssec03', $zone, q{MANY_ITERATIONS} );

$zone = Zonemaster->zone( 'dnssec03-no-nsec3param.zut-root.rd.nic.fr' );
zone_gives( 'dnssec03', $zone, q{NO_NSEC3PARAM} );

$zone = Zonemaster->zone( 'dnssec03-too-many-iterations.zut-root.rd.nic.fr' );
zone_gives( 'dnssec03', $zone, q{TOO_MANY_ITERATIONS} );

# dnssec04
$zone = Zonemaster->zone( 'dnssec04-duration-long.zut-root.rd.nic.fr' );
zone_gives( 'dnssec04', $zone, q{DURATION_LONG} );

$zone = Zonemaster->zone( 'dnssec04-remaining-long.zut-root.rd.nic.fr' );
zone_gives( 'dnssec04', $zone, q{REMAINING_LONG} );

# dnssec05
$zone = Zonemaster->zone( 'dnssec05-algorithm-deprecated.zut-root.rd.nic.fr' );
zone_gives( 'dnssec05', $zone, q{ALGORITHM_DEPRECATED} );
zone_gives_not( 'dnssec05', $zone, q{ALGORITHM_RESERVED} );
zone_gives_not( 'dnssec05', $zone, q{ALGORITHM_UNASSIGNED} );
zone_gives_not( 'dnssec05', $zone, q{ALGORITHM_PRIVATE} );
zone_gives_not( 'dnssec05', $zone, q{ALGORITHM_UNKNOWN} );

$zone = Zonemaster->zone( 'dnssec05-algorithm-reserved.zut-root.rd.nic.fr' );
zone_gives_not( 'dnssec05', $zone, q{ALGORITHM_DEPRECATED} );
zone_gives( 'dnssec05', $zone, q{ALGORITHM_RESERVED} );
zone_gives_not( 'dnssec05', $zone, q{ALGORITHM_UNASSIGNED} );
zone_gives_not( 'dnssec05', $zone, q{ALGORITHM_PRIVATE} );
zone_gives_not( 'dnssec05', $zone, q{ALGORITHM_UNKNOWN} );

$zone = Zonemaster->zone( 'dnssec05-algorithm-unassigned.zut-root.rd.nic.fr' );
zone_gives_not( 'dnssec05', $zone, q{ALGORITHM_DEPRECATED} );
zone_gives_not( 'dnssec05', $zone, q{ALGORITHM_RESERVED} );
zone_gives( 'dnssec05', $zone, q{ALGORITHM_UNASSIGNED} );
zone_gives_not( 'dnssec05', $zone, q{ALGORITHM_PRIVATE} );
zone_gives_not( 'dnssec05', $zone, q{ALGORITHM_UNKNOWN} );

$zone = Zonemaster->zone( 'dnssec05-algorithm-private.zut-root.rd.nic.fr' );
zone_gives_not( 'dnssec05', $zone, q{ALGORITHM_DEPRECATED} );
zone_gives_not( 'dnssec05', $zone, q{ALGORITHM_RESERVED} );
zone_gives_not( 'dnssec05', $zone, q{ALGORITHM_UNASSIGNED} );
zone_gives( 'dnssec05', $zone, q{ALGORITHM_PRIVATE} );
zone_gives_not( 'dnssec05', $zone, q{ALGORITHM_UNKNOWN} );

TODO: {
    local $TODO = "Need to find domain name with that error";

    # dnssec05 (can not exist in a live domain...)
    ok( $tag{ALGORITHM_UNKNOWN}, q{ALGORITHM_UNKNOWN} );
    # dnssec06
    ok( $tag{EXTRA_PROCESSING_BROKEN}, q{EXTRA_PROCESSING_BROKEN} );
    # dnssec07
    ok( $tag{ADDITIONAL_DNSKEY_SKIPPED}, q{ADDITIONAL_DNSKEY_SKIPPED} );
    ok( $tag{DNSKEY_BUT_NOT_DS}, q{DNSKEY_BUT_NOT_DS} );
    ok( $tag{NEITHER_DNSKEY_NOR_DS}, q{NEITHER_DNSKEY_NOR_DS} );
    ok( $tag{DS_BUT_NOT_DNSKEY}, q{DS_BUT_NOT_DNSKEY} );
    # dnssec08
    ok( $tag{DNSKEY_SIGNATURE_NOT_OK}, q{DNSKEY_SIGNATURE_NOT_OK} );
    ok( $tag{DNSKEY_NOT_SIGNED}, q{DNSKEY_NOT_SIGNED} );
    ok( $tag{NO_KEYS_OR_NO_SIGS}, q{NO_KEYS_OR_NO_SIGS} );
    # dnssec09
    ok( $tag{NO_KEYS_OR_NO_SIGS_OR_NO_SOA}, q{NO_KEYS_OR_NO_SIGS_OR_NO_SOA} );
    ok( $tag{SOA_SIGNATURE_NOT_OK}, q{SOA_SIGNATURE_NOT_OK} );
    ok( $tag{SOA_NOT_SIGNED}, q{SOA_NOT_SIGNED} );
    # dnssec10
    ok( $tag{INVALID_NAME_FOUND}, q{INVALID_NAME_FOUND} );
    ok( $tag{INVALID_NAME_RCODE}, q{INVALID_NAME_RCODE} );
    ok( $tag{NSEC_COVERS_NOT}, q{NSEC_COVERS_NOT} );
    ok( $tag{NSEC_SIG_VERIFY_ERROR}, q{NSEC_SIG_VERIFY_ERROR} );
    ok( $tag{NSEC_NOT_SIGNED}, q{NSEC_NOT_SIGNED} );
    ok( $tag{NSEC3_COVERS_NOT}, q{NSEC3_COVERS_NOT} );
    ok( $tag{NSE3C_SIG_VERIFY_ERROR}, q{NSE3C_SIG_VERIFY_ERROR} );
    ok( $tag{NSEC3_NOT_SIGNED}, q{NSEC3_NOT_SIGNED} );
}

if ( $ENV{ZONEMASTER_RECORD} ) {
    Zonemaster::Nameserver->save( $datafile );
}

done_testing;
