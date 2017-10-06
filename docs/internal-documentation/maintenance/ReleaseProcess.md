Release process
===============

## 1. Set all version numbers, if component is to be released

The version numbers can be found in these Perl modules:

 * zonemaster-ldns - [LDNS.pm](https://github.com/dotse/zonemaster-ldns/blob/master/lib/Zonemaster/LDNS.pm)
 * zonemaster-engine - [Engine.pm](https://github.com/dotse/zonemaster-engine/blob/master/lib/Zonemaster/Engine.pm)
 * zonemaster-cli - [CLI.pm](https://github.com/dotse/zonemaster-cli/blob/master/lib/Zonemaster/CLI.pm)
 * zonemaster-backend - [Backend.pm](https://github.com/dotse/zonemaster-backend/blob/master/lib/Zonemaster/Backend.pm)
 * zonemaster-gui - [GUI.pm](https://github.com/dotse/zonemaster-gui/blob/master/lib/Zonemaster/GUI.pm)

## 2. Update the Changes file

Any changes since the last release must be documented in the Changes files.
Please refer to any Github issues related to the change by the issue number.

 * zonemaster-ldns - [Changes](https://github.com/dotse/zonemaster-ldns/blob/master/Changes)
 * zonemaster-engine - [Changes](https://github.com/dotse/zonemaster-engine/blob/master/Changes)
 * zonemaster-cli - [Changes](https://github.com/dotse/zonemaster-cli/blob/master/Changes)
 * zonemaster-backend - [Changes](https://github.com/dotse/zonemaster-backend/blob/master/CHANGES)
 * zonemaster-gui - [Changes](https://github.com/dotse/zonemaster-gui/blob/master/Changes)

## 3. Update prerequisites

Make sure the [declaration of prerequisites] is up to date with regard to
[SupportCriteria](SupportCriteria.md).

## 4. Update [CI] configuration

Make sure the Travis configuration for each repo is up to date with the supported Perl versions.

 * zonemaster-ldns - [.travis.yml](https://github.com/dotse/zonemaster-ldns/blob/master/.travis.yml)
 * zonemaster-engine - [.travis.yml](https://github.com/dotse/zonemaster-engine/blob/master/.travis.yml)
 * zonemaster-cli - [.travis.yml](https://github.com/dotse/zonemaster-cli/blob/master/.travis.yml)
 * zonemaster-backend - [.travis.yml](https://github.com/dotse/zonemaster-backend/blob/master/.travis.yml)
 * zonemaster-gui - [.travis.yml](https://github.com/dotse/zonemaster-gui/blob/master/.travis.yml)

## 5. Verify that Makefile.PL has all the correct data

The Makefile.PL contains all the modules required by the component to
function, with all the version numbers needed as well. It also has some
other metadata about the component.

 * zonemaster-ldns - [Makefile.PL](https://github.com/dotse/zonemaster-ldns/blob/master/Makefile.PL)
 * zonemaster-engine - [Makefile.PL](https://github.com/dotse/zonemaster-engine/blob/master/Makefile.PL)
 * zonemaster-cli - [Makefile.PL](https://github.com/dotse/zonemaster-cli/blob/master/Makefile.PL)
 * zonemaster-backend - [Makefile.PL](https://github.com/dotse/zonemaster-backend/blob/master/Makefile.PL)
 * zonemaster-gui - [Makefile.PL](https://github.com/dotse/zonemaster-gui/blob/master/Makefile.PL)

## 6. Verify that MANIFEST is up to date

> **Note:** The MANIFEST file lists the files that will be included in the dist
> tarball.

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

> **Note:** The above command may give a warning about a missing META.yml file
> and urge informing the author. Instead of immediately informing the author,
> verify that META.yml was created by the command at a later stage.

For all components except Zonemaster::Engine, make sure that all files are
covered by MANIFEST and/or MANIFEST.SKIP:

    make distcheck

For the Zonemaster::Engine component, generate the complete MANIFEST file.

    make all       # Engine only
    make manifest  # Engine only

For all components, review the MANIFEST file if in doubt or if there seems to be
missing or extra files.

## 7. Produce distribution tarballs

This step serves double purposes.
First, it verifies that a distribution tarball can be successfully
built for each component that is to be updated in this release.
Second, it produces the preliminary distribution tarballs to be used in step 8
below (either by building or retrieving them).

For each component that **is** to be updated in this release, build a new
distribution tarball:

    make all
    make dist

For each component that **is not** to be updated in this release, retreive their
respective latest released distribution tarballs from the [ZNMSTR account at
CPAN].

[ZNMSTR account at CPAN]: http://search.cpan.org/~znmstr/

## 8. Verify that the module builds and all tests pass

Find the list of supported Perl versions and locales in the [declaration of
prerequisites]. Then find the latest point-release of each supported Perl
version in the table of [latest releases in each branch of Perl].

Make sure you've set up perlbrew and installed the latest point-release of each
supported Perl version for perlbrew.

    perlbrew init
    perlbrew install perl-5.14.4  # For every supported version of Perl

Perform the following for each component.

Verify that the module builds and all tests pass with the latest point release
for every supported major Perl version and for every supported system locale.
For each supported locale and the set of supported point-releases, modify and
run the folloing command:

    LC_ALL=en.UTF-8 LC_MESSAGES=en.UTF-8 LC_NUMERIC=en.UTF-8 LANG=en.UTF-8 perlbrew exec --with 5.14.4,5.16.3,5.18.4,5.20.3,5.22.4,5.24.3 '( git clean -dfx && perl Makefile.PL && make ) >/dev/null && prove -bQ'

## 9. Verify that Zonemaster works when installed according to the documented installation procedures

Using the preliminary distribution tarballs produced in step 7 above, follow the
procedures in [SystemTesting](SystemTesting.md).

If the system testing fails in a way that requires updated distribution
tarballs:
 1. Get the changes merged.
 2. Consider whether the actions taken in steps 1–6 above need amendment.
 3. Make new distribution tarballs for the affected components according to step
    7 above.
 4. Resume this document from step 8 above.

If the system testing is successful, the preliminary distribution tarballs used
in this step become accepted distribution tarballs to be used in step 11 below.

## 10. Tag the release with git

Tag the release with these git commands, and push the tag to Github.

**Change the version number below to the correct version for this release**

zonemaster-ldns:

    git tag v1.0.0
	git push <repository> --tags

zonemaster-engine:

    git tag v1.0.0
	git push <repository> --tags

zonemaster-cli:

    git tag v1.0.0
	git push <repository> --tags

zonemaster-backend:

    git tag v1.0.0
	git push origin --tags

zonemaster-gui:

    git tag v1.0.0
	git push origin --tags

### ToDo

Write a description how to set release in Github to get a nice presentation.

## 11. Upload to CPAN

For each component that is to be updated in this release, publish the
corresponding accepted distribution tarball on CPAN.
Currently we use the organizational account ZNMSTR on PAUSE for doing this.

## 12. Update the Distribution Release

If the release is for the whole Distribution (all components), the version
numbers on the Distribution Wiki page must be updated with all new compnent
releases.

Change it here:

https://github.com/dotse/zonemaster/wiki/Zonemaster-Distribution-Releases

To see tags for a repository:

    git show-ref --tags

-------

[CI]: https://github.com/travis-ci/travis-ci
[declaration of prerequisites]: ../../../README.md#prerequisites
[latest releases in each branch of Perl]: http://www.cpan.org/src/README.html
[the existence of inc/.author]: http://search.cpan.org/~ether/Module-Install-1.18/lib/Module/Install.pod#Standard_Extensions


Copyright (c) 2013-2017, IIS (The Internet Foundation in Sweden)\
Copyright (c) 2013-2017, AFNIC\
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <http://creativecommons.org/licenses/by/4.0/>.
