# Zonemaster installation guide

This is the installation instructions for the Zonemaster software. The
software has not yet been packaged for any operating systems, and you
have to install most of it from the source code.

The documentation covers the following operating systems:

 * Ubuntu 14.04 (LTS)
 * Debian Wheezy (version 7)
 * FreeBSD 10.0
 * CentOS 7

## Components

The Zonemaster software contains of several different components. The most important component is the Zonemaster Engine, which is the core library that implements the DNS test framework and all the test cases.

In order to use the Zonemaster Engine you must install one of the applications, the simplest being the CLI interface.

Another application is the web interface which is split in two parts. The user visible component is the Web Frontent, and the backend is responsible for the testing. The CLI and the web interface are both dependent on the Zonemaster Engine.

## Zonemaster Engine installation

### Instructions for Ubuntu 14.04

**To get the source code**

    $ sudo apt-get install git build-essential
    $ git clone https://github.com/dotse/zonemaster-engine.git

**Install package dependencies**

    $ sudo apt-get install libfile-slurp-perl libjson-perl \
    liblist-moreutils-perl libio-socket-inet6-perl libmodule-find-perl \
    libmoose-perl libnet-ip-perl libfile-sharedir-perl libhash-merge-perl \
    libreadonly-perl libldns-dev libmodule-install-perl \
	libmail-rfc822-address-perl libintl-xs-perl

**Install CPAN dependencies**

Unfortunately `Net::LDNS` has not been packaged for Ubuntu yet. So you need to install this dependency from CPAN:

    $ sudo perl -MCPAN -e 'install Net::LDNS'

You also need Net::IP::XS from CPAN:

	$ sudo perl -MCPAN -e 'install Net::IP::XS'

If all package dependencies are already installed from the previous section, this should compile and install after configuration of your CPAN module installer.

**Build source code**

	$ cd zonemaster-engine
    $ perl Makefile.PL
    Writing Makefile for Zonemaster
    Writing MYMETA.yml and MYMETA.json
    $ make test
    $ sudo make install

### Instructions for Debian Wheezy (version 7)

**To get the source code**

    $ sudo aptitude install git build-essential
    $ git clone https://github.com/dotse/zonemaster-engine.git

**Install package dependencies**

      $ sudo aptitude install libfile-slurp-perl libjson-perl \
	  liblist-moreutils-perl libio-socket-inet6-perl libmodule-find-perl \
	  libmoose-perl libnet-ip-perl libfile-sharedir-perl libhash-merge-perl \
	  libreadonly-perl libldns-dev libmodule-install-perl \
	  libmail-rfc822-address-perl

**Install CPAN dependencies**

Unfortunately `Net::IP::XS`, `Locale::TextDomain` and `Net::LDNS` have not been packaged for Debian yet. So you need to install these dependencies from CPAN:

	$ sudo perl -MCPAN -e 'install Net::IP::XS'
	$ sudo perl -MCPAN -e 'install Locale::TextDomain'

The version of ldns that Net::LDNS is based on is too old for Zonemaster, thus it has to be installed from source. However, ldns requires some more packages to be installed.

	$ sudo aptitude install libssl-dev zlib1g-dev

Fetch the lates version of ldns (as of this writing 1.6.17):

	$ wget http://www.nlnetlabs.nl/downloads/ldns/ldns-1.6.17.tar.gz
	$ tar zxf ldns-1.6.17.tar.gz
	$ cd ldns-1.6.17
	$ ./configure
	$ make
	$ sudo make install
	$ sudo ldconfig

Now that ldns has been installed, install Net::LDNS:

    $ sudo perl -MCPAN -e 'install Net::LDNS'

If all package dependencies are already installed from the previous section, this should compile and install after configuration of your CPAN module installer.

**Build source code**

	$ cd zonemaster-engine
    $ perl Makefile.PL
	Checking if your kit is complete...
	Looks good
	Generating a Unix-style Makefile
	Writing Makefile for Zonemaster
	Writing MYMETA.yml and MYMETA.json
	$ make test
    $ sudo make install

### Instructions for FreeBSD 10.0

**To get the source code**

	$ sudo pkg install git
    $ git clone https://github.com/dotse/zonemaster-engine.git

**Install package dependencies**

	$ sudo pkg install p5-File-ShareDir p5-File-Slurp p5-Hash-Merge \
	p5-IO-Socket-INET6 p5-JSON p5-List-MoreUtils p5-Moose p5-Net-IP \
	p5-Readonly p5-Module-Find p5-Module-Install p5-Devel-CheckLib \
	ldns p5-Mail-RFC822-Address-0.3 p5-Locale-libintl

**Install CPAN dependencies**

	$ sudo perl -MCPAN -e 'install Net::LDNS'

**Build source code**

	$ cd zonemaster-engine
    $ perl Makefile.PL
	Checking if your kit is complete...
	Looks good
	Generating a Unix-style Makefile
	Writing Makefile for Zonemaster
	Writing MYMETA.yml and MYMETA.json
	$ make test
    $ sudo make install

### Instructions for CentOS 7

**To get the source code**

	$ sudo yum install git
    $ git clone https://github.com/dotse/zonemaster-engine.git

**Install package dependencies**

	$ sudo yum install perl perl-ExtUtils-MakeMaker perl-File-ShareDir \
	perl-File-Slurp perl-IO-Socket-INET6 perl-JSON perl-List-MoreUtils \
	perl-Readonly perl-Time-HiRes perl-YAML ldns-devel

Zonemaster works better with ldns version 1.6.17 and up, CentOS includes
ldns 1.6.16 that works.

**Install CPAN dependencies**

Unfortunately a lot of Perl modules has not been packaged for Debian yet. So you need to install these dependencies from CPAN:

	$ sudo yum install perl-CPAN gcc

	$ sudo perl -MCPAN -e 'install Hash::Merge'
	$ sudo perl -MCPAN -e 'install Locale::TextDomain'
	$ sudo perl -MCPAN -e 'install Mail::RFC822::Address'
	$ sudo perl -MCPAN -e 'install Module::Find'
	$ sudo perl -MCPAN -e 'install Moose'
	$ sudo perl -MCPAN -e 'install Net::IP'
    $ sudo perl -MCPAN -e 'install Net::LDNS'

**Build source code**

	$ cd zonemaster-engine
    $ perl Makefile.PL
	Writing Makefile for Zonemaster
	Writing MYMETA.yml and MYMETA.json	$ make test
    $ sudo make install

## Zonemaster CLI installation

### Instructions for Ubuntu 14.04

First install the Zonemaster Engine, following the instructions above.

**To get the source code**

    $ git clone https://github.com/dotse/zonemaster-cli.git

**Install package dependencies**

    $ sudo apt-get install libmoosex-getopt-perl libtext-reflow-perl

**Build source code**

    $ cd zonemaster-cli
    $ perl Makefile.PL
    $ make test
    $ sudo make install

Now you are ready to run the zonemaster-cli command:

    $ zonemaster-cli example.com

### Instructions for Debian Wheezy (version 7)

First install the Zonemaster Engine, following the instructions above.

**To get the source code**

    $ git clone https://github.com/dotse/zonemaster-cli.git

**Install package dependencies**

    $ sudo aptitude install libmoosex-getopt-perl libtext-reflow-perl

**Build source code**

    $ cd zonemaster-cli
    $ perl Makefile.PL
    $ make test
    $ sudo make install

Now you are ready to run the zonemaster-cli command:

    $ zonemaster-cli example.com

### Instructions for FreeBSD 10.0

First install the Zonemaster Engine, following the instructions above.

**To get the source code**

    $ git clone https://github.com/dotse/zonemaster-cli.git

**Install package dependencies**

	$ sudo pkg install p5-MooseX-Getopt p5-Text-Reflow

**Build source code**

    $ cd zonemaster-cli
    $ perl Makefile.PL
    $ make test
    $ sudo make install

Now you are ready to run the zonemaster-cli command:

    $ zonemaster-cli example.com

### Instructions for CentOS 7

First install the Zonemaster Engine, following the instructions above.

**To get the source code**

    $ git clone https://github.com/dotse/zonemaster-cli.git

**Install package dependencies**

	$ sudo yum install perl-Module-Install
	$ sudo yum install perl-Getopt-Long

	$ sudo perl -MCPAN -e 'install Getopt::Long::Descriptive'
	$ sudo perl -MCPAN -e 'install MooseX::Getopt'
	$ sudo perl -MCPAN -e 'install Text::Reflow'

**Build source code**

    $ cd zonemaster-cli
    $ perl Makefile.PL
    $ make test
    $ sudo make install

Now you are ready to run the zonemaster-cli command:

    $ zonemaster-cli example.com

## Zonemaster Web Interface installation

In order to install the Web Interface you need to install the backend
and the frontend systems. The documentation is located in the repositories
for those components:

 * [Install the Backend](https://github.com/dotse/zonemaster-backend/blob/master/Doc/zonemaster-backend-installation-instructions.md)
 * [Install the Frontend](https://github.com/dotse/zonemaster-gui/blob/master/Zonemaster_Dancer/Doc/zonemaster-frontend-installation-instructions.md)
