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

4. Complete the system preparation.

   ```sh
   freebsd-update fetch install  # Update to latest patch level
   portsnap fetch extract        # Update to latest ports database
   pkg install curl              # Install prerequisites
   shutdown -r now               # Reboot into latest patch level
   ```
