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


## Preparing to install the Zonemaster-LDNS

1. Clone the develop directory in a machine different from the machine where you
want to install

   ```sh
   git clone -b develop git@github.com:dotse/zonemaster-ldns.git
   ```

2. Refresh and install the necessary packages in the zonemaster-engine (Step
1,2,3)(https://github.com/dotse/zonemaster-engine/blob/develop/docs/Installation.md#installation-on-debian)

3. Create the distribution file

   ```sh
   cd zonemaster-ldns
   perl Makefile.PL
   make all 
   make distcheck
   make dist
   ```

5. scp the compressed directory to the testing machine

   ```sh
   scp Zonemaster-LDNS-1.0.2.tar.gz user@machine:/path/to directory/
   ```

6. Install Zonemaster LDNS

   ```sh
   sudo cpanm Zonemaster-LDNS-1.0.2.tar.gz
   ```


## Preparing to install the Zonemaster-Engine

1. Clone the develop directory in a machine different from the machine where you
want to install

   ```sh
   git clone -b develop git@github.com:dotse/zonemaster-engine.git
   ```

2. Create the distribution file

   ```sh
   cd zonemaster-engine
   perl Makefile.PL
   make all
   make distcheck
   make dist
   ```

3. scp the compressed directory to the testing machine 

   ```sh
   scp Zonemaster-Engine-v2.0.6.tar.gz user@machine:/path/to directory/
   ```

4. Install Zonemaster Engine 

   ```sh
   sudo cpanm Zonemaster-Engine-v2.0.6.tar.gz
   ```


## Preparing to install the Zonemaster-CLI

1. Clone the develop directory in a machine different from the machine where you
want to install

   ```sh
   git clone -b develop git@github.com:dotse/zonemaster-cli.git
   ```

2.  Create the distribution file

   ```sh
   cd zonemaster-cli
   perl Makefile.PL
   make all
   make distcheck
   make dist
   ```

3. scp the compressed directory to the testing machine

   ```sh
   scp Zonemaster-CLI-v1.1.2.tar.gz user@machine:/path/to directory/
   ```

4. Install the dependencies as mentioned here: 
[link](https://github.com/dotse/zonemaster-cli/blob/develop/docs/Installation.md#2-debian)


5. Install Zonemaster CLI

   ```sh
   sudo cpanm Zonemaster-CLI-v1.1.2.tar.gz
   ```
6. Check proper installation of engine and the CLI by the following command 
   
   ```sh
   zonemaster-cli afnic.fr
   ```


## Preparing to install the Zonemaster-Backend

1. Clone the develop directory in a machine different from the machine where you
want to install

   ```sh
   git clone -b develop git@github.com:dotse/zonemaster-backend.git
   ```

2. Create the distribution file

   ```sh
   cd zonemaster-backend
   perl Makefile.PL
   make all
   make distcheck
   make dist
   ```

3. scp the compressed directory to the testing machine

   ```sh
   scp Zonemaster-Backend-2.0.2.tar.gz user@machine:/path/to directory/
   ```

4. Install the dependencies as mentioned here:
[link](https://github.com/dotse/zonemaster-backend/blob/develop/docs/Installation.md#4-installation-on-debian)

5. Install Zonemaster backend

   ```sh
   sudo cpanm Zonemaster-Backend-2.0.2.tar.gz
   ```

6. Follow the install doc for debian for database installation/configuration 


## Preparing to install the Zonemaster-gui

1. Follow the installation instructions as mentioned here:
[link](https://github.com/zonemaster/zonemaster-gui/blob/master/docs/Installation.md#2-debian)

2. Maybe you need to change the default config file "000-default.conf" and point
to a different port such as "8080" and then reload apache


