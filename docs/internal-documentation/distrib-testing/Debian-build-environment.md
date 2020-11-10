# Debian Build Environment

These are instructions for creating a build environment for Zonemaster
components based on Perl. This is not meant as instructions for installing
Zonemaster itself. 

This instruction is for creating it on Debian. See other files for other OSs.

> Should this be Debian 9 or Debian 10? Do we need to cover both?

> Is git installed by default?
>
> Here we need gettext. Anything else?


1. Make a clean installation of Debian.

2. Update the package database.

   ```sh
   sudo apt-get update
   ```

3. Install prerequisites

   ```sh
   sudo apt-get install cpanminus gettext
   ```


