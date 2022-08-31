# Test Case Identifier Specification

All test cases belong to one specific test level, and it gets its name from that
test level's name. The following test levels are defined and available:

* Address
* Basic
* Connectivity
* Consistency
* DNSSEC
* Delegation
* Nameserver
* Syntax
* Zone

The test level name is not case sensitive.

The test case identifier in the test case specification (both in the main
headline and in the "Test case identifier" section) uses the test level name
in all uppercase and has the format: `{Test Level name} + {Index}`

When referencing to a test case the test level name may be used in other letter
case than all uppercase.

The `{Index}` is a two-digit suffix 01-99, and should be selected so that the test
case identifier is unique. Normally the first free index is selected.

Example of test case identifiers:

* ADDRESS03
* BASIC04
* DNSSEC15
* ZONE06

One exceptional test case identifier is `BASIC00`, in which the index
suffix is out of range of the stated range above. That test case is planned to
be removed.
