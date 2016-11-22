# Debian system preparation for Zonemaster

1. Make a clean installation of Debian.

2. Create a new user.

   ```sh
   adduser username
   ```

3. Add user to the sudoer list.

   ```sh
   visudo
   ```

   Copy the contents of the ‘root’ in 'visudo' and change ‘root’ to ‘username’.

4. Update the package database.

   ```sh
   apt-get update
   ```

5. Generate all locales needed by test configurations.

   ```sh
   locale-gen C en_US.UTF-8
   dpkg-reconfigure locales
   ```

6. Exit from the root shell.

   ```sh
   exit
   ```
