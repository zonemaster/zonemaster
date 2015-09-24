# Zonemaster installation guide

This is the installation instructions for the Zonemaster software. The
software has not yet been packaged for any operating systems, and you
have to install most of it from the source code.

There is installation support available for the following operating systems:

 * Ubuntu 12.04 (LTS)
 * Ubuntu 14.04 (LTS)
 * Debian Wheezy (version 7)
 * FreeBSD 10.1
 * CentOS 7


## Components

The Zonemaster software contains of several different components. The
most important component is the Zonemaster Engine, which is the core
library that implements the DNS test framework and all the test cases.

In order to use the Zonemaster Engine you must install one of the
applications, the simplest being the CLI interface.

Another application is the web interface which is split in two
parts. The user visible component is the Web Frontent, and the backend
is responsible for the testing. The CLI and the web interface are both
dependent on the Zonemaster Engine.


## Zonemaster Engine installation instructions

The instructions on how to install the Zonemaster Engine are available in the
[Zonemaster Engine installation instructions
document](https://github.com/dotse/zonemaster-engine/blob/master/docs/installation.md).


## Zonemaster CLI installation instructions

The instructions on how to install the Zonemaster CLI are available in the
[Zonemaster CLI installation instructions
document](https://github.com/dotse/zonemaster-cli/blob/master/docs/installation.md).


## Zonemaster Web Interface installation

In order to install the Web Interface you need to install the backend
and the frontend systems. First you must install the Zonemaster Engine,
and then follow these instructions:

 * [Install the Backend](https://github.com/dotse/zonemaster-backend/blob/master/docs/installation.md)
 * [Install the
 * Frontend](https://github.com/dotse/zonemaster-gui/blob/master/docs/installation.md)



-------

Copyright (c) 2013, 2014, 2015, IIS (The Internet Infrastructure Foundation)  
Copyright (c) 2013, 2014, 2015, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <http://creativecommons.org/licenses/by/4.0/>.
