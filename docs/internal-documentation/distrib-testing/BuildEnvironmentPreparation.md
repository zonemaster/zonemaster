# Build Environment Preparation

## Overview

The build environment are used for several purposes, but the purpose
is not for the actual installation of Zonemaster. For the installation
the normal installation instructions for users should be used. In most
cases, if you create a build environment you usually do not install
Zonemaster on that.

* When testing the installation instructions for users you should avoid
  to do that from a build environment.
* For the use cases below, your should in most cases make sure that
  you use the develop branch.
* You should probably read this file from the develop branch, not
  master branch to get the latest changes.

## Use cases

1. Creating Perl tar balls for testing (Zonemaster-LDNS,
   Zonemaster-Engine, Zonemaster-CLI and Zonemaster-Backend).
2. Creating Perl tar balls for uploading to CPAN (Zonemaster-LDNS,
   Zonemaster-Engine, Zonemaster-CLI and Zonemaster-Backend) as part
   of a Zonemaster release.
3. Creating Zonemaster-GUI zip distribution for testing.
4. Creating Zonemaster-GUI zip distribution for release.
5. Translation work (PO file updates).
6. Updating documents in Zonemaster/Zonemaster by scripts in
   [utils README] as part of release.
7. Development work.

There could be more use cases.

### Perl CPAN packages

For use case 1 and 2, install [CentOS build environment],
[Debian build environment], [FreeBSD build environment] 
or [Ubuntu build environment] for Perl package building.

### GUI zip distribution

For use cases 3 and 4, install [Ubuntu nodjs environment].

### Translation work

For use case 5 (which applies for Zonemaster-Engine and
Zonemaster-CLI, install one of the environments listed for
use case 1 and 2 and then follow the Zonemaster-Engine
[instructions for translators].

### Updating documents

For use case 6, install one of the environments listed
for use cases 1 and 2, and then follow the 
[installation instructions] for Zonemaster-Engine. Make sure
that you install from develop branch.

### Development work

For use case 7, install an environment as for use cases
1 or 3. Additional installation might be needed.


[CentOS build environment]:         CentOS-build-environment.md
[Debian build environment]:         Debian-build-environment.md
[FreeBSD build environment]:        FreeBSD-build-environment.md
[Ubuntu build environment]:         Ubuntu-build-environment.md
[Ubuntu nodjs environment]:         Ubuntu-nodjs-build-environment.md
[installation instructions]:        https://github.com/zonemaster/zonemaster-engine/blob/develop/docs/Installation.md
[instructions for translators]:     https://github.com/zonemaster/zonemaster-engine/blob/develop/docs/Translation-translators.md
[utils README]:                     ../../../utils/README.md
