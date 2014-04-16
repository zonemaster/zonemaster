use Test::More;

BEGIN {
    use_ok( 'Giraffa' );
    use_ok( 'Giraffa::Test::DNSSEC' );
}

my $datafile = 't/dnssec.data';
if ( not $ENV{GIRAFFA_RECORD} ) {
    die "Stored data file missing" if not -r $datafile;
    Giraffa::Nameserver->restore( $datafile );
    Giraffa->config->{no_network} = 1;
}

my $zone = Giraffa->zone( 'nic.se' );

my @res = Giraffa->test_method( 'DNSSEC', 'dnssec01', $zone );
foreach my $msg ( @res ) {
    is( $msg->tag, 'DS_DIGTYPE_OK', 'DS_DIGTYPE_OK' );
}

$zone2 = Giraffa->zone( 'seb.se' );
@res = Giraffa->test_method( 'DNSSEC', 'dnssec01', $zone2 );
is( scalar( @res ), 1,       'Result count' );
is( $res[0]->tag,   'NO_DS', 'NO_DS' );

@res = Giraffa->test_method( 'DNSSEC', 'dnssec02', $zone );
my %tag = map { $_->tag => 1 } @res;
ok( $tag{DS_MATCHES_DNSKEY},        'DS_MATCHES_DNSKEY' );
ok( $tag{DS_DOES_NOT_MATCH_DNSKEY}, 'DS_DOES_NOT_MATCH_DNSKEY' );
ok( $tag{MATCH_FOUND},              'MATCH_FOUND' );

my $zone3 = Giraffa->zone( 'com' );
@res = Giraffa->test_method( 'DNSSEC', 'dnssec03', $zone3 );
is( scalar( @res ), 1, 'One message' );
is( $res[0]->tag, 'ITERATIONS_OK', 'ITERATIONS_OK' );

@res = Giraffa->test_method( 'DNSSEC', 'dnssec04', $zone );
%tag = map { $_->tag => 1 } @res;
ok( $tag{DURATION_OK}, 'DURATION_OK' );

@res = Giraffa->test_method( 'DNSSEC', 'dnssec05', $zone );
%tag = map { $_->tag => 1 } @res;
ok( $tag{ALGORITHM_OK}, 'ALGORITHM_OK' );

@res = Giraffa->test_method( 'DNSSEC', 'dnssec06', $zone );
%tag = map { $_->tag => 1 } @res;
ok( $tag{EXTRA_PROCESSING_OK}, 'EXTRA_PROCESSING_OK' );

@res = Giraffa->test_method( 'DNSSEC', 'dnssec07', $zone );
%tag = map { $_->tag => 1 } @res;
ok( $tag{DNSKEY_AND_DS}, 'DNSKEY_AND_DS' );

@res = Giraffa->test_method( 'DNSSEC', 'dnssec08', $zone );
%tag = map { $_->tag => 1 } @res;
ok( $tag{DNSKEY_SIGNATURE_OK}, 'DNSKEY_SIGNATURE_OK' );
ok( $tag{DNSKEY_SIGNED}, 'DNSKEY_SIGNED' );

@res = Giraffa->test_method( 'DNSSEC', 'dnssec09', $zone );
%tag = map { $_->tag => 1 } @res;
ok( $tag{SOA_SIGNATURE_OK}, 'SOA_SIGNATURE_OK' );
ok( $tag{SOA_SIGNED}, 'SOA_SIGNED' );

@res = Giraffa->test_method( 'DNSSEC', 'dnssec10', $zone );
%tag = map { $_->tag => 1 } @res;
ok( $tag{HAS_NSEC}, 'HAS_NSEC' );
ok( $tag{NSEC_SIGNED} || $tag{NSEC_NOT_SIGNED}, 'NSEC_SIGNED' ); # FIXME: Find better solution for key expiry
ok( $tag{NSEC_COVERS}, 'NSEC_COVERS' );

@res = Giraffa->test_method( 'DNSSEC', 'dnssec10', $zone3 );
%tag = map { $_->tag => 1 } @res;
ok( $tag{HAS_NSEC3}, 'HAS_NSEC3' );
ok( $tag{NSEC3_SIGNED} || $tag{NSE3C_NOT_SIGNED}, 'NSEC3_SIGNED' ); # FIXME: Find better solution for key expiry
ok( $tag{NSEC3_COVERS}, 'NSEC3_COVERS' );

if ( $ENV{GIRAFFA_RECORD} ) {
    Giraffa::Nameserver->save( $datafile );
}

done_testing;
