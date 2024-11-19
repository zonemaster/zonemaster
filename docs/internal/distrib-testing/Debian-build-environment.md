# Debian Build Environment

## Table of contents

* [Introduction](#introduction)
* [Preparation](#preparation)
* [Installation for package building](#installation-for-package-building)
* [Translation work](#translation-work)
* [Installation for mdBook](#installation-for-mdbook)

## Introduction

These are instructions for creating a build environment for Zonemaster
components based on Perl. This is not meant as instructions for installing
Zonemaster itself. 

This instruction is for creating it on Debian. See other files for other OSs.

## Preparation

1. Make a clean installation of latest version of Debian.

2. Update the package database.

   ```sh
   sudo apt-get update
   ```

## Installation for package building

1. Install dependencies and tools:

   ```sh
   sudo apt-get install git cpanminus gettext autoconf automake build-essential libdevel-checklib-perl libextutils-pkgconfig-perl libmime-base32-perl libmodule-install-xsutil-perl libtest-differences-perl libssl-dev libidn2-dev libtool
   ```

2. Clone 'develop' branch from all Zonemaster repositories except GUI:

   ```sh
   git clone -b develop https://github.com/zonemaster/zonemaster.git
   for d in ldns engine cli backend; do git clone -b develop https://github.com/zonemaster/zonemaster-$d.git; done
   ```

## Translation work

Install for translation (handling PO files), only needed if PO files are to be
handled.

* Follow "Software preparation" in [Instructions for translators] for
  Debian (usually use the version in develop branch).


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


[Instructions for translators]:            ../maintenance/Instructions-for-translators.md#software-preparation
