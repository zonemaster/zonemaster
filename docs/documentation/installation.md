# Zonemaster installation guide

This is the installation instructions for the Zonemaster software. The
software has not yet been packaged for any operating systems, and you
have to install most of it from the source code.

The documentation covers the following operating systems:

 * Ubuntu 12.04 (LTS)
 * Ubuntu 14.04 (LTS)
 * Debian Wheezy (version 7)
 * FreeBSD 10.1
 * CentOS 7

## Components

The Zonemaster software contains of several different components. The most important component is the Zonemaster Engine, which is the core library that implements the DNS test framework and all the test cases.

In order to use the Zonemaster Engine you must install one of the applications, the simplest being the CLI interface.

Another application is the web interface which is split in two parts. The user visible component is the Web Frontent, and the backend is responsible for the testing. The CLI and the web interface are both dependent on the Zonemaster Engine.

## Zonemaster Engine installation

### Instructions for Debian 7, Ubuntu 14.04 and Ubuntu 12.04

1) Make sure the package database is up to date.

`sudo apt-get update`

2) Install all necessary packages.

`sudo apt-get install build-essential libfile-slurp-perl libjson-perl liblist-moreutils-perl libio-socket-inet6-perl libmodule-find-perl libmoose-perl libfile-sharedir-perl libhash-merge-perl libreadonly-perl libmail-rfc822-address-perl libintl-xs-perl libssl-dev libdevel-checklib-perl libtest-fatal-perl libtie-simple-perl libio-capture-perl libgeography-countries-perl libidn11-dev`

3) Install non-packaged software.

`sudo cpan -i Text::Capitalize`

`sudo cpan -i Zonemaster`

If necessary, answer any questions from the cpan script by accepting the default value (just press enter).


### Instructions for FreeBSD 10.1

1) Become root.

`su`

2) Install all necessary packages

`pkg install libidn p5-Devel-CheckLib p5-MIME-Base64 p5-Test-Fatal p5-JSON-PP p5-IO-Socket-INET6 p5-Moose p5-Module-Find p5-JSON p5-File-ShareDir p5-File-Slurp p5-Mail-RFC822-Address p5-Hash-Merge p5-Time-HiRes p5-Locale-libintl p5-JSON-XS p5-Readonly-XS p5-Tie-Simple p5-Math-BigInt p5-IP-Country p5-IO-Capture`

3) Install non-packaged-software.

`cpan -i Text::Capitalize`

`cpan -i Zonemaster`

If necessary, answer any questions from the cpan script by accepting the default value (just press enter).

### Instructions for CentOS 7

1) Make sure the development environment is installed.

`sudo yum groupinstall "Development Tools"`

2) Install packages.

`sudo yum install perl-core perl-ExtUtils-MakeMaker perl-File-ShareDir perl-File-Slurp perl-IO-Socket-INET6 perl-JSON perl-List-MoreUtils perl-Readonly perl-Time-HiRes perl-YAML libidn-devel perl-libintl perl-Devel-CheckLib openssl-devel perl-Test-Fatal`

3) Install CPAN modules.

If it's the first time you use the CPAN module, it will ask three questions.
For the first and third, the default responses are fine. For the second, answer
"sudo" (the default is "local::lib", which you do not want).

`sudo cpan -i Text::Capitalize`

`sudo cpan -i Zonemaster`

## Zonemaster CLI installation

### Instructions for Debian 7, Ubuntu 14.04 and Ubuntu 12.04

First install the Zonemaster Engine, following the instructions above.

1) Install necessary packages.

`sudo apt-get install libmoosex-getopt-perl libtext-reflow-perl libmodule-install-perl`

2) Install non-packaged software

`sudo cpan -i Zonemaster::CLI`

3) Now you are ready to run the zonemaster-cli command:

`zonemaster-cli example.com`

### Instructions for FreeBSD 10.1

1) First install the Zonemaster Engine, following the instructions above.

2) Still as root, install necessary packages.

`pkg install p5-MooseX-Getopt p5-Text-Reflow p5-Module-Install`

3) Still as root, install non-packaged software.

`cpan -i Zonemaster::CLI`

4) The CLI tool is now installed and can be run by any user.

    $ zonemaster-cli example.com

### Instructions for CentOS 7

First install the Zonemaster Engine, following the instructions above.

1) Install the CPAN packages.

`sudo cpan -i Zonemaster::CLI`

## Zonemaster Web Interface installation

In order to install the Web Interface you need to install the backend
and the frontend systems. The documentation is located in the repositories
for those components:

 * [Install the Backend](https://github.com/dotse/zonemaster-backend/blob/master/docs/installation.md)
 * [Install the Frontend](https://github.com/dotse/zonemaster-gui/blob/master/Zonemaster_Dancer/Doc/zonemaster-frontend-installation-instructions.md)



-------

Copyright (c) 2013, 2014, 2015, .SE (The Internet Infrastructure Foundation)  
Copyright (c) 2013, 2014, 2015, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <http://creativecommons.org/licenses/by/4.0/>.
