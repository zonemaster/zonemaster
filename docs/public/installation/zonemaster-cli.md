# Installation

## Table of contents

* [Overview](#overview)
* [Docker](#docker)
* [Prerequisites for CPAN installation](#prerequisites-for-cpan-installation)
* [Local installation](#local-installation)
  * [Installation on Rocky Linux](#installation-on-rocky-linux)
  * [Installation on Debian and Ubuntu](#installation-on-debian-and-ubuntu)
  * [Installation on FreeBSD](#installation-on-freebsd)
  * [Installation on CentOS Linux 7](#installation-on-centos-linux-7)
* [Post-installation sanity check](#post-installation-sanity-check)
* [Using zonemaster-cli](#using-zonemaster-cli)
* [What to do next?](#what-to-do-next)


## Overview

This document describes prerequisites, installation and post-install sanity
checking for Zonemaster::CLI. The final section wraps up with a few pointer to
other interfaces to Zonemaster. For an overview of the Zonemaster product,
please see the [main Zonemaster Repository].

## Docker

Zonemaster-CLI is available on Docker Hub and can be run on Docker without any
installation, besides that Docker must be installed. See the [USING]
Zonemaster-CLI document for how to run it on Docker. Links for installation of
Docker are found there.

The rest of this document is about doing a local installation of Zonemaster-CLI,
not relevant for running Zonemaster-CLI on Docker.

## Prerequisites for CPAN installation

Before installing Zonemaster::CLI from CPAN, you should [install
Zonemaster::Engine][ Zonemaster::Engine installation], unless you are
to install on Debian using pre-built packages (see below).

> **Note:** [Zonemaster::Engine] and [Zonemaster::LDNS] are dependencies of
> Zonemaster::CLI. Zonemaster::LDNS has a special installation requirement,
> and Zonemaster::Engine has a list of dependencies that you may prefer to
> install from your operating system distribution (rather than CPAN).
> We recommend following the Zonemaster::Engine installation instruction.

Prerequisite for FreeBSD is that the package system is updated and activated
(see the FreeBSD section of [Zonemaster::Engine installation]).

For details on supported versions of Perl and operating system for
Zonemaster::CLI, see the [declaration of prerequisites].


## Local installation

### Installation on Rocky Linux

1) Install binary dependencies:

   ```sh
   sudo dnf install perl-JSON-XS perl-MooseX-Getopt perl-Try-Tiny
   ```

2) Install dependencies from CPAN:

   ```sh
   sudo cpanm Text::Reflow
   ```

3) Install Zonemaster::CLI

   ```sh
   sudo cpanm Zonemaster::CLI
   ```


### Installation on Debian and Ubuntu

Using pre-built packages is the preferred method for Debian and Ubuntu.

#### Installation from pre-built packages

1) Add Zonemaster packages repository to repository list
   ```sh
   curl -LOs https://package.zonemaster.net/setup.sh
   sudo sh setup.sh
   ```
2) Install Zonemaster CLI
   ```sh
   sudo apt install zonemaster-cli
   ```
3) Update configuration of "locale"

   ```sh
   sudo perl -pi -e 's/^# (da_DK\.UTF-8.*|en_US\.UTF-8.*|es_ES\.UTF-8.*|fi_FI\.UTF-8.*|fr_FR\.UTF-8.*|nb_NO\.UTF-8.*|sv_SE\.UTF-8.*)/$1/' /etc/locale.gen
   sudo locale-gen
   ```

   After the update, `locale -a` should at least list the following locales:
   ```
   da_DK.utf8
   en_US.utf8
   es_ES.utf8
   fi_FI.utf8
   fr_FR.utf8
   nb_NO.utf8
   sv_SE.utf8
   ```

#### Installation from CPAN

1) Install dependencies:

   ```sh
   sudo apt-get install locales libmoosex-getopt-perl libtext-reflow-perl libmodule-install-perl libtry-tiny-perl
   ```

2) Install Zonemaster::CLI:

   ```sh
   sudo cpanm Zonemaster::CLI
   ```
3) Update configuration of "locale"

   ```sh
   sudo perl -pi -e 's/^# (da_DK\.UTF-8.*|en_US\.UTF-8.*|es_ES\.UTF-8.*|fi_FI\.UTF-8.*|fr_FR\.UTF-8.*|nb_NO\.UTF-8.*|sv_SE\.UTF-8.*)/$1/' /etc/locale.gen
   sudo locale-gen
   ```

   After the update, `locale -a` should at least list the following locales:
   ```
   da_DK.utf8
   en_US.utf8
   es_ES.utf8
   fi_FI.utf8
   fr_FR.utf8
   nb_NO.utf8
   sv_SE.utf8
   ```

### Installation on FreeBSD

1) Become root:

   ```sh
   su -l
   ```

2) Install dependencies available from binary packages:

   ```sh
   pkg install devel/gmake p5-JSON-XS p5-Locale-libintl p5-MooseX-Getopt p5-Text-Reflow p5-Try-Tiny
   ```

3) Install Zonemaster::CLI:

   ```sh
   cpanm Zonemaster::CLI
   ```

### Installation on CentOS Linux 7

> **Please note!** CentOS 7 will only be supported until the release of
> v2023.1, which is planned to happen during the spring of 2023.

1) Install binary dependencies:

   ```sh
   sudo yum install perl-JSON-XS perl-MooseX-Getopt perl-Try-Tiny
   ```

2) Install dependencies from CPAN:

     ```sh
     sudo cpanm Text::Reflow Locale::TextDomain
     ```

3) Install Zonemaster::CLI

   ```sh
   sudo cpanm Zonemaster::CLI
   ```

## Post-installation sanity check

Run the zonemaster-cli command:

```sh
zonemaster-cli --test basic zonemaster.net
```

The command is expected to take a few seconds and print some results about the
delegation of zonemaster.net.


## Using zonemaster-cli

See the [USING] Zonemaster-CLI document for an overview on how to use
`zonemaster-cli` after installation.


## What to do next?

 * For a web GUI, follow the [Zonemaster::Backend][Zonemaster::Backend
   installation] and [Zonemaster::GUI installation] instructions.
 * For a [JSON-RPC][JSON-RPC API] frontend, follow the [Zonemaster::Backend
   installation] instruction.


[Declaration of prerequisites]:                   https://github.com/zonemaster/zonemaster/blob/master/README.md#prerequisites
[JSON-RPC API]:                                   https://github.com/zonemaster/zonemaster-backend/blob/master/docs/API.md
[Main Zonemaster repository]:                     https://github.com/zonemaster/zonemaster/blob/master/README.md
[USING]:                                          ../USING.md
[Zonemaster::Backend installation]:               https://github.com/zonemaster/zonemaster-backend/blob/master/docs/Installation.md
[Zonemaster::Engine installation]:                https://github.com/zonemaster/zonemaster-engine/blob/master/docs/Installation.md
[Zonemaster::Engine]:                             https://github.com/zonemaster/zonemaster-engine/blob/master/README.md
[Zonemaster::GUI installation]:                   https://github.com/zonemaster/zonemaster-gui/blob/master/docs/Installation.md
[Zonemaster::LDNS]:                               https://github.com/zonemaster/zonemaster-ldns/blob/master/README.md
