use Test::More;

use strict;
use 5.14.2;

BEGIN { use_ok( 'Giraffa::Zone')};

my $zone = new_ok('Giraffa::Zone' => [{ name => 'iis.se'}]);

isa_ok($zone->parent, 'Giraffa::Zone');
is($zone->parent->name, 'se');

my $root = new_ok('Giraffa::Zone' => [{ name => '.'}]);
is($root->parent, $root);

isa_ok($zone->glue, 'ARRAY');
ok(@{$zone->glue} > 0, 'glue list not empty');
isa_ok($_, 'Giraffa::Nameserver') for @{$zone->glue};

isa_ok($zone->ns, 'ARRAY');
ok(@{$zone->ns} > 0, 'NS list not empty');
isa_ok($_, 'Giraffa::Nameserver') for @{$zone->ns};

isa_ok($zone->glue_addresses, 'ARRAY');
isa_ok($_, 'Net::DNS::RR') for @{$zone->glue_addresses};

my $p = $zone->query_one('www.iis.se', 'A');
isa_ok($p, 'Giraffa::Packet');
my @rrs = $p->get_records('a', 'answer');
is(scalar(@rrs), 1, 'one answer A RR');
is($rrs[0]->address, '91.226.36.46', 'expected address');

my $ary = $zone->query_all('www.iis.se','A');
isa_ok($ary, 'ARRAY');
foreach my $p (@$ary) {
    isa_ok($p, 'Giraffa::Packet');
    my @rrs = $p->get_records('a', 'answer');
    is(scalar(@rrs), 1, 'one answer A RR');
    is($rrs[0]->address, '91.226.36.46', 'expected address');
}


done_testing;