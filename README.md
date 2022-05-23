# ![Zonemaster](docs/images/zonemaster_logo_2021_color.png)

## Table of contents

* [Introduction](#Introduction)
* [Background](#Background)
* [Purpose](#Purpose)
* [Documentation](#Documentation)
* [Prerequisites](#Prerequisites)
  * [Supported processor architectures](#Supported-processor-architectures)
  * [Supported operating system versions](#Supported-operating-system-versions)
  * [Supported database engine versions](#Supported-database-engine-versions)
  * [Supported Perl versions](#Supported-Perl-versions)
  * [Supported Client Browser versions](#Supported-Client-Browser-versions)
* [Support of DNSSEC algorithms 15 and 16](#Support-of-DNSSEC-algorithms-15-and-16)
* [Translation](#Translation)
* [Zonemaster and its components](#Zonemaster-and-its-components)
* [Installation](#Installation)
* [Docker](#Docker)
* [Versions](#Versions)
* [Participation](#Participation)
* [Bug reporting](#Bug-reporting)
* [Notable bugs and issues](#Notable-bugs-and-issues)
  * [DNSSEC algorithms 15 and 16](#DNSSEC-algorithms-15-and-16)
* [Contact and mailing lists](#Contact-and-mailing-lists)


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

* [CentOS Linux] 7
* [Debian] 11
* [Docker]
* [FreeBSD] 13.0
* [Ubuntu] 22.04
* [Rocky Linux] 8.6

Only the latest long-term supported version of Debian, FreeBSD, Rocky Linux and
Ubuntu, respectively, is supported. Support for CentOS Linux 7 will be dropped
by Zonemaster release v2023.1.

Only the Docker images provided by the Zonemaster project on [Docker Hub] are
supported. Currently only Zonemaster-CLI is supported on Docker. Docker itself
can run on any of the [Docker] supported OSs (Linux, MacOS and Windows).

[Rocky Linux] has replaced CentOS in Zonemaster version v2021.2 since CentOS 8
is not supported anymore and CentOS 7 is old and does not support modern OpenSSL
required by Zonemaster. Rocky Linux is also a Red Hat derivative and is available
at large cloud providers.

### Supported database engine versions

Operating System | MariaDB | PostgreSQL      | SQLite
---------------- | --------| ----------------|------------------------
CentOS Linux 7   | 5.5     | *not supported* | 3.36.0
Debian 11        | 10.5    | 13.3            | 3.34
Docker           | n/a     | n/a             | n/a
FreeBSD 13.0     | 5.7  1) | 13.6            | 3.37.2
Ubuntu 22.04     | 10.5    | 14.2            | 3.36
Rocky Linux 8.6  | 10.3    | 10.19           | 3.26

* FreeBSD uses MySQL, not MariaDB. 
* SQLite is usually bundled in Perl DBD::SQLite.
* Zonemaster Backend has been tested with the combination of OS and database
  engine version listed in the table above.
* Zonemaster depends on functionality introduced in PostgreSQL version 10, and
  earlier versions of PostgreSQL are as such not supported.
* Zonemaster Backend has not been published on [Docker Hub].

### Supported Perl versions

Operating System | Perl
---------------- | ----
CentOS Linux 7   | 5.16
Debian 11        | 5.32
Docker           | (*)
FreeBSD 13.0     | 5.32
Ubuntu 22.04     | 5.34
Rocky Linux 8.6  | 5.26

* Zonemaster requieres Perl version 5.16 or higher.
* Zonemaster has been tested with the default version of Perl in the OSs as
  listed in the table above.
* (*) Perl is included in the Docker image published on [Docker Hub].

### Supported Client Browser versions

Zonemaster GUI is tested against the combination and browser in the table below.
The latest version of the browser at the time of testing is used.

Operating System | Browser
---------------- | -------
Ubuntu 22.04     | Firefox
Ubuntu 22.04     | Chrome
Windows 10       | Firefox
Windows 10       | Chrome
MacOs            | Firefox
MacOs            | Chrome

Zonemaster GUI is tested manually and with testing tools. See the
[Zonemaster-gui repository][Zonemaster-GUI] for more details.

## Support of DNSSEC algorithms 15 and 16

To be able to support and process algorithms 15 (Ed25519) and 16 (Ed448) for DNSSEC
the underlying OS must
have a recent version of [OpenSSL] installed, and [LDNS] being linked against that
OpenSSL (see [Zonemaster-LDNS-README][Zonemaster-LDNS] for more details). These
conditions are not met in all supported OSs. The following table lists the
expected support for algorithms 15 and 16 in the supported OSs, given that the
installation instructions given for Zonemaster have been followed. A test of the
domains `ed25519.nl` and `superdns.nl` will reveal if the Zonemaster
installation has the support or not for algorithms 15 and 16, respectively.

All supported OSs, except CentOS Linux 7, support algorithms 15 and 16 out of the
box. To get the support in CentOS Linux 7 a newer version of OpenSSL has to be
installed and Zonemaster-LDNS has to be installed following special instructions
found in the [Zonemaster-Engine] installation instructions.

## Translation

Zonemaster comes with translation to the following languages. Translation is
available as methods in `Zonemaster::Engine`, `zonemaster-cli` (i.e. the
Zonemaster-CLI interface to `Zonemaster::Engine`), Zonemaster-Backend
`RPCAPI` interface to `Zonemaster::Engine`) and the Zonemaster-GUI interface
to `RPCAPI`.

* Danish (da, da_DK.UTF-8)
* English (en, en_US.UTF-8)
* Finnish (fi, fi_FI.UTF-8)
* French (fr, fr_FR.UTF-8)
* Norwegian (nb, nb_NO.UTF-8)
* Spanish (es, es_ES.UTF-8)
* Swedish (sv, sv_SE.UTF-8)

## Zonemaster and its components

The Zonemaster product consists of the main part and five components. The main part
consists of specifications and documentation for the Zonemaster product, and is
stored in the main [Zonemaster][Zonemaster/Zonemaster] Github repository.

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

## Docker

Zonemaster-CLI is available on [Docker Hub], and can be conveniently downloaded
and run without any installation. Through Docker Zonemaster-CLI can be run on
Linux, MacOS and Windows. See [USING] Zonemaster-CLI for how to run
Zonemaster-CLI on [Docker]. 

To build your own Docker image, see the [Docker Image Creation] documentation.

## Versions

Go to the [release list][Zonemaster release list] of this repository to find the
[latest version][Zonemaster latest version] of Zonemaster and the versions of
the specific components. Be sure to read the release note of each component
before installing or upgrading.

## Participation

You can submit code by forking this repository and creating pull requests.
When you create a pull request, please select the "develop" branch in the relevant
Zonemaster repository.

See our [contact and mailing lists] page for information on mailing lists.

## Bug reporting

For bug reporting go to the relevant Zonemaster repository
and create a GitHub issue there. Before creating the issue,
please search for the problem in the issue tracker in the relevant repository.
If you find an open issue covering your issue, please add
a comment with any additional information.

* [Issues in Zonemaster::LDNS]
* [Issues in Zonemaster::Engine]
* [Issues in Zonemaster::CLI]
* [Issues in Zonemaster::Backend]
* [Issues in Zonemaster::GUI]

If you cannot determine which repository to create the issue in, please select
the main [Zonemaster][Zonemaster/Zonemaster] repository (i.e.
[general issues in Zonemaster][Issues in Zonemaster/Zonemaster]).

## Notable bugs and issues

None.

## Contact and mailing lists

See our [contact and mailing lists] page for contact information and
information on mailing lists.


[CentOS Linux]:                        https://centos.org/centos-linux/
[CPAN]:                                https://www.cpan.org/
[Connectivity03]:                      docs/specifications/tests/Connectivity-TP/connectivity03.md
[Contact and mailing lists]:           docs/contact-and-mailing-lists.md
[Debian]:                              https://www.debian.org/
[Docker Hub]:                          https://hub.docker.com/u/zonemaster
[Docker Image Creation]:               https://github.com/zonemaster/zonemaster/blob/master/docs/internal-documentation/maintenance/ReleaseProcess-create-docker-image.md
[Docker]:                              https://www.docker.com/get-started
[FreeBSD]:                             https://www.freebsd.org/
[Issues in Zonemaster/Zonemaster]:     https://github.com/zonemaster/zonemaster/issues
[Issues in Zonemaster::Backend]:       https://github.com/zonemaster/zonemaster-backend/issues
[Issues in Zonemaster::CLI]:           https://github.com/zonemaster/zonemaster-cli/issues
[Issues in Zonemaster::Engine]:        https://github.com/zonemaster/zonemaster-engine/issues
[Issues in Zonemaster::GUI]:           https://github.com/zonemaster/zonemaster-gui/issues
[Issues in Zonemaster::LDNS]:          https://github.com/zonemaster/zonemaster-ldns/issues
[LDNS]:                                https://www.nlnetlabs.nl/projects/ldns/about/
[OpenSSL]:                             https://www.openssl.org/
[Rocky Linux]:                         https://rockylinux.org/
[USING]:                               https://github.com/zonemaster/zonemaster-cli/blob/master/USING.md
[Ubuntu]:                              https://ubuntu.com/
[Zonemaster latest version]:           https://github.com/zonemaster/zonemaster/releases/latest
[Zonemaster release list]:             https://github.com/zonemaster/zonemaster/releases
[Zonemaster-Backend]:                  https://github.com/zonemaster/zonemaster-backend
[Zonemaster-CLI]:                      https://github.com/zonemaster/zonemaster-cli
[Zonemaster-Engine]:                   https://github.com/zonemaster/zonemaster-engine
[Zonemaster-GUI]:                      https://github.com/zonemaster/zonemaster-gui
[Zonemaster-LDNS-README]:              https://github.com/zonemaster/zonemaster-ldns/blob/master/README.md
[Zonemaster-LDNS]:                     https://github.com/zonemaster/zonemaster-ldns
[Zonemaster/Zonemaster]:               https://github.com/zonemaster/zonemaster
[Zonemaster/zonemaster-engine#833]:    https://github.com/zonemaster/zonemaster-engine/issues/833


