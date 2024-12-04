Release process - Create Test Distribution
==========================================

## Table of contents

* [1. Overview](#1-overview)
* [2. Prepare a build environment](#2-prepare-a-build-environment)
* [3. Create a clean environment](#3-create-a-clean-environment)
* [4. Generate Makefile, META.yml and others](#4-generate-makefile-metayml-and-others)
* [5. Verify that MANIFEST is up to date and that tarball can be built](#5-verify-that-manifest-is-up-to-date-and-that-tarball-can-be-built)
* [6. Produce distribution tarballs](#6-produce-distribution-tarballs)
* [7. Produce distribution zip file](#7-produce-distribution-zip-file)
* [8. Produce Docker image](#8-produce-docker-image)
* [9. Verify that Zonemaster works when installed](#9-verify-that-zonemaster-works-when-installed)
* [10. Restart testing](#10-restart-testing)

## 1. Overview

The purpose of this part is to create the test distributions that can be
used in QA testing for a release. It can also be used to create test
distributions to verify a pull request.

> **Note:** *Normally, the develop branch version of this document should be used.*

## 2. Prepare a build environment

Set up build system to be used for the test distribution creation. See
[Build Environment Preparation] for how to set it up.


## 3. Create a clean environment

Make sure that you have checked out the correct git branch, normally
the `develop` branch and that your clone is up-to-date.

       git fetch --all
       git branch

For Zonemaster-LDNS only - check out submodule to the right commit (LDNS):

       git submodule update

Make sure your working directory is clean.

       git status --ignored

To clean (throw away untracked changes or files):

       git clean -dfx
       git reset --hard

You should usually work in the *develop branch*, and that should be up-to-date
with the remote *develop branch*. Your working branch:

    git branch -av | grep "^*"

All branches called "develop":

    git branch -av --list "*develop"


## 4. Generate Makefile, META.yml and others

> This section is not relevant for Zonemaster-GUI.

 * For Zonemaster-LDNS:

       perl Makefile.PL --no-ed25519

 * For all components except Zonemaster-LDNS:

       perl Makefile.PL

> **Note: You can ignore the following warnings:**
> * Missing META.yml (created by the very same command).
> * Zonemaster-LDNS: Missing ldns source files (fetched by the very same command).
> * Zonemaster-Engine and Zonemaster-CLI: Missing .mo files (created in a later step).
> * Missing prerequisite (only needed on target system), e.g.:
>   * "Warning: prerequisite JSON::XS 0 not found."

## 5. Verify that MANIFEST is up to date and that tarball can be built

> This section is not relevant for Zonemaster-GUI.

Build generated files (if any) and verify that a distribution tarball can be 
successfully built for each component that is to be updated in this release.

    make all

For all components, make sure that all files are covered by MANIFEST and/or 
MANIFEST.SKIP, i.e. no missing or extra files:

    make distcheck


## 6. Produce distribution tarballs

> This section is not relevant for Zonemaster-GUI.

    make dist


## 7. Produce distribution zip file

> This section is relevant for Zonemaster-GUI only.

For this you need a [build environment for Node.js], on which you create
the zip file.

Clone the Zonemaster-GUI git repository:

1. `git clone -b develop https://github.com/zonemaster/zonemaster-gui.git`
2. `cd zonemaster-gui`

If you already have the repository:

1. `cd zonemaster-gui`
2. `git fetch --all`
3. `git checkout origin/develop`

Build the distribution zip file:

1. `npm install` 
2. `npm run release`

> Usually you can ignore warnings and security fixes, and usually you
> do not run any `npm audit fix`. Check for open issues in Zonemaster-GUI
> and ask the others in the work group.

The distribution zip file is in the root level of the zonemaster-gui folder. 
Its name is `zonemaster_web_gui.zip`.


## 8. Produce Docker image

Follow the instructions in [Create Docker Image] to build CLI Docker image for
testing.

## 9. Verify that Zonemaster works when installed

Verify that Zonemaster works when installed according to the documented
installation procedures

Using the *preliminary distribution tarballs* produced in step 6 above, the
*preliminary distribution zip file* produced in step 7 above and the Docker
image produced in step 8, follow the procedures in [SystemTesting].

## 10. Restart testing

If the system testing fails in a way that requires updated distribution
tarballs, zip file or Docker image:
 1. Get the changes merged.
 2. Consider whether the actions taken in steps 2–8 above need amendment.
 3. Resume this document from step 9 above.


[Build Environment Preparation]:              ../distrib-testing/README.md
[Build environment for Node.js]:              ../distrib-testing/Ubuntu-Node.js-build-environment.md
[Create Docker Image]:                        ReleaseProcess-create-docker-image.md
[NVM]:                                        https://github.com/nvm-sh/nvm
[Node.js]:                                    https://nodejs.org/en/
[SystemTesting]:                              SystemTesting.md

