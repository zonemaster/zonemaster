use inc::Module::Install;

name 'Giraffa';

license 'bsd';
all_from 'lib/Giraffa.pm';

requires 'Net::DNS' => 0.72;
requires 'Net::DNS::SEC' => 0.16;
requires 'IO::Socket::INET6' => 2.71;
requires 'Moose' => 2.1005;
requires 'Module::Find' => 0.11;

install_script 'giraffa';
install_share 'defaults';

WriteAll;