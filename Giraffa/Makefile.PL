use inc::Module::Install;
use Module::Install::Share;

name 'Giraffa';

license 'bsd';
all_from 'lib/Giraffa.pm';

requires 'Net::LDNS' => 0.59;
requires 'IO::Socket::INET6' => 2.69;
requires 'Moose' => 2.0401;
requires 'Module::Find' => 0.10;
requires 'JSON' => 2.53;
requires 'File::ShareDir' => 1.00;
requires 'File::Slurp' => 0;
requires 'Net::IP' => 0;
requires 'List::MoreUtils' => 0;
requires 'RFC::RFC822::Address' => 0;

recommends 'JSON::XS' => 2.32;

install_script 'giraffa';
install_share;

WriteAll;
