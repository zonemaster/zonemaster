use Test::More;

BEGIN { use_ok( 'Giraffa' ) }

isa_ok( Giraffa->logger, 'Giraffa::Logger' );
isa_ok( Giraffa->config, 'Giraffa::Config' );

done_testing;
