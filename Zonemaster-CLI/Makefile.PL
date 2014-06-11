use 5.014002;
use strict;
use warnings FATAL => 'all';
use inc::Module::Install;

name     'Zonemaster-CLI';
author   q{Calle Dybedahl <calle@init.se>};
license  'bsd';
all_from 'lib/Zonemaster/CLI.pm';

perl_version 5.014002;

tests_recursive('t');

resources (
   license    => 'http://www.opensource.org/licenses/BSD-3-Clause',
   repository => 'git@github.com:dotse/new-dnscheck.git',
   bugtracker => 'http://rt.cpan.org/NoAuth/Bugs.html?Dist=Zonemaster-CLI',
);

configure_requires (
   'Module::Install' => 0,
);

build_requires (
   'Test::More' => 0,
);

requires (
    'Zonemaster' => 0,
    'MooseX::Getopt' => 0,
    'Getopt::Long::Descriptive' => 0,
    'JSON::XS' => 0,
    'Net::LibIDN' => 0,
);

install_script 'zonemaster-cli';

WriteAll;
