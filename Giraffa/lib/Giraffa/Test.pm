package Giraffa::Test v0.0.1;

use 5.14.2;
use strict;
use warnings;

use Giraffa;
use Giraffa::Util;
use Giraffa::Test::Basic;

use Module::Find qw[useall];

my @all_test_modules = map {s|^Giraffa::Test::||;$_} grep {$_ ne 'Giraffa::Test::Basic'} useall('Giraffa::Test');

sub modules {
    return @all_test_modules;
}

sub run_all_for {
    my ( $class, $zone ) = @_;
    my @results;

    info( MODULE_VERSION => {module => 'Giraffa::Test::Basic', version => Giraffa::Test::Basic->version});
    @results = Giraffa::Test::Basic->all($zone);

    if (Giraffa::Test::Basic->can_continue(@results)) {
        foreach my $module (map {"Giraffa::Test::$_"} __PACKAGE__->modules) {
            info( MODULE_VERSION => {module => $module, version => $module->version});
            push @results, $module->all($zone);
        }
    }

    return @results;
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

=back

=cut