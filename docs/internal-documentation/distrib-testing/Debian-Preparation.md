# Debian system preparation for installing Zonemaster components

1. Make a clean installation of Debian.

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


## Preparing to install the repositories

1. Follow the steps (1-7) of the [release
process](https://github.com/zonemaster/zonemaster/blob/master/docs/internal-documentation/maintenance/ReleaseProcess.md)
to prepare the tarballs in a separate machine

2. Install the modules as per the respective installation instructions

