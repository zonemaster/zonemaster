# Build a custom Zonemaster-GUI installation package

## Background

If you follow the [Zonemaster-GUI installation instructions] you can install an
official package, and skip the instructions in this document.

However, if you have created a custom [config.ts], done theme settings in
[tsconfig.json] or done some [theme updates] then you must create a custom
installation package for your custom installation. That can be acheived by
following the steps below.

It is also important to state that even though the installation package is
created on Ubuntu 22.04 below, the resulting installation package can be
installed on at least all OSs supported in the
[Zonemaster-GUI installation instructions].

## Prepare build environment

Start by creating a build environment. Here we assume and base it on
[Ubuntu] version 22.04. The instructions will probably work with other versions
of Ubuntu, or with other Linux distributions or other OSs, but then you might
need to adapt some of the commands. Note however that it is important that the
system fully supports [npm].

### Install toolchain

1. Make a clean installation of Ubuntu 22.04.

2. Update the package database and install Curl and Git.

   ```sh
   sudo apt-get update
   sudo apt-get install curl git

3. Install Node.js by using [NVM], a node version manager.

   ```sh
   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
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

## Check out source code

You need to checkout the source code of Zonemaster-GUI. In the usual case
you will start with the `master` branch latest Zonemaster-GUI release as
shown below.

```sh
git clone -b master https://github.com/zonemaster/zonemaster-gui.git
cd zonemaster-gui
```

If you already have a clone, make sure that you start from an up-to-date `master`
branch.

```sh
git checkout master
git fetch --all
git pull
```

## Add customization

From there, you can start to do your own customization. The simplest case only
requires an update to [config.ts]. See the [GUI Configuration][README] overview
for more details.

You should then save any changed file by doing the following steps (see
[Git tutorial]).

```sh
git checkout -b MY-BRANCH
git add FILE
git commit -m 'What did I do?'
```

## Build installation package

When building you should have a clean repository. Clean means that all temporary
(i.e. non-versioned) files are removed.


1. List all files and changes that will be removed with next step.

   ```sh
   git status --ignored
   ```

2. Remove all files and changes not included in a Git branch (listed in
   previous step).

   ```sh
   git clean -dfx
   git reset --hard
   ```

3. Install [npm] libraries in the repository.

   ```sh
   npm install
   ```

4. Build the Zonemaster-GUI.

   ```sh
   npm run build
   ```

5. If building fails, go back to the "[Install toolchain]" section and repeat the
   two `nvm` commands and restart building.

6. Build a Zonemaster-GUI installation package (a zip file).

   ```sh
   npm run release
   ```

If all steps worked well, there will be a zip file in the current repository that
can be used for installation, i.e. by replacing the official installation package
(zip file) with this new zip file in the [Zonemaster-GUI installation instructions].

If the build step above fails, go back to a safe branch and add your updates one
by one, and repeating steps 1-5.


## Testing the Build Locally

To test the static build locally, it must be served from the root path (/). You
can use any static server. Here are two common options, and note that
additional software has to be installed for those:

```sh
python3 -m http.server 8000 --directory ./public
```

```sh
php -S localhost:8000 -t ./public
```

Ensure you're serving the ./public directory (or your build output folder) as
the root for all assets and routing to work correctly.


[Git tutorial]:                                                   https://git-scm.com/docs/gittutorial
[Known issue]:                                                    https://github.com/nvm-sh/nvm#troubleshooting-on-linux
[NPM]:                                                            https://www.npmjs.com/
[NVM]:                                                            https://github.com/nvm-sh/nvm
[Node.js]:                                                        https://nodejs.org/en
[README]:                                                         README.md
[Ubuntu]:                                                         https://ubuntu.com/
[Zonemaster-GUI installation instructions]:                       ../../installation/zonemaster-gui.md
[config.ts]:                                                      configuring-using-config-ts.md
[tsconfig.json]:                                                  configuring-using-tsconfig-json.md
[theme updates]:                                                  configuring-using-theming.md
[Install toolchain]:                                              #install-toolchain
