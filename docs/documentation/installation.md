# ZoneMaster installation guide

## Components

The ZoneMaster software contains of several different components. The most important component is the ZoneMaster Engine, which is the core library that implements the DNS test framework and all the test cases.

In order to use the ZoneMaster Engine you must install one of the applications, the simplest being the CLI interface.

Another application is the web interface which is split in two parts. The user visible component is the Web Frontent, and the backend is responsible for the testing. The CLI and the web interface are both dependent on the ZoneMaster Engine.

## ZoneMaster Engine installation

### Instructions for Ubuntu 14.04

**To get the source code**

    $ sudo apt-get install git build-essential
    $ git clone https://github.com/dotse/zonemaster.git


**Install package dependencies**

    $ sudo apt-get install libfile-slurp-perl libjson-perl
    liblist-moreutils-perl libio-socket-inet6-perl libmodule-find-perl \
    libmoose-perl libnet-ip-perl libfile-sharedir-perl libhash-merge-perl \
    libreadonly-perl libldns-dev libmodule-install-perl

**Install CPAN dependencies**

Unfortunately `Net::LDNS` and `RFC::RFC822::Address` has not been packaged for Ubuntu yet. So you need to install these dependencies from CPAN:

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

    $ sudo apt-get install git build-essential
    $ git clone https://github.com/dotse/zonemaster.git

**Install package dependencies**

**Install CPAN dependencies**

**Build source code**

## ZoneMaster CLI installation

### Instructions for Ubuntu 14.04

First install the ZoneMaster Engine, following the instructions above.

**Install package dependencies**

    $ sudo apt-get install libmoosex-getopt-perl

**Build source code**

    $ cd zonemaster/Zonemaster-CLI
    $ perl Makefile.PL
    $ make test
    $ sudo make install

Now you are ready to run the zonemaster-cli command:

    $ zonemaster-cli example.com


## ZoneMaster Web interface installation

### Backend

### Frontend
