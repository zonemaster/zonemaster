# FreeBSD system preparation for Zonemaster

1. Make a clean installation of FreeBSD.

2. Create a new user.

   Make sure to add `wheel` as an additional group for the user.

   ```sh
   adduser
   ```

3. Allow users in the wheel group to run all commands.

   Uncomment the line `%wheel ALL=(ALL) ALL`.

   ```sh
   visudo
   ```

4. Use latest patch level when testing FreeBSD.

   ```sh
   freebsd-update fetch
   freebsd-update install
   shutdown -r now
   ```
