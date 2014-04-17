use Test::More;

BEGIN { use_ok( 'Giraffa::DNSName' ); }

my $name = new_ok( 'Giraffa::DNSName', ['www.iis.se'] );

is_deeply( $name->labels, [ 'www', 'iis', 'se' ] );

my $root = Giraffa::DNSName->new( '' );
is_deeply( $root->labels, [] );
is_deeply( Giraffa::DNSName->new( '.' )->labels, [] );

is( $name->string, 'www.iis.se' );
ok( 'www.iis.se' eq $name,  'Equal without dot' );
ok( 'www.iis.se.' eq $name, 'Equal with dot' );

ok( '.' eq $root, 'Root equal with dot' );
ok( $root eq '.', 'Root equal with dot, other way around' );

is( Giraffa::DNSName->new( labels => [qw(www nic se)] ), 'www.nic.se' );
is_deeply( Giraffa::DNSName->new( 'www.nic.se.' )->labels, [qw(www nic se)] );

is( $name->next_higher,              'iis.se' );
is( $name->next_higher->next_higher, 'se' );
is( $root->next_higher,              undef );

my $lower = Giraffa::DNSName->new( 'iis.se' );
my $upper = Giraffa::DNSName->new( 'IIS.SE' );
ok( $lower eq $upper, 'Comparison is case-insensitive' );

my $one = Giraffa::DNSName->new( 'foo.bar.baz.com' );
my $two = Giraffa::DNSName->new( 'fee.bar.baz.com' );
is( $one->common( $two ), 3, 'common label counting works' );

my $ex = Giraffa::DNSName->new( 'example.org' );
my $pr = $ex->prepend('xx-example');
is($pr, 'xx-example.example.org', "Prepend works: $pr");
is($ex, 'example.org', "Prepend does not change original: $ex");
$pr = $root->prepend('xx-example');
is($pr, 'xx-example', "Prepend to root works: $pr");

done_testing;
