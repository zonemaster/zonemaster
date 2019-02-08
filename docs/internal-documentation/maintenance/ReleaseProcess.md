Release process
===============

## 1. Update the Changes file

Any changes since the last release must be documented in the Changes files.
Please refer to any Github issues related to the change by the issue number.

 * zonemaster-ldns - [Changes](https://github.com/zonemaster/zonemaster-ldns/blob/master/Changes)
 * zonemaster-engine - [Changes](https://github.com/zonemaster/zonemaster-engine/blob/master/Changes)
 * zonemaster-cli - [Changes](https://github.com/zonemaster/zonemaster-cli/blob/master/Changes)
 * zonemaster-backend - [Changes](https://github.com/zonemaster/zonemaster-backend/blob/master/Changes)
 * zonemaster-gui - [Changes](https://github.com/zonemaster/zonemaster-gui/blob/master/Changes)

## 2. Set all version numbers

The version numbers can be found in these Perl modules:

 * zonemaster-ldns - [LDNS.pm](https://github.com/zonemaster/zonemaster-ldns/blob/master/lib/Zonemaster/LDNS.pm)
 * zonemaster-engine - [Engine.pm](https://github.com/zonemaster/zonemaster-engine/blob/master/lib/Zonemaster/Engine.pm)
 * zonemaster-cli - [CLI.pm](https://github.com/zonemaster/zonemaster-cli/blob/master/lib/Zonemaster/CLI.pm)
 * zonemaster-backend - [Backend.pm](https://github.com/zonemaster/zonemaster-backend/blob/master/lib/Zonemaster/Backend.pm)

The GUI has no Perl. Update the following files:

 * zonemaster-gui - [Installation.md](https://github.com/zonemaster/zonemaster-gui/blob/master/docs/Installation.md):
   The version is part of the download path (a diretory). It can be repeated several times.
 * zonemaster-gui - [package.json](https://github.com/zonemaster/zonemaster-gui/blob/master/package.json):
   In the top of the file, the version is given after "version".
 * zonemaster-gui - [environment.prod.ts](https://github.com/zonemaster/zonemaster-gui/blob/master/src/environments/environment.prod.ts):
   Under "client-info", "version" should point at the version number.
 * zonemaster-gui - [environment.ts](https://github.com/zonemaster/zonemaster-gui/blob/master/src/environments/environment.ts):
   Under "client-info", "version" should point at the version number.

## 3. Update prerequisites

Make sure the [declaration of prerequisites] is up to date with regard to
[SupportCriteria](SupportCriteria.md).

## 4. Update [CI] configuration

Make sure the Travis configuration for each repo is up to date with the supported Perl versions.

 * zonemaster-ldns - [.travis.yml](https://github.com/zonemaster/zonemaster-ldns/blob/master/.travis.yml)
 * zonemaster-engine - [.travis.yml](https://github.com/zonemaster/zonemaster-engine/blob/master/.travis.yml)
 * zonemaster-cli - [.travis.yml](https://github.com/zonemaster/zonemaster-cli/blob/master/.travis.yml)
 * zonemaster-backend - [.travis.yml](https://github.com/zonemaster/zonemaster-backend/blob/master/.travis.yml)
 * zonemaster-gui - [.travis.yml](https://github.com/zonemaster/zonemaster-gui/blob/master/.travis.yml) --
   Currently there is no Travis configured for GUI.

## 5. Verify that META.yml has all the correct data

This section is not relevant for Zonemaster-GUI.

For all components, make sure your working directory is clean, or that all
listed changes are covered by MANIFEST.SKIP:

    git status --ignored

> **Note:** To throw away any and all changes to tracked and untracked files you
> can run `git clean -dfx ; git reset --hard`.

For the Zonemaster::LDNS component, manually allow META.yml to be created:

    mkdir -p inc/.author  # LDNS only

> **Note:** META.yml is only generated in the next step if Module::Install
> determines that you are an author based on [the existence of inc/.author].

For all components, generate Makefile, META.yml and others.

    perl Makefile.PL

> **Note:** Ignore the warning from the above command about the missing
> META.yml. The META.yml is created by the same command at a later stage.

Verify that META.yml contains all the paths in the following table and
that the value at each path matches the listed requirement.

Property             | Requirement
---------------------|----------------------------------------------------------------------
abstract             | component tag line
author               | current maintainer and original author
license              | [license string]
name                 | name of the component
recommends           | all modules that aren't strictly required but still used if available
requires             | all required modules
requires.perl        | minimum perl version
resources.bugtracker | link to the bug tracker
resources.license    | link to the license text
resources.repository | link to the repository
version              | version number of the new release

## 6. Verify that MANIFEST is up to date and that tarball can be built

This section is not relevant for Zonemaster-GUI.

Build generated files (if any) and verify that a distribution tarball can be 
successfully built for each component that is to be updated in this release.

    make all

For all components, make sure that all files are covered by MANIFEST and/or 
MANIFEST.SKIP, i.e. no missing or extra files:

    make distcheck

## 7. Produce distribution tarballs (except Zonemaster-GUI)

In this step produce the *preliminary distribution tarballs*.

For each component that **is** to be updated in this release, build a new
distribution tarball:

    make dist

For each component that **is not** to be updated in this release, retreive their
respective latest released distribution tarballs from the [ZNMSTR account at
CPAN].

[ZNMSTR account at CPAN]: http://search.cpan.org/~znmstr/

## 8. Produce distribution zip file (Zonemaster-GUI only)

The requirements are nodejs and npm. There are available from the [official website]( https://nodejs.org/en/).
Minimal version of Nodejs is 6.0 but install the last LTS version available.

To build the tarballs, steps are: 

1. `git clone https://github.com/zonemaster/zonemaster-gui.git`  
2. `cd zonemaster-gui`
3. `npm install` 
4. `npm run release`

The distribution zip file is in the root level of the zonemaster-gui folder. 
Its name is `zonemaster_web_gui.zip`.

## 9. Verify that Zonemaster works when installed according to the documented installation procedures

> For Zonemaster-GUI, the instructions below are not relevant. Please
> provide instructions.

Using the *preliminary distribution tarballs* produced in step 7 above
and the *preliminary distribution zip file* produced in step 8 above,
follow the procedures in [SystemTesting](SystemTesting.md).

If the system testing fails in a way that requires updated distribution
tarballs (zip file):
 1. Get the changes merged.
 2. Consider whether the actions taken in steps 1–6 above need amendment.
 3. Resume this document from step 7 above.

If the system testing is successful, the *preliminary distribution tarballs (zip file)* used
in this step become *accepted distribution tarballs (zip file)*.

## 9. Update Zonemaster repository main _README.md_

If needed, update the following section of the Zonemaster repository main _README.MD_ file:

* Notable bugs and issues

## 10. Upload to CPAN

This section is not relevant for Zonemaster-GUI.

For each component that is to be updated in this release, publish the
corresponding *accepted distribution tarball* on CPAN.
Currently we use the organizational account ZNMSTR on PAUSE for doing
this.

## 11. Merge develop branch into master

Merge the develop branch into master on Github.

### ToDo

Write a detailed instruction with commands.

## 12. Tag the release with git

For each repository, go to "releases" in Github and select "draft a new release".
Use the version number as tag and create a new release description in the same
format as previous releases. 

For Zonemaster-GUI, add the *distribution zip file* as attached file to the
release description in Github.

## 13. Release the Zonemaster Product

If there are no more components to release, go to the Zonemaster repository an
make a release.

https://github.com/zonemaster/zonemaster/releases

Use the version number as tag and create a new release description in the same
format as previous releases. 

-------

[CI]: https://github.com/travis-ci/travis-ci
[declaration of prerequisites]: ../../../README.md#prerequisites
[latest releases in each branch of Perl]: http://www.cpan.org/src/README.html
[license string]: https://metacpan.org/pod/CPAN::Meta::Spec#license
[the existence of inc/.author]: http://search.cpan.org/~ether/Module-Install-1.18/lib/Module/Install.pod#Standard_Extensions


