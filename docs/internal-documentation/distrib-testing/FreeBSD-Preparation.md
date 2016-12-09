# FreeBSD system preparation for Zonemaster

1. Use latest patch level and ports database

   ```sh
   freebsd-update fetch install
   portsnap fetch extract
   ```

2. Install prerequisites

   ```sh
   pkg install curl sudo
   ```

3. Create a new user

   Make sure to add `wheel` as an additional group for the user.

   ```sh
   adduser
   ```

4. Allow users in the wheel group to run all commands

   Uncomment the line `%wheel ALL=(ALL) ALL`.

   ```sh
   visudo
   ```

5. Reboot into latest patch level
   ```sh
   shutdown -r now
   ```
