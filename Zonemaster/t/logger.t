use Test::More;

BEGIN { use_ok( 'Zonemaster::Logger' ) }
use Zonemaster::Util;

my $log = Zonemaster->logger;

isa_ok( $log, 'Zonemaster::Logger' );

$log->add( 'TAG', { seventeen => 17 } );

my $e = $log->entries->[0];
isa_ok( $e, 'Zonemaster::Logger::Entry' );
is( $e->module, 'SYSTEM', 'module ok' );
is( $e->tag,    'TAG',    'tag ok' );
is_deeply( $e->args, { seventeen => 17 }, 'args ok' );

my $entry = info( 'TEST', { an => 'argument' } );
isa_ok( $entry, 'Zonemaster::Logger::Entry' );

is( scalar( @{ Zonemaster->logger->entries } ), 2, 'expected number of entries' );

like( "$entry", qr/SYSTEM:TEST an=argument/, 'stringification overload' );

is( $entry->level, 'DEBUG', 'right level' );
my $example = Zonemaster::Logger::Entry->new( { module => 'BASIC', tag => 'NS_FAILED' } );
is( $example->level, 'WARNING', 'expected level' );

my $canary = 0;
$log->callback(
    sub {
        my ( $e ) = @_;
        isa_ok( $e, 'Zonemaster::Logger::Entry' );
        is( $e->tag, 'CALLBACK', 'expected tag in callback' );
        $canary = $e->args->{canary};
    }
);
$log->add( CALLBACK => { canary => 1 } );
ok( $canary, 'canary set' );

$log->callback(
    sub { die "in callback"}
);
$log->add( DO_CRASH => {} );
my %res = map {$_->tag => 1} @{$log->entries};
ok($res{LOGGER_CALLBACK_ERROR}, 'Callback crash logged');
ok($res{DO_CRASH}, 'DO_CRASH got logged anyway');
ok(!$log->callback, 'Callback got removed');

ok(Zonemaster->config->load_config_file('t/config.json'), 'config loaded');
$log->add( FILTER_THIS => { when => 1, and => 'this' });
my $filtered = $log->entries->[-1];
$log->add( FILTER_THIS => { when => 1, and => 'or' });
my $also_filtered = $log->entries->[-1];
$log->add( FILTER_THIS => { when => 2, and => 'that' });
my $not_filtered = $log->entries->[-1];

is($not_filtered->level, 'DEBUG', 'Unfiltered level');
is($filtered->level, 'INFO', 'Filtered level');
is($also_filtered->level, 'INFO', 'Filtered level');

done_testing;
