use Test::More;

BEGIN { use_ok( 'Giraffa::Nameserver' ); }
use Giraffa;
use Giraffa::Util;

my $datafile = 't/nameserver.data';
if ( not $ENV{GIRAFFA_RECORD} ) {
    die "Stored data file missing" if not -r $datafile;
    Giraffa::Nameserver->restore( $datafile );
    config->{no_network} = 1;
}

my $nsv6 = new_ok( 'Giraffa::Nameserver' => [ { name => 'ns.nic.se', address => '2a00:801:f0:53::53' } ] );
my $nsv4 = new_ok( 'Giraffa::Nameserver' => [ { name => 'ns.nic.se', address => '212.247.7.228' } ] );

eval { Giraffa::Nameserver->new( { name => 'dummy' } ); };
like( $@, qr/Attribute \(address\) is required/, 'create fails without address.' );

isa_ok( $nsv6->address, 'Net::IP' );
isa_ok( $nsv6->name,    'Giraffa::DNSName' );
is( $nsv6->dns->retry, 2 );

my $p1 = $nsv6->query( 'iis.se', 'SOA' );
my $p2 = $nsv6->query( 'iis.se', 'SOA', { dnssec => 1 } );
my $p3 = $nsv6->query( 'iis.se', 'SOA', { dnssec => 1 } );
my $p4 = $nsv4->query( 'iis.se', 'SOA', { dnssec => 1 } );

isa_ok( $p1, 'Giraffa::Packet' );
isa_ok( $p2, 'Giraffa::Packet' );
my ( $soa ) = grep { $_->type eq 'SOA' } $p1->answer;
is( scalar( $p1->answer ), 1, 'one answer RR present ' );
ok( $soa, 'it is a SOA RR' );
is( $soa->rname, 'hostmaster.iis.se.', 'RNAME has expected format' );
is( scalar( grep { $_->type eq 'SOA' or $_->type eq 'RRSIG' } $p2->answer ), 2, 'SOA and RRSIG RRs present' );
ok( !$nsv6->dns->dnssec, 'dnssec flag still unset' );
ok( $p3 eq $p2,          'Same packet object returned' );
ok( $p3 ne $p4,          'Same packet object not returned from other server' );
ok( $p3 ne $p1,          'Same packet object not returned with other flag' );

my $nscopy = Giraffa->ns( 'ns.nic.se.', '2a00:801:f0:53:0000::53' );
ok( $nsv6 eq $nscopy, 'Same nameserver object returned' );

SKIP: {
    skip '/tmp not writable', 2 unless -w '/tmp';
    my $name = "/tmp/namserver_test_$$";
    Giraffa::Nameserver->save( $name );
    my $count = keys %Giraffa::Nameserver::object_cache;
    undef %Giraffa::Nameserver::object_cache;
    is( scalar( keys %Giraffa::Nameserver::object_cache ), 0, 'Nameserver cache is empty after clear.' );
    Giraffa::Nameserver->restore( $name );
    is( scalar( keys %Giraffa::Nameserver::object_cache ),
        $count, 'Same number of top-level keys in cache after restore.' );
    unlink $name;
}

my $broken = new_ok( 'Giraffa::Nameserver' => [ { name => 'ns.not.existing', address => '192.0.2.17' } ] );
my $p = $broken->query( 'www.iis.se' );
ok( !$p, 'no response from broken server' );

my $googlens = ns( 'ns1.google.com', '216.239.32.10' );
my $save = config->{no_network};
config->{no_network} = 1;
delete( $googlens->cache->{'www.google.com'} );
eval { $googlens->query( 'www.google.com', 'TXT' ) };
like( $@,
    qr{External query for www.google.com, TXT attempted to ns1.google.com/216.239.32.10 while running with no_network}i
);
config->{no_network} = $save;

@{ $nsv6->times } = ( qw[2 4 4 4 5 5 7 9] );
is( $nsv6->stddev_time, 2, 'known value check' );
is( $nsv6->average_time, 5 );
is( $nsv6->median_time,  4.5 );

foreach my $ns ( Giraffa::Nameserver->all_known_nameservers ) {
    isa_ok( $ns, 'Giraffa::Nameserver' );
}

if ( $ENV{GIRAFFA_RECORD} ) {
    Giraffa::Nameserver->save( $datafile );
}

done_testing;
