# Debian Build Environment

These are instructions for creating a build environment for Zonemaster
components based on Perl. This is not meant as instructions for installing
Zonemaster itself. 

This instruction is for creating it on Debian. See other files for other OSs.

1. Make a clean installation of Debian 11.

2. Update the package database.

   ```sh
   sudo apt-get update
   ```

3. Install prerequisites

   ```sh
   sudo apt-get install git cpanminus gettext autoconf automake build-essential libdevel-checklib-perl libmodule-install-xsutil-perl libssl-dev libidn2-dev libtool
   ```

4. Clone 'develop' branch from all Zonemaster repositories

   ```sh
   for d in ldns engine cli backend; do git clone -b develop https://github.com/zonemaster/zonemaster-$d.git; done
   ```