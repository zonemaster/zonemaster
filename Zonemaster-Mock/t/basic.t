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

done_testing;