use 5.014002;
use strict;
use warnings FATAL => 'all';
use inc::Module::Install;

name     'Zonemaster-Distributed';
all_from 'lib/Zonemaster/Distributed.pm';
author   q{Calle Dybedahl <calle@init.se>};
license  'perl';

perl_version 5.014002;

tests_recursive('t');

resources (
   license    => 'http://dev.perl.org/licenses/',
   bugtracker => 'https://github.com/dotse/zonemaster/issues',
);

configure_requires (
   'Module::Install' => 0,
);

build_requires (
   'Test::More' => 0,
);

requires (
    'IPC::Run' => 0,
    'Moose' => 0,
    'Zonemaster' => '0.0.4',
    'Net::LibIDN' => 0,
    'JSON::XS' => 0,
    'Digest::SHA' => 0,
    'Daemon::Control' => 0,
    'Log::Log4perl' => 0,
);

install_as_cpan;
WriteAll;
