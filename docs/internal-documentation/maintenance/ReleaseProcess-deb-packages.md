Release Process - Create .deb Packages
=====================================


## Overview

The process to build the packages is splitted in two parts. First we update the
"nightly packages", packages that are based on the develop branch of Zonemaster
repositories. Then we promote those packages to "stable packages". The only
difference between a nightly packages and its prometed version should be the
upstream tarball. While the nightly packages use the develop branch as upstream,
the stable ones use a specific tag.

Each package is splitted in two, one for the libraries and executable and an
other one for the documentation. The documentation packages are marked as
"Recommends" and by default will be installed alongside their corresponding
package.

## Repositories location

* Packages sources: https://gitlab.rd.nic.fr/zonemaster/packages/debian
* Common Gitlab pipeline: https://gitlab.rd.nic.fr/zonemaster/ci/-/blob/main/deb-packaging.yml
* `package.zonemaster.net` content: https://gitlab.rd.nic.fr/zonemaster/packages/www/

## Updating the nightly packages

The source for nightly packages are kept in the branche `<distribution>-nightly`.

For each package:

1. Update the `debian/control` file to add / remove any dependencies that have
   changed.

2. If there are new files (executables as such), update `debian/*.manpages` and
   `debian/*.install` accordingly.

## Promote the nightly build to stable

After the Github release and when the nightly package is working fine, promote
it to stable:

1. Locally merge `<distribution>-nightly` into `<distribution>`.

2. Update the upstream ref in `pkg.sh` with the tag of the corresponding release
   for each package.

3. Update the changelog for each packages, by adding a new entry. The first line
   should contain the package version in format
   `<project version>-<package version>+deb<debian version>`.

   For example:  `zonemaster-cli (3.1.0-3+deb11)` is the partial entry for
   Zonemaster CLI version 3.1.0, the package version is `3` and it is build for
   Debian 11.

4. Push the modification to the package sources repository. The packages then
   are automatically built and deployed to package.zonemaster.net.

> Note: It is fairly important to perform all of those steps in "one push"
> as the continuous deployment pipeline will start building the new packages
> on push.

## Publication pipeline

The continuous deployment pipeline perform 3 tasks:

1. Build the packages using the `build.sh` script in the packages sources
   repository.

2. Update the [aptly] repository and publish the new packages.

3. Perform a smoke test by installing the latest package and running the CLI.


## Testing the packages

To test the new created package you can configure Zonemaster package repository
using:

```sh
curl -Ls https://package.zonemaster.net/setup.sh | sudo sh
```

To configure the nightly repository use instead:

```sh
curl -Ls https://package.zonemaster.net/setup.sh | sudo nightly=yes sh
```

The packages can then be installed using apt, e.g.:

```sh
sudo apt install zonemaster-cli
```


## Further resources
* [Aptly documentation](https://www.aptly.info/doc/overview/)
* [Debian maintainer guide](https://www.debian.org/doc/manuals/maint-guide/)
* [Third party repository in Debian](https://wiki.debian.org/DebianRepository/UseThirdParty)

[aptly]: https://aplty.info
