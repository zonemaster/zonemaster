# Versions and Releases

## Introduction

This document is intended to specify the semantics of the versions numbers used for the Zonemaster Product and its
components. There are two different version schema, one for the Zonemaster Product, and one for its components.

The main Zonemaster Repository ([zonemaster](https://github.com/dotse/zonemaster)) stores the specifications
and documentation for the Zonemaster Product. There is no direct Perl code for Zonemaster in that repository. The Zonemaster
components are part of the Zonemaster Product, but stored in separate repositories 
([zonemaster-ldns](https://github.com/dotse/zonemaster-ldns), 
[zonemaster-engine](https://github.com/dotse/zonemaster-engine),
[zonemaster-cli](https://github.com/dotse/zonemaster-cli),
[zonemaster-backend](https://github.com/dotse/zonemaster-backend) and 
[zonemaster-gui](https://github.com/dotse/zonemaster-gui)). In each component repository the main Perl module of 
the component can be found:
* [Zonemaster::LDNS](https://github.com/dotse/zonemaster-ldns/blob/master/lib/Zonemaster/LDNS.pm)
* [Zonemaster::Engine](https://github.com/dotse/zonemaster-engine/blob/master/lib/Zonemaster/Engine.pm)
* [Zonemaster::CLI](https://github.com/dotse/zonemaster-cli/blob/master/lib/Zonemaster/CLI.pm)
* [Zonemaster::Backend](https://github.com/dotse/zonemaster-backend/blob/master/lib/Zonemaster/Backend.pm)
* [Zonemaster::GUI](https://github.com/dotse/zonemaster-gui/blob/master/lib/Zonemaster/GUI.pm)

This document also discusses how the Zonemaster project intend to do new relases.

## Version Number Syntax for Zonemaster product

Published version numbers of the Zonemaster Product (stored in the main Repository) will be in the _vYYYY.I.i_ format,
where "v" is the literal character, "YYYY" is the year in four digits, "." is the literal dot and "I" and "i" are
interger counters starting with 1. "I" or "i" is incremented for each release. If "I" is incremented, then ".i" is
empty, e.g. from _v2016.1.2_ to _v2016.2_. If "i" is incremented, then "I" remains the same as the previous version, e.g. _v2016.1.1_ to _v2016.1.2_. "I" can be incremented even if there is no ".i", e.g. _v2016.3_ to _v2016.4_. They year is 
the year when the release is created.

A release when no component has been updated on major or minor version, then the product version is normally incremented
with the "i" only, e.g. _v2016.3_ to _v2016.3.1_. If any component has been updated on major or minor version, then
the "I" must be updated in the product version.

### Versioning principle

A specific version of the Zonemaster Product will, besides specifications and other documents, include a specific
version of each of the Zonemaster components. The specifications and other documents are stored in the main
repository, and the version is defined in Git by a tag on the last commit. The included versions of the components is
defined by the [CHANGES.txt](https://github.com/dotse/zonemaster/blob/master/CHANGES.txt) file.

## Version Number Syntax for Zonemaster components

Published version numbers will be on the common x.y.z triplet form. We will refer to the x part as the _major version_, 
the y part as the _minor version_ and the z part as the _patch version_. 

### Versioning principle

We will follow the ideas of [Semantic Versioning](http://semver.org/). This is how they state it (version 2.0.0):

>Given a version number MAJOR.MINOR.PATCH, increment the:
>1. MAJOR version when you make incompatible API changes,
>2. MINOR version when you add functionality in a backwards-compatible manner, and
>3. PATCH version when you make backwards-compatible bug fixes.

### Major version

Changes in this number indicate changes in the outward-facing interface, and it means that users of 
the interface probably have to do changes to their code, or changes of the usage.

### Minor Version

Changes in the minor version number indicate that there are functional changes that is fully backward compatible.
If the user wants to utilize the new features and functions, calls to Zonemaster might have to be changed.
Interface changes are permitted, as long as they
are of such a nature that they do not affect current users. That is, the interface after a minor version upgrade should be
a strict superset of the interface as it was before.

### Patch Version

Changes in the patch version number indicate internal changes in the library, that need not be visible to an external user
in any way other than the reported test results being more correct or previous bug does not show up.

### Development Releases

Interim releases for development use (that is, intended for developers working on the versioned component itself rather 
than developers using the component) will created directly from the repository, and is not published in CPAN.

## Publication of releases

Major, minor and patch releases of the Zonemaster Components are normally published at [CPAN](https://www.cpan.org/). The
rest of the Zonemaster Product (specifications and documentation) is only available in the repository.

## Release Handling

### Development Releases

Issued as needed.

### Patch Versions

The goal is that it should be easy to do patch releases, in order to encourage fixing problems quickly. All unit tests 
must pass, and all changes must be properly documented. Besides that, enough testing should be completed before a new
version is released. Automated tests that cover the corrected code should be inluced.

### Minor Versions

These should be done with more care. Not only must all unit tests pass and everything be documented, but release 
candidates should be produced and known major users of the component should be encouraged to test the release 
candidates.

### Major version

When this happens, it must be clearly documented and all parts of Zonemaster must work together. Automated tests for new
functionality must be created before release, and integration testing between components must be performed.



-------

Copyright (c) 2013-2017, IIS (The Internet Foundation in Sweden)  
Copyright (c) 2013-2017, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <http://creativecommons.org/licenses/by/4.0/>.

