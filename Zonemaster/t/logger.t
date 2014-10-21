use Test::More;
use Test::Fatal;

BEGIN {
    use_ok( 'Zonemaster::Logger' );
    use_ok( 'Zonemaster::Logger::Entry' );
    use_ok( 'Zonemaster::Exception' );
}
use Zonemaster::Util;

my $log = Zonemaster->logger;

isa_ok( $log, 'Zonemaster::Logger' );

$log->add( 'TAG', { seventeen => 17 } );

# Make sure all our policy comes from our config file.
$Zonemaster::Config::policy = {};
Zonemaster->config->load_policy_file('t/policy.json');

my $e = $log->entries->[-1];
isa_ok( $e, 'Zonemaster::Logger::Entry' );
is( $e->module, 'SYSTEM', 'module ok' );
is( $e->tag,    'TAG',    'tag ok' );
is_deeply( $e->args, { seventeen => 17 }, 'args ok' );

my $entry = info( 'TEST', { an => 'argument' } );
isa_ok( $entry, 'Zonemaster::Logger::Entry' );

ok( scalar( @{ Zonemaster->logger->entries } ) >= 2, 'expected number of entries' );

like( "$entry", qr/SYSTEM:TEST an=argument/, 'stringification overload' );

is( $entry->level, 'DEBUG', 'right level' );
my $example = Zonemaster::Logger::Entry->new( { module => 'BASIC', tag => 'NS_FAILED' } );
is( $example->level,         'ERROR', 'expected level' );
is( $example->numeric_level, 4,         'expected numeric level' );

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

$log->callback( sub { die "in callback" } );
$log->add( DO_CRASH => {} );
my %res = map { $_->tag => 1 } @{ $log->entries };
ok( $res{LOGGER_CALLBACK_ERROR}, 'Callback crash logged' );
ok( $res{DO_CRASH},              'DO_CRASH got logged anyway' );
ok( !$log->callback,             'Callback got removed' );

$log->callback( sub { die Zonemaster::Exception->new( { message => 'canary' } ) } );
eval { $log->add( DO_NOT_CRASH => {} ) };
my $err = $@;
%res = map { $_->tag => 1 } @{ $log->entries };
ok( $res{DO_NOT_CRASH}, 'DO_NOT_CRASH got logged' );
ok( $log->callback,     'Callback still there' );
isa_ok( $err, 'Zonemaster::Exception' );
is( "$err", 'canary' );
$log->clear_callback;

ok( Zonemaster->config->load_config_file( 't/config.json' ), 'config loaded' );
$log->add( FILTER_THIS => { when => 1, and => 'this' } );
my $filtered = $log->entries->[-1];
$log->add( FILTER_THIS => { when => 1, and => 'or' } );
my $also_filtered = $log->entries->[-1];
$log->add( FILTER_THIS => { when => 2, and => 'that' } );
my $not_filtered = $log->entries->[-1];

is( $not_filtered->level,  'DEBUG', 'Unfiltered level' );
is( $filtered->level,      'INFO',  'Filtered level' );
is( $also_filtered->level, 'INFO',  'Filtered level' );

my %levels = Zonemaster::Logger::Entry->levels;
is( $levels{CRITICAL}, 5, 'CRITICAL is level 5' );
is( $levels{INFO},     1, 'INFO is level 1' );

ok( @{ $log->entries } > 0, 'There are log entries' );
my $all_json  = $log->json;
my $some_json = $log->json( 'ERROR' );
ok( length( $all_json ) > length( $some_json ), 'All longer than some' );

like(
    $some_json,
qr[[{"args":{"exception":"in callback at t/logger.t line 47, <DATA> line 1.\n"},"level":"ERROR","module":"SYSTEM","tag":"LOGGER_CALLBACK_ERROR","timestamp":0.\d+}]],
    'JSON looks OK'
);

Zonemaster->config->policy->{BASIC}{NS_FAILED} = 'GURKSALLAD';
my $fail = Zonemaster::Logger::Entry->new( { module => 'BASIC', tag => 'NS_FAILED' } );
like( exception { $fail->level }, qr/Unknown level string: GURKSALLAD/, 'Dies on unknown level string' );

done_testing;
