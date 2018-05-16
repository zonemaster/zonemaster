![Zonemaster](docs/images/zonemaster_logo_black.png)
==========

## Introduction

Zonemaster is a software package that validates the quality of a DNS delegation. The ambition of the Zonemaster project is to develop and maintain an open source DNS validation tool, offering improved performance over existing tools and providing extensive documentation which could be re-used by similar projects in the future.

Zonemaster consists of several modules or components. The components will help different types of users to check domain servers for configuration errors and generate a report that will assist in fixing the errors.

## Background

DNSCheck from IIS and Zonecheck from AFNIC are two old software packages that validate the quality of a DNS delegation. AFNIC and IIS came together to develop a new DNS validation tool from scratch under the name Zonemaster. Zonemaster intends to be a major rewrite of Zonecheck and DNSCheck, and aims to implement the best parts of both.

## Purpose

The components developed as part of the Zonemaster project will help different
types of [users](USING.md) to check domain servers for configuration errors and
generate a report that will assist in fixing the errors.

The ambition of the Zonemaster project is to develop and maintain an open source
DNS validation tool, offering improved performance over existing tools and
providing extensive documentation which could be re-used by similar projects in
the future.

## Documentation

This is the main project repository. In this
repository, documentation regarding the [design](docs/design),
[requirements](docs/requirements) and [specifications](docs/specifications)
for the Zonemaster implementation are available. 
We also have a brief [user guide](USING.md).

## Prerequisites

Zonemaster comes with documentation for and has been tested on the operating systems and processor
architecture listed below.

### Supported processor architectures

* x86_64 / amd64

### Supported operating system versions

* CentOS 7
* Debian 8
* Debian 9
* FreeBSD 10.4
* FreeBSD 11.1
* Ubuntu 14.04
* Ubuntu 16.04
* Ubuntu 18.04

### Supported database engine versions

Operating System | MySQL | PostgreSQL
---------------- | ------| -----------
CentOS 7         | 5.6   |   9.3
Debian 8         | TBD   |   TBD
Debian 9         | TBD   |   TBD
FreeBSD 10.3     | 5.6   |   9.5       
FreeBSD 11.1     | 5.6   |   9.5      
Ubuntu 14.04     | 5.5   |   9.3
Ubuntu 16.04     | 5.7   |   9.5
Ubuntu 18.04     | TBD   |   TBD

Zonemaster Backend has been tested with the combination of OS and database engine version
listed in the table above. Zonemaster uses functionality introduced in PostgreSQL version 9.3, and earlier versions are as such not supported.

### Supported Perl versions

Operating System | Perl
---------------- | ----
CentOS 7         | 5.16                        
Debian 8         | TBD
Debian 9         | TBD
FreeBSD 10.4     | 5.26
FreeBSD 11.1     | 5.26
Ubuntu 14.04     | 5.18
Ubuntu 16.04     | 5.22
Ubuntu 18.04     | TBD

Zonemaster requieres Perl version 5.14.2 or higher. Zonemaster has been tested with the default version of Perl in the OSs as listed in the table above.

## Localization

Zonemaster comes with localization for these locales:

* en.UTF-8
* fr.UTF-8
* sv.UTF-8
* da.UTF-8 (*)

*) Some strings have not yet been translated to Danish.

## Zonemaster and its components

The Zonemaster product consists of the main part and five components. The main part
consists of specifications and documentation for the Zonemaster product, and is
stored in main Zonemaster Github repository ([zonemaster]).

All the software for the Zonemaster project belong to the five components, each
component being stored in its own Github repository (listed below).

The software has not yet been packaged for any operating systems, and you have to 
install most of it from the source code. The recommended method is to install 
from [CPAN], but it is possible to install directly from clones of the Github 
repositories.

The Zonemaster Product includes the following components:

 * [zonemaster-ldns] - A fork of [ldns] with a Perl frontend used by [zonemaster-engine].
 * [zonemaster-engine] - The Zonemaster test library.
 * [zonemaster-cli] - A Command Line Interface (CLI) to the test library ([zonemaster-engine]).
 * [zonemaster-backend] - A JSON/RPC interface with database to the test library ([zonemaster-engine]).
 * [zonemaster-gui] - **MUST BE UPDATED!** A web user interface to the test library via [zonemaster-backend]. 

## Installation

To install Zonemaster, start with installation of [zonemaster-engine] (which will
draw in Zonemaster-LDNS) and then continue with the other parts. You will find 
installation instructions from the links above.

## Versions

Go to the [release list](https://github.com/dotse/zonemaster/releases) 
of this repository to find the 
[latest version](https://github.com/dotse/zonemaster/releases/latest) of 
Zonemaster and the versions of the specific components. Be
sure to read the release note of each component before installing or
upgrading.

## Participation

You can submit code by forking this repository and creating pull requests.
When you create a pull request, please select the "develop" branch in the relevant
Zonemaster repository.

You can follow the project in these two mailing lists:

 * [zonemaster-users](http://lists.iis.se/cgi-bin/mailman/listinfo/zonemaster-users)
 * [zonemaster-devel](http://lists.iis.se/cgi-bin/mailman/listinfo/zonemaster-devel)

## Bug reporting 

For bug reporting go to the relevant Zonemaster repository
and create a GitHub issue there. Before creating the issue,
please search for the problem in the issue tracker in the relevant repository. 
If you find an open issue covering your issue, please add
a comment with any additional information.

* [Issues in Zonemaster::LDNS](https://github.com/dotse/zonemaster-ldns/issues)
* [Issues in Zonemaster::Engine](https://github.com/dotse/zonemaster-engine/issues)
* [Issues in Zonemaster::CLI](https://github.com/dotse/zonemaster-cli/issues)
* [Issues in Zonemaster::Backend](https://github.com/dotse/zonemaster-backend/issues)
* [Issues in zonemaster::GUI](https://github.com/dotse/zonemaster-gui/issues)

If you cannot determine which repository to create the issue in, please select the main [zonemaster] 
repository (i.e. [general issues in Zonemaster](https://github.com/dotse/zonemaster/issues)).


## Notable bugs and issues

None.


## Contact 

For contacting the Zonemaster project, please send an e-mail to
contact@zonemaster.net.

[zonemaster]: https://github.com/dotse/zonemaster
[zonemaster-ldns]: https://github.com/dotse/zonemaster-ldns
[zonemaster-engine]: https://github.com/dotse/zonemaster-engine 
[zonemaster-cli]: https://github.com/dotse/zonemaster-cli
[zonemaster-backend]: https://github.com/dotse/zonemaster-backend
[zonemaster-gui]: https://github.com/dotse/zonemaster-gui
[ldns]: https://www.nlnetlabs.nl/projects/ldns/
[CPAN]: http://search.cpan.org/search?query=Zonemaster&mode=dist
