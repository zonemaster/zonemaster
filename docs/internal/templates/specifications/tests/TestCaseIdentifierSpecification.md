# Test Case Identifier Specification

All test cases belong to one specific test level and their names are based on
that test level’s name. The following test levels are defined and available:

* Address
* Basic
* Connectivity
* Consistency
* DNSSEC
* Delegation
* Nameserver
* Syntax
* Zone

The test level name is not case sensitive, but the forms defined above
must be used when referring to the test levels, i.e. only the first letter
uppercase, expect for acronyms, in the case all uppercase is used.
For exemple "Address" and neither "ADDRESS" nor "address".

The test case identifier in the test case specification (both in the main
headline and in the "Test case identifier" section) uses the test level name,
as defined above, and has the format: `{Test level name} + {Index}`

When referencing to a test case, for readability, the letter case defined
above must be used for the test level name.

The `{Index}` is a two-digit suffix 01-99, and should be selected so that the
test case identifier is unique. Normally the first free index is selected.

Example of test case identifiers:

* Address03
* Basic04
* DNSSEC15
* Zone06

One exceptional test case identifier is `Basic00`, in which the index
suffix is out of range of the stated range above. That test case is planned to
be removed.
