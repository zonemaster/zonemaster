OA# Specification of test scenarios for MethodsV2


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


## Public methods

[MethodsV2] provides the following public methods:

* For parent zone:
  * Get parent NS IP addresses
* For delegation:
  * Get delegation NS names and IP addresses
  * Get delegation NS IP addresses
  * Get delegation NS names
* For zone information:
  * Get zone NS names and IP addresses
  * Get zone NS names
  * Get zone NS IP addresses

### Data type

All methods can return one of the following data types:
  * Empty set
  * Non-empty set
  * Undefined set

For these scenarios no distrinction is made between "empty" and "undefined". Both
are set as an empty set.

The non-empty set from the following methods consists of unique IP addresses,
IPv4, IPv6 or both (e.g "127.40.4.21" and "fda1:b2:c3::21" are valid):
  * Get parent NS IP addresses
  * Get delegation NS IP addresses
  * Get zone NS IP addresses
  
The non-empty set from the following methods consists of unique name server
names (e.g. "ns1.example.xa" and "ns2.example.xb" are valid):
  * Get delegation NS names
  * Get zone NS names

The non-empty set from the following methods consists of unique pairs of name
server name and its IP address (IPv4 or IPv6). The IP address can be left blank
(e.g. "ns1.example.xa/127.40.4.21", "ns1.example.xa/fda1:b2:c3::21" and
"ns1.example.xa" are valid):
  * Get delegation NS names and IP addresses
  * Get zone NS names and IP addresses

### Data defined for the scenarios

Both *Get delegation NS IP addresses* and *Get delegation NS names* can be
dirived from *Get delegation NS names and IP addresses*.

Both *Get zone NS IP addresses* and *Get zone NS names* can be direved from
*Get zone NS names and IP addresses*.

For the scenarios defined in this document the expected data is only defined for
the following three methods:
  * Get parent NS IP addresses
  * Get delegation NS names and IP addresses
  * Get zone NS names and IP addresses


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
A "happy path". Everything is fine. Child has both in-bailiwick and
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

## GOOD-4

### Zone specification
A "happy path". Everything is fine. Parent zone is hosted also on grandparent
server.

* Zone: child.parent.good-4.methodsv2.xa
  * Parent NS:
    * ns1.parent.good-4.methodsv2.xa
    * ns2.parent.good-4.methodsv2.xa
    * ns1.good-4.methodsv2.xa
  * Glue for parent:
    * Adress records (A and AAAA) for
      * ns1.parent.good-4.methodsv2.xa
      * ns2.parent.good-4.methodsv2.xa
      * ns1.good-4.methodsv2.xa (optional)

## GOOD-5

### Zone specification
A "happy path". Everything is fine. Child zone is hosted also on grandparent
server and parent server.

* Zone: child.parent.good-5.methodsv2.xa
  * Child NS:
    * ns1.child.parent.good-5.methodsv2.xa
    * ns2.child.parent.good-5.methodsv2.xa
    * ns1.good-5.methodsv2.xa
    * ns1.parent.good-5.methodsv2.xa
  * Glue:
    * Adress records (A and AAAA) for
      * ns1.child.parent.good-5.methodsv2.xa
      * ns2.child.parent.good-5.methodsv2.xa
      * ns1.parent.good-5.methodsv2.xa (optional)

## GOOD-6

### Zone specification
A "happy path". Everything is fine. Child zone is only hosted on grandparent
servers.

* Zone: child.parent.good-6.methodsv2.xa
  * Child NS:
    * ns1.good-6.methodsv2.xa
    * ns2.good-6.methodsv2.xa
  * No glue.

## GOOD-7

### Zone specification
A "happy path". Everything is fine. Child zone is only hosted on parent
servers.

* Zone: child.parent.good-7.methodsv2.xa
  * Child NS:
    * ns1.parent.good-7.methodsv2.xa
    * ns2.parent.good-7.methodsv2.xa
  * Glue:
    * Adress records (A and AAAA) for
      * ns1.parent.good-7.methodsv2.xa (optional)
      * ns2.parent.good-7.methodsv2.xa (optional)


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
      * ns1-2.child.parent.good-undel-1.methodsv2.xa/IPv4
      * ns1-2.child.parent.good-undel-1.methodsv2.xa/IPv6
      * ns3.parent.good-undel-1.methodsv2.xa/IPv4
      * ns3.parent.good-undel-1.methodsv2.xa/IPv6
      * ns6.good-undel-1.methodsv2.xa
  * There is an undelegated version of the zone matching undelegated data.
  * ns1-2 have different IP addresses for delegation and delegated zone, on one
    hand, and undelegated data and undelegated version of the zone, on the other.
  * ns3.parent.good-undel-1.methodsv2.xa is shared between delegated zone and
    undelegated version of zone, but holding the data of the undelegated version.

## GOOD-UNDEL-2

### Zone specification
A "happy path". Everything is fine. Child has boot in-bailiwick and
out-of-bailiwick name servers. Child is not delegated but is tested
undelegated.

* Zone: child.parent.good-undel-2.methodsv2.xa
  * No delegation from parent.
  * To be tested with undelegated data (fake data):
      * ns1.child.parent.good-undel-2.methodsv2.xa/IPv4
      * ns1.child.parent.good-undel-2.methodsv2.xa/IPv6
      * ns3.parent.good-undel-2.methodsv2.xa/IPv4
      * ns3.parent.good-undel-2.methodsv2.xa/IPv6
      * ns6.good-undel-2.methodsv2.xa
  * There is an undelegated version of the zone matching undelegated data.



\[Not complete. More scenarios and test zones to be defined.]




[RCODE Name]:                                                     https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[Test zone README file]:                                          ../../README.md
[Zone setup for test scenarios]:                                  #zone-setup-for-test-scenarios
[MethodsV2]:                                                      ../../tests/MethodsV2.md 
[Get parent NS IP addresses]:                                     ../../tests/MethodsV2.md#method-get-parent-ns-ip-addresses
[Implementation of test scenarios for MethodsV2]:                 https://github.com/matsduf/zonemaster/blob/master/test-zone-data/MethodsV2/README.md
