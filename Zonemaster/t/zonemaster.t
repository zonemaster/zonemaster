use Test::More;

BEGIN { use_ok( 'Zonemaster' ) }
BEGIN { use_ok( 'Zonemaster::Test' ) }

isa_ok( Zonemaster->logger, 'Zonemaster::Logger' );
isa_ok( Zonemaster->config, 'Zonemaster::Config' );

my %module = map { $_ => 1 } Zonemaster::Test->modules;

ok($module{Consistency}, 'Consistency');
ok($module{Delegation}, 'Delegation');
ok($module{Syntax}, 'Syntax');
ok($module{Connectivity}, 'Connectivity');

my %methods = Zonemaster->all_methods;
ok(exists($methods{Basic}));

done_testing;
