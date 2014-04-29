use Test::More;

BEGIN {
    use_ok('Giraffa');
    use_ok('Giraffa::Nameserver');
    use_ok('Giraffa::Test::Connectivity');
}

my $datafile = 't/connectivity.data';
if ( not $ENV{GIRAFFA_RECORD} ) {
    die "Stored data file missing" if not -r $datafile;
    Giraffa::Nameserver->restore( $datafile );
    Giraffa->config->{no_network} = 1;
}

my %res = map {$_->tag => 1} Giraffa->test_module('connectivity', 'afnic.fr');
ok($res{NAMESERVER_HAS_UDP_53}, 'Nameserver has UDP port 53 reachabale');
ok($res{NAMESERVER_HAS_TCP_53}, 'Nameserver has TCP port 53 reachabale');
ok($res{NAMESERVER_IPV6_ADDRESSES_NOT_BOGON}, 'Nameserver IPv6 addresses not bogon');
ok(!$res{NAMESERVER_IPV6_ADDRESS_BOGON}, 'Nameserver IPv6 addresses not bogon (double check)');

%res = map {$_->tag => 1} Giraffa->test_module('connectivity', '001.tf');
ok($res{NAMESERVERS_IPV6_WITH_UNIQ_AS}, 'Nameservers IPv6 with Uniq AS');

%res = map {$_->tag => 1} Giraffa->test_module('connectivity', 'go.tf');
ok($res{NAMESERVERS_WITH_UNIQ_AS}, 'Nameservers with Uniq AS');

%res = map {$_->tag => 1} Giraffa->test_module('connectivity', 'farra.tf');
ok($res{NAMESERVER_NO_UDP_53}, 'Nameserver UDP port 53 unreachabale');
ok(!$res{NAMESERVER_HAS_UDP_53}, 'Nameserver UDP port 53 unreachabale (double check)');
ok($res{NAMESERVER_NO_TCP_53}, 'Nameserver TCP port 53 unreachabale');
ok(!$res{NAMESERVER_HAS_TCP_53}, 'Nameserver TCP port 53 unreachabale (double check)');

if ( $ENV{GIRAFFA_RECORD} ) {
    Giraffa::Nameserver->save( $datafile );
}

done_testing;
