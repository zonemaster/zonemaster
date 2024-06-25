# Zonemaster - Change management

## Scope

This document outlines how the any changes to the software during the
technical maintenance period will be classified and the process to implement
these changes.

## Input for change 

Change requests can come from anywhere such as the users mailinglist, the
steering committee or the development team. The change requests could be
classified into two broad categories:

1. Minor change
2. Major change

## Minor change 

The nature of minor change requests are explained in the following
subsection:

###  Bug Fixing 

Any bug fixes, the team or any user discovers should be published in the
GitHub issue tracker.

Not all issues in the tracker are bugs, and not all reported bugs are
software bugs, but can be protocol errors in DNS, or user or documentation
errors.

Bug fixes are included in minor releases. See the [version numbering policy]
document for documentation on version numbers for releases.

### Minor Changes

Minor changes are new features, changes or deprecated functionality that
do not break backwards compatibility, neither force any user to change or
update their environment that currently runs the software. 

Minor changes are included in minor releases. See the [version numbering policy]
document for documentation on version numbers for releases.

## Major changes 

Any change and specification that requires changes in the software
architecture, an API change or new major features could be classified
under the category "Major change".

Major changes are included in major releases. See the [version numbering policy]
document for documentation on version numbers for releases.

## Process to implement the change

Change requests can come from anywhere such as the users mailinglist, the
steering committee or the development team. 

### Minor changes

A "bug fix" or "minor change" should be added as an issue in GitHub. Then
the person corresponding is assigned by the release manager or the person
who has created the issue. The assigned person should then close the
ticket within a specified time as mentioned in the "Key Performance
Indicator" (or) update the bug with the time duration on when the bug/minor improvement could be solved (or) comments the reason for not able to solve
the bug/minor improvement.

### Major changes

Any new development for Zonemaster must follow the strict process where
there are formal requirements, specifications for implementing the
requirements and then any design and architecture fulfilling the
specifications, and finally the implementation and quality assurance.
When all this is performed successully the software package is released
using the release process.

#### Decision on discarding or including changes

Whatever be the type of change request, it should go through the "Issues
tracker" in the GitHub project. All requests should be promptly responded
to, even if the decision to acknowledge the request is postponed (or)
not taken into consideration.

Requirements should then be ranked in importance depending on a number of
factors such as complexity, amount of work, risk, architectural changes,
relevance to the product and so on.

The decision to include the requirement for the release during the
maintenance period will be taken by the development team in consultation
with the steering committee. 

New requirements that are acknowledged (by the development team and the
steering committee)  make it to the roadmap and planned for specification
and implementation. They are also added to the current set of requirements.



[version numbering policy]: ../design/Versions%20and%20Releases.md
