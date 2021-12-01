Release Process - Create .deb Packages
=====================================


## Overview

The process to build the packages is split in two parts. First "nightly
packages" are updated, those packages that are based on the develop branch
of Zonemaster git repositories. Thenthose packages are promoted to "stable
packages". The only difference between a nightly packages and its promoted
version is the upstream tarball. While the nightly packages use the develop
branch as upstream, the stable ones use a specific tag.

## 1. Updating the nightly packages

The sources for nightly packages are kept in the branch `<distribution>-nightly`.

For each package:

1. Update the `debian/control` file to add and/or remove any dependencies that
   have changed.

2. If there are new files (executables as such), update `debian/*.manpages` and
   `debian/*.install` accordingly. This step is not required for new Perl
   modules, but will be for new scripts.

## 2. Promote the nightly build to stable

After the Github release and when the nightly package is working fine, promote
it to stable:

1. Locally merge `<distribution>-nightly` into `<distribution>`.

2. Update the upstream ref in `pkg.sh` with the tag of the corresponding release
   for each package.

3. Update the `changelog` for each packages, by adding a new entry. The first line
   should contain the package version in format
   `<project version>-<package version>+deb<debian version>`.

   For example:  `zonemaster-cli (3.1.0-3+deb11)` is the partial entry for
   Zonemaster CLI version `3.1.0`, the package version is `3` and it is built
   for Debian 11.

4. Push the modifications to the packages sources repository. Then the packages
   are automatically built and deployed to package.zonemaster.net.

> Note: It is fairly important to perform all of those steps in "one push"
> as the continuous deployment pipeline will start building the new packages
> on the push event.


## 3. Testing the packages

To test the newly created packages you can configure Zonemaster packages
repository using:

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
## Appendices

### Repositories location

* [Packages sources]: hold the sources for all Zonemaster packages.

  Each package is split in two, one for the libraries and executable and an
  other one for the documentation. The documentation packages are marked as
  "Recommends" and will be installed by default alongside their corresponding
  package.

* [Common Gitlab pipeline]: common ci/cd jobs for all branchs in the packages
  source repository.

* [`package.zonemaster.net` content]: setup script and public verification key

### Publication pipeline overview

The continuous deployment pipeline perform 3 tasks:

1. Build the packages using the `build.sh` script in the packages sources
   repository.

2. Update the [aptly] repository and publish the new packages.

3. Perform a smoke test by installing the latest package and running the CLI.

### Further resources

* [Aptly documentation](https://www.aptly.info/doc/overview/)
* [Debian maintainer guide](https://www.debian.org/doc/manuals/maint-guide/)
* [Third party repository in Debian](https://wiki.debian.org/DebianRepository/UseThirdParty)

[aptly]: https://aplty.info
[Packages sources]: https://gitlab.rd.nic.fr/zonemaster/packages/debian
[Common Gitlab pipeline]: https://gitlab.rd.nic.fr/zonemaster/ci/-/blob/main/deb-packaging.yml
[`package.zonemaster.net` content]: https://gitlab.rd.nic.fr/zonemaster/packages/www/
