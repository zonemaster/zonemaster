use 5.014002;
use strict;
use warnings FATAL => 'all';
use inc::Module::Install;

name     'Giraffa-CLI';
all_from 'lib/Giraffa/CLI.pm';
author   q{Calle Dybedahl <calle@init.se>};
license  'bsd';

perl_version 5.014002;

tests_recursive('t');

resources (
   #homepage   => 'http://yourwebsitehere.com',
   #IRC        => 'irc://irc.perl.org/#Giraffa-CLI',
   license    => 'http://www.opensource.org/licenses/BSD-3-Clause',
   #repository => 'git://github.com/Calle Dybedahl/Giraffa-CLI.git',
   bugtracker => 'http://rt.cpan.org/NoAuth/Bugs.html?Dist=Giraffa-CLI',
);

configure_requires (
   'Module::Install' => 0,
);

build_requires (
   'Test::More' => 0,
);

requires (
   #'ABC'              => 1.6,
   #'Foo::Bar::Module' => 5.0401,
);

install_as_cpan;
auto_install;
WriteAll;
