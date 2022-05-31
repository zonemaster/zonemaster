Release process - Release
=========================

## Table of contents

* [1. Overview](#1-overview)
* [2. Applicable components](#2-applicable-components)
* [3. Updates to repositories](#3-updates-to-repositories)
* [4. Determine the new version number](#4-determine-the-new-version-number)
* [5. Update the Changes file](#5-update-the-changes-file)
* [6. Set all version numbers](#6-set-all-version-numbers)
* [7. Update Makefile.PL with required version](#7-update-makefilepl-with-required-version)
* [8. Create a clean Git working area of *develop branch*](#8-create-a-clean-git-working-area-of-develop-branch)
* [9. Generate Makefile, META.yml and others](#9-generate-makefile-metayml-and-others)
* [10. Verify that MANIFEST is up to date and that tarball can be built](#10-verify-that-manifest-is-up-to-date-and-that-tarball-can-be-built)
* [11. Produce distribution tarballs](#11-produce-distribution-tarballs)
* [12. Produce distribution zip file](#12-produce-distribution-zip-file)
* [13. Update Zonemaster repository main _README.md_](#13-update-zonemaster-repository-main-readmemd)
* [14. Generate documents](#14-generate-documents)
* [15. Upload to CPAN](#15-upload-to-cpan)
* [16. Merge develop branch into master](#16-merge-develop-branch-into-master)
* [17. Create Docker images and upload image to Docker Hub](#17-create-docker-images-and-upload-image-to-docker-hub)
* [18. Tag the release with git](#18-tag-the-release-with-git)
* [19. Announce the release](#19-announce-the-release)
* [20. Merge master into develop](#20-merge-master-into-develop)
* [Appendix A on version number in Makefile.PL](#appendix-a-on-version-number-in-makefilepl)
* [Appendix B on how to verify merge develop branch into master branch](#appendix-b-on-how-to-verify-merge-develop-branch-into-master-branch)

## 1. Overview

The steps in this document executes the actual release. They assume that
development, the preparation steps and the QA testing have been concluded.
To run the steps below a build system is needed. See 
[Build Environment Preparation] for how to set it up.

> **Note:** *Normally, the develop branch version of this document should be used.*


## 2. Applicable components

Every applicable step below should be run for each component. If there are no
changes in a component (no release) it should be skipped. The main component
(Zonemaster/Zonemaster) can never be skipped and should always be released.
The components should be released in the following order:

 * zonemaster-ldns
 * zonemaster-engine
 * zonemaster-cli
 * zonemaster-backend
 * zonemaster-gui
 * Zonemaster/Zonemaster


## 3. Updates to repositories

All updates to *develop branch* and *master branch* should go via pull
requests following the usual process. That is just assumed here.


## 4. Determine the new version number

The version number of the new release should be chosen according to
[Versions and Releases] document.

Each component listed above should have its version number. The Zonemaster
Product (Zonemaster/Zonemaster) version number also refer to the version
of the other components.


## 5. Update the Changes file

Any changes since the last release must be documented in the Changes files.
Refer to any Github issues or pull requests related to the change by the
issue number or pull request number or both.

The updates to the *Changes* file are done to the *develop branch*.

 * zonemaster-ldns - [Changes LDNS]
 * zonemaster-engine - [Changes Engine]
 * zonemaster-cli - [Changes CLI]
 * zonemaster-backend - [Changes Backend]
 * zonemaster-gui - [Changes GUI]
 * Zonemaster/Zonemaster - [Changes Zonemaster]
 

## 6. Set all version numbers

> This section is not relevant for Zonemaster/Zonemaster.

The version numbers is to be set in these Perl modules in the *develop branch*:

 * zonemaster-ldns - [LDNS.pm]
 * zonemaster-engine - [Engine.pm]
 * zonemaster-cli - [CLI.pm]
 * zonemaster-backend - [Backend.pm]

The GUI has no Perl. Update the following files in the *develop branch*:

 * zonemaster-gui
   - [docs/Installation.md][Installation.md GUI]
     - The version is part of the download path (a directory). It can be
       repeated several times, once per OS.
   - [package.json][package.json GUI]
     - In the top of the file, the version is given after "version".
     - The file `package-lock.json` is ignored
   - [src/environments/version.ts][Version.ts GUI]
     - "version" should point at the version number.

## 7. Update Makefile.PL with required version

> This section is relevant for Zonemaster-Engine, Zonemaster-CLI and
> Zonemaster-Backend.

If needed, update Makefile.PL in the *develop branch*. See [Appendix A] for
how the version number should be specified in `Makefile.PL`.

Usually let Zonemaster-Engine, Zonemaster-CLI and Zonemaster-Backend,
respectively, require the version of other the Zonemaster components
(see below) included in this release, because that is what has been tested.

If a component will not be updated by this release, then it can continue to
require the previous version unless it must be change to resolve some issue,
and then the version of the requiring component must also be updated.

In **[Zonemaster-Engine Makefile.PL]** set the lowest version of Zonemaster-LDNS
that Zonemaster-Engine requires. E.g.

```
requires 'Zonemaster::LDNS'   => 2.001;
```

In **[Zonemaster-CLI Makefile.PL]** and **[Zonemaster-Backend Makefile.PL]**,
set the minimum required versions of Zonemaster-LDNS and Zonemaster-Engine.
E.g.

```
requires 'Zonemaster::Engine' => 4.000;
requires 'Zonemaster::LDNS'   => 2.001;
```

## 8. Create a clean Git working area of *develop branch*

Make sure that you have checked out the `develop` branch and
that your clone is up-to-date.

       git fetch --all
       git branch

Make sure your working directory is clean.

       git status --ignored

To clean:

       git clean -dfx
       git reset --hard


## 9. Generate Makefile, META.yml and others

> This section is not relevant for Zonemaster-GUI or Zonemaster/Zonemaster

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


## 10. Verify that MANIFEST is up to date and that tarball can be built

> This section is not relevant for Zonemaster-GUI or Zonemaster/Zonemaster

Build generated files (if any) and verify that a distribution tarball can be 
successfully built for each component that is to be updated in this release.

    make all

For all components, make sure that all files are covered by MANIFEST and/or 
MANIFEST.SKIP, i.e. no missing or extra files:

    make distcheck


## 11. Produce distribution tarballs

> This section is not relevant for Zonemaster-GUI or Zonemaster/Zonemaster

    make dist


## 12. Produce distribution zip file

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

> You can ignore warnings and security fixes at this stage, and do not run 
> any `npm audit fix`.

The distribution zip file is in the root level of the zonemaster-gui folder. 
Its name is `zonemaster_web_gui.zip`.


## 13. Update Zonemaster repository main _README.md_

> This section is relevant for Zonemaster/Zonemaster only.

If needed, update the following section of the Zonemaster repository main
[README.md][Zonemaster main README] file in *develop branch*:

* Notable bugs and issues


## 14. Generate documents

> This section is relevant for Zonemaster/Zonemaster only.

If no files in neither Zonemaster/Zonemaster nor Zonemaster-Engine have been
updated this section can be skipped.

1. On a computer install Zonemaster-LDNS and Zonemaster-Engine using the
   distribution packages created for this release.  
2. Clone Zonemaster/Zonemaster and check out the *develop branch*. The
   working area should be clean (`git status --ignore`).
3. Go to the [utils][utils Zonemaster] directory and create the files as
   documented in the [README.pm][Zonemaster utils README] file in that
   directory.
4. If any of the created files has been updated (`git status`) then it
   should be added to the *develop branch* via a pull request.


## 15. Upload to CPAN

> This section is not relevant for Zonemaster-GUI or Zonemaster/Zonemaster.

For each component that is to be updated in this release, publish the
distribution tarball created following this document on CPAN.
Currently we use the organizational account [ZNMSTR] on [PAUSE] for doing
this.


## 16. Merge develop branch into master

> For the steps in this section, it is assumed that the git "remote"
> which is called "origin" points at "zonemaster/zonemaster.git",
> "zonemaster/zonemaster-ldns.git" etc. This is default when making a
> git clone. Use `git remote -v` to verify that.

Make sure you're up to date and your working directory is completely clean:

    git fetch origin
    git status --ignored

> **Note:** To throw away any and all changes to tracked and untracked files you
> can run `git clean -dfx ; git reset --hard`.

Create a new branch named `merge-develop-into-master` with both *master* and
*develop* as ancestors and with the exact contents from *develop*:

    # We want the contents of the *develop* branch
    git checkout -b merge-develop-into-master origin/develop

    # But on top of the history of the *master* branch
    git reset --soft origin/master

    # With all differences squashed into a single commit
    git commit -m 'Update master to state of develop'

    # And we want the history of *develop* merged too
    git merge origin/develop

Create a pull request from `merge-develop-into-master` into `master` and have it
merged through the normal process.

In [Appendix B] it is shown how `merge-develop-into-master` can be verified.


## 17. Create Docker images and upload image to Docker Hub

1. Follow the instructions in [Create Docker Image] to build a Docker images.
2. Upload the Zonemaster-CLI image to [Docker Hub] for Zonemaster using the
   instructions in [Create Docker Image].


## 18. Tag the release with git

For each repository, go to "releases" in Github and select "draft a new release".
Use the version number as tag and create a new release description. Use the
section of Changes file for the relevant release and make links of everything 
that can have meaningful links, especially make links to issues and PRs.

For Zonemaster-GUI, add the *distribution zip file* as attached file to the
release description in Github.

Always release the Zonemaster Product (Zonemaster/Zonemaster) as the last step.

The releases pages:

* [Zonemaster-LDNS Releases]
* [Zonemaster-Engine Releases]
* [Zonemaster-CLI Releases]
* [Zonemaster-Backend Releases]
* [Zonemaster-GUI Releases]
* [Zonemaster Product Releases]


## 19. Announce the release

Send emails to the mailing lists `zonemaster-users` and `zonemaster-announce`.


## 20. Merge master into develop

Create a pull request from `master` on github back into `develop` and have it
merged through the normal process.


## Appendix A on version number in Makefile.PL

As described above, `Makefile.PL` of Zonemaster-CLI and Zonemaster-Backend,
respectively, must be specified with the lowest supported version of
Zonemaster::LDNS and Zonemaster::Engine, respectively. Zonemaster-Engine
must have that of Zonemaster::LDNS.

The versions of Zonemaster::LDNS and Zonemaster::Engine are defined in the
format `vX.Y.Z` and it is important how this is written in `Makefile.PL`.

For lowest risk of error follow the following steps:

1. Expand the version number with leading zeros on second ("Y") and third
   ("Z") level. Remove the leading `v` and the second and third dots.
   E.g. `v2.1.2` = `2.001002`.
2. Decide if the third level can be skipped, e.g. `v2.1.2` > `2.001`.
3. Please note that if the version in `Makefile.PL` is set to `2.1` then
   the interpretation is that the "v" version is `v2.100.0` or greater.

When specifying the version of Zonemaster::LDNS and Zonemaster::Engine in
`Makefile.PL` always use the expanded format, e.g. `2.001002` or `2.001`
depending on the need.

For other libraries, other formats may be correct. If the version of the
library only has two levels ("X.Y") then other rules apply. Also note
that the version in Zonemaster::Backend is speciefied as `X.Y.Z` without
the "v", which may affect the version comparison.


## Appendix B on how to verify merge develop branch into master branch

Below are two ways of verifying that the branch created for merging
develop branch into master branch is correct. The first is to use the
local clone where the `merge-develop-into-master` branch was created.

Run the command

```
git diff origin/develop merge-develop-into-master
```
The result should be no difference, i.e. the contents of the new branch
is the same as the develop branch. Then run the following two commands
```
git merge-base origin/develop merge-develop-into-master
git show-ref --hash origin/develop
```
The two commands should report the same commit.

The second way of verifying is to use Githubs tool for creating pull
requests. Start to create a pull request from
`merge-develop-into-master` develop `master` (but do not really create
it) and inspect what files that Github says will be updated, added or
deleted.

If Github says that no files are updated, added or created, then
branch `merge-develop-into-master` is correct, and a pull request into
`master` branch (not `develop` branch) can be created.


<!-- Zonemaster links point on purpose on the develop branch. -->
[Appendix A]:                              #appendix-a-on-version-number-in-makefilepl
[Appendix B]:                              #appendix-b-on-how-to-verify-merge-develop-branch-into-master-branch
[Backend.pm]:                              https://github.com/zonemaster/zonemaster-backend/blob/develop/lib/Zonemaster/Backend.pm
[Build Environment Preparation]:           ../distrib-testing/BuildEnvironmentPreparation.md
[Build environment for Node.js]:           ../distrib-testing/Ubuntu-Node.js-build-environment.md
[CI]:                                      https://github.com/travis-ci/travis-ci
[CLI.pm]:                                  https://github.com/zonemaster/zonemaster-cli/blob/develop/lib/Zonemaster/CLI.pm
[CPAN]:                                    https://www.cpan.org/
[Changes Backend]:                         https://github.com/zonemaster/zonemaster-backend/blob/develop/Changes
[Changes CLI]:                             https://github.com/zonemaster/zonemaster-cli/blob/develop/Changes
[Changes Engine]:                          https://github.com/zonemaster/zonemaster-engine/blob/develop/Changes
[Changes GUI]:                             https://github.com/zonemaster/zonemaster-gui/blob/develop/Changes
[Changes LDNS]:                            https://github.com/zonemaster/zonemaster-ldns/blob/develop/Changes
[Changes Zonemaster]:                      https://github.com/zonemaster/zonemaster-gui/blob/develop/Changes
[Create Docker Image]:                     ReleaseProcess-create-docker-image.md
[Docker Hub]:                              https://hub.docker.com/u/zonemaster
[Engine.pm]:                               https://github.com/zonemaster/zonemaster-engine/blob/develop/lib/Zonemaster/Engine.pm
[Installation.md GUI]:                     https://github.com/zonemaster/zonemaster-gui/blob/develop/docs/Installation.md
[LDNS.pm]:                                 https://github.com/zonemaster/zonemaster-ldns/blob/develop/lib/Zonemaster/LDNS.pm
[PAUSE]:                                   https://pause.perl.org/
[Package.json GUI]:                        https://github.com/zonemaster/zonemaster-gui/blob/develop/package.json
[Utils Zonemaster]:                        ../../../utils/
[Version.ts GUI]:                          https://github.com/zonemaster/zonemaster-gui/blob/develop/src/environments/version.ts
[Versions and releases]:                   ../../design/Versions%20and%20Releases.md
[ZNMSTR]:                                  https://metacpan.org/author/ZNMSTR
[Zonemaster Product Releases]:             https://github.com/zonemaster/zonemaster/releases
[Zonemaster main README]:                  ../../../README.md
[Zonemaster utils README]:                 ../../../utils/README.md
[Zonemaster-Backend Makefile.PL]:          https://github.com/zonemaster/zonemaster-backend/blob/develop/Makefile.PL
[Zonemaster-Backend Releases]:             https://github.com/zonemaster/zonemaster-backend/releases
[Zonemaster-CLI Makefile.PL]:              https://github.com/zonemaster/zonemaster-cli/blob/develop/Makefile.PL
[Zonemaster-CLI Releases]:                 https://github.com/zonemaster/zonemaster-cli/releases
[Zonemaster-Engine Makefile.PL]:           https://github.com/zonemaster/zonemaster-engine/blob/develop/Makefile.PL
[Zonemaster-Engine Releases]:              https://github.com/zonemaster/zonemaster-engine/releases
[Zonemaster-GUI Releases]:                 https://github.com/zonemaster/zonemaster-gui/releases
[Zonemaster-LDNS Releases]:                https://github.com/zonemaster/zonemaster-ldns/releases

