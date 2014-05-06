#!perl -T
use 5.014002;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Giraffa::CLI' ) || print "Bail out!\n";
}

diag( "Testing Giraffa::CLI $Giraffa::CLI::VERSION, Perl $], $^X" );
