package Zonemaster::Test v0.0.3;

use 5.14.2;
use strict;
use warnings;

use Zonemaster;
use Zonemaster::Util;
use Zonemaster::Test::Basic;

use IO::Socket::INET6;    # Lazy-loads, so make sure it's here for the version logging

use Module::Find qw[useall];
use Scalar::Util qw[blessed];

my @all_test_modules;

@all_test_modules =
  sort {$a cmp $b}
  map { my $f = $_; $f =~ s|^Zonemaster::Test::||; $f }
  grep { $_ ne 'Zonemaster::Test::Basic' } useall( 'Zonemaster::Test' );

sub _log_dependency_versions {
    info( DEPENDENCY_VERSION => { name => 'Net::LDNS',            version => $Net::LDNS::VERSION } );
    info( DEPENDENCY_VERSION => { name => 'IO::Socket::INET6',    version => $IO::Socket::INET6::VERSION } );
    info( DEPENDENCY_VERSION => { name => 'Moose',                version => $Moose::VERSION } );
    info( DEPENDENCY_VERSION => { name => 'Module::Find',         version => $Module::Find::VERSION } );
    info( DEPENDENCY_VERSION => { name => 'JSON',                 version => $JSON::VERSION } );
    info( DEPENDENCY_VERSION => { name => 'File::ShareDir',       version => $File::ShareDir::VERSION } );
    info( DEPENDENCY_VERSION => { name => 'File::Slurp',          version => $File::Slurp::VERSION } );
    info( DEPENDENCY_VERSION => { name => 'Net::IP',              version => $Net::IP::VERSION } );
    info( DEPENDENCY_VERSION => { name => 'List::MoreUtils',      version => $List::MoreUtils::VERSION } );
    info( DEPENDENCY_VERSION => { name => 'Mail::RFC822::Address', version => $Mail::RFC822::Address::VERSION } );
    info( DEPENDENCY_VERSION => { name => 'Scalar::Util',         version => $Scalar::Util::VERSION } );
    info( DEPENDENCY_VERSION => { name => 'Hash::Merge',          version => $Hash::Merge::VERSION } );
    info( DEPENDENCY_VERSION => { name => 'Readonly',             version => $Readonly::VERSION } );

    foreach my $file (@{Zonemaster->config->cfiles}) {
        info( CONFIG_FILE => { name => $file } );
    }
    foreach my $file (@{Zonemaster->config->pfiles}) {
        info( POLICY_FILE => { name => $file } );
    }
}

sub modules {
    return @all_test_modules;
}

sub run_all_for {
    my ( $class, $zone ) = @_;
    my @results;

    Zonemaster->start_time_now();
    info(
        MODULE_VERSION => {
            module  => 'Zonemaster::Test::Basic',
            version => Zonemaster::Test::Basic->version
        }
    );
    _log_dependency_versions();

    if (not (Zonemaster->config->ipv4_ok or Zonemaster->config->ipv6_ok)) {
        return info( NO_NETWORK => {});
    }

    @results = Zonemaster::Test::Basic->all( $zone );

    if ( Zonemaster::Test::Basic->can_continue( @results ) ) {
        ## no critic (Modules::RequireExplicitInclusion)
        foreach my $mod ( __PACKAGE__->modules ) {
            Zonemaster->config->load_module_policy($mod);

            if (not _policy_allowed($mod)) {
                push @results, info( POLICY_DISABLED => {name => $mod} );
                next;
            }

            my $module = "Zonemaster::Test::$mod";
            info( MODULE_VERSION => { module => $module, version => $module->version } );
            my @res = eval { $module->all( $zone ) };
            if ( $@ ) {
                my $err = $@;
                if ( blessed $err and $err->isa( 'Zonemaster::Exception' ) ) {
                    die $err;    # Utility exception, pass it on
                }
                else {
                    push @res, info( MODULE_ERROR => { module => $module, msg => "$err" } );
                }
            }

            push @results, @res;
        }
    }
    else {
        push @results, info( CANNOT_CONTINUE => { zone => $zone->name->string });
    }

    return @results;
} ## end sub run_all_for

sub run_module {
    my ( $class, $requested, $zone ) = @_;

    my ( $module ) = grep { lc( $requested ) eq lc( $_ ) } $class->modules;
    $module = 'Basic' if ( not $module and lc( $requested ) eq 'basic' );

    Zonemaster->start_time_now();
    if (not (Zonemaster->config->ipv4_ok or Zonemaster->config->ipv6_ok)) {
        return info( NO_NETWORK => {});
    }

    if ( $module ) {
        Zonemaster->config->load_module_policy($module);
        my $m = "Zonemaster::Test::$module";
        info( MODULE_VERSION => { module => $m, version => $m->version } );
        my @res = eval { $m->all( $zone ) };
        if ( $@ ) {
            my $err = $@;
            if ( blessed $err and $err->isa( 'Zonemaster::Exception' ) ) {
                die $err;    # Utility exception, pass it on
            }
            else {
                push @res, info( MODULE_ERROR => { module => $module, msg => "$err" } );
            }
        }
        return @res;
    }
    else {
        info( UNKNOWN_MODULE => { name => $requested, method => 'all', known => join( ':', sort $class->modules ) } );
    }

    return;
} ## end sub run_module

sub run_one {
    my ( $class, $requested, $test, @arguments ) = @_;

    my ( $module ) = grep { lc( $requested ) eq lc( $_ ) } $class->modules;
    $module = 'Basic' if ( not $module and lc( $requested ) eq 'basic' );

    Zonemaster->start_time_now();
    if (not (Zonemaster->config->ipv4_ok or Zonemaster->config->ipv6_ok)) {
        return info( NO_NETWORK => {});
    }

    if ( $module ) {
        Zonemaster->config->load_module_policy($module);
        my $m = "Zonemaster::Test::$module";
        if ( $m->metadata->{$test} ) {
            info( MODULE_CALL => { module => $module, method => $test, version => $m->version } );
            my @res = eval { $m->$test( @arguments ) };
            if ( $@ ) {
                my $err = $@;
                if ( blessed $err and $err->isa( 'Zonemaster::Exception' ) ) {
                    die $err;    # Utility exception, pass it on
                }
                else {
                    push @res, info( MODULE_ERROR => { module => $module, msg => "$err" } );
                }
            }
            return @res;
        }
        else {
            info( UNKNOWN_METHOD => { module => $m, method => $test } );
        }
    } ## end if ( $module )
    else {
        info( UNKNOWN_MODULE => { module => $requested, method => $test, known => join( ':', sort $class->modules) } );
    }

    return;
} ## end sub run_one

sub _policy_allowed {
    my ( $name ) = @_;

    return not Zonemaster::Util::policy()->{ uc( $name ) }{DISABLED};
}

1;

=head1 NAME

Zonemaster::Test - module to find, load and execute all test modules

=head1 SYNOPSIS

    my @results = Zonemaster::Test->run_all_for($zone);

=head1 METHODS

=over

=item modules()

Returns a list with the names of all available test modules except L<Zonemaster::Test::Basic> (since that one is a bit special).

=item run_all_for($zone)

Runs all (default) tests in all test modules found, and returns a list of the log entry objects they returned.

The order in which the test modules found will be executed is not defined, except that L<Zonemaster::Test::Basic> is always executed first. If the
Basic tests fail to indicate a very basic level of function (it must have a parent domain, and it must have at least one nameserver) for the zone,
no further tests will be executed.

Test modules are defined as modules with names starting with "Zonemaster::Test::". They are expected to provide at least to class methods, C<all> and
C<version>. C<all> will be given a zone object as its only argument, and is epected to return a list of L<Zonemaster::Logger::Entry> objects.
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
