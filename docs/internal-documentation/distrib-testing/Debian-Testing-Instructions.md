# Zonemaster Engine installation guide before release


The documentation covers the following operating systems:

 * [1] <a href="#Debian">Debian Wheezy (version 7)</a>


The Engine Perl module name is 'Zonemaster'.

## Prerequisite

   No other Zonemaster component is required by the engine.

### <a name="Debian"></a> Instructions for Debian 7

1) Adding an user and required access rights

`adduser username`
- Provide the password
- Add user to the sudoer list using `visudo`
- copy the contents of the ‘root’ and change ‘root’ to ‘username’
- exit


2) Make sure the package database is up to date.

`sudo apt-get update`

2) Install all necessary packages.

`sudo apt-get install build-essential libfile-slurp-perl libjson-perl
liblist-moreutils-perl libio-socket-inet6-perl libmodule-find-perl libmoose-perl
libfile-sharedir-perl libhash-merge-perl libreadonly-perl
libmail-rfc822-address-perl libintl-xs-perl libssl-dev libdevel-checklib-perl
libtest-fatal-perl libtie-simple-perl libio-capture-perl
libgeography-countries-perl libidn11-dev`

3) Install/Configure Git 

`sudo apt-get install git`

`git clone https://github.com/dotse/zonemaster-engine.git` from your home
directory

`cd zonemaster-engine`

4) Locale Issues fix 

`sudo locale-gen en_US.UTF-8 (e.g. change to your locale)`

`sudo dpkg-reconfigure locales`

5) Install modules from CPAN 

`sudo cpan install Module::Install`
`sudo cpan install Net::IP`
`sudo cpan install Net::LDNS`

6) Install Engine

`perl Makefile.PL`
`make`
`make test`

While running `make test` if you get “msgfmt: Command not found” run the
following command
`sudo apt-get install gettext`

`sudo make install`


##### Installing the CLI

1) Install/Configure Git 
`git clone https://github.com/dotse/zonemaster-cli.git` from your home directory

`cd zonemaster-cli`

2) Install all necessary packages.

`sudo apt-get install libmoosex-getopt-perl libtext-reflow-perl
libmodule-install-perl`

3) Install cli

`perl Makefile.PL`
`make test`
`sudo make install`

 
Verify the CLI and Engine 

zoenmaster-cli afnok.fr

