use Test::More;

BEGIN { use_ok( 'Giraffa::Logger' ) }
use Giraffa::Util;

my $log = Giraffa->logger;
isa_ok( $log, 'Giraffa::Logger' );

$log->add( 'TAG', { seventeen => 17 } );

my $e = $log->entries->[0];
isa_ok( $e, 'Giraffa::Logger::Entry' );
is( $e->module, 'SYSTEM', 'module ok' );
is( $e->tag,    'TAG',    'tag ok' );
is_deeply( $e->args, { seventeen => 17 }, 'args ok' );

my $entry = info( 'TEST', { an => 'argument' } );
isa_ok( $entry, 'Giraffa::Logger::Entry' );

is( scalar( @{ Giraffa->logger->entries } ), 2, 'expected number of entries' );

like( "$entry", qr/SYSTEM:TEST an=argument/, 'stringification overload' );

done_testing;
