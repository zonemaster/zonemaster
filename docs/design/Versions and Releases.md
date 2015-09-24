# Introduction

This document is intended to specify the semantics of the versions numbers used for the main Zonemaster Perl module, and optionally for other components of the whole Zonemaster system. It will also discuss how we intend to do new relases.

# Version Number Syntax

Published version numbers will be on the common x.y.z triplet form. We will refer to the x part as the _epoch_, the y part as the _major version_ and the z part as the _minor version_.

## Epoch

Changes in this number indicate major changes in the outward-facing interface, and will almost certainly mean that users of the interface will have to do significant changes to their code. It is expected that this number will go from 0 to 1 with the first non-testing public release, and stay at 1 for the foreseeable future.

## Major Version

Changes in the major version number indicate that there are changes to the outward-facing interface, but that these changes are localized and of a modest nature. A user of the interface should inform themselves on what the changes are, but may not need to make any modifications to their own code.

## Minor Version

Changes in the minor version number indicate internal changes in the library, that need not be visible to an external user in any way other than the reported test results being more correct. Small interface changes are permitted, as long as they are of such a nature that they do not affect current users. That is, the interface after a minor version upgrade should be a strict superset of the interface as it was before. Adding new result messages is explicitly permitted at this level, and external code using Zonemaster must always be prepared to handle messages it has not seen before.

## Development Releases

Interim releases for development use (that is, intended for developers working on the versioned component itself rather than developers using the component) will use the CPAN convention of appending an underscore followed by a number. Perl's own version parsing and handling routines will treat a version on this form as comparing in between the version number without the underscore part and the version number before it. That is, all versions of the form 1.0.1\_nn compare as being between 1.0.1 and 1.0.0. Or, to look at it slightly differently, all 1.0.1\_nn versions are steps towards what is going to be 1.0.1.

# Release Handling

## Development Releases

Issued as needed.

## Minor Versions

Should be easy to do, in order to encourage fixing problems quickly. All unit tests must pass, and all changes must be properly documented.

## Major Versions

These should be done with more care. Not only must all unit tests pass and everything be documented, but release candidates should be produced and known major users of the component should be encouraged to test the release candidates.

## New Epoch

If this happens, it will likely be treated as if it was an entirely new product.



-------

Copyright (c) 2013, 2014, 2015, IIS (The Internet Infrastructure Foundation)  
Copyright (c) 2013, 2014, 2015, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <http://creativecommons.org/licenses/by/4.0/>.

