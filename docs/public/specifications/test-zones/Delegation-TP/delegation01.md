# Specification of test Scenarios for Delegation01


## Table of contents

* [Background](#background)
* [Test Case](#test-case)
* [Test scenarios](#test-scenarios)
* [Test zone names](#test-zone-names)
* [All message tags](#all-message-tags)
* [Test scenarios and message tags](#test-scenarios-and-message-tags)
* [Zone setup for test scenarios]


## Background

See the [test scenario README file].


## Test Case
This document specifies defined test zones for test case [Delegation01].


## Test scenarios

The purpose of the test scenarios is to cover all reasonable contexts where
different message tags are outputted when [Delegation01] is run on a test zone.
The message tags are defined in the test case ([Delegation01]) and the scenarios
are defined below.

The test scenarios are structured as stated in the [test scenario README file].

## Test zone names

The test zone for each test scenario in this document is a subdomain delegated
from the base name (`delegation01.xa`) and that subdomain having the same name as the
scenario. The names of those zones are given in section
"[Zone setup for test scenarios]" below.

## All message tags

The test case can output any of these message tags, but not necessarily in any
combination. See [Delegation01] for the specification of the tags.

* ENOUGH_IPV4_NS_CHILD
* ENOUGH_IPV4_NS_DEL
* ENOUGH_IPV6_NS_CHILD
* ENOUGH_IPV6_NS_DEL
* ENOUGH_NS_CHILD
* ENOUGH_NS_DEL
* NOT_ENOUGH_IPV4_NS_CHILD
* NOT_ENOUGH_IPV4_NS_DEL
* NOT_ENOUGH_IPV6_NS_CHILD
* NOT_ENOUGH_IPV6_NS_DEL
* NOT_ENOUGH_NS_CHILD
* NOT_ENOUGH_NS_DEL
* NO_IPV4_NS_CHILD
* NO_IPV4_NS_DEL
* NO_IPV6_NS_CHILD
* NO_IPV6_NS_DEL


## Test scenarios and message tags

If a message tag is not listed for the scenario, its presence or non-presence is
irrelevant to the test scenario and must be ignored.


Scenario name                 | Mandatory message tag                                    | Forbidden message tags
:-----------------------------|:---------------------------------------------------------|:-------------------------------------------
ENOUGH-1                      | ENOUGH_IPV4_NS_CHILD, ENOUGH_IPV4_NS_DEL, ENOUGH_IPV6_NS_CHILD, ENOUGH_IPV6_NS_DEL, ENOUGH_NS_CHILD, ENOUGH_NS_DEL | 2)
ENOUGH-2                      | ENOUGH_IPV4_NS_CHILD, ENOUGH_IPV4_NS_DEL, ENOUGH_IPV6_NS_CHILD, ENOUGH_IPV6_NS_DEL, ENOUGH_NS_CHILD, ENOUGH_NS_DEL | 2)
ENOUGH-3                      | ENOUGH_IPV4_NS_CHILD, ENOUGH_IPV4_NS_DEL, ENOUGH_IPV6_NS_CHILD, ENOUGH_IPV6_NS_DEL, ENOUGH_NS_CHILD, ENOUGH_NS_DEL | 2)
ENOUGH-DEL-NOT-CHILD          | ENOUGH_IPV4_NS_DEL, ENOUGH_IPV6_NS_DEL, ENOUGH_NS_DEL, NOT_ENOUGH_IPV4_NS_CHILD, NOT_ENOUGH_IPV6_NS_CHILD, NOT_ENOUGH_NS_CHILD | 2)
ENOUGH-CHILD-NOT-DEL          | ENOUGH_IPV4_NS_CHILD, ENOUGH_IPV6_NS_CHILD, ENOUGH_NS_CHILD, NOT_ENOUGH_IPV4_NS_DEL, NOT_ENOUGH_IPV6_NS_DEL, NOT_ENOUGH_NS_DEL | 2)
IPV6-AND-DEL-OK-NO-IPV4-CHILD | ENOUGH_IPV4_NS_DEL, ENOUGH_IPV6_NS_CHILD, ENOUGH_IPV6_NS_DEL, ENOUGH_NS_CHILD, ENOUGH_NS_DEL, NO_IPV4_NS_CHILD | 2)
IPV4-AND-DEL-OK-NO-IPV6-CHILD | ENOUGH_IPV4_NS_DEL, ENOUGH_IPV4_NS_CHILD, ENOUGH_IPV6_NS_DEL, ENOUGH_NS_CHILD, ENOUGH_NS_DEL, NO_IPV6_NS_CHILD | 2)
NO-IPV4-1                     | ENOUGH_IPV6_NS_CHILD, ENOUGH_IPV6_NS_DEL, ENOUGH_NS_CHILD, ENOUGH_NS_DEL, NO_IPV4_NS_CHILD, NO_IPV4_NS_DEL | 2)
NO-IPV4-2                     | ENOUGH_IPV6_NS_CHILD, ENOUGH_IPV6_NS_DEL, ENOUGH_NS_CHILD, ENOUGH_NS_DEL, NO_IPV4_NS_CHILD, NO_IPV4_NS_DEL | 2)
NO-IPV4-3                     | ENOUGH_IPV6_NS_CHILD, ENOUGH_IPV6_NS_DEL, ENOUGH_NS_CHILD, ENOUGH_NS_DEL, NO_IPV4_NS_CHILD, NO_IPV4_NS_DEL | 2)
NO-IPV6-1                     | ENOUGH_IPV4_NS_CHILD, ENOUGH_IPV4_NS_DEL, ENOUGH_NS_CHILD, ENOUGH_NS_DEL, NO_IPV6_NS_CHILD, NO_IPV6_NS_DEL | 2)
NO-IPV6-2                     | ENOUGH_IPV4_NS_CHILD, ENOUGH_IPV4_NS_DEL, ENOUGH_NS_CHILD, ENOUGH_NS_DEL, NO_IPV6_NS_CHILD, NO_IPV6_NS_DEL | 2)
NO-IPV6-3                     | ENOUGH_IPV4_NS_CHILD, ENOUGH_IPV4_NS_DEL, ENOUGH_NS_CHILD, ENOUGH_NS_DEL, NO_IPV6_NS_CHILD, NO_IPV6_NS_DEL | 2)


## Zone setup for test scenarios

Assumptions for the scenario specifications unless otherwise specified for the
specific scenario:
* For each scenario zone there are two name server configured.
  * Both NS (ns1 and ns2) are equal in delegation and in zone.
  * Both NS are in-bailiwick
  * Both NS have both IPv4 and IPv6 addresses
  * All required glue are present in the delegation.
  * All glue exactly matches the authoritative address records in correct zone
    (not more and not less records).
  * All NS IP addresses respond with identical zone content.

### ENOUGH-1
This is the happy path.

* Zone: enough-1.delegation01.xa

### ENOUGH-2
This is also a happy path. Out-of-bailiwick.

* Zone: enough-2.delegation01.xa
  * Both ns1 and ns2 are out-of-bailiwick under the xb tree.
  * ns1 is "ns1.enough-2.delegation01.xb"
  * ns2 is "ns2.enough-2.delegation01.xb"
  * Delegation is without glue.
  * The test zone ("child") has no address records for the NS names.
  * The "ns2.enough-2.delegation01.xb" zone has full set of address records.

### ENOUGH-3
This is also a happy path. Also out-of-bailiwick, but with sibbling glue.

* Zone: child.enough-3.delegation01.xa
  * Both ns1 and ns2 are out-of-bailiwick
  * ns1 is "ns1.sibbling.enough-3.delegation01.xa"
  * ns2 is "ns2.sibbling.enough-3.delegation01.xa"
  * Delegation is with glue.
  * The test zone ("child") has no address records for the NS names.
  * The "sibbling" zone has full set of address records.

### ENOUGH-DEL-NOT-CHILD
Only one NS in child zone.

* Zone: enough-del-not-child.delegation01.xa
  * The child zone has only one NS, for ns1.

### ENOUGH-CHILD-NOT-DEL
Only one NS in delegation.

* Zone: enough-child-not-del.delegation01.xa
  * The delegation has only on NS, for ns1.

### IPV6-AND-DEL-OK-NO-IPV4-CHILD
No IPv4 in zone

* Zone: ipv6-and-del-ok-no-ipv4-child.delegation01.xa
  * No A records for ns1 and ns2 in zone.

### IPV4-AND-DEL-OK-NO-IPV6-CHILD
No IPv6 in zone

* Zone: ipv4-and-del-ok-no-ipv6-child.delegation01.xa
  * No AAAA records for ns1 and ns2 in zone.

### NO-IPV4-1
No IPv4 in delegation or zone.

* Zone: no-ipv4-1.delegation01.xa
  * No A glue for ns1 and ns2.
  * No A records in zone for ns1 and ns2.

### NO-IPV4-2
No IPv4 in delegation or zone. Out-of-bailiwick NS and no glue.

* Zone: no-ipv4-2.delegation01.xa
  * Both ns1 and ns2 are out-of-bailiwick under the xb tree.
  * ns1 is "ns1.no-ipv4-2.delegation01.xb"
  * ns2 is "ns2.no-ipv4-2.delegation01.xb"
  * Delegation is without glue.
  * The test zone ("child") has no address records for the NS names
  * The "no-ipv4-2.delegation01.xb" zone has full set of address records.
    * AAAA only, not A

### NO-IPV4-3
No IPv4 in delegation or zone. Out-of-bailiwick NS, but with sibbling glue.

* Zone: child.no-ipv4-3.delegation01.xa
  * Both ns1 and ns2 are out-of-bailiwick
  * ns1 is "ns1.sibbling.no-ipv4-3.delegation01.xa"
  * ns2 is "ns2.sibbling.no-ipv4-3.delegation01.xa"
  * Delegation is with glue.
  * The test zone ("child") has no address records for the NS names
  * The "sibbling" zone has full set of address records.
    * AAAA only, not A.

### NO-IPV6-1
No Ipv6 in delegation or zone.

* Zone: no-ipv6-1.delegation01.xa
  * No AAAA glue for ns1 and ns2.
  * No AAAA records in zone for ns1 and ns2.

### NO-IPV6-2
No Ipv6 in delegation or zone. Out-of-bailiwick NS and no glue.

* Zone: no-ipv6-2.delegation01.xa
  * Both ns1 and ns2 are out-of-bailiwick under the xb tree.
  * ns1 is "ns1.no-ipv6-2.delegation01.xb"
  * ns2 is "ns2.no-ipv6-2.delegation01.xb"
  * Delegation is without glue.
  * The test zone ("child") has no address records for the NS names
  * The "no-ipv6-2.delegation01.xb" zone has full set of address records.
    * A only, not AAAA

### NO-IPV6-3
No Ipv6 in delegation or zone. Out-of-bailiwick NS, but with sibbling glue.

* Zone: child.no-ipv6-3.delegation01.xa
  * Both ns1 and ns2 are out-of-bailiwick
  * ns1 is "ns1.sibbling.no-ipv6-3.delegation01.xa"
  * ns2 is "ns2.sibbling.no-ipv6-3.delegation01.xa"
  * Delegation is with glue.
  * The test zone ("child") has no address records for the NS names
  * The "sibbling" zone has full set of address records.
    * A only, not AAAA.


[Delegation01]:                                                   ../../tests/Delegation-TP/delegation01.md
[RCODE Name]:                                                     https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[Test scenario README file]:                                      ../README.md
[Zone setup for test scenarios]:                                  #zone-setup-for-test-scenarios

