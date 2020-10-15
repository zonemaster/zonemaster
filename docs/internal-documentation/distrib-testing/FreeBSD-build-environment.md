# FreeBSD Build Environment

These are instructions for creating a build environment for Zonemaster
components based on Perl. This is not meant as instructions for installing
Zonemaster itself. 

This instruction is for creating it on FreeBSD. See other files for other OSs.


1. Do a clean installation of FreeBSD 12.1

2. Become root:

   ```sh
   su -l
   ```

3. Update to latest patch level

   ```sh
   freebsd-update fetch install
   ```

4. Reboot into latest patch level and then continue as root on next step
   ```sh
   shutdown -r now
   ```

5. Create a new user (optional)

   Make sure to add `wheel` as an additional group for the user.

   ```sh
   adduser
   ```

6. Update list of package repositories:

   Create the file `/usr/local/etc/pkg/repos/FreeBSD.conf` with the 
   following content, unless it is already updated:

   ```sh
   FreeBSD: {
   url: "pkg+http://pkg.FreeBSD.org/${ABI}/latest",
   }
   ```

7. Check or activate the package system:

   Run the following command, and accept the installation of the `pkg` package
   if suggested.

   ```sh
   pkg info -E pkg
   ```

8. Update local package repository:

   ```sh
   pkg update -f
   ```

9. Install some tools
    ```sh
    pkg install devel/gettext-tools devel/git-lite devel/p5-Locale-PO p5-App-cpanminus
    ```

10. Install other tools needed, e.g. editor

11. To upgrade the packages at a later stage
    ```sh
    pkg upgrade
    ```

