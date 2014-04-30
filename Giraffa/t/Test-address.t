use Test::More;

BEGIN {
    use_ok(q{Giraffa});
    use_ok(q{Giraffa::Nameserver});
    use_ok(q{Giraffa::Test::Address});
}

my $datafile = q{t/Test-address.data};
if ( not $ENV{GIRAFFA_RECORD} ) {
    die "Stored data file missing" if not -r $datafile;
    Giraffa::Nameserver->restore( $datafile );
    Giraffa->config->{no_network} = 1;
}  

# Add tests cases for NAMESERVER_IP_PRIVATE_NETWORK/NAMESERVER_IP_WITHOUT_REVERSE/NAMESERVER_IP_PTR_MISMATCH
if ( $ENV{GIRAFFA_RECORD} ) {
    Giraffa::Nameserver->save( $datafile );
}

done_testing;
