# Specification of test scenarios for MethodsV2


## Table of contents

* [Background](#background)
* [Test scenarios](#test-scenarios)
* [Test zone names](#test-zone-names)
* [Test scenarios and expected output](#test-scenarios-and-expected)
* [Zone setup for test scenarios]


## Background

See the [test zone README file] which is for test case base test zones. Since
this specifies test zones for a [MethodsV2] Method it is not fully applicable.

## Test scenarios

The purpose of the test scenarios is to cover all reasonable contexts for the
Methods. See [Implementation of test scenarios for MethodsV2] for the
implementation of the scenarios described in this document.


## Test zone name

The test zone for each test scenario in this document is a subdomain delegated
from the base name (`methodsv2.xa`) and that subdomain having the same name as
the specific scenario. The names of those zones are given in section
"[Zone setup for test scenarios]" below.


## Zone setup for test scenarios

Assumptions for the scenario specifications unless otherwise specified for
the specific scenario:

* The child zone is `child.parent.SCENARIO.methodsv2.xa`.
  * It is served by two IB (in-bailiwick) NS (ns1 and ns2).
  * ns1 and ns2 have the same zone content.
  * ns1 and ns2 have both IPv4 and IPv6 glue.
  * The records matching glue in the zone are complete.
  * The delegation from the parent has the same NS with complete glue.
* The parent zone is `parent.SCENARIO.methodsv2.xa`.
  * It is served by two IB NS (ns1 and ns2).
  * ns1 and ns2 have the same zone content.
  * ns1 and ns2 have both IPv4 and IPv6 glue.
  * The records matching glue in the zone are complete.
  * The delegation from the grand parent has the same NS with complete glue.
* The grandparent zone is `SCENARIO.methodsv2.xa`.
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
* Standard root is used.
* In all cases, delegation and zone are consistent.
  * Same NS
  * Any required glue matches address records in zone. No extra address
    records.

## GOOD-1

### Zone specification
A "happy path". Everything is fine.

* Zone: child.parent.good-1.methodsv2.xa
  * Just defaults

## GOOD-2

### Zone specification
A "happy path". Everything is fine. Child has out-of-bailiwick name servers
only.

* Zone: child.parent.good-2.methodsv2.xa
  * Child NS are out-of-bailiwick:
    * ns5.good-2.methodsv2.xa
    * ns6.good-2.methodsv2.xa
  * No glue

## GOOD-3

### Zone specification
A "happy path". Everything is fine. Child has boot in-bailiwick and
out-of-bailiwick name servers.

* Zone: child.parent.good-3.methodsv2.xa
  * Child NS:
    * ns1.child.parent.good-3.methodsv2.xa
    * ns3.parent.good-3.methodsv2.xa
    * ns5.good-3.methodsv2.xa
  * Glue:
    * Adress records (A and AAAA) for
      * ns1.child.parent.good-3.methodsv2.xa
      * ns3.parent.good-3.methodsv2.xa (optional)

## GOOD-UNDEL-1

### Zone specification
A "happy path". Everything is fine. Child has boot in-bailiwick and
out-of-bailiwick name servers. Child is delegated but is tested
undelegated.

* Zone: child.parent.good-undel-1.methodsv2.xa
  * Delegation:
    * Child NS:
      * ns1-2.child.parent.good-undel-1.methodsv2.xa
      * ns3.parent.good-undel-1.methodsv2.xa
      * ns5.good-undel-1.methodsv2.xa
    * Glue:
      * Adress records (A and AAAA) for
        * ns1-2.child.parent.good-undel-1.methodsv2.xa
        * ns3.parent.good-undel-1.methodsv2.xa (optional)
  * To be tested with undelegated data (fake data):
      * ns1-2.child.parent.good-undel-1.methodsv2.xa/IPv4-12
      * ns1-2.child.parent.good-undel-1.methodsv2.xa/IPv6-12
      * ns3.parent.good-undel-1.methodsv2.xa/IPv4-13
      * ns3.parent.good-undel-1.methodsv2.xa/IPv6-13
      * ns6.good-undel-1.methodsv2.xa

## GOOD-UNDEL-2

### Zone specification
A "happy path". Everything is fine. Child has boot in-bailiwick and
out-of-bailiwick name servers. Child is not delegated but is tested
undelegated.

* Zone: child.parent.good-undel-2.methodsv2.xa
  * No delegation from parent.
  * To be tested with undelegated data (fake data):
      * ns1.child.parent.good-undel-2.methodsv2.xa/IPv4-12
      * ns1.child.parent.good-undel-2.methodsv2.xa/IPv6-12
      * ns3.parent.good-undel-2.methodsv2.xa/IPv4-13
      * ns3.parent.good-undel-2.methodsv2.xa/IPv6-13
      * ns6.good-undel-2.methodsv2.xa

\[Not complete. More scenarios and test zones to be defined.]









[RCODE Name]:                                                     https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[Test zone README file]:                                          ../../README.md
[Zone setup for test scenarios]:                                  #zone-setup-for-test-scenarios
[MethodsV2]:                                                      ../../tests/MethodsV2.md 
[Get parent NS IP addresses]:                                     ../../tests/MethodsV2.md#method-get-parent-ns-ip-addresses
[Implementation of test scenarios for MethodsV2]:                 https://github.com/matsduf/zonemaster/blob/master/test-zone-data/MethodsV2/methodsv2.xa
