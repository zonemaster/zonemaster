Release process - Release
=========================

The steps in this document executes the actual release. They assume that
development, the preparation steps and the QA testing have been concluded.


## 1. Applicable components

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


## 2. Updates to repositories

All updates to *develop branch* and *master branch* should go via pull
requests following the usual process. That is just assumed here.


## 3. Determine the new version number

The version number of the new release should be chosen according to
[Versions and Releases] document.

Each component listed above should have its version number. The Zonemaster
Product (Zonemaster/Zonemaster) version number also refer to the version
of the other components.


## 4. Update the Changes file

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
 

## 5. Set all version numbers

> This section is not relevant for Zonemaster/Zonemaster.

The version numbers is to be set in these Perl modules in the *develop branch*:

 * zonemaster-ldns - [LDNS.pm]
 * zonemaster-engine - [Engine.pm]
 * zonemaster-cli - [CLI.pm]
 * zonemaster-backend - [Backend.pm]

The GUI has no Perl. Update the following files in the *develop branch*:

 * zonemaster-gui
   - [Installation.md][Installation.md GUI]: The version is part of the download
   path (a directory). It can be repeated several times, once per OS.
   - [package.json][package.json GUI]: In the top of the file, the version is
   given after "version".
   - [environment.prod.ts][environment.prod.ts GUI] and 
   [environment.ts][environment.ts GUI]: Under "client-info", "version"
   should point at the version number in both files.


## 5. Update Makefile.PL with required version

> This section is relevant for Zonemaster-Engine, Zonemaster-CLI and
> Zonemaster-Backend.

If needed update Makefile.PL in the *develop branch*.

### Zonemaster-Engine

In [Zonemaster-Engine Makefile.PL] set the lowest version of Zonemaster-LDNS
that Zonemaster-Engine requires. If unsure, set the version of Zonemaster-LDNS
included in this release since that is what has been tested. E.g.

```
requires 'Zonemaster::LDNS'   => 2.0;
```

### Zonemaster-CLI

In [Zonemaster-CLI Makefile.PL] set the lowest version of Zonemaster-LDNS and
Zonemaster-Engine that Zonemaster-CLI requires. If unsure, set the versions
included in this release since that is what has been tested. E.g.

```
requires 'Zonemaster::Engine' => 3.0;
requires 'Zonemaster::LDNS'   => 2.0;
```

### Zonemaster-Backend

For [Zonemaster-Backend Makefile.PL], as for Zonemaster-CLI above.


## 6. Create a clean Git working area of *develop branch*

Make sure that you have checked out the `develop` branch and
that your clone is up-to-date.

       git fetch --all
       git branch

Make sure your working directory is clean.

       git status --ignored

To clean:

       git clean -dfx
       git reset --hard


## 7. Generate Makefile, META.yml and others

> This section is not relevant for Zonemaster-GUI or Zonemaster/Zonemaster

 * For Zonemaster-LDNS:

       perl Makefile.PL --no-ed25519

 * For all components except Zonemaster-LDNS:

       perl Makefile.PL

> **Note:** Ignore the warning about the missing META.yml (created by the very
> same command).
>
> For Zonemaster-LDNS ignore the warnings about lots of missing ldns source
> files (fetched by the very same command).
>
> For Zonemaster-Engine ignore the warnings about missing .mo files (created
> in a later step).


## 8. Verify that MANIFEST is up to date and that tarball can be built

> This section is not relevant for Zonemaster-GUI or Zonemaster/Zonemaster

Build generated files (if any) and verify that a distribution tarball can be 
successfully built for each component that is to be updated in this release.

    make all

For all components, make sure that all files are covered by MANIFEST and/or 
MANIFEST.SKIP, i.e. no missing or extra files:

    make distcheck


## 9. Produce distribution tarballs

> This section is not relevant for Zonemaster-GUI or Zonemaster/Zonemaster

    make dist


## 10. Produce distribution zip file

> This section is relevant for Zonemaster-GUI only.

The requirements are nodejs and npm. There are available from the [Node.js]
official website. Minimal version of Nodejs is 10.0 but install the last LTS
version available. It was tested on Ubuntu 18.04.

To build a new development environnement, you need to install nodejs.
We use [NVM], a node version manager.

1. `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash`
2. `nvm install 13.12.0`
3. `nvm use 13.12.0`

To build the tarballs, steps are: 

1. `git clone https://github.com/zonemaster/zonemaster-gui.git`
2. `cd zonemaster-gui`
3. `npm install` 
4. `npm run release`

The distribution zip file is in the root level of the zonemaster-gui folder. 
Its name is `zonemaster_web_gui.zip`.


## 11. Update Zonemaster repository main _README.md_

> This section is relevant for Zonemaster/Zonemaster only.

If needed, update the following section of the Zonemaster repository main
[README.md][Zonemaster main README] file in *develop branch*:

* Notable bugs and issues


## 12. Generate documents

> This section is relevant for Zonemaster/Zonemaster only.

If no files in neither Zonemaster/Zonemster nor Zonemaster-Engine have been
updated this section can be skipped.

1. On a computer install Zonemaster-LDNS and Zonemaster-Engine using the
   distribution packages created for this release.  
2. Clone Zonemaster/Zonemaster and check out the *develop branch*. The
   working area should be clean (`git status --ignore`).
3. Go to the [utils Zonemaster][utils] directory and create the files as
   documented in the [Zonemaster utils README][README.pm] file in that
   directory.
4. If any of the created files has been updated (`git status`) then it
   should be added to the *develop branch* via a pull request.


## 11. Upload to CPAN

> This section is not relevant for Zonemaster-GUI or Zonemaster/Zonemster.

For each component that is to be updated in this release, publish the
distribution tarball created following this document on CPAN.
Currently we use the organizational account [ZNMSTR] on [PAUSE] for doing
this.


## 12. Merge develop branch into master

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
    git reset origin/master

    # With all differences squashed into a single commit
    git commit -m 'Update master to state of develop' -i .

    # And we want the history of *develop* merged too
    git merge origin/develop

Create a pull request from `merge-develop-into-master` into `master` and have it
merged through the normal process.


## 13. Tag the release with git

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


## 14. Announce the release

Send emails to the mailing lists `zonemaster-users` and `zonemaster-announce`.


<!-- Zonemaster links point on purpose on the develop branch. -->
[Backend.pm]:                              https://github.com/zonemaster/zonemaster-backend/blob/develop/lib/Zonemaster/Backend.pm
[CI]:                                      https://github.com/travis-ci/travis-ci
[CLI.pm]:                                  https://github.com/zonemaster/zonemaster-cli/blob/develop/lib/Zonemaster/CLI.pm
[CPAN]:                                    https://www.cpan.org/
[Changes Backend]:                         https://github.com/zonemaster/zonemaster-backend/blob/develop/Changes
[Changes CLI]:                             https://github.com/zonemaster/zonemaster-cli/blob/develop/Changes
[Changes Engine]:                          https://github.com/zonemaster/zonemaster-engine/blob/develop/Changes
[Changes GUI]:                             https://github.com/zonemaster/zonemaster-gui/blob/develop/Changes
[Changes LDNS]:                            https://github.com/zonemaster/zonemaster-ldns/blob/develop/Changes
[Changes Zonemaster]:                      https://github.com/zonemaster/zonemaster-gui/blob/develop/Changes
[Engine.pm]:                               https://github.com/zonemaster/zonemaster-engine/blob/develop/lib/Zonemaster/Engine.pm
[Installation.md GUI]:                     https://github.com/zonemaster/zonemaster-gui/blob/develop/docs/Installation.md
[LDNS.pm]:                                 https://github.com/zonemaster/zonemaster-ldns/blob/develop/lib/Zonemaster/LDNS.pm
[NVM]:                                     https://github.com/nvm-sh/nvm
[Node.js]:                                 https://nodejs.org/en/
[PAUSE]:                                   https://pause.perl.org/
[Versions and releases]:                   https://github.com/zonemaster/zonemaster/blob/develop/docs/design/Versions%20and%20Releases.md
[ZNMSTR]:                                  https://metacpan.org/author/ZNMSTR
[Zonemaster Product Releases]:             https://github.com/zonemaster/zonemaster/releases
[Zonemaster main README]:                  https://github.com/zonemaster/zonemaster/blob/develop/README.md
[Zonemaster-Backend Makefile.PL]:          https://github.com/zonemaster/zonemaster-backend/blob/develop/Makefile.PL
[Zonemaster-Backend Releases]:             https://github.com/zonemaster/zonemaster-backend/releases
[Zonemaster-CLI Makefile.PL]:              https://github.com/zonemaster/zonemaster-cli/blob/develop/Makefile.PL
[Zonemaster-CLI Releases]:                 https://github.com/zonemaster/zonemaster-cli/releases
[Zonemaster-Engine Makefile.PL]:           https://github.com/zonemaster/zonemaster-engine/blob/develop/Makefile.PL
[Zonemaster-Engine Releases]:              https://github.com/zonemaster/zonemaster-engine/releases
[Zonemaster-GUI Releases]:                 https://github.com/zonemaster/zonemaster-gui/releases
[Zonemaster-LDNS Releases]:                https://github.com/zonemaster/zonemaster-ldns/releases
[declaration of prerequisites]:            https://github.com/zonemaster/zonemaster/blob/develop/README.md#prerequisites
[environment.prod.ts GUI]:                 https://github.com/zonemaster/zonemaster-gui/blob/develop/src/environments/environment.prod.ts
[environment.ts GUI]:                      https://github.com/zonemaster/zonemaster-gui/blob/develop/src/environments/environment.ts
[license string]:                          https://metacpan.org/pod/CPAN::Meta::Spec#license
[package.json GUI]:                        https://github.com/zonemaster/zonemaster-gui/blob/develop/package.json
[utils Zonemaster]:                        https://github.com/zonemaster/zonemaster/tree/develop/utils
[Zonemaster utils README]:                 https://github.com/zonemaster/zonemaster/blob/develop/utils/README.md



