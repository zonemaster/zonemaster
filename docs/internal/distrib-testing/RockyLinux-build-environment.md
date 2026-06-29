# Rocky Linux Build Environment

## Table of contents

* [Introduction](#introduction)
* [Preparation](#preparation)
* [Installation for package building](#installation-for-package-building)
* [Translation work](#translation-work)
* [Installation for mdBook](#installation-for-mdbook)

## Introduction

These are instructions for creating a build environment for Zonemaster components
based on Perl. This is not meant as instructions for installing Zonemaster
itself. You should normally use the version of these instructions found in the
develop branch.

This instruction is for creating it on Rocky Linux. See other files for other OSs.

## Preparation

1. Make a clean installation of [Rocky Linux].

2. Update the package database.

   ```sh
   sudo dnf update
   ```

## Installation for package building

1. Install dependencies and tools:

   ```sh
   sudo dnf install git cpanminus gettext autoconf automake libtool perl-Module-Install
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
  Rocky Linux (usually use the version in develop branch).

## Installation for mdBook

> Note that building with Cargo below can be time consuming.

Needed for release process:

   ```
   sudo dnf install rustc
   ```
   ```
   cargo install mdbook-linkcheck
   ```
Needed to build the mdBook (not part of release process):

   ```
   sudo dnf install rustc
   ```
   ```
   cargo install mdbook mdbook-linkcheck
   ```


[Instructions for translators]:            ../maintenance/Instructions-for-translators.md#software-preparation
[Rocky Linux]:                             https://rockylinux.org/
