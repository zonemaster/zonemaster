# Ubuntu nodjs Build Environment

The requirements to build the Zonemaster-GUI distribution zip file are nodejs
and npm. Below are instructions to create such an build environment on Ubuntu.

Nodjs and npn are available from the [Node.js] official website. Minimal version
of Nodejs is 10.0 but install the latest LTS version available. The process has
been tested on Ubuntu 18.04, which we use here.

1. Make a clean installation of Ubuntu 18.04.

> Are we root at this stage?

2. Update the package database.

   ```sh
   apt-get update
   ```

3. Create a new user.

   ```sh
   adduser username
   ```

4. Add user to the sudoer list.

   ```sh
   visudo
   ```

   Copy the contents of the ‘root’ in 'visudo' and change ‘root’ to ‘username’.


5. Exit from the root shell.

   ```sh
   exit
   ```

6. Install nodejs by using [NVM], a node version manager.

   ```sh
   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
   nvm install 13.12.0
   nvm use 13.12.0
   ```


[Node.js]:                              https://nodejs.org/en/
[NVM]:                                  https://github.com/nvm-sh/nvm


