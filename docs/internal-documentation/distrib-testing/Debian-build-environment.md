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

> Are we root at this stage?

2. Update the package database.

   ```sh
   apt-get update
   ```

3. Install prerequisites

   ```sh
   apt-get install cpanminus
   ```

4. Create a new user.

   ```sh
   adduser username
   ```

5. Add user to the sudoer list.

   ```sh
   visudo
   ```

   Copy the contents of the ‘root’ in 'visudo' and change ‘root’ to ‘username’.

6. Generate all locales needed by test configurations.

   ```sh
   dpkg-reconfigure locales
   ```

7. Exit from the root shell.

   ```sh
   exit
   ```


