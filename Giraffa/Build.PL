use 5.014002;
use strict;
use warnings FATAL => 'all';
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Giraffa',
    license             => 'perl',
    dist_author         => q{Calle Dybedahl <calle@init.se>},
    dist_version_from   => 'lib/Giraffa.pm',
    release_status      => 'stable',
    configure_requires => {
        'Module::Build' => 0,
    },
    build_requires => {
        'Test::More' => 0,
    },
    requires => {
        'Net::DNS' => 0.72,
        'Net::DNS::SEC' => 0.16,
        'IO::Socket::INET6' => 2.71,
        'Moose' => 2.1005,
        'Module::Find' => 0.11,
    },
    add_to_cleanup     => [ 'Giraffa-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
