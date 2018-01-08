![Zonemaster](docs/images/zonemaster_logo_black.png)
==========

## Background

DNSCheck from IIS and Zonecheck from AFNIC are two different software
packages that do DNS validation of the quality of a DNS
delegation. AFNIC and IIS decided to develop a new DNS validation tool from the
scratch under the name "Zonemaster". 

The Zonemaster implementation intends to be a major
rewrite of the existing DNS validation tools developed by AFNIC (Zonecheck) and
IIS (DNSCheck), and implement the best parts of both.

## Purpose

The components developed as part of the Zonemaster project will help different
types of [users](USING.md) to check domain servers for configuration errors and
generate a report that will enable to fix the errors.

The ambition of the Zonemaster project is to develop and maintain an open source
DNS validation tool, offering better performance than the existing tools and
provide extensive documentation which could be re-used by similar projects in
the future.

## Documentation

The repository you are looking at is the main project repository. In this
repository, documentation regarding the [design](docs/design),
[requirements](docs/requirements) and [specifications](docs/specifications)
for the zonemaster implementation are available.

Also, in this repository, you can find a brief [user guide](USING.md).

## Prerequisites

Zonemaster comes with documentation for and has been tested on the operative systems and processor
architecture listed below.

### Supported processor architectures

* x86_64 / amd64

### Supported operating system versions

* CentOS 7
* Debian 7
* Debian 8
* (Debian 9)
* FreeBSD 10.3
* FreeBSD 11.1
* Ubuntu 14.04
* Ubuntu 16.04

_Currently, Debian 9 is not supported due to a known bug in Zonemaster::LDNS. That has to be resolved 
before we can include support for Debian 9._

### Supported database engine versions

Operating System | MySQL | PostgreSQL
---------------- | ------| -----------
CentOS 7         | 5.6   |   (9.3)
Debian 7         | 5.5   |   (9.3)
Debian 8         | 5.5   |   (9.4)
FreeBSD 10.3     | (5.6) |   9.5       
FreeBSD 11.1     | (5.6) |   9.5      
Ubuntu 14.04     | 5.5   |   9.3
Ubuntu 16.04     | 5.7   |   (9.5)

_PostgreSQL has not been tested on CentOS 7 and Debian 7. We had issues
on Debian 8 and Ubuntu 16.04 that we could not resolve before release._

_MySQL has not been tested on FreeBSD._

### Supported Perl versions

Operating System | Perl
---------------- | ----
CentOS 7         | 5.16                        
Debian 7         | 5.14
Debian 8         | 5.20
FreeBSD 10.3     | 5.24
FreeBSD 11.1     | 5.24
Ubuntu 14.04     | 5.18
Ubuntu 16.04     | 5.22

## Localization

Zonemaster comes with localization for these locales:

* en.UTF-8
* fr.UTF-8
* sv.UTF-8
* da.UTF-8 (*)

*) Some strings have not yet been translated to Danish.

## Zonemaster and its components

The Zonemaster Product consists of the main part and five components. The main part
consists of specifications and documentation for the Zonemaster product, and is
stored in main Zonemaster Github repository ([zonemaster]).

All the software for the Zonemaster project belong to the five components, each
component being stored in its own Github repository (listed below).

The software has not yet been packaged for any operating systems, and you have to 
install most of it from the source code. The recommended method is to install 
from [CPAN], but it is possible to install directly from clones of the Github 
repositories.

The Zonemaster Product includes the following components:

 * [zonemaster-ldns] - A fork of of [ldns] with a Perl frontend used by [zonemaster-engine].
 * [zonemaster-engine] - The Zonemaster test library.
 * [zonemaster-cli] - A Command Line Interface (CLI) to the test library ([zonemaster-engine]).
 * [zonemaster-backend] - A JSON/RPC interface with database to the test library ([zonemaster-engine]).
 * [zonemaster-gui] - A web user interface to the test library via [zonemaster-backend].

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

The core development team are people from IIS and Afnic. However, you
can submit code by forking this repository and creating pull requests.
When you create a pull request, please select the "develop" branch in the relevant
Zonemaster repository.

You can follow the project in these two mailinglists:

 * [zonemaster-users](http://lists.iis.se/cgi-bin/mailman/listinfo/zonemaster-users)
 * [zonemaster-devel](http://lists.iis.se/cgi-bin/mailman/listinfo/zonemaster-devel)


## Bug reporting 

For bug reporting go to the relevant Zonemaster repository
and create a Github issue there. Before creating the issue,
please search for the problem in the issue tracker in the relevant repository, 
and if you find an open issue covering your issue, please add
a comment with additional information, if any.

* [Issues in Zonemaster::LDNS](https://github.com/dotse/zonemaster-ldns/issues)
* [Issues in Zonemaster::Engine](https://github.com/dotse/zonemaster-engine/issues)
* [Issues in Zonemaster::CLI](https://github.com/dotse/zonemaster-cli/issues)
* [Issues in Zonemaster::Backend](https://github.com/dotse/zonemaster-backend/issues)
* [Issues in zonemaster::GUI](https://github.com/dotse/zonemaster-gui/issues)

If you cannot determine which repository to create the issue in, please select the main [zonemaster] 
repository, i.e. [general issues in Zonemaster](https://github.com/dotse/zonemaster/issues).


## Notable bugs and issues

### Selecting language with zonemaster-cli

The command line tool `zonemaster-cli` has an option `--locale` with which you can select the language
the output is written (currently English (the default), French, Swedish or Danish). If the environment
variable `LANGUAGE` is set, then that might not work. The work-around is to unset the variable before
running the `zonemaster-cli` command, e.g.

```sh
unset LANGUAGE
zonemaster-cli zonemaster.net --locale sv_SE.utf8
```

## Contact 

For contacting the Zonemaster project, please send a mail to
"contact@zonemaster.net".

[zonemaster]: https://github.com/dotse/zonemaster
[zonemaster-ldns]: https://github.com/dotse/zonemaster-ldns
[zonemaster-engine]: https://github.com/dotse/zonemaster-engine 
[zonemaster-cli]: https://github.com/dotse/zonemaster-cli
[zonemaster-backend]: https://github.com/dotse/zonemaster-backend
[zonemaster-gui]: https://github.com/dotse/zonemaster-gui
[ldns]: https://www.nlnetlabs.nl/projects/ldns/
[CPAN]: http://search.cpan.org/search?query=Zonemaster&mode=dist
