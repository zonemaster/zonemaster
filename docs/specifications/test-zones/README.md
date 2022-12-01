# Test zones for verification of test case implementation

## Table of contents

* [Objective](#objective)
* [Test scenarios](#test-scenarios)
* [Test environment and naming convensions](#test-environment-and-naming-convensions)
  * [Test zone names](#test-zone-names)
  * [Data outside the test zones](#data-outside-the-test-zones)
* [Terminology](#terminology)



## Objective

The purpose of the structure found here is to define test zones to be able to
test the correctness of the implementation of the Zonemaster [test cases]. The
main use case is to be the basis for the [unit tests] in the Zonemaster
implementation. The second use case is to verify work in progress, e.g.
implementation of new or updated test cases or updated test case
implementation where the test case has not changed.

There can be other use cases, but only these two use cases are covered here
and in the test zone specifications.


## Test scenarios

The goal of the test scenarios is to cover all reasonable contexts where
different message tags are outputted when a test case is run on test zones. The
message tags are defined in the test case specifications found via "[test cases]"
and the scenarios are defined in the test case specific specifications for test
data found via the [test-zones] directory.

In the test zone specifications the scenarios are defined in two parts:

* What messages from test case that are expected to be outputted and what
  messages are expected not to be outputted when a test zone setup according to
  the scenario is tested by the test case.
* Specification of the zone setup for the scenario.

One special aspect is the test scenario name. Since the name is to be part
of the test zone name there are some requirements on it:
* Under a specific test case there must not be two scenarios with the same name.
  Two closely related scenarios can, in their names, be separated with a
  relevant suffix.
* The length of the scenario name must not exceed 32 characters to give room for
  additional parts and still make sure it can fit into a DNS label.
* The character set of the name is limited to those of a host name, i.e.
  `A-Z0-9-` where `A-Z` will be downcased to `a-z` in the domain name.
* The scenario name must not start or end with `-`.


## Test environment and naming convensions

The tests against the test zones are assumed to be run in a closed environment
with a private DNS tree to achieve full access to any zone. Configuration data
and instructions to set this up are available elsewhere in this repository
(*to be completed and linked from here*).

In this document, domain names are given without trailing dot, except for the root
zone (or node) given as a dot `.`.

The non-existing `.xa` TLD and its tree is reserved to host the target test
zones, i.e. the zone name that will be given as *Child Zone* to the test case.
All test zones are to be created under `.xa` except for a few cases elaborated
below.

Unless specified in the test zone specification, DNS records that can be stored
within the zone should also be stored there:
* MX records should point at the relative name `mail` and that name should be
  added to the zone.
* Name server names (NS record RDATA) should be [in-bailiwick]. "Prefixes" to be
  used are `ns1`, `ns2`, `ns3` etc.


### Test zone names

The normal test zone name is built from the following parts:
* `.xa`, the non-existing TLD used here.
* The test case identifier in lower case, e.g. `zone09`.
* The test scenario name in lower case, e.g. `no-response-mx-query`.

In the normal case, the test zone name is `<scenario name>.<test case name>.xa`,
e.g. `no-response-mx-query.zone09.xa`. The normal case should be used as long as
it is possible.

There are some exceptions to the name of the test zone that are defined here:
1. If the test zone is the root, then the name is `.`.
2. If the test zone is a TLD zone, then the the name is
   `<scenario name>-<test case name>`. Note that hyphen "-" is used between the
   parts to create one label. E.g. `no-mx-tld-zone09`. In practice such a TLD
   can never be in conflict with real TLDs in the public DNS tree, especially
   since TLD names are not permitted to contain neither dash "-" nor digits.
3. If the test zone must be in the ARPA tree, then the name is
   `<scenario name>.<test case name>.arpa`, e.g. `no-mx-arpa.zone09.arpa`. In
   practice such a name will never be in conflict with names in the public DNS
   tree since there no such names under public `.arpa`.
4. If a scenario requires that the parent zone has different settings compared to
   other scenrios for the same test case, then the test zone name is
   `child.<scenario name>.<test case name>.xa`, e.g.
   `child.no-response-mx-query.zone09.xa`, where
   `no-response-mx-query.zone09.xa`, instead of `zone09.xa`, is the parent zone
   of the test zone.
5. If a scenario requires that the grandparent zone has different settings
   compared to other scenrios for the same test case, then the test zone name is
   `child.parent.<scenario name>.<test case name>.xa`, e.g.
   `child.parent.no-response-mx-query.zone09.xa`, where
   `no-response-mx-query.zone09.xa`, instead of `zone09.xa`, is the grand parent
   zone of the test zone.

### Data outside the test zones

If a scenario requries that a certain name is outside its own zone, it should be
stored within the `.xb` TLD (also a non-existing TLD) using the same name
structure as under `.xa`, i.e. names for a scenario should be stored under
`<scenario name>.<test case name>.xb`, e.g. `no-mx-arpa.zone09.xb`. This
specification does not require any delegation into several zones in the `.xb`
tree. If it works well all data can be stored in one zone file.

What was stated above on data outside its own zone does not apply to reverse data
since that must be stored in the `in-addr.arpa` or `ipv6.arpa` tree, and the
owner names of such data must follow the reverse data standards. There is no
requirements of creating separate zones for `in-addr.arpa` or `ipv6.arpa` or
below.


## Terminology

* "Glue Record" - The term is used as defined in [RFC 8499], section 7, pages
  24-25.

* "In-Bailiwick" - The term is used as defined in [RFC 8499], section 7,
  pages 24-25. In this document it is limited to the meaning "in domain" in the
  RFC.

* "Out-Of-Bailiwick" lue record" - The terms means, in this document, what is
  not "In-Bailiwick, in domain". [RFC 8499], section 7,  pages 24-25.


[Glue Records]:                                      #terminology
[In-Bailiwick]:                                      #terminology
[Out-Of-Bailiwick]:                                  #terminology
[RFC 8499]:                                          https://datatracker.ietf.org/doc/html/rfc8499#section-7
[Test cases]:                                        ../tests/README.md
[Test-zones]:                                        .
[Unit tests]:                                        https://github.com/zonemaster/zonemaster-engine/tree/master/t
