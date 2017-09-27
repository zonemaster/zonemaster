# Introduction

This document is intended to specify the semantics of the versions numbers used for the Zonemaster Git Repositories and their main Perl modules. There are two different version schema, one for the main Zonemaster Git Repository [zonemaster](https://github.com/dotse/zonemaster), which has documents but no Perl code, and the other for the other Zonemaster Git Repositories ([zonemaster-ldns](https://github.com/dotse/zonemaster-ldns), [zonemaster-engine](https://github.com/dotse/zonemaster-engine), [zonemaster-backend](https://github.com/dotse/zonemaster-backend) and [zonemaster-gui](https://github.com/dotse/zonemaster-gui)) and their main Perl modules (Zonemaster::LDNS, Zonemaster::Engine, Zonemaster::CLI, Zonemaster::Backend and Zonemaster::GUI). It will also discuss how we intend to do new relases.

# Version Number Syntax for Zonemaster main repository

Published version numbers of the main Zonemaster Git Repository will be in the _vYYYY.I_ format, where "v" is the literal character, "YYYY" is the year in four digits, "." is the literal dot and "I" is a whole number counter starting with 1, which is incremented for each release, e.g. _v2016.1_ and _v2017.2_. They year is the year when the release is created.

## Versioning principle

The release of the main Zonemaster repository includeds all documents up to the release tag and points at the versions of the other Zonemaster repository release versions. This means that the main Zonemaster release includes the specific versions of the other Zonemaster repositories and main Perl modules.


# Version Number Syntax for other Zonemaster repository

Published version numbers will be on the common x.y.z triplet form. We will refer to the x part as the _major version_, the y part as the _minor version_ and the z part as the _patch version_. 

## Versioning principle

We will follow the ideas of [Semantic Versioning](http://semver.org/). This is how they state it (version 2.0.0):

```
Given a version number MAJOR.MINOR.PATCH, increment the:

    MAJOR version when you make incompatible API changes,
    MINOR version when you add functionality in a backwards-compatible manner, and
    PATCH version when you make backwards-compatible bug fixes.
```

## Major version

Changes in this number indicate changes in the outward-facing interface, and will almost certainly mean that users of the interface will have to do significant changes to their code.

## Minor Version

Changes in the minor version number indicate that there are functional changes that might change outward-facing interface, but only in an additional fashion. A user of the interface should inform themselves on what the changes are, but does not have to make any modifications to their own code.

## Patch Version

Changes in the patch version number indicate internal changes in the library, that need not be visible to an external user in any way other than the reported test results being more correct. Small interface changes are permitted, as long as they are of such a nature that they do not affect current users. That is, the interface after a patch version upgrade should be a strict superset of the interface as it was before. Adding new result messages is explicitly permitted at this level, and external code using Zonemaster must always be prepared to handle messages it has not seen before.

## Development Releases

Interim releases for development use (that is, intended for developers working on the versioned component itself rather than developers using the component) will use the CPAN convention of appending an underscore followed by a number. Perl's own version parsing and handling routines will treat a version on this form as comparing in between the version number without the underscore part and the version number before it. That is, all versions of the form 1.0.1\_nn compare as being between 1.0.1 and 1.0.0. Or, to look at it slightly differently, all 1.0.1\_nn versions are steps towards what is going to be 1.0.1.

# Release Handling

## Development Releases

Issued as needed.

## Patch Versions

Should be easy to do, in order to encourage fixing problems quickly. All unit tests must pass, and all changes must be properly documented.

## Minor Versions

These should be done with more care. Not only must all unit tests pass and everything be documented, but release candidates should be produced and known major users of the component should be encouraged to test the release candidates.

## Major version

When this happens, it must be clearly documented and all parts of Zonemaster must work together.



-------

Copyright (c) 2013-2017, IIS (The Internet Foundation in Sweden)  
Copyright (c) 2013-2017, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <http://creativecommons.org/licenses/by/4.0/>.

