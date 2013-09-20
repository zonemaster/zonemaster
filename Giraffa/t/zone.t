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

done_testing;