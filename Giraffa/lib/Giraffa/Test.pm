package Giraffa::Test v0.0.1;

use 5.14.2;
use strict;
use warnings;

use Giraffa;
use Giraffa::Util;
use Giraffa::Test::Basic;

use Module::Find qw[useall];

my @all_test_modules;

INIT {
    @all_test_modules =
      grep { _policy_allowed( $_ ) }
      map { s|^Giraffa::Test::||; $_ }
      grep { $_ ne 'Giraffa::Test::Basic' } useall( 'Giraffa::Test' );
}

sub modules {
    return @all_test_modules;
}

sub run_all_for {
    my ( $class, $zone ) = @_;
    my @results;

    info(
        MODULE_VERSION => {
            module  => 'Giraffa::Test::Basic',
            version => Giraffa::Test::Basic->version
        }
    );
    @results = Giraffa::Test::Basic->all( $zone );

    if ( Giraffa::Test::Basic->can_continue( @results ) ) {
        foreach my $module ( map { "Giraffa::Test::$_" } __PACKAGE__->modules ) {
            info( MODULE_VERSION => { module => $module, version => $module->version } );
            push @results, $module->all( $zone );
        }
    }

    return @results;
} ## end sub run_all_for

sub run_module {
    my ( $class, $module, $zone ) = @_;

    $module = ucfirst( $module );

    if ( grep { $module eq $_ } $class->modules ) {
        my $m = "Giraffa::Test::$module";
        return $m->all( $zone );
    }
    else {
        info( UNKOWN_MODULE => { name => $module, method => 'all' } );
    }

    return;
}

sub run_one {
    my ( $class, $module, $test, @arguments ) = @_;

    if ( grep { $module eq $_ } $class->modules ) {
        my $m = "Giraffa::Test::$module";
        if ( $m->metadata->{$test} ) {
            info( MODULE_CALL => { module => $module, method => $test, version => $m->version } );
            return $m->$test( @arguments );
        }
        else {
            info( UNKNOWN_METHOD => { module => $m, method => $test } );
        }
    }
    else {
        info( UNKNOWN_MODULE => { module => $module, method => $test } );
    }

    return;
}

sub _policy_allowed {
    my ( $name ) = @_;

    return not Giraffa::Util::policy()->{ uc( $name ) }{DISABLED};
}

1;

=head1 NAME

Giraffa::Test - module to find, load and execute all test modules

=head1 SYNOPSIS

    my @results = Giraffa::Test->run_all_for($zone);

=head1 METHODS

=over

=item modules()

Returns a list with the names of all available test modules except L<Giraffa::Test::Basic> (since that one is a bit special).

=item run_all_for($zone)

Runs all (default) tests in all test modules found, and returns a list of the log entry objects they returned.

The order in which the test modules found will be executed is not defined, except that L<Giraffa::Test::Basic> is always executed first. If the
Basic tests fail to indicate a very basic level of function (it must have a parent domain, and it must have at least one nameserver) for the zone,
no further tests will be executed.

Test modules are defined as modules with names starting with "Giraffa::Test::". They are expected to provide at least to class methods, C<all> and
C<version>. C<all> will be given a zone object as its only argument, and is epected to return a list of L<Giraffa::Logger::Entry> objects.
C<version> is called without arguments, and is expected to return a single value indicating the version of the test module. A log entry with this
version will be included in the global log entry list, but not in the list returned from C<run_all_for>.

=item run_module($module, $zone)

Runs all default tests in the named module for the given zone.

=item run_one($module, $method, @arguments)

Run one particular test method in one particular module. The requested module must be in the list of active loaded modules (that is, not the Basic
module and not a module disabled by the current policy), and the method must be listed in the metadata the module exports. If those requirements
are fulfilled, the method will be called with the provided arguments.

=back

=cut
