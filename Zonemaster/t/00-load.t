use 5.014002;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Zonemaster' ) || print "Bail out!\n";
}

diag( "Testing Zonemaster $Zonemaster::VERSION, Perl $], $^X" );
