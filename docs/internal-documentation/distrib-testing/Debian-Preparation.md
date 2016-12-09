# Debian system preparation for Zonemaster

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
   locale-gen C en_US.UTF-8
   dpkg-reconfigure locales
   ```

7. Exit from the root shell.

   ```sh
   exit
   ```
