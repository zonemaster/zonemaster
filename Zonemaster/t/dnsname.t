use Test::More;

BEGIN { use_ok( 'Zonemaster::DNSName' ); }

my $name = new_ok( 'Zonemaster::DNSName', ['www.iis.se'] );

is_deeply( $name->labels, [ 'www', 'iis', 'se' ] );

my $root = Zonemaster::DNSName->new( '' );
is_deeply( $root->labels, [] );
is_deeply( Zonemaster::DNSName->new( '.' )->labels, [] );

is( $name->string, 'www.iis.se' );
ok( 'www.iis.se' eq $name,  'Equal without dot' );
ok( 'www.iis.se.' eq $name, 'Equal with dot' );

ok( '.' eq $root, 'Root equal with dot' );
ok( $root eq '.', 'Root equal with dot, other way around' );

is( Zonemaster::DNSName->new( labels => [qw(www nic se)] ), 'www.nic.se' );
is_deeply( Zonemaster::DNSName->new( 'www.nic.se.' )->labels, [qw(www nic se)] );

is( $name->next_higher,              'iis.se' );
is( $name->next_higher->next_higher, 'se' );
is( $root->next_higher,              undef );

my $lower = Zonemaster::DNSName->new( 'iis.se' );
my $upper = Zonemaster::DNSName->new( 'IIS.SE' );
ok( $lower eq $upper, 'Comparison is case-insensitive' );

my $one = Zonemaster::DNSName->new( 'foo.bar.baz.com' );
my $two = Zonemaster::DNSName->new( 'fee.bar.baz.com' );
is( $one->common( $two ), 3, 'common label counting works' );

my $ex = Zonemaster::DNSName->new( 'example.org' );
my $pr = $ex->prepend('xx-example');
is($pr, 'xx-example.example.org', "Prepend works: $pr");
is($ex, 'example.org', "Prepend does not change original: $ex");
$pr = $root->prepend('xx-example');
is($pr, 'xx-example', "Prepend to root works: $pr");

done_testing;
