# FreeBSD Build Environment

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

This instruction is for creating it on FreeBSD. See other files for other OSs.

## Preparation

1. Do a clean installation of latest version of FreeBSD

2. Become root:

   ```sh
   su -l
   ```

3. Update to latest patch level

   ```sh
   freebsd-update fetch install
   ```

4. Reboot into latest patch level and then continue as root on next step
   ```sh
   shutdown -r now
   ```

5. Create a new user (optional)

   Make sure to add `wheel` as an additional group for the user.

   ```sh
   adduser
   ```

6. Update list of package repositories:

   Create the file `/usr/local/etc/pkg/repos/FreeBSD.conf` with the 
   following content, unless it is already updated:

   ```sh
   FreeBSD: {
   url: "pkg+http://pkg.FreeBSD.org/${ABI}/latest",
   }
   ```

7. Check or activate the package system:

   Run the following command, and accept the installation of the `pkg` package
   if suggested.

   ```sh
   pkg info -E pkg
   ```

8. Update local package repository:

   ```sh
   pkg update -f
   ```

## Installation for package building

1. Install dependencies and tools:

    ```sh
    pkg install gmake gettext-tools git-lite p5-Locale-PO p5-App-cpanminus p5-ExtUtils-PkgConfig p5-MIME-Base32 p5-Module-Install libtool autoconf automake p5-Devel-CheckLib p5-Module-Install-XSUtil p5-Test-Exception libidn libidn2
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
  FreeBSD (usually use the version in develop branch).

## Installation for mdBook

Needed for release process:

   ```
   pkg install mdbook-linkcheck
   ```

Needed to build the mdBook (not part of release process):

   ```
   pkg install mdbook mdbook-linkcheck
   ```


[Instructions for translators]:            ../maintenance/Instructions-for-translators.md#software-preparation
