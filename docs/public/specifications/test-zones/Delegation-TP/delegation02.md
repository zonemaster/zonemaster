# Specification of test Scenarios for Delegation02


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
This document specifies defined test zones for test case [Delegation02].


## Test scenarios

The purpose of the test scenarios is to cover all reasonable contexts where
different message tags are outputted when [Delegation02] is run on a test zone.
The message tags are defined in the test case ([Delegation02]) and the scenarios
are defined below.

The test scenarios are structured as stated in the [test scenario README file].

## Test zone names

The test zone for each test scenario in this document is a subdomain delegated
from the base name (`delegation02.xa`) and that subdomain having the same name as the
scenario. The names of those zones are given in section
"[Zone setup for test scenarios]" below.

## All message tags

The test case can output any of these message tags, but not necessarily in any
combination. See [Delegation02] for the specification of the tags.

* DEL_DISTINCT_NS_IP
* CHILD_DISTINCT_NS_IP
* DEL_NS_SAME_IP
* CHILD_NS_SAME_IP


## Test scenarios and message tags

If a message tag is not listed for the scenario, its presence or non-presence is
irrelevant to the test scenario and must be ignored.

Scenario name                 | Mandatory message tag                    | Forbidden message tags
:-----------------------------|:-----------------------------------------|:-------------------------------------------
ALL-DISTINCT-1                | DEL_DISTINCT_NS_IP, CHILD_DISTINCT_NS_IP | 2)
ALL-DISTINCT-2                | DEL_DISTINCT_NS_IP, CHILD_DISTINCT_NS_IP | 2)
ALL-DISTINCT-3                | DEL_DISTINCT_NS_IP, CHILD_DISTINCT_NS_IP | 2)
DEL-NON-DISTINCT              | DEL_NS_SAME_IP, CHILD_DISTINCT_NS_IP     | 2)
DEL-NON-DISTINCT-UND          | DEL_NS_SAME_IP, CHILD_DISTINCT_NS_IP     | 2)
CHILD-NON-DISTINCT            | DEL_DISTINCT_NS_IP, CHILD_NS_SAME_IP     | 2)
CHILD-NON-DISTINCT-UND        | DEL_DISTINCT_NS_IP, CHILD_NS_SAME_IP     | 2)
NON-DISTINCT-1                | DEL_NS_SAME_IP, CHILD_NS_SAME_IP         | 2)
NON-DISTINCT-2                | DEL_NS_SAME_IP, CHILD_NS_SAME_IP         | 2)
NON-DISTINCT-3                | DEL_NS_SAME_IP, CHILD_NS_SAME_IP         | 2)

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
This is the happy path.

* Zone: all-distinct-1.delegation02.xa

### ALL-DISTINCT-2
This is also a happy path. Out-of-bailiwick.

* Zone: all-distinct-2.delegation02.xa
  * Both ns1 and ns2 are out-of-bailiwick under the xb tree.
  * ns1 is "ns1.all-distinct-2.delegation02.xb"
  * ns2 is "ns2.all-distinct-2.delegation02.xb"
  * Delegation is without glue.
  * The test zone has no address records for the NS names.
  * The "delegation02.xb" zone has full set of address records for this scenario.

### ALL-DISTINCT-3
This is also a happy path. Also out-of-bailiwick, but with sibbling glue.

* Zone: all-distinct-3.delegation02.xa
  * Both ns1 and ns2 are out-of-bailiwick
  * ns1 is "ns1.all-distinct-3.sibbling.delegation02.xa"
  * ns2 is "ns2.all-distinct-3.sibbling.delegation02.xa"
  * Delegation is with glue.
  * The test zone ("child") has no address records for the NS names.
  * The "delegation02.xa" zone has full set of address records for this scenario.

### DEL-NON-DISTINCT
The glue records use the same IP addresses.

* Zone: del-non-distinct.delegation02.xa
  * NS are ns1a and ns1b
  * ns1a and ns1b in the delegation (glue) have the same IPv4 and IPv6 addresses,
    respectively.
  * ns1a and ns1b have distinct addresses in the zone (IPv4 and IPv6,
    respectively).

### DEL-NON-DISTINCT-UND
The glue records use the same IP addresses. The zone is undelegated.

* Zone: del-non-distinct-und.delegation02.xa
  * The zone is undelegated.
  * NS are ns1a and ns1b
  * ns1a and ns1b in the delegation (glue) have the same IPv4 and IPv6 addresses,
    respectively.
  * ns1a and ns1b have distinct addresses in the zone (IPv4 and IPv6,
    respectively).
  * Undelegated data:
    * ns1a.del-non-distinct-und.delegation02.xa/IPv4
    * ns1a.del-non-distinct-und.delegation02.xa/IPv6
    * ns1b.del-non-distinct-und.delegation02.xa/IPv4
    * ns1b.del-non-distinct-und.delegation02.xa/IPv6

### CHILD-NON-DISTINCT
The address records in the zone use the same IP addresses.

* Zone: child-non-distinct.delegation02.xa
  * NS are ns1a and ns1b
  * ns1a and ns1b in the delegation (glue) have distinct addresses (IPv4 and
    IPv6, respectively).
  * ns1a and ns1b have the same addresses in the zone, IPv4 and IPv6, 
    respectively.

### CHILD-NON-DISTINCT-UND
The address records in the zone use the same IP addresses.

* Zone: child-non-distinct-und.delegation02.xa
  * The zone is undelegated.
  * NS are ns1a and ns1b
  * ns1a and ns1b in the delegation (glue) have distinct addresses (IPv4 and
    IPv6, respectively).
  * ns1a and ns1b have the same addresses in the zone, IPv4 and IPv6, 
    respectively.
  * Undelegated data:
    * ns1a.child-non-distinct-und.delegation02.xa/IPv4
    * ns1a.child-non-distinct-und.delegation02.xa/IPv6
    * ns1b.child-non-distinct-und.delegation02.xa/IPv4
    * ns1b.child-non-distinct-und.delegation02.xa/IPv6

### NON-DISTINCT-1
The address records in both delegation and zone use the same IP addresses.

* Zone: non-distinct-1.delegation02.xa
  * NS are ns1a, ns1b and ns2
  * ns1a and ns1b in the delegation (glue) have the same IPv4 and IPv6 addresses,
    respectively.
  * ns1a and ns1b have the same addresses in the zone, IPv4 and IPv6, 
    respectively.
  * ns2 has a distinct address both in delegation and in zone.

### NON-DISTINCT-2
The NS in both delegation and zone refer to the same IP addresses. The
names are out-of-bailiwick.

* Zone: non-distinct-2.delegation02.xa
  * NS are ns1a, ns1b and ns2, and are out-of-bailiwick under the xb tree.
  * ns1a is "ns1a.non-distinct-2.delegation02.xb"
  * ns1b is "ns1a.non-distinct-2.delegation02.xb"
  * ns2 is "ns2.non-distinct-2.delegation02.xb"
  * Delegation is without glue.
  * ns1a and ns1b have the same addresses, IPv4 and IPv6, respectively.
  * ns2 has distinct addresses (IPv4 and IPv6).
  * The test zone has no address records for the NS names.
  * The "delegation02.xb" zone has full set of address records for this scenario.

### NON-DISTINCT-2
The NS in both delegation and zone refer to the same IP addresses. The
names are out-of-bailiwick, but with sibbling glue.

* Zone: non-distinct-3.delegation02.xa
  * NS are ns1a, ns1b and ns2, and are out-of-bailiwick.
  * ns1a is "ns1a.non-distinct-3.sibbling.delegation02.xa"
  * ns1b is "ns1a.non-distinct-3.sibbling.delegation02.xa"
  * ns2 is "ns2.non-distinct-3.sibbling.delegation02.xa"
  * Delegation has sibbling glue.
  * ns1a and ns1b have the same addresses, IPv4 and IPv6, respectively.
  * ns2 has distinct addresses (IPv4 and IPv6).
  * The test zone has no address records for the NS names.
  * The "delegation02.xa" zone has full set of address records for this scenario.


[Delegation02]:                                                   ../../tests/Delegation-TP/delegation02.md
[RCODE Name]:                                                     https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[test scenario README file]:                                          ../README.md
[Zone setup for test scenarios]:                                  #zone-setup-for-test-scenarios

