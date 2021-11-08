# Ubuntu Build Environment

These are instructions for creating a build environment for Zonemaster components
based on Perl. This is not meant as instructions for installing Zonemaster
itself. You should normally use the version of these instructions found in the
develop branch.

This instruction is for creating it on Ubuntu. See other files for other OSs.

## Target system

This description targets to create a system that can be used for the following
needs for testing and releasing Zonemaster:

1. Git work on the Zonemaster repositories.
2. Creating distributing packages for testing or uploading to CPAN.
3. Creating Docker imaging for testing or uploading to Docker Hub.
4. Updateting PO files (translation).
5. Generating the files listed in the [utils README].

## Instructions

1. Make a clean installation of [Ubuntu 20.04]

2. Update the package database.

   ```sh
   sudo apt-get update
   ```

3. Install prerequisites (binaries)

   ```sh
   sudo apt-get install cpanminus gettext autoconf automake build-essential libdevel-checklib-perl libmodule-install-xsutil-perl libssl-dev libidn11-dev libtool
   ```

4. Install Docker - *only needed if Docker images are to be built*

   ```sh
   sudo apt-get install docker.io
   ```

5. Add yourself to the Docker group - *only if Docker has been installed*

   ```sh
   sudo usermod -aG docker $LOGNAME
   ```

6. Install for translation (handling PO files) -
   *only needed if PO files are to be handled*

   > Follow "Software preparation" in [Instructions for translators] for Ubuntu
   > (usually use the version in develop branch)

7. Install binaries for Zonemaster-Engine -
   *only needed if the files listed in [utils README] are to be generated*
   
   > Follow the [Installation instructions] for Zonemaster-Engine for Ubuntu. Only
   > install the dependencies from binary packages and CPAN (if any). Do not
   > install neither Zonemaster::LDNS nor Zonemaster::Engine at this stage.




[Installation instructions]:               https://github.com/zonemaster/zonemaster-engine/blob/develop/docs/Installation.md
[Instructions for translators]:            https://github.com/zonemaster/zonemaster-engine/blob/develop/docs/Translation-translators.md#software-preparation
[Ubuntu 20.04]:                            https://ubuntu.com/
[utils README]:                            ../../../utils/README.md
