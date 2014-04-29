use Test::More;

BEGIN { use_ok( 'Giraffa::Config' ) }
use Giraffa::Util;

my $ref = Giraffa::Config->get;

isa_ok( $ref, 'HASH' );
is( $ref->{resolver}{defaults}{retry},   2, 'retry exists and has expected value' );
is( config->{resolver}{defaults}{retry}, 2, 'access other way works too' );

my $policy = Giraffa::Config->policy;
isa_ok( $policy, 'HASH', 'policy got loaded and' );
is( $policy->{'EXAMPLE'}{'EXAMPLE_TAG'}, 'DEBUG', 'found policy for example tag' );

Giraffa::Config->load_config_file('t/config.json');
is( config->{resolver}{defaults}{retry}, 4711, 'loading config works' );

Giraffa::Config->load_policy_file('t/policy.json');
is( Giraffa::Config->policy->{'EXAMPLE'}{'EXAMPLE_TAG'}, 'WARNING', 'loading policy works' );

done_testing;
