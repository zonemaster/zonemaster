# Zonemaster installation guide

## Components

The Zonemaster software contains of several different components. The most important component is the Zonemaster Engine, which is the core library that implements the DNS test framework and all the test cases.

In order to use the Zonemaster Engine you must install one of the applications, the simplest being the CLI interface.

Another application is the web interface which is split in two parts. The user visible component is the Web Frontent, and the backend is responsible for the testing. The CLI and the web interface are both dependent on the Zonemaster Engine.

## Zonemaster Engine installation

### Instructions for Ubuntu 14.04

**To get the source code**

    $ sudo apt-get install git build-essential
    $ git clone https://github.com/dotse/zonemaster.git


**Install package dependencies**

    $ sudo apt-get install libfile-slurp-perl libjson-perl \
    liblist-moreutils-perl libio-socket-inet6-perl libmodule-find-perl \
    libmoose-perl libnet-ip-perl libfile-sharedir-perl libhash-merge-perl \
    libreadonly-perl libldns-dev libmodule-install-perl

**Install CPAN dependencies**

Unfortunately `Locale::TextDomain`, `Net::LDNS` and `RFC::RFC822::Address` has not been packaged for Ubuntu yet. So you need to install these dependencies from CPAN:

	$ sudo perl -MCPAN -e 'install Locale::TextDomain'
    $ sudo perl -MCPAN -e 'install RFC::RFC822::Address'
    $ sudo perl -MCPAN -e 'install Net::LDNS'

If all package dependencies are already installed from the previous section, this should compile and install after configuration of your CPAN module installer.

**Build source code**

    $ cd zonemaster/Zonemaster
    $ perl Makefile.PL
    Writing Makefile for Zonemaster
    Writing MYMETA.yml and MYMETA.json
    $ make test
    $ sudo make install

### Instructions for Debian Wheezy (version 7)

**To get the source code**

    $ sudo aptitude install git build-essential
    $ git clone https://github.com/dotse/zonemaster.git

**Install package dependencies**

      $ sudo aptitude install libfile-slurp-perl libjson-perl \
	  liblist-moreutils-perl libio-socket-inet6-perl libmodule-find-perl \
	  libmoose-perl libnet-ip-perl libfile-sharedir-perl libhash-merge-perl \
	  libreadonly-perl libldns-dev libmodule-install-perl

**Install CPAN dependencies**

Unfortunately `Locale::TextDomain`, `Net::LDNS` and `RFC::RFC822::Address` has not been packaged for Debian yet. So you need to install these dependencies from CPAN:

	$ sudo perl -MCPAN -e 'install Locale::TextDomain'
    $ sudo perl -MCPAN -e 'install RFC::RFC822::Address'

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

    $ cd zonemaster/Zonemaster
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
	$ git clone https://github.com/dotse/zonemaster.git

**Install package dependencies**

	$ sudo pkg install p5-File-ShareDir p5-File-Slurp p5-Hash-Merge \
	p5-IO-Socket-INET6 p5-JSON p5-List-MoreUtils p5-Moose p5-Net-IP \
	p5-Readonly p5-Module-Find p5-Module-Install p5-Devel-CheckLib ldns

**Install CPAN dependencies**

	$ sudo perl -MCPAN -e 'install Locale::TextDomain'
	$ sudo perl -MCPAN -e 'install RFC::RFC822::Address'
	$ sudo perl -MCPAN -e 'install Net::LDNS'

**Build source code**

    $ cd zonemaster/Zonemaster
    $ perl Makefile.PL
	Checking if your kit is complete...
	Looks good
	Generating a Unix-style Makefile
	Writing Makefile for Zonemaster
	Writing MYMETA.yml and MYMETA.json
	$ make test
    $ sudo make install

## Zonemaster CLI installation

### Instructions for Ubuntu 14.04

First install the Zonemaster Engine, following the instructions above.

**Install package dependencies**

    $ sudo apt-get install libmoosex-getopt-perl

**Build source code**

    $ cd zonemaster/Zonemaster-CLI
    $ perl Makefile.PL
    $ make test
    $ sudo make install

Now you are ready to run the zonemaster-cli command:

    $ zonemaster-cli example.com

### Instructions for Debian Wheezy (version 7)

First install the Zonemaster Engine, following the instructions above.

**Install package dependencies**

    $ sudo aptitude install libmoosex-getopt-perl

**Build source code**

    $ cd zonemaster/Zonemaster-CLI
    $ perl Makefile.PL
    $ make test
    $ sudo make install

Now you are ready to run the zonemaster-cli command:

    $ zonemaster-cli example.com

### Instructions for FreeBSD 1.0

First install the Zonemaster Engine, following the instructions above.

**Install package dependencies**

	$ sudo pkg install p5-MooseX-Getopt

**Build source code**

    $ cd zonemaster/Zonemaster-CLI
    $ perl Makefile.PL
    $ make test
    $ sudo make install

Now you are ready to run the zonemaster-cli command:

    $ zonemaster-cli example.com

## Zonemaster Web interface installation

### Backend

### Frontend
