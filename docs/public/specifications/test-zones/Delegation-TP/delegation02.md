# Specification of test zones for DELEGATION02


## Table of contents

* [Background](#background)
* [Test Case](#test-case)
* [Test scenarios](#test-scenarios)
* [Test zone names](#test-zone-names)
* [Test scenarios and message tags](#test-scenarios-and-message-tags)
* [Zone setup for test scenarios]


## Background

See the [test zone README file].


## Test Case
This document specifies defined test zones for test case [DELEGATION02].


## Test scenarios

The purpose of the test scenarios is to cover all reasonable contexts where
different message tags are outputted when [DELEGATION02] is run on a test zone.
The message tags are defined in the test case ([DELEGATION02]) and the scenarios
are defined below.

The test scenarios are structured as stated in the [test zone README file].

## Test zone names

The test zone for each test scenario in this document is a subdomain delegated
from the base name (`delegation02.xa`) and that subdomain having the same name as the
scenario. The names of those zones are given in section
"[Zone setup for test scenarios]" below.


## Test scenarios and message tags

If a message tag is not listed for the scenario, its presence or non-presence is
irrelevant to the test scenario and must be ignored.


Scenario name                 | Mandatory message tag                    | Forbidden message tags
:-----------------------------|:-----------------------------------------|:-------------------------------------------
ALL-DISTINCT-1                | DEL_DISTINCT_NS_IP, CHILD_DISTINCT_NS_IP | DEL_NS_SAME_IP, CHILD_NS_SAME_IP
ALL-DISTINCT-2                | DEL_DISTINCT_NS_IP, CHILD_DISTINCT_NS_IP | DEL_NS_SAME_IP, CHILD_NS_SAME_IP
ALL-DISTINCT-3                | DEL_DISTINCT_NS_IP, CHILD_DISTINCT_NS_IP | DEL_NS_SAME_IP, CHILD_NS_SAME_IP
DEL-NON-DISTINCT              | DEL_NS_SAME_IP, CHILD_DISTINCT_NS_IP     | DEL_DISTINCT_NS_IP, CHILD_NS_SAME_IP
CHILD-NON-DISTINCT            | DEL_DISTINCT_NS_IP, CHILD_NS_SAME_IP     | DEL_NS_SAME_IP, CHILD_DISTINCT_NS_IP

## Zone setup for test scenarios

Assumptions for the scenario specifications unless otherwise specified for the
specific scenario:
* For each scenario zone there are two name server configured.
  * Both NS (ns1 and ns2) are equal in delegation and in zone.
  * Both NS are in-bailiwick
  * Both NS have both IPv4 and IPv6 addresses
  * All addresses are distinct
  * All required glue are present in the delegation.
  * All glue exactly matches the authoritative address records in correct zone
    (not more and not less records).
  * All NS IP addresses respond with identical zone content.

### ALL-DISTINCT-1
* This is the happy path.
* Zone: "all-distinct-1.delegation02.xa."

### ALL-DISTINCT-2
* This is also a happy path. Out-of-bailiwick.
* Zone: "all-distinct-2.delegation02.xa"
  * Both ns1 and ns2 are out-of-bailiwick under the xb tree.
  * ns1 is "ns1.all-distinct-2.delegation02.xb"
  * ns2 is "ns2.all-distinct-2.delegation02.xb"
  * Delegation is without glue.
  * The test zone has no address records for the NS names.
  * The "ns2.enough-2.delegation02.xb" zone has full set of address records.

### ALL-DISTINCT-3
* This is also a happy path. Also out-of-bailiwick, but with sibbling glue.
* Zone: "child.all-distinct-3.delegation02.xa"
  * Both ns1 and ns2 are out-of-bailiwick
  * ns1 is "ns1.sibbling.all-distinct-3.delegation02.xa"
  * ns2 is "ns2.sibbling.all-distinct-3.delegation02.xa"
  * Delegation is with glue.
  * The test zone ("child") has no address records for the NS names.
  * The "sibbling" zone has full set of address records.

### DEL-NON-DISTINCT
* The glue records use the same IP addresses
* Zone: "del-non-distinct.delegation02.xa"
  * ns1 and ns2 in the glue have the ns1 IPv4 address
  * ns1 and ns2 in the glue have the ns2 IPv6 address
  * ns1 and ns2 are distinct in the zone

### CHILD-NON-DISTINCT
* The address records in the zone use the same IP addresses
* Zone: "child-non-distinct.delegation02.xa"
  * ns1 and ns2 in the zone have the ns1 IPv4 address
  * ns1 and ns2 in the zone have the ns2 IPv6 address
  * ns1 and ns2 are distinct in glue


[DELEGATION02]:                                                   ../../tests/Delegation-TP/delegation02.md
[RCODE Name]:                                                     https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[Test zone README file]:                                          ../README.md
[Zone setup for test scenarios]:                                  #zone-setup-for-test-scenarios

