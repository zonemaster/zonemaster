
# ![Zonemaster](docs/images/zonemaster_logo_2021_color.png)

## Table of contents

* [Introduction](#introduction)
* [Background](#background)
* [Purpose](#purpose)
* [Documentation](#documentation)
* [Prerequisites](#prerequisites)
* [Support of DNSKEY algorithms 15 and 16](#support-of-dnskey-algorithms-15-and-16)
* [Translation](#translation)
* [Zonemaster and its components](#zonemaster-and-its-components)
* [Installation](#installation)
* [Docker](#docker)
* [Versions](#versions)
* [Participation](#participation)
* [Bug reporting](#bug-reporting)
* [Notable bugs and issues](#notable-bugs-and-issues)
* [Contact and mailing lists](#contact-and-mailing-lists)
* [License](#license)

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

This is the main project repository. In this repository, documentation
regarding the [design](docs/internal/design),
[requirements](docs/internal/requirements) and
[specifications](docs/public/specifications) for the Zonemaster implementation
are available.
We also have a brief [user guide](USING.md).

The [public](docs/public) documentation can be built using
[`mdbook`](https://rust-lang.github.io/mdBook/) and the following commands:

```
cd docs/public
mdbook build
open book/index.html
```

## Prerequisites

See [Prerequisites] document.

## Support of DNSKEY algorithms 15 and 16

To be able to support and process DNSKEY algorithms 15 (Ed25519) and 16 (Ed448)
for DNSSEC the underlying OS must
have a recent version of [OpenSSL] installed, and [LDNS] being linked against that
OpenSSL (see [Zonemaster-LDNS-README][Zonemaster-LDNS] for more details). Then
information below on support of the algorithms assumes that the
installation instructions given for Zonemaster have been followed. A test of the
domains `ed25519.nl` and `superdns.nl` will reveal if the Zonemaster
installation has the support or not for algorithms 15 and 16, respectively.

All supported OSs support algorithms 15 and 16 out of the box.

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

Zonemaster itself can be installed manually. It can also be run using
[Docker]. For detailed instructions on both options, see the
[Installation][Installation] document.

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


## License

This is free software under a 2-clause BSD license. The full text of the license can
be found in the [LICENSE](LICENSE) file included in this respository.


[CPAN]:                                https://www.cpan.org/
[Connectivity03]:                      docs/specifications/tests/Connectivity-TP/connectivity03.md
[Contact and mailing lists]:           docs/contact-and-mailing-lists.md
[Docker]:                              https://www.docker.com/get-started
[Issues in Zonemaster/Zonemaster]:     https://github.com/zonemaster/zonemaster/issues
[Issues in Zonemaster::Backend]:       https://github.com/zonemaster/zonemaster-backend/issues
[Issues in Zonemaster::CLI]:           https://github.com/zonemaster/zonemaster-cli/issues
[Issues in Zonemaster::Engine]:        https://github.com/zonemaster/zonemaster-engine/issues
[Issues in Zonemaster::GUI]:           https://github.com/zonemaster/zonemaster-gui/issues
[Issues in Zonemaster::LDNS]:          https://github.com/zonemaster/zonemaster-ldns/issues
[LDNS]:                                https://www.nlnetlabs.nl/projects/ldns/about/
[OpenSSL]:                             https://www.openssl.org/
[Prerequisites]:                       docs/public/installation/prerequisites.md
[USING]:                               https://github.com/zonemaster/zonemaster-cli/blob/master/USING.md
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



[Installation]: docs/public/installation/README.md
