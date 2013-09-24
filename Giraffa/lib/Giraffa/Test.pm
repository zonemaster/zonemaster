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