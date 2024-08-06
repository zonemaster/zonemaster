# Versions and Releases

## Introduction

This document is intended to specify the semantics of the versions numbers used for the Zonemaster Product and its
components. There are two different version schema, one for the Zonemaster Product, and one for its components.

The main Zonemaster Repository ([Zonemaster]) stores the specifications
and documentation for the Zonemaster Product. There is no direct code for Zonemaster in that repository. The Zonemaster
components are part of the Zonemaster Product, but stored in separate repositories 
([Zonemaster-LDNS], [Zonemaster-Engine], [Zonemaster-CLI], [Zonemaster-Backend] and [Zonemaster-GUI]. 

This document also discusses how the Zonemaster project intend to do new releases.

## Version Number Syntax for Zonemaster product

Published version numbers of the Zonemaster Product (stored in the main repository, i.e. [Zonemaster]) are in format 
_vYYYY.I.i_, where 
* "v" is the literal character, 
* "YYYY" is the year of the creation of the release in four digits, 
* "." is the literal dot, and 
* "I" and "i" are integer counters starting with 1. 
  * "I" or "i" (not both) is incremented for each release unless "YYYY" is incremented.
  * If "YYYY" is incremented, then "I" is reset to 1 and "i" is omitted. 
  * If "I" is incremented, then ".i" omitted, e.g. from _v2016.1.2_ to _v2016.2_. 
  * If "i" is incremented, then "I" remains the same as the previous version, e.g. from _v2016.1.1_ to _v2016.1.2_. 
  * "I" can be incremented even if there is no ".i", e.g. from _v2016.3_ to _v2016.4_.

The product version is normally incremented with the "i" only, e.g. from _v2016.3_ to _v2016.3.1_, when no component has
been updated on major or minor version. If any component has been updated on major or minor version, then the "YYYY" or 
"I" must be updated in the product version.

### Versioning principle

A specific version of the Zonemaster Product includes, besides specifications and other documents, a specific
version of each of the Zonemaster components. The specifications and other documents are stored in the main
repository, and the version is defined in Git by a tag on the last commit. The included versions of the components is
defined by the [Changes][Zonemaster-Changes] file.

## Version Number Syntax for Zonemaster components

Published version numbers of each Zonemaster component is in the common x.y.z triplet form. The x part is referred to
as the _major version_, the y part as the _minor version_ and the z part as the _patch version_. 

### Versioning principle

Zonemaster follow the ideas of [Semantic Versioning]. This is how it is stated (version 2.0.0):

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

### Development Versions

Interim versions for development use (that is, intended for developers working on the versioned component itself rather 
than developers using the component) are created directly from the "develop" branch of the Git repositories, and are 
not published on [CPAN] ([Zonemaster-GUI] is never published at [CPAN]).

## Publication of releases

Major, minor and patch releases of the Zonemaster Components, including the mail repository, are published in the GitHub
repositories by merging the code to the "master" branch in Git and by creating a release note in GitHub. In the normal
case the Perl based components are also published at [CPAN]. The rest of the Zonemaster Product 
([Zonemaster-GUI], specifications and documentation) is only available in the "master" branch in each repository.

All components have clear installation instructions for installing the latest version.

## Release Handling

### Development Releases

Issued as needed.

### Patch Versions

The goal is that it should be easy to do patch releases, in order to encourage fixing problems quickly. All unit tests 
must pass, and all changes must be properly documented. Besides that, enough testing should be completed before a new
version is released. Automated tests that cover the corrected code should be included.

### Minor Versions

These should be done with more care. Not only must all unit tests pass and everything be documented, but release 
candidates should be produced and known major users of the component should be encouraged to test the release 
candidates.

### Major version

When this happens, it must be clearly documented and all parts of Zonemaster must work together. Automated tests for new
functionality must be created before release, and integration testing between components must be performed.


[CPAN]:                       https://www.cpan.org/
[Semantic Versioning]:        https://semver.org/
[Zonemaster-Backend]:         https://github.com/zonemaster/zonemaster-backend
[Zonemaster-CLI]:             https://github.com/zonemaster/zonemaster-cli
[Zonemaster-Changes]:         https://github.com/zonemaster/zonemaster/blob/master/Changes
[Zonemaster-Engine]:          https://github.com/zonemaster/zonemaster-engine
[Zonemaster-GUI package file]:https://github.com/zonemaster/zonemaster-gui/blob/master/package.json
[Zonemaster-GUI]:             https://github.com/zonemaster/zonemaster-gui
[Zonemaster-LDNS]:            https://github.com/zonemaster/zonemaster-ldns
[Zonemaster]:                 https://github.com/zonemaster/zonemaster
