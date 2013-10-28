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

    return { placeholder => [qw( EXAMPLE_TAG )] };
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

    push @results, info( EXAMPLE_TAG => { example_arg => 'example_value' } );

    return @results;
}

1;

=head1 NAME

Giraffa::Test::Example - example module showing the expected structure of Giraffa test modules

=head1 SYNOPSIS

    my @results = Giraffa::Test::Example->all($zone);

=head1 METHODS

=over

=item all($zone)

Runs the default set of tests and returns a list of log entries made by the tests.

=item metadata()

Returns a reference to a hash, the keys of which are the names of all test methods in the module, and the corresponding values are references to
lists with all the tags that the method can use in log entries.

=item version()

Returns a version string for the module.

=back

=head1 TESTS

=over

=item placeholder($zone)

Since this is an example module, this test does nothing except return a single log entry.

=back

=cut
