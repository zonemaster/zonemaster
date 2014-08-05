use Test::More;

BEGIN { use_ok( 'Zonemaster::Nameserver' ); }
use Zonemaster;
use Zonemaster::Util;

my $datafile = 't/nameserver.data';
if ( not $ENV{ZONEMASTER_RECORD} ) {
    die "Stored data file missing" if not -r $datafile;
    Zonemaster::Nameserver->restore( $datafile );
    Zonemaster->config->no_network(1);
}

my $nsv6 = new_ok( 'Zonemaster::Nameserver' => [ { name => 'ns.nic.se', address => '2a00:801:f0:53::53' } ] );
my $nsv4 = new_ok( 'Zonemaster::Nameserver' => [ { name => 'ns.nic.se', address => '212.247.7.228' } ] );

eval { Zonemaster::Nameserver->new( { name => 'dummy' } ); };
like( $@, qr/Attribute \(address\) is required/, 'create fails without address.' );

isa_ok( $nsv6->address, 'Net::IP' );
isa_ok( $nsv6->name,    'Zonemaster::DNSName' );
is( $nsv6->dns->retry, 2 );

my $p1 = $nsv6->query( 'iis.se', 'SOA' );
my $p2 = $nsv6->query( 'iis.se', 'SOA', { dnssec => 1 } );
my $p3 = $nsv6->query( 'iis.se', 'SOA', { dnssec => 1 } );
my $p4 = $nsv4->query( 'iis.se', 'SOA', { dnssec => 1 } );

isa_ok( $p1, 'Zonemaster::Packet' );
isa_ok( $p2, 'Zonemaster::Packet' );
my ( $soa ) = grep { $_->type eq 'SOA' } $p1->answer;
is( scalar( $p1->answer ), 1, 'one answer RR present ' );
ok( $soa, 'it is a SOA RR' );
is( $soa->rname, 'hostmaster.iis.se.', 'RNAME has expected format' );
is( scalar( grep { $_->type eq 'SOA' or $_->type eq 'RRSIG' } $p2->answer ), 2, 'SOA and RRSIG RRs present' );
ok( !$nsv6->dns->dnssec, 'dnssec flag still unset' );
ok( $p3 eq $p2,          'Same packet object returned' );
ok( $p3 ne $p4,          'Same packet object not returned from other server' );
ok( $p3 ne $p1,          'Same packet object not returned with other flag' );

my $nscopy = Zonemaster->ns( 'ns.nic.se.', '2a00:801:f0:53:0000::53' );
ok( $nsv6 eq $nscopy, 'Same nameserver object returned' );
my $nssame = Zonemaster->ns( 'foo.example.org', '2a00:801:f0:53:0000::53' );
ok(
    ( $nssame ne $nsv6 and $nssame->cache eq $nsv6->cache ),
    'Different name, same IP are different but has same cache'
);

SKIP: {
    skip '/tmp not writable', 2 unless -w '/tmp';
    my $name = "/tmp/namserver_test_$$";
    Zonemaster::Nameserver->save( $name );
    my $count = keys %Zonemaster::Nameserver::object_cache;
    undef %Zonemaster::Nameserver::object_cache;
    is( scalar( keys %Zonemaster::Nameserver::object_cache ), 0, 'Nameserver cache is empty after clear.' );
    Zonemaster::Nameserver->restore( $name );
    is( scalar( keys %Zonemaster::Nameserver::object_cache ),
        $count, 'Same number of top-level keys in cache after restore.' );
    unlink $name;
}

my $broken = new_ok( 'Zonemaster::Nameserver' => [ { name => 'ns.not.existing', address => '192.0.2.17' } ] );
my $p = $broken->query( 'www.iis.se' );
ok( !$p, 'no response from broken server' );

my $googlens = ns( 'ns1.google.com', '216.239.32.10' );
my $save = Zonemaster->config->no_network;
Zonemaster->config->no_network(1);
delete( $googlens->cache->{'www.google.com'} );
eval { $googlens->query( 'www.google.com', 'TXT' ) };
like( $@,
    qr{External query for www.google.com, TXT attempted to ns1.google.com/216.239.32.10 while running with no_network}i
);
Zonemaster->config->no_network( $save );

@{ $nsv6->times } = ( qw[2 4 4 4 5 5 7 9] );
is( $nsv6->stddev_time, 2, 'known value check' );
is( $nsv6->average_time, 5 );
is( $nsv6->median_time,  4.5 );
is( $nsv6->max_time,     9 );
is( $nsv6->min_time,     2 );
@{ $nsv6->times } = ( qw[2 4 4 4 5 5 7] );
is( $nsv6->median_time, 4 );

foreach my $ns ( Zonemaster::Nameserver->all_known_nameservers ) {
    isa_ok( $ns, 'Zonemaster::Nameserver' );
}

ok( scalar( keys %Zonemaster::Nameserver::Cache::object_cache ) >= 4 );

Zonemaster->config->ipv4_ok(0);
Zonemaster->config->ipv6_ok(0);
my $p5 = $nsv6->query( 'iis.se', 'SOA', { dnssec => 1 } );
my $p6 = $nsv4->query( 'iis.se', 'SOA', { dnssec => 1 } );
ok( !defined( $p5 ), 'IPv4 blocked' );
ok( !defined( $p6 ), 'IPv6 blocked' );

Zonemaster->config->ipv4_ok(1);
Zonemaster->config->ipv6_ok(1);
$p5 = $nsv6->query( 'iis.se', 'SOA', { dnssec => 1 } );
$p6 = $nsv4->query( 'iis.se', 'SOA', { dnssec => 1 } );
ok( defined( $p5 ), 'IPv4 not blocked' );
ok( defined( $p6 ), 'IPv6 not blocked' );

is( $p5->edns_size,  4096, 'EDNS0 size' );
is( $p5->edns_rcode, 0,    'EDNS0 rcode' );

$p5->unique_push( 'additional', Net::LDNS::RR->new( 'www.iis.se.		26	IN	A	91.226.36.46' ) );
my ( $rr ) = $p5->additional;
isa_ok( $rr, 'Net::LDNS::RR::A' );

$nsv4->add_fake_ds( 'iis.se' => [ { keytag => 16696, algorithm => 5, type => 1, digest => 'DEADBEEF' } ] );
ok( $nsv4->fake_ds->{'iis.se'}, 'Fake DS data added' );
my $p7 = $nsv4->query( 'iis.se', 'DS', { class => 'IN' } );
isa_ok( $p7, 'Zonemaster::Packet' );
my ( $dsrr ) = $p7->answer;
isa_ok( $dsrr, 'Net::LDNS::RR::DS' );
is( $dsrr->keytag,    16696,      'Expected keytag' );
is( $dsrr->hexdigest, 'deadbeef', 'Expected digest data' );

Zonemaster->config->no_network(0);
my $fail_ns = Zonemaster::Nameserver->new( { name => 'fail', address => '127.0.0.17' } );
my $fail_p = $fail_ns->_query( 'example.org', 'A', {} );
is( $fail_p, undef, 'No return from broken server' );
my ( $e ) = grep { $_->tag eq 'LOOKUP_ERROR' } @{ Zonemaster->logger->entries };
isa_ok( $e, 'Zonemaster::Logger::Entry' );
like( $e->args->{message}, qr/Could not send or receive, because of network error/ );

if ( $ENV{ZONEMASTER_RECORD} ) {
    Zonemaster::Nameserver->save( $datafile );
}
done_testing;
