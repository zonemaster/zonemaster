use Test::More;

BEGIN { use_ok( 'Giraffa' ) }
BEGIN { use_ok( 'Giraffa::Test' ) }

isa_ok( Giraffa->logger, 'Giraffa::Logger' );
isa_ok( Giraffa->config, 'Giraffa::Config' );

is_deeply( [ sort Giraffa::Test->modules ], [sort qw'Delegation Hostname'] );

done_testing;
