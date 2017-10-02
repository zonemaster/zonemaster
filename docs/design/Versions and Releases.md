# Introduction

This document is intended to specify the semantics of the versions numbers used for the Zonemaster Product and its
components. There are two different version schema, one for the Zonemaster Product, and one for its components.

The main Zonemaster Github Repository ([zonemaster](https://github.com/dotse/zonemaster)) stores the specifications
and documentation for the Zonemaster Product. There is no direct Perl code for Zonemaster in that repository. The Zonemaster
components are part of the Zonemaster Product, but stored in separate Github repositories 
([zonemaster-ldns](https://github.com/dotse/zonemaster-ldns), 
[zonemaster-engine](https://github.com/dotse/zonemaster-engine), 
[zonemaster-backend](https://github.com/dotse/zonemaster-backend) and 
[zonemaster-gui](https://github.com/dotse/zonemaster-gui)). In each component Github repository the main Perl module of 
the component (Zonemaster::LDNS, Zonemaster::Engine, Zonemaster::CLI, Zonemaster::Backend and Zonemaster::GUI,
respectivey) can be found. 

This document also discusses how the Zonemaster project intend to do new relases.

# Version Number Syntax for Zonemaster product

Published version numbers of the Zonemaster Product (stored in the main Github Repository) will be in the _vYYYY.I_ format,
where "v" is the literal character, "YYYY" is the year in four digits, "." is the literal dot and "I" is an interger
counter starting with 1, and is incremented for each release, e.g. _v2016.1_ and _v2017.2_. They year is the year when 
the release is created.

## Versioning principle

A specific version of the Zonemaster Product will, besides specifications and other documents, include a specific
version of each of the Zonemaster components. The specifications and other documents are stored in the main Github
repository, and the version is defined in Git by a tag on the last commit. The included versions of the components is
defined by the [CHANGES.txt](https://github.com/dotse/zonemaster/blob/master/CHANGES.txt) file.

# Version Number Syntax for Zonemaster components

Published version numbers will be on the common x.y.z triplet form. We will refer to the x part as the _major version_, 
the y part as the _minor version_ and the z part as the _patch version_. 

## Versioning principle

We will follow the ideas of [Semantic Versioning](http://semver.org/). This is how they state it (version 2.0.0):

```
Given a version number MAJOR.MINOR.PATCH, increment the:

    MAJOR version when you make incompatible API changes,
    MINOR version when you add functionality in a backwards-compatible manner, and
    PATCH version when you make backwards-compatible bug fixes.
```

## Major version

Changes in this number indicate changes in the outward-facing interface, and it means that users of 
the interface probably have to do changes to their code, or changes of the usage.

## Minor Version

Changes in the minor version number indicate that there are functional changes that might change outward-facing interface,
but not in a breaking fashion. A user of the interface should inform themselves on what the changes are, but does not have
to make any modifications to their own code, unless the user wants to utilize updates that require changes to the code.

## Patch Version

Changes in the patch version number indicate internal changes in the library, that need not be visible to an external user
in any way other than the reported test results being more correct. Small interface changes are permitted, as long as they
are of such a nature that they do not affect current users. That is, the interface after a patch version upgrade should be
a strict superset of the interface as it was before. Adding new result messages is explicitly permitted at this level, and
external code using Zonemaster must always be prepared to handle messages it has not seen before.

## Development Releases

Interim releases for development use (that is, intended for developers working on the versioned component itself rather 
than developers using the component) will use the CPAN convention of appending an underscore followed by a number. Perl's
own version parsing and handling routines will treat a version on this form as comparing in between the version number
without the underscore part and the version number before it. That is, all versions of the form 1.0.1\_nn compare as being
between 1.0.1 and 1.0.0. Or, to look at it slightly differently, all 1.0.1\_nn versions are steps towards what is going to
be 1.0.1.

# Release Handling

## Development Releases

Issued as needed.

## Patch Versions

The goal is that it should be easi to do patch releases, in order to encourage fixing problems quickly. All unit tests 
must pass, and all changes must be properly documented. Besides that, enough testing should be completed before a new
version is released.

## Minor Versions

These should be done with more care. Not only must all unit tests pass and everything be documented, but release 
candidates should be produced and known major users of the component should be encouraged to test the release 
candidates.

## Major version

When this happens, it must be clearly documented and all parts of Zonemaster must work together.



-------

Copyright (c) 2013-2017, IIS (The Internet Foundation in Sweden)  
Copyright (c) 2013-2017, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <http://creativecommons.org/licenses/by/4.0/>.

