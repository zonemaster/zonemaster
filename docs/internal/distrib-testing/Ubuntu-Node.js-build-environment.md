# Ubuntu Node.js Build Environment

The build process takes over 1GB of RAM. A machine with at least 2GB of RAM is recommended to build Zonemaster-GUI.

The requirements to build the Zonemaster-GUI distribution zip file are Node.js
and npm. Below are instructions to create such a build environment on Ubuntu.

Node.js and npm are available from the [Node.js] official website. The required
Node.js version is 18. The process has been tested on Ubuntu 22.04, which we use
here.

1. Make a clean installation of Ubuntu 22.04.

2. Update the package database and install curl
   ```sh
   sudo apt-get update && sudo apt-get install curl
   ```

3. Install Node.js by using [NVM], a node version manager.
   ```sh
   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
   ```

4. After installation, log out and log in again to handle [known issue], or just:

   ```sh
   source ~/.bashrc
   ```

5. Install the supported Node.js version
   ```sh
   nvm install 24
   ```

6. Switch to the previously installed version
   ```sh
   nvm use 24
   ```

[known issue]:                          https://github.com/nvm-sh/nvm#troubleshooting-on-linux
[Node.js]:                              https://nodejs.org/en
[NVM]:                                  https://github.com/nvm-sh/nvm
