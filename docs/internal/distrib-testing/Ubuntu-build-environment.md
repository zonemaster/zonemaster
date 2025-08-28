# Ubuntu Build Environment

## Table of contents

* [Introduction](#introduction)
* [Preparation](#preparation)
* [Installation for package building](#installation-for-package-building)
* [Install Docker](#install-docker)
* [Translation work](#translation-work)
* [Generate documents in Zonemaster/Zonemaster](#generate-documents-in-zonemasterzonemaster)
* [Installation for mdBook](#installation-for-mdbook)

## Introduction

These are instructions for creating a build environment for Zonemaster components
based on Perl. This is not meant as instructions for installing Zonemaster
itself. You should normally use the version of these instructions found in the
develop branch.

This instruction is for creating it on Ubuntu. See other files for other OSs.

This description targets to create a system that can be used for the following
needs for testing and releasing Zonemaster:

1. Git work on the Zonemaster repositories.
2. Creating distributing packages for testing or uploading to CPAN.
3. Creating Docker imaging for testing or uploading to Docker Hub.
4. Updating PO files (translation).
5. Generating the files listed in the [utils README].


## Preparation

1. Make a clean installation of [Ubuntu] 22.04.

2. Update the package database.

   ```sh
   sudo apt-get update
   ```

## Installation for package building

1. Install dependencies and tools:

   ```sh
   sudo apt-get install git cpanminus gettext autoconf automake build-essential libdevel-checklib-perl libextutils-pkgconfig-perl libmime-base32-perl libmodule-install-xsutil-perl libssl-dev libtest-exception-perl libidn2-dev libtool
   ```

2. Clone 'develop' branch from all Zonemaster repositories except GUI:

   ```sh
   git clone -b develop https://github.com/zonemaster/zonemaster.git
   for d in ldns engine cli backend; do git clone -b develop https://github.com/zonemaster/zonemaster-$d.git; done
   ```

## Install Docker

This step is only needed if Docker images are to be built.

The Docker version installed by the command below is the version found in the
Ubuntu package repository. If a newer version is needed, follow the
instructions on the [Install Docker Engine on Ubuntu] page instead.

   ```sh
   sudo apt-get install docker.io
   ```

Add yourself to the Docker group.

   ```sh
   sudo usermod -aG docker $LOGNAME
   ```

## Translation work

Install for translation (handling PO files), only needed if PO files are to be
handled.

* Follow "Software preparation" in [Instructions for translators] for
  Ubuntu (usually use the version in develop branch).

## Generate documents in Zonemaster/Zonemaster

Only needed if the files listed in [utils README] are to be generated (updated).

* Follow the [Installation instructions] for Zonemaster-Engine for Ubuntu.
  * Only install the dependencies from binary packages and CPAN (if any).
  * Do not install neither Zonemaster::LDNS nor Zonemaster::Engine at this stage.

## Installation for mdBook

> Note that building with Cargo below can be time consuming.

Needed for release process:

   ```
   sudo apt install rustc
   ```
   ```
   cargo install mdbook-linkcheck
   ```
Needed to build the mdBook (not part of release process):

   ```
   sudo apt install rustc
   ```
   ```
   cargo install mdbook mdbook-linkcheck
   ```



[Install Docker Engine on Ubuntu]:         https://docs.docker.com/engine/install/ubuntu/
[Installation instructions]:               ../../public/installation/zonemaster-engine.md
[Instructions for translators]:            ../maintenance/Instructions-for-translators.md#software-preparation
[Ubuntu]:                                  https://ubuntu.com/
[Utils README]:                            ../../../utils/README.md
