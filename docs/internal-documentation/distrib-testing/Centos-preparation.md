# CentOS system preparation for installing Zonemaster components

1. Make a clean installation of CentOs.

2. Update the package database.

   ```sh
   yum update
   yum groupinstall "Development Tools"
   ```

3. Install prerequisites

   ```sh
   yum install cpanminus
   ```

4. Create a new user.

   ```sh
   adduser username
   passwd username
   ```

5. Add user to the sudoer list.

   ```sh
   usermod -aG wheel username
   ```

6. Exit from the root shell.

   ```sh
   exit
   ```


## Preparing to install the repositories

1. Follow the steps (1-7) of the [release
process](https://github.com/zonemaster/zonemaster/blob/master/docs/internal-documentation/maintenance/ReleaseProcess.md) to prepare the tarballs in a separate machine 

2. Install the modules as per the respective installation instructions
