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
A "happy path". Everything is fine.

* Zone: child.parent.good-1.methodsv2.xa
  * Just defaults

## GOOD-2
A "happy path". Everything is fine. Child has out-of-bailiwick name servers
only.

* Zone: child.parent.good-2.methodsv2.xa
  * Child NS are out-of-bailiwick:
    * ns5.good-2.methodsv2.xa
    * ns6.good-2.methodsv2.xa
  * No glue

## GOOD-3
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
A "happy path". Everything is fine. Child zone is only hosted on grandparent
servers.

* Zone: child.parent.good-6.methodsv2.xa
  * Child NS:
    * ns1.good-6.methodsv2.xa
    * ns2.good-6.methodsv2.xa
  * No glue.

## GOOD-7
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
  * `ns1-2` have different IP addresses for delegation and delegated zone, on one
    hand, and undelegated data and undelegated version of the zone, on the other.
  * `ns3.parent.good-undel-1.methodsv2.xa`  is shared between delegated zone and
    undelegated version of zone, but holding the data of the undelegated version.

## GOOD-UNDEL-2
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

## DIFF-NS-1
No match in name server names between delegation and zone. Same name server IP.

* Zone: child.parent.diff-ns-1.methodsv2.xa
  * Delegation to ns1 and ns2.
  * NS in zone ns1-2 and ns2-2.
  * ns1-2 and ns2-2 in zone, ns1 and ns2 not in zone.
  
## DIFF-NS-2
No match in name server names. Same name server IP on one server. Different
on the other. No zone on all servers from delegation.

* Zone: child.parent.diff-ns-2.methodsv2.xa
  * Delegation to ns1a, ns2 and ns3.
  * NS in zone ns1b, ns4 and ns5.
  * ns1b, ns4 and ns5 in zone, ns1a, ns2 and ns3 not in zone.
  * No zone on ns2 and ns3.
  * ns1a and ns1b have the same IP.

## IB-NOT-IN-ZONE-1
Delegation ti in-bailiwick NS, but the names are not defined in the zone.

* Zone: child.parent.ib-not-in-zone-1.methodsv2.xa
  * ns1 and ns2 not defined in zone.
  
## CHILD-NO-ZONE-1
* Zone: child.parent.child-no-zone-1.methodsv2.xa
  * No child zone on ns1 and ns2.

## CHILD-NO-ZONE-2
* Zone: child.parent.child-no-zone-1.methodsv2.xa
  * Delegated to `ns6-delegated-child.methodsv2.xa` and
    `ns7-delegated-child.methodsv2.xa` which do not respond.


### GOOD-MIXED-UNDEL-1
The child zone is delegated, but there is also an undelegated version which is
the one tested. One grandparent server, in the delegated tree, also serves
parent zone.

* Zone: child.parent.good-mixed-undel-1.methodsv2.xa
  * Parent zone `parent.good-mixed-undel-1.methodsv2.xa` is served by `ns1`, `ns2` and on
    `ns4.good-mixed-undel-1.methodsv2.xa`.
  * Grandparent zone `good-mixed-undel-1.methodsv2.xa` is served on `ns1` adn `ns4`.
  * Child zone is delegated, but there is also an undelegated version.
  * Undelgated data:
    * ns3.child.parent.good-mixed-undel-1.methodsv2.xa
    * ns4.child.parent.good-mixed-undel-1.methodsv2.xa

##

### GOOD-MIXED-UNDEL-2
The child zone is delegated, but there is also an undelegated version. One parent
server also serves the delegated child zone.

* Zone: child.parent.good-mixed-undel-2.methodsv2.xa
  * Child zone is served by `ns1`, `ns2` and
    `ns6.parent.good-mixed-undel-2.methodsv2.xa`.
  * Child zone exists.
  * Parent zone `parent.good-mixed-undel-2.methodsv2.xa` is served by `ns1` and
    `ns6`.
  * Child zone is delegated, but there is also an undelegated version, but no
    zone for the undelegated version.
  * Undelgated data:
    * ns3-undelegated-child.methodsv2.xa
    * ns4-undelegated-child.methodsv2.xa

### NO-DEL-MIXED-UNDEL-1
The child zone is not delegated, but there is an undelegated version that is
tested. One grandparent server also serves the parent zone.

* Zone: child.parent.no-del-mixed-undel-1.methodsv2.xa
  * Parent zone `parent.no-del-mixed-undel-1.methodsv2.xa` is served by `ns1`, `ns2` and on
    `ns4.no-del-mixed-undel-1.methodsv2.xa`.
  * Grandparent zone `no-del-mixed-undel-1.methodsv2.xa` is served on `ns1` adn `ns4`.
  * Child zone is not delegated, but there is an undelegated version, but no zone file.
  * Undelgated data:
    * ns3-undelegated-child.methodsv2.xa
    * ns4-undelegated-child.methodsv2.xa

### NO-DEL-MIXED-UNDEL-2
The child zone is not delegated, but there is an undelegated version that is
tested. One grandparent server also serves the parent zone. There are extra empty
nodes between the zone cuts.

* Zone: child.w.x.parent.y.z.no-del-mixed-undel-2.methodsv2.xa
  * Parent zone `parent.y.z.no-del-mixed-undel-2.methodsv2.xa` is served by `ns1`,
    `ns2` and on `ns4.no-del-mixed-undel-2.methodsv2.xa`.
  * Grandparent zone `no-del-mixed-undel-2.methodsv2.xa` is served on `ns1` adn `ns4`.
  * There are no zone cuts at `w`, `x`, `y` and `z`.
  * Child zone is not delegated, but there is also an undelegated version, but no
    zone file.
  * Undelgated data:
    * ns3-undelegated-child.methodsv2.xa
    * ns4-undelegated-child.methodsv2.xa

### NO-CHILD-1
The child zone is not delegated. Parent zone returns NXDOMAIN.

* Zone: child.parent.no-child-1.methodsv2.xa
  * Child zone does not exist is not served by any NS.

### NO-CHILD-2
The child zone is not delegated. Parent zone returns NODATA.

* Zone: child.parent.no-child-2.methodsv2.xa
  * Child zone does not exist is not served by any NS.
  * The name child.parent.no-child-2.methodsv2.xa exists as a TXT record.

### NO-CHLD-PAR-UNDETER-1
The child zone is not delegated. One grandparent NS lacks delegation of parent
and return NXDOMAIN of child. The parent zone lacks delegation of child.

* Zone: child.parent.no-chld-par-undeter-1.methodsv2.xa
  * Child zone does not exist is not served by any NS.
  * Grandparent `ns1` lacks delegation of parent.
  * Grandparent `ns2` has delegation of parent (to both parent NS).
  * Parent zone lacks delegation of child.

### CHLD-FOUND-PAR-UNDET-1
The child zone is delegated from one grandparent NS and from the parent zone.

* Zone: child.parent.chld-found-par-undet-1.methodsv2.xa
  * Grandparent `ns1` has delegation of child but lacks delegation of parent.
  * Grandparent `ns2` has delegation of parent (to both parent NS).
  * Parent zone has delegation of child.

### CHLD-FOUND-INCONSIST-1
The child is delegated from one parent NS. On the other there is an NXDOMAIN
response.

* Zone: child.parent.chld-found-inconsist-1.methodsv2.xa
  * Parent `ns1` has normal delegation of child to two child NS, `ns1` and `ns2`.
  * Parent `ns2` lacks delegation of child (NXDOMAIN).

### CHLD-FOUND-INCONSIST-2
The child is delegated from one parent NS. On the other there is an CNAME
response.

* Zone: child.parent.chld-found-inconsist-2.methodsv2.xa
  * Parent `ns1` has normal delegation of child to two child NS, `ns1` and `ns2`.
  * Parent `ns2` lacks delegation of child, and has a CNAME on that name,
    pointing at `no-child.parent.chld-found-inconsist-2.methodsv2.xa`, which has
    two address records (A and AAAA) with the IP addresses of child `ns2`.

### CHLD-FOUND-INCONSIST-3
The child is delegated from one parent NS. On the other there is a CNAME
to another name, and that other name is delegated.

* Zone: child.parent.chld-found-inconsist-3.methodsv2.xa
  * Parent `ns1` has normal delegation of child to two child NS, `ns1` and `ns2`.
  * Parent `ns2` lacks delegation of child, and has a CNAME on the name,
    pointing at `sister.parent.chld-found-inconsist-3.methodsv2.xa`, which is
    delegated to `ns1-delegated-child.methodsv2.xa` and
    `ns2-delegated-child.methodsv2.xa`.
  * Zone `sister` does not exist.

### CHLD-FOUND-INCONSIST-4
The child is delegated from one parent NS. On the other there is a DNAME to
another name.

* Zone: child.parent.chld-found-inconsist-4.methodsv2.xa
  * Parent `ns1` has normal delegation of child to two child NS, `ns1` and `ns2`.
  * Parent `ns2` has a DNAME on `child` pointing at
    `sister.parent.chld-found-inconsist-4.methodsv2.xa` which is delegated to
    `ns1-delegated-child.methodsv2.xa` and `ns2-delegated-child.methodsv2.xa`.
  * Zone `sister` does not exist.

### CHLD-FOUND-INCONSIST-5
The child is delegated from one parent NS. On the other there is a NODATA
response.

* Zone: child.parent.chld-found-inconsist-5.methodsv2.xa
  * Parent `ns1` has normal delegation of child to two child NS, `ns1` and `ns2`.
  * Parent `ns2` lacks delegation of child, instead `child` has two address
    records (A and AAAA) with the IP addresses of child `ns2`.

### CHLD-FOUND-INCONSIST-6
The child is delegated from one parent NS, which is also NS for the child.
On the other there is an NXDOMAIN response.

* Zone: child.parent.chld-found-inconsist-6.methodsv2.xa
  * Parent `ns1` has normal delegation of child to the two child NS.
  * Parent `ns2` lacks delegation of child (NXDOMAIN).
  * Child shares `ns1.parent.chld-found-inconsist-6.methodsv2.xa` with parent.
  * Child also uses child `ns2`.
  * Child exists with a zone.

### CHLD-FOUND-INCONSIST-7
The child is delegated from one parent NS, which is also NS for the child. On the
other there is an CNAME response.

* Zone: child.parent.chld-found-inconsist-7.methodsv2.xa
  * Parent `ns1` has normal delegation of child to two child NS, `ns1` and `ns2`.
  * Parent `ns2` lacks delegation of child, and has a CNAME on that name,
    pointing at `no-child.parent.chld-found-inconsist-7.methodsv2.xa`, which has
    two address records (A and AAAA) with the IP addresses of child `ns2`.
  * Child shares `ns1.parent.chld-found-inconsist-7.methodsv2.xa` with parent.
  * Child also uses `ns2`.
  * Child exists with a zone.

### CHLD-FOUND-INCONSIST-8
The child is delegated from one parent NS, which is also NS for the child. On
the other there is a CNAME to another name, and that other name is delegated.

* Zone: child.parent.chld-found-inconsist-8.methodsv2.xa
  * Parent `ns1` has normal delegation of child to two child NS, `ns1` and `ns2`.
  * Parent `ns2` lacks delegation of child, and has a CNAME on the name,
    pointing at `sister.parent.chld-found-inconsist-8.methodsv2.xa`, which is
    `ns1-delegated-child.methodsv2.xa` and `ns2-delegated-child.methodsv2.xa`.
  * Zone `sister` does not exist.
  * Child shares `ns1.parent.chld-found-inconsist-8.methodsv2.xa` with parent.
  * Child also uses `ns2`.
  * Child exists with a zone.

### CHLD-FOUND-INCONSIST-9
The child is delegated from one parent NS, which is also NS for the child. On
the other there is a DNAME to another name.

* Zone: child.parent.chld-found-inconsist-9.methodsv2.xa
  * Parent `ns1` has normal delegation of child to two child NS, `ns1` and `ns2`.
  * Parent `ns2` has a DNAME on `child` pointing at
    `sister.parent.chld-found-inconsist-9.methodsv2.xa` which is delegated to
    `ns1-delegated-child.methodsv2.xa` and `ns2-delegated-child.methodsv2.xa`.
  * Zone `sister` does not exist.
  * Child shares `ns1.parent.chld-found-inconsist-9.methodsv2.xa` with parent.
  * Child also uses `ns2`.
  * Child exists with a zone.

### CHLD-FOUND-INCONSIST-10
The child is delegated from one parent NS, which is also NS for the child. On the
other there is a NODATA response.

* Zone: child.parent.chld-found-inconsist-10.methodsv2.xa
  * Parent `ns1` has normal delegation of child to two child NS, `ns1` and `ns2`.
  * Parent `ns2` lacks delegation of child, instead `child` has two address
    records (A and AAAA) with the IP addresses of child `ns2`.
  * Child shares `ns1.parent.chld-found-inconsist-10.methodsv2.xa` with parent.
  * Child also uses `ns2`.
  * Child exists with a zone.

### NO-DEL-UNDEL-NO-PAR-1
The child is not delegated, but there is undelegated data to test. Both
grandparent NS return SERVFAIL.

* Zone: child.parent.no-del-undel-no-par-1.methodsv2.xa
  * Grandparent `ns1` and `ns2` both return SERVFAIL.
  * No need of parent zone.
  * Child zone is not delegated, but there is an undelegated version.
  * Undelgated data:
    * ns3-undelegated-child.methodsv2.xa
    * ns4-undelegated-child.methodsv2.xa

### NO-DEL-UNDEL-PAR-UND-1
The child is not delegated, but there is an undelegated data to test. One
grandparent NS lacks delegation of parent and return NXDOMAIN of child. The
parent zone lacks delegation of child.

* Zone: child.parent.no-del-undel-par-und-1.methodsv2.xa
  * Child zone does not exist is not served by any NS.
  * Grandparent `ns1` lacks delegation of parent.
  * Grandparent `ns2` has delegation of parent (to both parent NS).
  * Parent zone lacks delegation of child.
  * Child zone is not delegated, but there is an undelegated version.
  * Undelgated data:
    * ns3-undelegated-child.methodsv2.xa
    * ns4-undelegated-child.methodsv2.xa

### NO-CHLD-NO-PAR-1
The child is not delegated. Both grandparent NS return SERVFAIL.

* Zone: child.parent.no-chld-no-par-1.methodsv2.xa
  * Grandparent `ns1` and `ns2` both return SERVFAIL.
  * No need of parent zone.
  * Child zone is not delegated, and there is no undelegated data.
  * No need of child zone.

### CHILD-ALIAS-1
The child zone does not exist, instead there is a DNAME in the parent zone.

* Zone: child.parent.child-alias-1.methodsv2.xa
  * Parent has a DNAME on `child` pointing at
    `sister.parent.child-alias-1.methodsv2.xa` which is delegated to
    `ns1-delegated-child.methodsv2.xa` and `ns2-delegated-child.methodsv2.xa`.
  * Zone `sister` does not exist.

### CHILD-ALIAS-2
The child zone does not exist, instead there is a DNAME in the parent zone,
however, different DNAME targets in the two parents.

* Zone: child.parent.child-alias-2.methodsv2.xa
  * On `ns1` parent has a DNAME on `child` pointing at
    `sister.parent.child-alias-2.methodsv2.xa` which is delegated to
    `ns1-delegated-child.methodsv2.xa` and `ns2-delegated-child.methodsv2.xa`.
  * Zone `sister` does not exist.
  * On `ns2` parent has a DNAME on `child` pointing at
    `brother.parent.child-alias-2.methodsv2.xa` which is delegated to
    `ns1-delegated-child.methodsv2.xa` and `ns2-delegated-child.methodsv2.xa`.
  * Zone `brother` does not exist.

### ZONE-ERR-GRANDPARENT-1
Grandparent `ns2` responds with AA bit unset on queries for granparent zone.

* Zone: child.parent.zone-err-grandparent-1.methodsv2.xa
  * Normal response on granparent `ns1`.
  * Grandparent `ns2` responds with AA bit unset on queries for the
    grandparent zone.

### ZONE-ERR-GRANDPARENT-2
Grandparent `ns2` responds with NODATA on NS query for granparent zone.

* Zone: child.parent.zone-err-grandparent-2.methodsv2.xa
  * Normal response on granparent `ns1`.
  * Grandparent `ns2` responds with NODATA on NS query for the
    grandparent zone.

### ZONE-ERR-GRANDPARENT-3
Grandparent `ns2` responds with wrong owner name on NS
on query for grandparent zone NS.

* Zone: child.parent.zone-err-grandparent-3.methodsv2.xa
  * Normal response on grandparent `ns1`.
  * Grandparent `ns2` responds with other owner name on NS query for
    `zone-err-grandparent-3.methodsv2.xa`:
      * Owner name `oncle.zone-err-grandparent-3.methodsv2.xa` instead.















  

\[Not complete. More scenarios and test zones to be defined.]




[RCODE Name]:                                                     https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[Test zone README file]:                                          ../../README.md
[Zone setup for test scenarios]:                                  #zone-setup-for-test-scenarios
[MethodsV2]:                                                      ../../tests/MethodsV2.md 
[Get parent NS IP addresses]:                                     ../../tests/MethodsV2.md#method-get-parent-ns-ip-addresses
[Implementation of test scenarios for MethodsV2]:                 https://github.com/matsduf/zonemaster/blob/master/test-zone-data/MethodsV2/README.md
