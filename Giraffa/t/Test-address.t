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

my %res = map {$_->tag => 1} Giraffa->test_module(q{address}, q{nic.fr});
ok($res{NAMESERVER_IP_PTR_MISMATCH}, q{Nameserver IP PTR mismatch});

%res = map {$_->tag => 1} Giraffa->test_module(q{address}, q{x6.tf});
ok($res{NAMESERVER_IP_WITHOUT_REVERSE}, q{Nameserver IP without PTR});

# Add test case for NAMESERVER_IP_PRIVATE_NETWORK

if ( $ENV{GIRAFFA_RECORD} ) {
    Giraffa::Nameserver->save( $datafile );
}

done_testing;
