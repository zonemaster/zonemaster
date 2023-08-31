# Test Case Identifier Specification

All test cases belong to one module and their names are based on that module’s
name. The following modules are defined and available:

* Address
* Basic
* Connectivity
* Consistency
* DNSSEC
* Delegation
* Nameserver
* Syntax
* Zone

The module name is not case sensitive, but camel case, as defined above,
should be prefered.

The test case identifier in the test case specification (both in the main
headline and in the "Test case identifier" section) uses the module name,
as defined above, and has the format: `{Module name} + {Index}`

When referencing to a test case the module name may be used in other letter
case, but for readability, camel case sould be prefered.

The `{Index}` is a two-digit suffix 01-99, and should be selected so that the test
case identifier is unique. Normally the first free index is selected.

Example of test case identifiers:

* Address03
* Basic04
* DNSSEC15
* Zone06

One exceptional test case identifier is `Basic00`, in which the index
suffix is out of range of the stated range above. That test case is planned to
be removed.
