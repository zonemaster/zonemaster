# Ubuntu Build Environment

These are instructions for creating a build environment for Zonemaster
components based on Perl. This is not meant as instructions for installing
Zonemaster itself. 

This instruction is for creating it on Ubuntu. See other files for other OSs.

1. Make a clean installation of Ubuntu 18.04 or 20.04

2. Update the package database.

   ```sh
   sudo apt-get update
   ```

3. Install prerequisites (binaries)

   ```sh
   sudo apt-get install cpanminus gettext autoconf automake build-essential
   ```

3. Install prerequisites (binaries)

   ```sh
   sudo cpanm Module::Install
   ```

