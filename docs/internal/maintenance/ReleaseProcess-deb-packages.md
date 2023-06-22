Release Process - Create .deb packages
======================================


## Overview

The purpose of this process is to create and publish .deb packages for
Zonemaster components, currently only Zonemaster-CLI, Zonemaster-Engine and
Zonemaster-LDNS are covered.

The process to build the packages is split in two steps. In the first step "nightly
packages" are updated. In the second step packages are promoted to "stable packages".

## 1. Update the nightly packages specification

Nightly packages are based on the develop branch of Zonemaster git repositories.
The sources for nightly packages are kept in the branch `<distribution>-nightly`
of the [Packages sources] repository. Where `<distribution>` corresponds to the
name of the Debian or Ubuntu version the branch is building packages for.
As Ubuntu packages are based on the Debian ones, this will most likely be a
Debian version name.

For each package:

1. If dependencies have changed, update the `Build-Depends` and `Depends`
   section of the  `debian/control` file for each  required package to add
   and/or remove any dependencies that have changed.

2. If there are new files (such as executables), update `debian/*.manpages` and
   `debian/*.install` accordingly. This step is not required for new Perl
   modules, but will be for new scripts.

## 2. Promote the nightly build to stable


When a new Zonemaster release of the relevant component has been
[published on Github], and when the nightly package is working fine (the build
is successfull, it can be installed and is usable, all of that should have been
already checked during the relase testing if the package specification has not
changed since), promote it to stable. The only difference between a nightly
packages and its promoted version is the upstream tarball. While the nightly
packages use the develop branch as upstream, the stable ones use a specific
tag.

1. Locally merge the `<distribution>-nightly` branch into `<distribution>` of
   the [Packages sources] repository. The `.gitlab-ci.yml` and `pkg.sh` files
   should not be merged.
   For instance the following commands could be used to merge
   `bullseye-nightly` into `bullseye`:
   ```
   git checkout bullseye-nightly
   git merge --no-commit bullseye
   git restore .gitlab-ci.yml */pkg.sh
   git commit
   ```

2. Update the upstream ref in `pkg.sh` with the tag of the corresponding release
   for each package.

3. Update the `changelog` for each package, by adding a new entry. The first line
   should contain the package version in format
   `<project version>-<package version>+deb<debian version>`.

   For example:  `zonemaster-cli (3.1.0-3+deb11)` is the partial entry for
   Zonemaster CLI version `3.1.0`, the package version is `3` and it is built
   for Debian 11. Package version is incremented when the package sources are
   updated but the upstream version (i.e. Zonemaster component version) remains
   the same.

4. Push the modifications to the packages sources repository. Then the packages
   are automatically built and deployed to package.zonemaster.net.

> Note: It is fairly important to perform all of those steps in "one push"
> as the continuous deployment pipeline will start building the new packages
> on the push event.


## Test the packages

To test the newly created packages you can configure Zonemaster packages
repository using:

```sh
curl -LSsf https://package.zonemaster.net/setup.sh | sudo sh
```

To configure the nightly repository use instead:

```sh
curl -LSsf https://package.zonemaster.net/setup.sh | sudo nightly=yes sh
```

The packages can then be installed using apt, e.g.:

```sh
sudo apt install zonemaster-cli
```

## Add support for a new OS version

Edit the `.gitlab-ci.yml` file to add three new jobs for the new OS version.
The name of the job is in the format `{step}:{os}:{version codename}`, where
step is one of `build`, `publish` and `test`. The jobs must extend a parent job
named `.{step}`. The build and publish steps must also define the following
variables:
* `OS`: OS name as it is in the `/etc/os-release`;
* `DISTRIBUTION`: Version codename as defined by `VERSION_CODENAME` in
   `/etc/os-release`, optionaly suffixed by `-nightly`.

The container image used for building should be the same version as the targeted
distribution.

Example for Ubuntu 22.04, codename "Jammy" the following is added to the CI
file.
```yml
build:ubuntu:jammy:
  extends: .build
  image: ubuntu:jammy
  variables:
    # For nightly
    #DISTRIBUTION: jammy-nightly
    # For stable
    DISTRIBUTION: jammy
    OS: ubuntu

publish:ubuntu:jammy:
  extends: .publish
  image: ubuntu:jammy
  variables:
    # For nightly
    #DISTRIBUTION: jammy-nightly
    # For stable
    DISTRIBUTION: jammy
    OS: ubuntu
  needs:
    - build:ubuntu:jammy

test:ubuntu:jammy:
  extends: .test
  image: ubuntu:jammy
  # Only in nightly branches
  #variables:
  #  nightly: 'yes'
  needs:
    - publish:ubuntu:jammy
```

When publishing packages for a different Debian version, it may be prefered to
create a separate set of branches. In this case the new CI jobs replace the olds
ones in the CI file.

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

The continuous deployment pipeline performs 3 tasks:

1. `build`: build the packages using the `build.sh` script in the packages
   sources repository.

2. `publish`: update the [aptly] repository and publish the new packages.

3. `test`: perform a smoke test by installing the latest package and running the
    CLI.

### Further resources

* [Aptly documentation](https://www.aptly.info/doc/overview/)
* [Debian maintainer guide](https://www.debian.org/doc/manuals/maint-guide/)
* [Third party repository in Debian](https://wiki.debian.org/DebianRepository/UseThirdParty)

[aptly]: https://www.aptly.info
[Packages sources]: https://gitlab.rd.nic.fr/zonemaster/packages/debian
[Common Gitlab pipeline]: https://gitlab.rd.nic.fr/zonemaster/ci/-/blob/main/deb-packaging.yml
[`package.zonemaster.net` content]: https://gitlab.rd.nic.fr/zonemaster/packages/www/
[published on Github]: ReleaseProcess-release.md#16-tag-the-release-with-git
