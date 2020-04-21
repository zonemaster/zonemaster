![Zonemaster](docs/images/zonemaster_logo_black.png)
==========

## Introduction

Zonemaster is a software package that validates the quality of a DNS delegation.
The ambition of the Zonemaster project is to develop and maintain an open source
DNS validation tool, offering improved performance over existing tools and providing
extensive documentation which could be re-used by similar projects in the future.

Zonemaster consists of several modules or components. The components will help
different types of users to check domain servers for configuration errors and
generate a report that will assist in fixing the errors.

## Background

DNSCheck from IIS and Zonecheck from AFNIC are two old software packages that validate
the quality of a DNS delegation. AFNIC and IIS came together to develop a new DNS
validation tool from scratch under the name Zonemaster. Zonemaster intends to be a
major rewrite of Zonecheck and DNSCheck, and aims to implement the best parts of both.

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

Zonemaster comes with documentation for and has been tested on the operating systems
and processor architecture listed below.

### Supported processor architectures

* x86_64 / amd64

### Supported operating system versions

* CentOS 7
* CentOS 8
* Debian 9
* Debian 10
* FreeBSD 11.3
* FreeBSD 12.1
* Ubuntu 16.04
* Ubuntu 18.04

### Supported database engine versions

Operating System | MySQL    | PostgreSQL
---------------- | ---------| -----------
CentOS 7         | 5.6      | 9.3
CentOS 8         | 8.0      | 9.6
Debian 9         | 10.1 (*) | 9.6
Debian 10        | 10.3 (*) | 11.5
FreeBSD 11.3     | 5.7      | 11
FreeBSD 12.1     | 5.7      | 11
Ubuntu 16.04     | 5.7      | 9.5
Ubuntu 18.04     | 5.7      | 10

*) For Debian 9 and 10 MariaDB is supported, not MySQL.

Zonemaster Backend has been tested with the combination of OS and database
engine version listed in the table above. Zonemaster uses functionality
introduced in PostgreSQL version 9.3, and earlier versions are as such not supported.

### Supported Perl versions

Operating System | Perl
---------------- | ----
CentOS 7         | 5.16
CentOS 8         | 5.26
Debian 9         | 5.24
Debian 10        | 5.28
FreeBSD 11.3     | 5.30
FreeBSD 12.1     | 5.30
Ubuntu 16.04     | 5.22
Ubuntu 18.04     | 5.26

Zonemaster requieres Perl version 5.14.2 or higher. Zonemaster has been
tested with the default version of Perl in the OSs as listed in the table above.

### Supported Client Browser versions

Zonemaster GUI is tested against the browsers, their versions and listed OS as
indicated bellow and should work perfectly with similar configurations.

Operating System | Browser | Version
---------------- | ------- | -------
Ubuntu 18.04     | Firefox | 74
Ubuntu 18.04     | Chrome  | 80
Windows 10       | Firefox | 74
Windows 10       | Chrome  | 80
MacOs            | Firefox | 74
MacOs            | Chrome  | 80

Zonemaster GUI was tested manually or with testing tools.
See the [Zonemaster-gui repository](https://github.com/zonemaster/zonemaster-gui) for
more details.

## Support of DNSSEC algorithm 15 (Ed25519)

To be able to support and process algorithm 15 for DNSSEC the underlying OS must
have recent version of [OpenSSL] installed, and [LDNS] being linked against that
OpenSSL (see [Zonemaster-LDNS-README][Zonemaster-LDNS] for more details). These
conditions are not met in all supported. The following table lists the expected
support for algorithm 15 in the supported OSs, given that the installation
instructions given for Zonemaster have been followed. A test of the domain
`ed25519.nl` will reveal if the Zonemaster installation has the support or not.

Operating System | Supports algorithm 15
---------------- | ----
CentOS 7         | no
CentOS 8         | yes
Debian 9         | no
Debian 10        | yes
FreeBSD 11.3     | yes
FreeBSD 12.1     | yes
Ubuntu 16.04     | no
Ubuntu 18.04     | yes


## Translation

Zonemaster comes with translation to the following languages. Translation is
available as methods in `Zonemaster::Engine`, `zonemaster-cli` (i.e. the
Zonemaster-CLI interface to `Zonemaster::Engine`), Zonemaster-Backend
`RPCAPI` interface to `Zonemaster::Engine`) and the Zonemaster-GUI interface
to `RPCAPI`.


* English (en, en_US.UTF-8)
* French (fr, fr_FR.UTF-8)
* Swedish (sv, sv_SE.UTF-8)
* Danish (da, da_DK.UTF-8)

## Zonemaster and its components

The Zonemaster product consists of the main part and five components. The main part
consists of specifications and documentation for the Zonemaster product, and is
stored in main Zonemaster Github repository ([Zonemaster]).

All the software for the Zonemaster project belong to the five components, each
component being stored in its own Github repository (listed below).

The software has not yet been packaged for any operating systems, and you have to
install most of it from the source code. The recommended method is to install
from [CPAN] (except for [Zonemaster-GUI]), but it is possible to install directly
from clones of the Github repositories. [Zonemaster-GUI] has no Perl code, and is
installed directly from its repository at Github.

The Zonemaster Product includes the following components:

 * [Zonemaster-LDNS] - [LDNS] with a Perl frontend used by [Zonemaster-Engine].
 * [Zonemaster-Engine] - The Zonemaster test library.
 * [Zonemaster-CLI] - A Command Line Interface (CLI) to the test library ([Zonemaster-Engine]).
 * [Zonemaster-Backend] - A JSON/RPC interface with database to the test library ([Zonemaster-Engine]).
 * [Zonemaster-GUI] - A web user interface to the test library via [Zonemaster-Backend].

## Installation

To install Zonemaster, start with installation of [Zonemaster-Engine] (which will
draw in Zonemaster-LDNS) and then continue with the other parts. You will find
installation instructions from the links above.

## Versions

Go to the [release list](https://github.com/zonemaster/zonemaster/releases)
of this repository to find the
[latest version](https://github.com/zonemaster/zonemaster/releases/latest) of
Zonemaster and the versions of the specific components. Be
sure to read the release note of each component before installing or
upgrading.

## Participation

You can submit code by forking this repository and creating pull requests.
When you create a pull request, please select the "develop" branch in the relevant
Zonemaster repository.

You can follow the project in these two mailing lists:

 * [zonemaster-users](https://lists.iis.se/cgi-bin/mailman/listinfo/zonemaster-users)
 * [zonemaster-devel](https://lists.iis.se/cgi-bin/mailman/listinfo/zonemaster-devel)

## Bug reporting

For bug reporting go to the relevant Zonemaster repository
and create a GitHub issue there. Before creating the issue,
please search for the problem in the issue tracker in the relevant repository.
If you find an open issue covering your issue, please add
a comment with any additional information.

* [Issues in Zonemaster::LDNS](https://github.com/zonemaster/zonemaster-ldns/issues)
* [Issues in Zonemaster::Engine](https://github.com/zonemaster/zonemaster-engine/issues)
* [Issues in Zonemaster::CLI](https://github.com/zonemaster/zonemaster-cli/issues)
* [Issues in Zonemaster::Backend](https://github.com/zonemaster/zonemaster-backend/issues)
* [Issues in zonemaster::GUI](https://github.com/zonemaster/zonemaster-gui/issues)

If you cannot determine which repository to create the issue in, please select the main [Zonemaster]
repository (i.e. [general issues in Zonemaster](https://github.com/zonemaster/zonemaster/issues)).

## Limitations and issues in translation

The table below documents in what OS the translation function works for
`zonemaster-cli` and Zonemaster-Backend `RPCAPI`. Zonemaster-GUI depends
the `RPCAPI` it sends it calls to.

Operating System | CLI | Backend
---------------- | ----|--------
CentOS 7         |  ?  |   ?
CentOS 8         |  ?  |   ?
Debian 9         |  ?  |   ?
Debian 10        |  ?  |   ?
FreeBSD 11.3     | yes |  no
FreeBSD 12.1     | yes |  yes
Ubuntu 16.04     |  ?  |   ?
Ubuntu 18.04     |  ?  |   ?

The following issues covers the limitions above:

* [zonemaster-backend#530](https://github.com/zonemaster/zonemaster-backend/issues/530)

## Zonemaster and its components

## Notable bugs and issues

*TO BE UPDATED AT RELEASE*

* Translation does not work poperly under FreeBSD11 ([zonemaster-backend#512], [zonemaster-engine#546])
* Backend not starting after reboot on Debian ([zonemaster-backend#513])

[zonemaster-backend#513]: https://github.com/zonemaster/zonemaster-backend/issues/513
[zonemaster-backend#512]: https://github.com/zonemaster/zonemaster-backend/issues/512
[zonemaster-engine#546]: https://github.com/zonemaster/zonemaster-engine/issues/546

## Contact

For contacting the Zonemaster project, please send an e-mail to
contact@zonemaster.net.

[CPAN]:                         https://www.cpan.org/
[LDNS]:                         https://www.nlnetlabs.nl/projects/ldns/about/
[OpenSSL]:                      https://www.openssl.org/
[Zonemaster-Backend]:           https://github.com/zonemaster/zonemaster-backend
[Zonemaster-CLI]:               https://github.com/zonemaster/zonemaster-cli
[Zonemaster-Engine]:            https://github.com/zonemaster/zonemaster-engine
[Zonemaster-GUI]:               https://github.com/zonemaster/zonemaster-gui
[Zonemaster-LDNS-README]:       https://github.com/zonemaster/zonemaster-ldns/blob/master/README.md
[Zonemaster-LDNS]:              https://github.com/zonemaster/zonemaster-ldns
[Zonemaster]:                   https://github.com/zonemaster/zonemaster

