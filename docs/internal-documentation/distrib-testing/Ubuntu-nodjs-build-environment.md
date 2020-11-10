# Ubuntu nodjs Build Environment

The requirements to build the Zonemaster-GUI distribution zip file are nodejs
and npm. Below are instructions to create such a build environment on Ubuntu.

Nodjs and npn are available from the [Node.js] official website. Minimal version
of Nodejs is 10.0 but install the latest LTS version available. The process has
been tested on Ubuntu 18.04, which we use here.

1. Make a clean installation of Ubuntu 18.04.

2. Update the package database.
   ```sh
   sudo apt-get update
   ```

3. Install nodejs by using [NVM], a node version manager.
   ```sh
   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
   nvm install 13.12.0
   nvm use 13.12.0
   ```

4. After installation, log out and log in again to handle [known issue], or just:

   ```sh
   source ~/.bashrc
   ```


[known issue]:                          https://github.com/nvm-sh/nvm#troubleshooting-on-linux
[Node.js]:                              https://nodejs.org/en/
[NVM]:                                  https://github.com/nvm-sh/nvm

