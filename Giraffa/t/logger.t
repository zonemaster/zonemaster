use Test::More;

BEGIN { use_ok( 'Giraffa::Logger' ) }
use Giraffa::Util;

my $log = new_ok( 'Giraffa::Logger' );

$log->add( 'TAG', { seventeen => 17 } );

my $e = $log->entries->[0];
isa_ok( $e, 'Giraffa::Logger::Entry' );
is( $e->module, 'MAIN', 'module ok' );
is( $e->tag,    'TAG',  'tag ok' );
is_deeply( $e->args, { seventeen => 17 }, 'args ok' );

my $entry = info( 'TEST', {} );
isa_ok( $entry, 'Giraffa::Logger::Entry' );

done_testing;
