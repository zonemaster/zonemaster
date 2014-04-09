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

if ( $ENV{GIRAFFA_RECORD} ) {
    Giraffa::Nameserver->save( $datafile );
}

done_testing;
