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

is($entry->level, 'DEBUG', 'right level');
my $example = Giraffa::Logger::Entry->new({ module => 'BASIC', tag => 'NS_FAILED'});
is($example->level, 'WARNING', 'expected level');

my $canary = 0;
$log->callback(
    sub {
        my ( $e ) = @_;
        isa_ok( $e, 'Giraffa::Logger::Entry' );
        is( $e->tag, 'CALLBACK', 'expected tag in callback' );
        $canary = $e->args->{canary};
    }
);
$log->add( CALLBACK => { canary => 1 } );
ok( $canary, 'canary set' );

done_testing;
