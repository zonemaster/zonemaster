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
    is( $msg->tag, 'DS_DIGTYPE_OK' );
}

$zone = Giraffa->zone( 'seb.se' );
@res = Giraffa->test_method( 'DNSSEC', 'dnssec01', $zone );
is( scalar( @res ), 1 );
is( $res[0]->tag,   'NO_DS' );

if ( $ENV{GIRAFFA_RECORD} ) {
    Giraffa::Nameserver->save( $datafile );
}

done_testing;
