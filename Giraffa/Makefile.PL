use inc::Module::Install;

name 'Giraffa';

license 'bsd';
all_from 'lib/Giraffa.pm';

requires 'Net::DNS' => 0.72;
requires 'Net::DNS::SEC' => 0.16;
requires 'IO::Socket::INET6' => 2.69;
requires 'Moose' => 2.0401;
requires 'Module::Find' => 0.10;
requires 'JSON' => 2.53;

recommends 'JSON::XS' => 2.32;

install_script 'giraffa';
install_share 'defaults';

WriteAll;