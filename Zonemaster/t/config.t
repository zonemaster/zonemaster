use Test::More;

BEGIN { use_ok( 'Zonemaster::Config' ) }
use Zonemaster::Util;

my $ref = Zonemaster::Config->get;

isa_ok( $ref, 'HASH' );
is( $ref->{resolver}{defaults}{retry},   2, 'retry exists and has expected value' );
is( Zonemaster->config->resolver_defaults->{retry}, 2, 'access other way works too' );

isa_ok( Zonemaster::Config->policy, 'HASH', 'policy got loaded and' );
is( Zonemaster::Config->policy->{'EXAMPLE'}{'EXAMPLE_TAG'}, 'DEBUG', 'found policy for example tag' );
Zonemaster::Config->load_module_policy("DNSSEC");
is( Zonemaster::Config->policy->{DNSSEC}{ALGORITHM_OK}, 'DEBUG', 'Found policy loaded from module');

Zonemaster::Config->load_config_file( 't/config.json' );
is( Zonemaster->config->resolver_defaults->{retry}, 4711, 'loading config works' );

Zonemaster::Config->load_policy_file( 't/policy.json' );
is( Zonemaster::Config->policy->{'EXAMPLE'}{'EXAMPLE_TAG'}, 'WARNING', 'loading policy works' );

done_testing;
