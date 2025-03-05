# Installation: Zonemaster-CLI

## Table of contents

* [Overview](#overview)
* [Prerequisites for CPAN installation](#prerequisites-for-cpan-installation)
* [Local installation](#local-installation)
  * [Installation on Rocky Linux](#installation-on-rocky-linux)
  * [Installation on Debian and Ubuntu](#installation-on-debian-and-ubuntu)
  * [Installation on FreeBSD](#installation-on-freebsd)
* [Post-installation sanity check](#post-installation-sanity-check)
* [Using Zonemaster-CLI](#using-zonemaster-cli)
* [Global cache](#global-cache)
* [What to do next?](#what-to-do-next)


## Overview

Zonemaster-CLI provides a CLI (command line interface) to Zonemaster. To install
follow the instructions below. An alternative to installing Zonemaster-CLI is to
run it under [Docker]. See [Using the CLI] for run it under Docker.


## Prerequisites for CPAN installation

Before installing Zonemaster::CLI from CPAN, you should [install
Zonemaster::Engine][Zonemaster::Engine installation], unless you are
to install on Debian using pre-built packages (see below).

> **Note:** [Zonemaster::Engine] and [Zonemaster::LDNS] are dependencies of
> Zonemaster::CLI. Zonemaster::LDNS has a special installation requirement,
> and Zonemaster::Engine has a list of dependencies that you may prefer to
> install from your operating system distribution (rather than CPAN).
> We recommend following the [Zonemaster::Engine installation] instruction.

Prerequisite for FreeBSD is that the package system is updated and activated
(see the FreeBSD section of [Zonemaster::Engine installation]).

For details on supported versions of Perl and operating system for
Zonemaster::CLI, see the [declaration of prerequisites].


## Local installation

### Installation on Rocky Linux

1) Install dependencies:

   ```sh
   sudo dnf install --assumeyes perl-JSON-XS perl-Try-Tiny perl-Test-Deep perl-Mojolicious
   ```

   ```sh
   sudo cpanm --notest JSON::Validator
   ```

> Note: Test::Deep and Mojolicious are indirect dependencies. They are dependencies
> of JSON::Validator.

2) Install Zonemaster::CLI

   ```sh
   sudo cpanm --notest Zonemaster::CLI
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
   sudo perl -pi -e 's/^# (da_DK\.UTF-8.*|en_US\.UTF-8.*|es_ES\.UTF-8.*|fi_FI\.UTF-8.*|fr_FR\.UTF-8.*|nb_NO\.UTF-8.*|sl_SI\.UTF-8.*|sv_SE\.UTF-8.*)/$1/' /etc/locale.gen
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
   sl_SI.utf8
   sv_SE.utf8
   ```

#### Installation from CPAN

1) Install dependencies:

   ```sh
   sudo apt-get install locales libmodule-install-perl libtry-tiny-perl libjson-validator-perl
   ```

2) Install Zonemaster::CLI:

   ```sh
   sudo cpanm --notest Zonemaster::CLI
   ```
3) Update configuration of "locale"

   ```sh
   sudo perl -pi -e 's/^# (da_DK\.UTF-8.*|en_US\.UTF-8.*|es_ES\.UTF-8.*|fi_FI\.UTF-8.*|fr_FR\.UTF-8.*|nb_NO\.UTF-8.*|sl_SI\.UTF-8.*|sv_SE\.UTF-8.*)/$1/' /etc/locale.gen
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
   sl_SI.utf8
   sv_SE.utf8
   ```

### Installation on FreeBSD

1) Become root:

   ```sh
   su -l
   ```

2) Install dependencies available from binary packages:

   ```sh
   pkg install gmake p5-JSON-XS p5-Locale-libintl p5-Try-Tiny p5-JSON-Validator
   ```

3) Install Zonemaster::CLI:

   ```sh
   cpanm --notest Zonemaster::CLI
   ```

## Post-installation sanity check

Run the zonemaster-cli command:

```sh
zonemaster-cli --test basic zonemaster.net
```

The command is expected to take a few seconds and print some results about the
delegation of zonemaster.net.

Also, verify that the manual page is properly installed:

```sh
man zonemaster-cli
```


## Using Zonemaster-CLI

See [Using the CLI] for an overview on how to use `zonemaster-cli` after
installation.


## Global cache

If Zonemaster-CLI is to be used for large batches, global cache can improve
performance. See [Global cache in Zonemaster-Engine].


## What to do next?

 * For a web GUI, follow the [Zonemaster::Backend][Zonemaster::Backend
   installation] and [Zonemaster::GUI installation] instructions.
 * For a [JSON-RPC][JSON-RPC API] frontend, follow the [Zonemaster::Backend
   installation] instruction.


[Declaration of prerequisites]:                   prerequisites.md
[Docker]:                                         https://en.wikipedia.org/wiki/Docker_(software)
[Global cache in Zonemaster-Engine]:              ../configuration/global-cache.md
[JSON-RPC API]:                                   ../using/backend/rpcapi-reference.md
[Using the CLI]:                                  ../using/cli.md
[Zonemaster::Backend installation]:               zonemaster-backend.md
[Zonemaster::Engine installation]:                zonemaster-engine.md
[Zonemaster::Engine]:                             https://github.com/zonemaster/zonemaster-engine/blob/master/README.md
[Zonemaster::GUI installation]:                   zonemaster-gui.md
[Zonemaster::LDNS]:                               https://github.com/zonemaster/zonemaster-ldns/blob/master/README.md
