# Test Case Identifier Specification

All test cases belong to one specific test level, and it gets its name from that
test level's name. The following test levels are defined and available:

* Address
* Basic
* Connectivity
* Consitency
* DNSSEC
* Delegation
* Nameserver
* Syntax
* Zone

The test case identifier has the format: <Test Level name> + <Index>

The test level name is listed above, and the identifier takes the same uppe
case/lower case format as listed above.

The <Index> is a two-digit suffix 01-99, and should be selected so that the test
case identifier is unique. Normally the first free index is selected.

Example of test case identifiers:

* Address03
* Basic04
* DNSSEC1515
* Zone06

One execptional test case identifier is `Basic00`, in which the index suffix is
out of range of the stated range above.
