Release process
===============

## 1. Update the Changes file

Any changes since the last release must be documented in the Changes files.
Please refer to any Github issues related to the change by the issue number.

 * zonemaster-ldns - [Changes](https://github.com/dotse/zonemaster-ldns/blob/master/Changes)
 * zonemaster-engine - [Changes](https://github.com/dotse/zonemaster-engine/blob/master/Changes)
 * zonemaster-cli - [Changes](https://github.com/dotse/zonemaster-cli/blob/master/Changes)
 * zonemaster-backend - [Changes](https://github.com/dotse/zonemaster-backend/blob/master/Changes)
 * zonemaster-gui - [Changes](https://github.com/dotse/zonemaster-gui/blob/master/Changes)

## 2. Set all version numbers

The version numbers can be found in these Perl modules:

 * zonemaster-ldns - [LDNS.pm](https://github.com/dotse/zonemaster-ldns/blob/master/lib/Zonemaster/LDNS.pm)
 * zonemaster-engine - [Engine.pm](https://github.com/dotse/zonemaster-engine/blob/master/lib/Zonemaster/Engine.pm)
 * zonemaster-cli - [CLI.pm](https://github.com/dotse/zonemaster-cli/blob/master/lib/Zonemaster/CLI.pm)
 * zonemaster-backend - [Backend.pm](https://github.com/dotse/zonemaster-backend/blob/master/lib/Zonemaster/Backend.pm)
 * zonemaster-gui - [GUI.pm](https://github.com/dotse/zonemaster-gui/blob/master/lib/Zonemaster/GUI.pm)

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

## 5. Verify that META.yml has all the correct data

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

Build generated files (if any) and verify that a distribution tarball can be 
successfully built for each component that is to be updated in this release.

    make all

For all components, make sure that all files are covered by MANIFEST and/or 
MANIFEST.SKIP, i.e. no missing or extra files:

    make distcheck

## 7. Produce distribution tarballs

In this step produce the *preliminary distribution tarballs*.

For each component that **is** to be updated in this release, build a new
distribution tarball:

    make dist

For each component that **is not** to be updated in this release, retreive their
respective latest released distribution tarballs from the [ZNMSTR account at
CPAN].

[ZNMSTR account at CPAN]: http://search.cpan.org/~znmstr/

## 8. Verify that Zonemaster works when installed according to the documented installation procedures

Using the *preliminary distribution tarballs* produced in step 7 above,
follow the procedures in [SystemTesting](SystemTesting.md).

If the system testing fails in a way that requires updated distribution
tarballs:
 1. Get the changes merged.
 2. Consider whether the actions taken in steps 1–6 above need amendment.
 3. Make new distribution tarballs for the affected components according to step
    7 above.
 4. Resume this document from step 8 above.

If the system testing is successful, the *preliminary distribution tarballs* used
in this step become *accepted distribution tarballs*.

## 9. Update Zonemaster repository main _README.md_

If needed, update the following section of the Zonemaster repository main _README.MD_ file:

* Notable bugs and issues

## 10. Upload to CPAN

For each component that is to be updated in this release, publish the
corresponding *accepted distribution tarball* on CPAN.
Currently we use the organizational account ZNMSTR on PAUSE for doing
this.

## 11. Merge develop branch into master

Merge the develop branch into master on Github.

### ToDo

Write a detailed instruction with commands.

## 12. Tag the release with git

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

## 13. Release the Zonemaster Product

If there are no more components to release, go to the Zonemaster repository an
make a release.

https://github.com/dotse/zonemaster/wiki/Zonemaster-Distribution-Releases

To see tags for a repository:

    git show-ref --tags

-------

[CI]: https://github.com/travis-ci/travis-ci
[declaration of prerequisites]: ../../../README.md#prerequisites
[latest releases in each branch of Perl]: http://www.cpan.org/src/README.html
[license string]: https://metacpan.org/pod/CPAN::Meta::Spec#license
[the existence of inc/.author]: http://search.cpan.org/~ether/Module-Install-1.18/lib/Module/Install.pod#Standard_Extensions


Copyright (c) 2013-2017, IIS (The Internet Foundation in Sweden)\
Copyright (c) 2013-2017, AFNIC\
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <https://creativecommons.org/licenses/by/4.0/>.
