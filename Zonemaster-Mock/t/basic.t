use Test::More;

use strict;
use warnings;
use 5.12.3;

use_ok('Zonemaster::Mock', ':all');
use_ok('Zonemaster');
use_ok('Zonemaster::Nameserver');

load_and_link_zonefiles('t/zmfake.se');

my %ns = map {$_ => 1} Zonemaster::Nameserver->all_known_nameservers();

foreach my $n (qw[ns1.zmfake.se/192.168.17.1 ns1.zmfake.se/17::23 ns2.zmfake.se/172.17.17.17 ns3.zmfake.se/10.11.12.13]) {
    ok($ns{$n}, $n)
}

my $zone = Zonemaster->zone('zmfake.se');
isa_ok($zone, 'Zonemaster::Zone');
my $parent = $zone->parent;
my $ns = $parent->ns->[0];
my $p = $ns->query('zmfake.se', 'NS');
is($p->rcode, 'NOERROR', 'RCODE ok');
is(scalar($p->answer), 3, '3 answer RRs');
is(scalar($p->additional), 4, '4 additional RRs');

is(scalar(@{$zone->glue}), 4, '4 glue entries');
is(scalar(@{$zone->ns}), 4, '4 ns entries');

$p = $zone->query_one('www.zmfake.se', 'A');
my %type = map {$_->type => $_} $p->answer;
ok($type{CNAME}, 'Has a CNAME');
ok($type{A}, 'Has an A');

my @msg = Zonemaster->test_zone($zone->name);
my %tags = map {$_->tag => 1} @msg;
ok($tags{NAMESERVER_IPV6_ADDRESS_BOGON}, 'NAMESERVER_IPV6_ADDRESS_BOGON');
ok($tags{NAMESERVER_IP_PRIVATE_NETWORK}, 'NAMESERVER_IP_PRIVATE_NETWORK');

done_testing;