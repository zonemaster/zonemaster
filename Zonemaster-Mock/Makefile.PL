use 5.014002;
use strict;
use warnings FATAL => 'all';
use inc::Module::Install;

name     'Zonemaster-Mock';
author   q{Calle Dybedahl <calle@init.se>};
license  'perl';
all_from 'lib/Zonemaster/Mock.pm';

perl_version 5.014002;

tests_recursive( 't' );

resources(
    repository => 'git@github.com:dotse/zonemaster.git',
    bugtracker => 'https://github.com/dotse/zonemaster/issues',
);

configure_requires( 'Module::Install' => 0, );

build_requires( 'Test::More' => 0, );

requires( 'Net::LDNS' => 0.67, );

WriteAll;
