Release process
===============

## 1. Set all version numbers, if component is to be released

The version numbers can be found in these Perl modules:

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

 * zonemaster-engine - [Changes](https://github.com/dotse/zonemaster-engine/blob/master/Changes)
 * zonemaster-cli - [Changes](https://github.com/dotse/zonemaster-cli/blob/master/Changes)
 * zonemaster-backend - [Changes](https://github.com/dotse/zonemaster-backend/blob/master/CHANGES)
 * zonemaster-gui - [Changes](https://github.com/dotse/zonemaster-gui/blob/master/Changes)

## 3. Verify that MANIFEST is up to date

In order to have a complete installation from a package, the MANIFEST needs
to be the complete set of files to be included.

 * zonemaster-engine - [MANIFEST](https://github.com/dotse/zonemaster-engine/blob/master/MANIFEST)
 * zonemaster-cli - [MANIFEST](https://github.com/dotse/zonemaster-cli/blob/master/MANIFEST)
 * zonemaster-backend - [MANIFEST](https://github.com/dotse/zonemaster-backend/blob/master/MANIFEST)
 * zonemaster-gui - [MANIFEST](https://github.com/dotse/zonemaster-gui/blob/master/MANIFEST)

## 4. Verify that Makefile.PL has all the correct data

The Makefile.PL contains all the modules required by the component to
function, with all the version numbers needed as well. It also has some
other metadata about the component.

 * zonemaster-engine - [Makefile.PL](https://github.com/dotse/zonemaster-engine/blob/master/Makefile.PL)
 * zonemaster-cli - [Makefile.PL](https://github.com/dotse/zonemaster-cli/blob/master/Makefile.PL)
 * zonemaster-backend - [Makefile.PL](https://github.com/dotse/zonemaster-backend/blob/master/Makefile.PL)
 * zonemaster-gui - [Makefile.PL](https://github.com/dotse/zonemaster-gui/blob/master/Makefile.PL)

## 5. Test to create a distribution file

Create with make dist and verify that it can be used to successfully
build and test in a clean Perl installation.

    make manifest
    make dist

## 6. Verify that the module builds and all tests pass

Verify that the module builds and all tests pass with the latest point release for every supported major Perl version. This can be done quite easily with something like this:

    perlbrew exec --with 5.14.4,5.16.3,5.18.4,5.20.1 '( git clean -dfx && perl Makefile.PL && make ) >& /dev/null && prove -bQ'

## 7. Tag the release with git

Tag the release with these git commands, and push the tag to Github.

**Change the version number below to the correct version for this release**

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

## 8. Upload to CPAN

For the CLI and the Engine, we have published the code on CPAN. Currently
we use the organizational account IIS on PAUSE for doing this. If the release
is ok, upload it now to CPAN - use make dist and upload the resulting tar
ball.

## 9. Update the Distribution Release

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
