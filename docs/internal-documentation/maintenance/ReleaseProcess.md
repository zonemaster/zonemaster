Release process
===============

## 1. Set all version numbers, if component is to be released

The version numbers can be found in these Perl modules:

 * zonemaster-ldns - [LDNS.pm](https://github.com/dotse/zonemaster-ldns/blob/master/lib/Zonemaster/LDNS.pm)
 * zonemaster-engine - [Zonemaster.pm](https://github.com/dotse/zonemaster-engine/blob/master/lib/Zonemaster.pm)
 * zonemaster-cli - [CLI.pm](https://github.com/dotse/zonemaster-cli/blob/master/lib/Zonemaster/CLI.pm)
 * zonemaster-backend - [Config.pm](https://github.com/dotse/zonemaster-backend/blob/master/lib/Zonemaster/WebBackend/Config.pm) and
   [DB.pm](https://github.com/dotse/zonemaster-backend/blob/master/lib/Zonemaster/WebBackend/DB.pm)
 * zonemaster-gui - [Client.pm](https://github.com/dotse/zonemaster-gui/blob/master/lib/Zonemaster/GUI/Dancer/Client.pm),
   [Frontend.pm](https://github.com/dotse/zonemaster-gui/blob/master/lib/Zonemaster/GUI/Dancer/Frontend.pm) and
   [NoJsFrontend.pm](https://github.com/dotse/zonemaster-gui/blob/master/lib/Zonemaster/GUI/Dancer/NoJsFrontend.pm)

## 2. Update the Changes file

Any changes since the last release must be documented in the Changes files.
Please refer to any Github issues related to the change by the issue number.

 * zonemaster-ldns - [Changes](https://github.com/dotse/zonemaster-ldns/blob/master/Changes)
 * zonemaster-engine - [Changes](https://github.com/dotse/zonemaster-engine/blob/master/Changes)
 * zonemaster-cli - [Changes](https://github.com/dotse/zonemaster-cli/blob/master/Changes)
 * zonemaster-backend - [Changes](https://github.com/dotse/zonemaster-backend/blob/master/CHANGES)
 * zonemaster-gui - [Changes](https://github.com/dotse/zonemaster-gui/blob/master/Changes)

## 3. Update prerequisites

Make sure the prerequisites section in [README.md](https://github.com/dotse/zonemaster/blob/master/README.md)
is up to date with regard to [SupportCriteria](https://github.com/dotse/zonemaster/blob/master/docs/internal-documentation/maintenance/SupportCriteria.md).

## 4. Verify that MANIFEST is up to date

In order to have a complete installation from a package, the MANIFEST needs
to be the complete set of files to be included.

 * zonemaster-ldns - [MANIFEST](https://github.com/dotse/zonemaster-ldns/blob/master/MANIFEST)
 * zonemaster-engine - (it will be created by the `make manifest` command below)
 * zonemaster-cli - [MANIFEST](https://github.com/dotse/zonemaster-cli/blob/master/MANIFEST)
 * zonemaster-backend - [MANIFEST](https://github.com/dotse/zonemaster-backend/blob/master/MANIFEST)
 * zonemaster-gui - [MANIFEST](https://github.com/dotse/zonemaster-gui/blob/master/MANIFEST)

## 5. Verify that Makefile.PL has all the correct data

The Makefile.PL contains all the modules required by the component to
function, with all the version numbers needed as well. It also has some
other metadata about the component.

 * zonemaster-ldns - [Makefile.PL](https://github.com/dotse/zonemaster-ldns/blob/master/Makefile.PL)
 * zonemaster-engine - [Makefile.PL](https://github.com/dotse/zonemaster-engine/blob/master/Makefile.PL)
 * zonemaster-cli - [Makefile.PL](https://github.com/dotse/zonemaster-cli/blob/master/Makefile.PL)
 * zonemaster-backend - [Makefile.PL](https://github.com/dotse/zonemaster-backend/blob/master/Makefile.PL)
 * zonemaster-gui - [Makefile.PL](https://github.com/dotse/zonemaster-gui/blob/master/Makefile.PL)

## 6. Produce distribution tarballs

This step serves double purposes.
First, it verifies that a distribution tarball can be successfully
built for each component that is to be updated in this release.
Second, it produces the preliminary distribution tarballs to be used in step 8
below (either by building or retrieving them).

For each component that **is** to be updated in this release, build a new
distribution tarball:

    perl Makefile.PL
    make all
    make manifest
    make dist

For each component that **is not** to be updated in this release, retreive their
respective latest released distribution tarballs from the [ZNMSTR account at
CPAN].

[ZNMSTR account at CPAN]: http://search.cpan.org/~znmstr/

## 7. Verify that the module builds and all tests pass

Verify that the module builds and all tests pass with the latest point release
for every supported major Perl version and for every supported system locale.
This can be done quite easily with something like this command for each locale:

    LC_ALL=en.UTF-8 LC_MESSAGES=en.UTF-8 LC_NUMERIC=en.UTF-8 LANG=en.UTF-8 perlbrew exec --with 5.14.4,5.16.3,5.18.4,5.20.1 '( git clean -dfx && perl Makefile.PL && make ) >& /dev/null && prove -bQ'

## 8. Verify that Zonemaster works when installed according to the documented installation procedures

Using the preliminary distribution tarballs produced in step 6 above, follow the
procedures in [SystemTesting.md].

If the system testing fails in a way that requires updated distribution
tarballs:
 1. Get the changes merged.
 2. Consider whether the actions taken in steps 1–5 above need amendment.
 3. Make new distribution tarballs for the affected components according to step
    6 above.
 4. Resume this document from step 7 above.

If the system testing is successful, the preliminary distribution tarballs used
in this step become accepted distribution tarballs to be used in step 10 below.

[SystemTesting.md]: https://github.com/dotse/zonemaster/blob/master/docs/internal-documentation/maintenance/SystemTesting.md

## 9. Tag the release with git

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

## 10. Upload to CPAN

For each component that is to be updated in this release, publish the
corresponding accepted distribution tarball on CPAN.
Currently we use the organizational account ZNMSTR on PAUSE for doing this.

## 11. Update the Distribution Release

If the release is for the whole Distribution (all components), the version
numbers on the Distribution Wiki page must be updated with all new compnent
releases.

Change it here:

https://github.com/dotse/zonemaster/wiki/Zonemaster-Distribution-Releases


Too see tags for a repository:

git show-ref --tags

-------

Copyright (c) 2013, 2014, 2015, IIS (The Internet Infrastructure Foundation)  
Copyright (c) 2013, 2014, 2015, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <http://creativecommons.org/licenses/by/4.0/>.
