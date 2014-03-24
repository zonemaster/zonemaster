use Test::More;

BEGIN { use_ok( 'Giraffa' ) }
BEGIN { use_ok( 'Giraffa::Test' ) }

isa_ok( Giraffa->logger, 'Giraffa::Logger' );
isa_ok( Giraffa->config, 'Giraffa::Config' );

my %module = map { $_ => 1 } Giraffa::Test->modules;

ok($module{Consistency}, 'Consistency');
ok($module{Delegation}, 'Delegation');
ok($module{Syntax}, 'Syntax');
ok($module{Connectivity}, 'Connectivity');

done_testing;
