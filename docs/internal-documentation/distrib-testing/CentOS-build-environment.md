# CentOS Build Environment

These are instructions for creating a build environment for Zonemaster
components based on Perl. This is not meant as instructions for installing
Zonemaster itself. 

This instruction is for creating it on CentOS. See other files for other OSs.

> Should this be CentOS 7 or CentOS 8? Do we need to cover both?

> Is git installed by "development tools"? Is "development tools" really
> needed for normal installation of Zonemaster?
>
> Here we need gettext. Anything else?


1. Make a clean installation of CentOs.

> Are you root at this stage?

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
