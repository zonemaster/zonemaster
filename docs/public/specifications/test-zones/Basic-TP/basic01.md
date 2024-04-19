# Specification of test zones for Basic01


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
This document specifies defined test zones for test case [Basic01].


## Test scenarios

The purpose of the test scenarios is to cover all reasonable contexts where
different message tags are outputted when [Basic01] is run on a test zone.
The message tags are defined in the test case ([Basic01]) and the scenarios
are defined below.

The test scenarios are structured as stated in the [test zone README file].

## Test zone names

The test zone for each test scenario in this document is a subdomain (or lower
zone) delegated from the base name (`basic01.xa`) and that subdomain having the
same name as the scenario. The names of those zones are given in section
"[Zone setup for test scenarios]" below.


## Test scenarios and message tags

If a message tag is not listed for the scenario, its presence or non-presence is
irrelevant to the test scenario and must be ignored.

Scenario name             | Mandatory message tag                                           | Forbidden message tags
:-------------------------|:----------------------------------------------------------------|:-------------------------------------------
GOOD-1                    | B01_CHILD_FOUND, B01_PARENT_FOUND                               | B01_CHILD_IS_ALIAS, B01_CHILD_NOT_EXIST, B01_INCONSISTENT_ALIAS, B01_INCONSISTENT_DELEGATION, B01_NO_CHILD, B01_PARENT_UNDETERMINED, B01_UNEXPECTED_NS_RESPONSE
GOOD-MIXED-1              | B01_CHILD_FOUND, B01_PARENT_FOUND                               | B01_CHILD_IS_ALIAS, B01_CHILD_NOT_EXIST, B01_INCONSISTENT_ALIAS, B01_INCONSISTENT_DELEGATION, B01_NO_CHILD, B01_PARENT_UNDETERMINED, B01_UNEXPECTED_NS_RESPONSE
GOOD-MIXED-2              | B01_CHILD_FOUND, B01_PARENT_FOUND                               | B01_CHILD_IS_ALIAS, B01_CHILD_NOT_EXIST, B01_INCONSISTENT_ALIAS, B01_INCONSISTENT_DELEGATION, B01_NO_CHILD, B01_PARENT_UNDETERMINED, B01_UNEXPECTED_NS_RESPONSE
GOOD-UNDEL-1              | B01_CHILD_FOUND, B01_PARENT_FOUND                               | B01_CHILD_IS_ALIAS, B01_CHILD_NOT_EXIST, B01_INCONSISTENT_ALIAS, B01_INCONSISTENT_DELEGATION, B01_NO_CHILD, B01_PARENT_UNDETERMINED, B01_UNEXPECTED_NS_RESPONSE
GOOD-MIXED-UNDEL-1        | B01_CHILD_FOUND, B01_PARENT_FOUND                               | B01_CHILD_IS_ALIAS, B01_CHILD_NOT_EXIST, B01_INCONSISTENT_ALIAS, B01_INCONSISTENT_DELEGATION, B01_NO_CHILD, B01_PARENT_UNDETERMINED, B01_UNEXPECTED_NS_RESPONSE
GOOD-MIXED-UNDEL-2        | B01_CHILD_FOUND, B01_PARENT_FOUND                               | B01_CHILD_IS_ALIAS, B01_CHILD_NOT_EXIST, B01_INCONSISTENT_ALIAS, B01_INCONSISTENT_DELEGATION, B01_NO_CHILD, B01_PARENT_UNDETERMINED, B01_UNEXPECTED_NS_RESPONSE
NO-DEL-UNDEL-1            | B01_CHILD_NOT_EXIST, B01_PARENT_FOUND                           | B01_CHILD_IS_ALIAS, B01_CHILD_FOUND, B01_INCONSISTENT_ALIAS, B01_INCONSISTENT_DELEGATION, B01_NO_CHILD, B01_PARENT_UNDETERMINED, B01_UNEXPECTED_NS_RESPONSE
NO-DEL-MIXED-UNDEL-1      | B01_CHILD_NOT_EXIST, B01_PARENT_FOUND                           | B01_CHILD_IS_ALIAS, B01_CHILD_FOUND, B01_INCONSISTENT_ALIAS, B01_INCONSISTENT_DELEGATION, B01_NO_CHILD, B01_PARENT_UNDETERMINED, B01_UNEXPECTED_NS_RESPONSE
NO-DEL-MIXED-UNDEL-2      | B01_CHILD_NOT_EXIST, B01_PARENT_FOUND                           | B01_CHILD_IS_ALIAS, B01_CHILD_FOUND, B01_INCONSISTENT_ALIAS, B01_INCONSISTENT_DELEGATION, B01_NO_CHILD, B01_PARENT_UNDETERMINED, B01_UNEXPECTED_NS_RESPONSE
CHILD-ALIAS-1             | B01_CHILD_IS_ALIAS, B01_CHILD_NOT_EXIST                         | B01_CHILD_FOUND, B01_INCONSISTENT_ALIAS, B01_INCONSISTENT_DELEGATION, B01_NO_CHILD, B01_PARENT_FOUND, B01_PARENT_UNDETERMINED, B01_UNEXPECTED_NS_RESPONSE
CHILD-ALIAS-2             | B01_CHILD_IS_ALIAS, B01_CHILD_NOT_EXIST, B01_INCONSISTENT_ALIAS | B01_CHILD_FOUND, B01_CHILD_NOT_EXIST, B01_INCONSISTENT_DELEGATION, B01_NO_CHILD, B01_PARENT_FOUND, B01_PARENT_UNDETERMINED, B01_UNEXPECTED_NS_RESPONSE
CHILD-FOUND-1             | B01_CHILD_FOUND                                                 | B01_CHILD_IS_ALIAS, B01_CHILD_NOT_EXIST, B01_INCONSISTENT_ALIAS, B01_INCONSISTENT_DELEGATION, B01_NO_CHILD, B01_PARENT_FOUND, B01_PARENT_UNDETERMINED, B01_UNEXPECTED_NS_RESPONSE
CHILD-FOUND-2             | B01_CHILD_FOUND                                                 | B01_CHILD_IS_ALIAS, B01_CHILD_NOT_EXIST, B01_INCONSISTENT_ALIAS, B01_INCONSISTENT_DELEGATION, B01_NO_CHILD, B01_PARENT_FOUND, B01_PARENT_UNDETERMINED, B01_UNEXPECTED_NS_RESPONSE
CHILD-FOUND-3             | B01_CHILD_FOUND                                     | B01_CHILD_IS_ALIAS, B01_CHILD_NOT_EXIST, B01_INCONSISTENT_ALIAS, B01_INCONSISTENT_DELEGATION, B01_NO_CHILD, B01_PARENT_FOUND, B01_PARENT_UNDETERMINED, B01_UNEXPECTED_NS_RESPONSE
CHILD-FOUND-INCONSIST-1   | B01_CHILD_FOUND, B01_INCONSISTENT_DELEGATION        | B01_CHILD_IS_ALIAS, B01_CHILD_NOT_EXIST, B01_INCONSISTENT_ALIAS, B01_NO_CHILD, B01_PARENT_FOUND, B01_PARENT_UNDETERMINED, B01_UNEXPECTED_NS_RESPONSE
CHILD-FOUND-INCONSIST-2   | B01_CHILD_FOUND, B01_INCONSISTENT_DELEGATION        | B01_CHILD_IS_ALIAS, B01_CHILD_NOT_EXIST, B01_INCONSISTENT_ALIAS, B01_NO_CHILD, B01_PARENT_FOUND, B01_PARENT_UNDETERMINED, B01_UNEXPECTED_NS_RESPONSE
CHILD-FOUND-INCONSIST-3   | B01_CHILD_FOUND, B01_INCONSISTENT_DELEGATION        | B01_CHILD_IS_ALIAS, B01_CHILD_NOT_EXIST, B01_INCONSISTENT_ALIAS, B01_NO_CHILD, B01_PARENT_FOUND, B01_PARENT_UNDETERMINED, B01_UNEXPECTED_NS_RESPONSE
CHILD-FOUND-INCONSIST-4   | B01_CHILD_IS_ALIAS, B01_CHILD_FOUND, B01_INCONSISTENT_DELEGATION | B01_CHILD_NOT_EXIST, B01_INCONSISTENT_ALIAS, B01_NO_CHILD, B01_PARENT_FOUND, B01_PARENT_UNDETERMINED, B01_UNEXPECTED_NS_RESPONSE
CHILD-FOUND-INCONSIST-5   | B01_CHILD_FOUND, B01_INCONSISTENT_DELEGATION        | B01_CHILD_IS_ALIAS, B01_CHILD_NOT_EXIST, B01_INCONSISTENT_ALIAS, B01_NO_CHILD, B01_PARENT_FOUND, B01_PARENT_UNDETERMINED, B01_UNEXPECTED_NS_RESPONSE
CHILD-NOT-EXIST-1         | B01_CHILD_NOT_EXIST                                 | B01_CHILD_IS_ALIAS, B01_CHILD_FOUND, B01_INCONSISTENT_ALIAS, B01_INCONSISTENT_DELEGATION, B01_NO_CHILD, B01_PARENT_FOUND, B01_PARENT_UNDETERMINED, B01_UNEXPECTED_NS_RESPONSE
NO-CHILD-1                | B01_NO_CHILD                                 | B01_CHILD_IS_ALIAS, B01_CHILD_FOUND, B01_CHILD_NOT_EXIST, B01_INCONSISTENT_ALIAS, B01_INCONSISTENT_DELEGATION, B01_PARENT_FOUND, B01_PARENT_UNDETERMINED, B01_UNEXPECTED_NS_RESPONSE


## Zone setup for test scenarios

Assumptions for the scenario specifications unless otherwise specified for
the specific scenario:

* The child zone is `child.parent.SCENARIO.basic01.xa`.
  * It is served by two IB (in-bailiwick) NS (ns1 and ns2).
  * ns1 and ns2 have the same zone content.
  * ns1 and ns2 have both IPv4 and IPv6 glue.
  * The records matching glue in the zone are complete.
  * The delegation from the parent has the same NS with complete glue.
* The parent zone is `parent.SCENARIO.basic01.xa`.
  * It is served by two IB NS (ns1 and ns2).
  * ns1 and ns2 have the same zone content.
  * ns1 and ns2 have both IPv4 and IPv6 glue.
  * The records matching glue in the zone are complete.
  * The delegation from the grand parent has the same NS with complete glue.
* The grandparent zone is `SCENARIO.basic01.xa`.
  * It is served by two IB NS (ns1 and ns2).
  * ns1 and ns2 have the same zone content.
  * ns1 and ns2 have both IPv4 and IPv6 glue.
  * The records matching glue in the zone are complete.
  * The delegation from the SCENARIO zoen has the same NS with complete glue.
* Responds with a A record for the zone on query for A.
* Responds with a AAAA record for the zone on query for AAAA.
* All responses are authoritative with [RCODE Name] "NoError"
* EDNS, version 0, is included in all responses on queries with EDNS.
* EDNS is not included in responses on queries without EDNS.
* Standard test zone root is used.
* In all cases, delegation and zone are consistent.
  * Same NS.
  * Any required glue matches address records in zone.
  * No extra address records for the NS names.

### GOOD-1
A "happy path". Everything is fine.

* Zone: child.parent.good-1.basic01.xa

### GOOD-MIXED-1
One grandparent server also serves parent zone.

* Zone: child.parent.good-mixed-1.basic01.xa
  * Parent zone `parent.good-mixed-1.basic01.xa` is served by `ns1`, `ns2` and on
    `ns4.good-mixed-1.basic01.xa`.
  * Grandparent zone `good-mixed-1.basic01.xa` is served on `ns1` adn `ns4`.

### GOOD-MIXED-2
One parent server also hosts the child zone.

* Zone: child.parent.good-mixed-2.basic01.xa
  * Child zone is served by `ns1`, `ns2` and
    `ns4.parent.good-mixed-2.basic01.xa`.
  * Parent zone `parent.good-mixed-2.basic01.xa` is served by `ns1` and `ns4`.

### GOOD-UNDEL-1
The child zone is delegated, but there is also an undelegated version which is
the one tested.

* Zone: child.parent.good-undel-1.basic01.xa
  * Child zone is delegated, but there is also an undelegated version which is
    the one tested.
  * Child zone (undelegated) is served by `ns3` och `ns4` with other IP addresses
    compared to `ns1` and `ns2` (the delegated zone).
  * `ns1` and `ns2` do not exist in the undelegated zone.
  * `ns3` and `ns4` do not exist in the delegated zone.
  * Undelgated data:
    * ns3.child.parent.good-undel-1.basic01.xa/IPv4
    * ns3.child.parent.good-undel-1.basic01.xa/IPv6
    * ns4.child.parent.good-undel-1.basic01.xa/IPv4
    * ns4.child.parent.good-undel-1.basic01.xa/IPv6

### GOOD-MIXED-UNDEL-1
The child zone is delegated, but there is also an undelegated version which is
the one tested. One grandparent server, in the delegated tree, also serves
parent zone.

* Zone: child.parent.good-mixed-undel-1.basic01.xa
  * Parent zone `parent.good-mixed-undel-1.basic01.xa` is served by `ns1`, `ns2` and on
    `ns4.good-mixed-undel-1.basic01.xa`.
  * Grandparent zone `good-mixed-undel-1.basic01.xa` is served on `ns1` adn `ns4`.
  * Child zone is delegated, but there is also an undelegated version which is
    the one tested.
  * Child zone (undelegated) is served by `ns3` och `ns4` with other IP addresses
    compared to `ns1` and `ns2` (the delegated zone).
  * `ns1` and `ns2` do not exist in the undelegated zone.
  * `ns3` and `ns4` do not exist in the delegated zone.
  * Undelgated data:
    * ns3.child.parent.good-mixed-undel-1.basic01.xa/IPv4
    * ns3.child.parent.good-mixed-undel-1.basic01.xa/IPv6
    * ns4.child.parent.good-mixed-undel-1.basic01.xa/IPv4
    * ns4.child.parent.good-mixed-undel-1.basic01.xa/IPv6

### GOOD-MIXED-UNDEL-2
The child zone is delegated, but there is also an undelegated version which is
the one tested. One parent server also serves the delegated child zone.

* Zone: child.parent.good-mixed-undel-2.basic01.xa
  * Child zone is served by `ns1`, `ns2` and
    `ns6.parent.good-mixed-undel-2.basic01.xa`.
  * Parent zone `parent.good-mixed-undel-2.basic01.xa` is served by `ns1` and `ns6`.
  * Child zone is delegated, but there is also an undelegated version which is
    the one tested.
  * Child zone (undelegated) is served by `ns3` och `ns4` with other IP addresses
    compared to the delegated zone.
  * `ns1` and `ns2` do not exist in the undelegated zone.
  * `ns3` and `ns4` do not exist in the delegated zone.
  * Undelgated data:
    * ns3.child.parent.good-mixed-undel-1.basic01.xa/IPv4
    * ns3.child.parent.good-mixed-undel-1.basic01.xa/IPv6
    * ns4.child.parent.good-mixed-undel-1.basic01.xa/IPv4
    * ns4.child.parent.good-mixed-undel-1.basic01.xa/IPv6

### NO-DEL-UNDEL-1
The child zone is not delegated, but there is an undelegated version that is
tested.

* Zone: child.parent.no-del-undel-1.basic01.xa
  * Child zone (undelegated) is served by `ns1`, `ns2`.
  * Undelgated data:
    * ns1.child.parent.good-mixed-undel-1.basic01.xa/IPv4
    * ns1.child.parent.good-mixed-undel-1.basic01.xa/IPv6
    * ns2.child.parent.good-mixed-undel-1.basic01.xa/IPv4
    * ns2.child.parent.good-mixed-undel-1.basic01.xa/IPv6

### NO-DEL-MIXED-UNDEL-1
The child zone is not delegated, but there is an undelegated version that is
tested. One grandparent server also serves the parent zone.

* Zone: child.parent.no-del-mixed-undel-1.basic01.xa
  * Parent zone `parent.no-del-mixed-undel-1.basic01.xa` is served by `ns1`, `ns2` and on
    `ns4.no-del-mixed-undel-1.basic01.xa`.
  * Grandparent zone `no-del-mixed-undel-1.basic01.xa` is served on `ns1` adn `ns4`.
  * Child zone is not delegated, but there is also an undelegated version which is
    the one tested.
  * Undelegated child zone is served by `ns1` and `ns2`.
  * Undelgated data:
    * ns1.child.parent.no-del-mixed-undel-1.basic01.xa/IPv4
    * ns1.child.parent.no-del-mixed-undel-1.basic01.xa/IPv6
    * ns2.child.parent.no-del-mixed-undel-1.basic01.xa/IPv4
    * ns2.child.parent.no-del-mixed-undel-1.basic01.xa/IPv6

### NO-DEL-MIXED-UNDEL-2
The child zone is not delegated, but there is an undelegated version that is
tested. One grandparent server also serves the parent zone. There are extra empty
nodes between the zone cuts.

* Zone: child.w.x.parent.y.z.no-del-mixed-undel-2.basic01.xa
  * Parent zone `parent.y.z.no-del-mixed-undel-2.basic01.xa` is served by `ns1`, `ns2` and on
    `ns4.no-del-mixed-undel-2.basic01.xa`.
  * Grandparent zone `no-del-mixed-undel-2.basic01.xa` is served on `ns1` adn `ns4`.
  * There are no zone cuts at `w`, `x`, `y` and `z`.
  * Child zone is not delegated, but there is also an undelegated version which is
    the one tested.
  * Undelegated child zone is served by `ns1` and `ns2`.
  * Undelgated data:
    * ns1.child.w.x.parent.y.z.no-del-mixed-undel-2.basic01.xa/IPv4
    * ns1.child.w.x.parent.y.z.no-del-mixed-undel-2.basic01.xa/IPv6
    * ns2.child.w.x.parent.y.z.no-del-mixed-undel-2.basic01.xa/IPv4
    * ns2.child.w.x.parent.y.z.no-del-mixed-undel-2.basic01.xa/IPv6

### CHILD-ALIAS-1

### CHILD-ALIAS-2

### CHILD-FOUND-1

### CHILD-FOUND-2

### CHILD-FOUND-3

### CHILD-FOUND-INCONSIST-1

### CHILD-FOUND-INCONSIST-2

### CHILD-FOUND-INCONSIST-3

### CHILD-FOUND-INCONSIST-4

### CHILD-FOUND-INCONSIST-5

### CHILD-NOT-EXIST-1

### NO-CHILD-1




[Basic01]:                                                        ../../tests/Basic-TP/basic01.md
[RCODE Name]:                                                     https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[Test zone README file]:                                          ../README.md
[Zone setup for test scenarios]:                                  #zone-setup-for-test-scenarios

