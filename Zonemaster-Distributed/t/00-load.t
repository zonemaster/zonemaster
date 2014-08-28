#!perl -T
use 5.014002;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Zonemaster::Distributed' ) || print "Bail out!\n";
}

diag( "Testing Zonemaster::Distributed $Zonemaster::Distributed::VERSION, Perl $], $^X" );
