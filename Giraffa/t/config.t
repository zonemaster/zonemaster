use Test::More;

BEGIN { use_ok( 'Giraffa::Config' ) }
use Giraffa::Util;

my $ref = Giraffa::Config->get;

isa_ok( $ref, 'HASH' );
is( $ref->{resolver}{defaults}{retry},   1, 'retry exists and has expected value' );
is( config->{resolver}{defaults}{retry}, 1, 'access other way works too' );

my $policy = Giraffa::Config->policy;
isa_ok( $policy, 'HASH', 'policy got loaded and' );
is( $policy->{'EXAMPLE'}{'EXAMPLE_TAG'}, 'DEBUG', 'found policy for example tag' );

done_testing;
