package Giraffa::Test::Example v0.0.1;

###
### This test module is meant to serve as an example when writing proper ones.
###

use 5.14.2;
use strict;
use warnings;

use Giraffa;
use Giraffa::Util;

###
### Entry points
###

sub all {
    my ( $class, $zone ) = @_;
    my @results;

    push @results, $class->placeholder;

    return @results;
}

###
### Metadata Exposure
###

sub metadata {
    my ( $class ) = @_;

    return {
        placeholder => [qw( GAZONK )]
    };
}

sub version {
    return "$Giraffa::Test::Example::VERSION";
}

###
### Tests
###

sub placeholder {
    my ( $class, $zone ) = @_;
    my @results;

    push @results, info( EXAMPLE_TAG => { example_arg => 'example_value' });

    return @results;
}

1;