use 5.014002;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Zonemaster::CLI' ) || print "Bail out!\n";
}

diag( "Testing Zonemaster::CLI $Zonemaster::CLI::VERSION, Perl $], $^X" );
