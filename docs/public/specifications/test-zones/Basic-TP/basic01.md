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


## All tags
The test case can output any of these message tags, but not necessarily in any combination.

* B01_CHILD_FOUND
* B01_CHILD_IS_ALIAS
* B01_INCONSISTENT_ALIAS
* B01_INCONSISTENT_DELEGATION
* B01_NO_CHILD
* B01_PARENT_DISREGARDED
* B01_PARENT_FOUND
* B01_PARENT_NOT_FOUND
* B01_PARENT_UNDETERMINED
* B01_ROOT_HAS_NO_PARENT
* B01_SERVER_ZONE_ERROR


## Test scenarios and message tags

If a message tag is not listed for the scenario, its presence or non-presence is
irrelevant to the test scenario and must be ignored.

Scenario name             | Mandatory message tag                                                             | Forbidden message tags
:-------------------------|:----------------------------------------------------------------------------------|:----------------------
GOOD-1                    | B01_CHILD_FOUND, B01_PARENT_FOUND                                                 | 2)
GOOD-MIXED-1              | B01_CHILD_FOUND, B01_PARENT_FOUND                                                 | 2)
GOOD-MIXED-2              | B01_CHILD_FOUND, B01_PARENT_FOUND                                                 | 2)
GOOD-PARENT-HOST-1        | B01_CHILD_FOUND, B01_PARENT_FOUND                                                 | 2)
GOOD-GRANDPARENT-HOST-1   | B01_CHILD_FOUND, B01_PARENT_FOUND                                                 | 2)
GOOD-UNDEL-1              | B01_CHILD_FOUND, B01_PARENT_DISREGARDED                                           | 2)
GOOD-MIXED-UNDEL-1        | B01_CHILD_FOUND, B01_PARENT_DISREGARDED                                           | 2)
GOOD-MIXED-UNDEL-2        | B01_CHILD_FOUND, B01_PARENT_DISREGARDED                                           | 2)
NO-DEL-UNDEL-1            | B01_CHILD_FOUND, B01_PARENT_DISREGARDED                                           | 2)
NO-DEL-MIXED-UNDEL-1      | B01_CHILD_FOUND, B01_PARENT_DISREGARDED                                           | 2)
NO-DEL-MIXED-UNDEL-2      | B01_CHILD_FOUND, B01_PARENT_DISREGARDED                                           | 2)
NO-CHILD-1                | B01_NO_CHILD, B01_PARENT_FOUND                                                    | 2)
NO-CHILD-2                | B01_NO_CHILD, B01_PARENT_FOUND                                                    | 2)
NO-CHLD-PAR-UNDETER-1     | B01_NO_CHILD, B01_PARENT_FOUND, B01_PARENT_UNDETERMINED                           | 2)
CHLD-FOUND-PAR-UNDET-1    | B01_CHILD_FOUND, B01_PARENT_FOUND, B01_PARENT_UNDETERMINED                        | 2)
CHLD-FOUND-INCONSIST-1    | B01_CHILD_FOUND, B01_INCONSISTENT_DELEGATION, B01_PARENT_FOUND                    | 2)
CHLD-FOUND-INCONSIST-2    | B01_CHILD_FOUND, B01_INCONSISTENT_DELEGATION, B01_PARENT_FOUND                    | 2)
CHLD-FOUND-INCONSIST-3    | B01_CHILD_FOUND, B01_INCONSISTENT_DELEGATION, B01_PARENT_FOUND                    | 2)
CHLD-FOUND-INCONSIST-4    | B01_CHILD_IS_ALIAS, B01_CHILD_FOUND, B01_INCONSISTENT_DELEGATION, B01_PARENT_FOUND| 2)
CHLD-FOUND-INCONSIST-5    | B01_CHILD_FOUND, B01_INCONSISTENT_DELEGATION, B01_PARENT_FOUND                    | 2)
CHLD-FOUND-INCONSIST-6    | B01_CHILD_FOUND, B01_INCONSISTENT_DELEGATION, B01_PARENT_FOUND                    | 2)
CHLD-FOUND-INCONSIST-7    | B01_CHILD_FOUND, B01_INCONSISTENT_DELEGATION, B01_PARENT_FOUND                    | 2)
CHLD-FOUND-INCONSIST-8    | B01_CHILD_FOUND, B01_INCONSISTENT_DELEGATION, B01_PARENT_FOUND                    | 2)
CHLD-FOUND-INCONSIST-9    | B01_CHILD_IS_ALIAS, B01_CHILD_FOUND, B01_INCONSISTENT_DELEGATION, B01_PARENT_FOUND| 2)
CHLD-FOUND-INCONSIST-10   | B01_CHILD_FOUND, B01_INCONSISTENT_DELEGATION, B01_PARENT_FOUND                    | 2)
NO-DEL-UNDEL-NO-PAR-1     | B01_CHILD_FOUND, B01_PARENT_DISREGARDED                                           | 2)
NO-DEL-UNDEL-PAR-UND-1    | B01_CHILD_FOUND, B01_PARENT_DISREGARDED                                           | 2)
NO-CHLD-NO-PAR-1          | B01_NO_CHILD, B01_PARENT_NOT_FOUND, B01_SERVER_ZONE_ERROR                         | 2)
CHILD-ALIAS-1             | B01_CHILD_IS_ALIAS, B01_NO_CHILD, B01_PARENT_FOUND                                | 2)
CHILD-ALIAS-2             | B01_CHILD_IS_ALIAS, B01_NO_CHILD, B01_INCONSISTENT_ALIAS, B01_PARENT_FOUND        | 2)
ZONE-ERR-GRANDPARENT-1    | B01_CHILD_FOUND, B01_PARENT_FOUND, B01_SERVER_ZONE_ERROR                          | 2)
ZONE-ERR-GRANDPARENT-2    | B01_CHILD_FOUND, B01_PARENT_FOUND, B01_SERVER_ZONE_ERROR                          | 2)
ZONE-ERR-GRANDPARENT-3    | B01_CHILD_FOUND, B01_PARENT_FOUND, B01_SERVER_ZONE_ERROR                          | 2)
ROOT-ZONE                 | B01_CHILD_FOUND, B01_ROOT_HAS_NO_PARENT                                           | 2)

* (1) All tags except for those specified as "Forbidden message tags" (no instances for these test scenarios)
* (2) All tags except for those specified as "Mandatory message tags"


## Zone setup for test scenarios

Assumptions for the scenario specifications unless otherwise specified for
the specific scenario:

* The child zone is `child.parent.SCENARIO.basic01.xa`.
  * It is delegated to two name servers, `ns1-delegated-child.basic01.xa`
    and `ns2-delegated-child.basic01.xa`.
    * The name server names have A and AAAA records to avoid non-relevant error
      messages.
    * There is no zone file or zone data for the child zone.
  * If there is an undelegated "version" of the child zone, it is
    referred to `ns3-undelegated-child.basic01.xa` and
    `ns4-undelegated-child.basic01.xa`.
    * The name server names have A and AAAA records to avoid non-relevant error
      messages.
    * There is no zone file or zone data for the undelegated "version".
* The parent zone is `parent.SCENARIO.basic01.xa`.
  * It is served by two in-bailiwick NS (ns1 and ns2).
  * ns1 and ns2 have the same zone content.
  * ns1 and ns2 have both IPv4 and IPv6 glue.
  * The records matching glue in the zone are complete.
  * The delegation from the grand parent has the same NS with complete glue.
* The grandparent zone is `SCENARIO.basic01.xa`.
  * It is served by two in-bailiwick NS (ns1 and ns2).
  * ns1 and ns2 have the same zone content.
  * ns1 and ns2 have both IPv4 and IPv6 glue.
  * The records matching glue in the zone are complete.
  * The delegation from the SCENARIO zone has the same NS with complete glue.
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
  * Grandparent zone `good-mixed-1.basic01.xa` is served on `ns1` and `ns4`.

### GOOD-MIXED-2
One parent server also hosts the child zone.

* Zone: child.parent.good-mixed-2.basic01.xa
  * Child zone is served by `ns1`, `ns2` and
    `ns4.parent.good-mixed-2.basic01.xa`.
  * Child zone exists.
  * There is a zone file for the child zone, and that is loaded on the child
    zone name servers.
  * Parent zone `parent.good-mixed-2.basic01.xa` is served by `ns1` and `ns4`.

### GOOD-PARENT-HOST-1
The child is hosted on parent servers only.

* Zone: child.parent.good-parent-host-1.basic01.xa
  * Child zone is served by `ns1.parent.good-parent-host-1.basic01.xa` and
    `ns2.parent.good-parent-host-1.basic01.xa`.
  * There is a zone file for the child zone.

### GOOD-GRANDPARENT-HOST-1
The child is hosted on grandparent servers only.

* Zone: child.parent.good-grandparent-host-1.basic01.xa
  * Child zone is served by `ns1.good-grandparent-host-1.basic01.xa` and
    `ns2.good-grandparent-host-1.basic01.xa`.
  * There is a zone file for the child zone.

### GOOD-UNDEL-1
The child zone is delegated, but there is also an undelegated version which is
the one tested.

* Zone: child.parent.good-undel-1.basic01.xa
  * Child zone is delegated, but there is also an undelegated version.
  * There are no zone files for child (delegated or undelegated).
  * Undelegated data:
    * ns3-undelegated-child.basic01.xa
    * ns4-undelegated-child.basic01.xa

### GOOD-MIXED-UNDEL-1
The child zone is delegated, but there is also an undelegated version which is
the one tested. One grandparent server, in the delegated tree, also serves
parent zone.

* Zone: child.parent.good-mixed-undel-1.basic01.xa
  * Parent zone `parent.good-mixed-undel-1.basic01.xa` is served by `ns1`, `ns2` and on
    `ns4.good-mixed-undel-1.basic01.xa`.
  * Grandparent zone `good-mixed-undel-1.basic01.xa` is served on `ns1` and `ns4`.
  * Child zone is delegated, but there is also an undelegated version.
  * No child zone exists.
  * Undelegated data:
    * ns3-undelegated-child.basic01.xa
    * ns4-undelegated-child.basic01.xa

### GOOD-MIXED-UNDEL-2
The child zone is delegated, but there is also an undelegated version. One parent
server also serves the delegated child zone.

* Zone: child.parent.good-mixed-undel-2.basic01.xa
  * Child zone is served by `ns1`, `ns2` and
    `ns6.parent.good-mixed-undel-2.basic01.xa`.
  * Child zone exists.
  * Parent zone `parent.good-mixed-undel-2.basic01.xa` is served by `ns1` and
    `ns6`.
  * Child zone is delegated, but there is also an undelegated version, but no
    zone for the undelegated version.
  * Undelegated data:
    * ns3-undelegated-child.basic01.xa
    * ns4-undelegated-child.basic01.xa

### NO-DEL-UNDEL-1
The child zone is not delegated, but there is an undelegated version.

* Zone: child.parent.no-del-undel-1.basic01.xa
  * Undelegated data:
    * ns3-undelegated-child.basic01.xa
    * ns4-undelegated-child.basic01.xa

### NO-DEL-MIXED-UNDEL-1
The child zone is not delegated, but there is an undelegated version that is
tested. One grandparent server also serves the parent zone.

* Zone: child.parent.no-del-mixed-undel-1.basic01.xa
  * Parent zone `parent.no-del-mixed-undel-1.basic01.xa` is served by `ns1`, `ns2` and on
    `ns4.no-del-mixed-undel-1.basic01.xa`.
  * Grandparent zone `no-del-mixed-undel-1.basic01.xa` is served on `ns1` and `ns4`.
  * Child zone is not delegated, but there is an undelegated version, but no zone file.
  * Undelegated data:
    * ns3-undelegated-child.basic01.xa
    * ns4-undelegated-child.basic01.xa

### NO-DEL-MIXED-UNDEL-2
The child zone is not delegated, but there is an undelegated version that is
tested. One grandparent server also serves the parent zone. There are extra empty
nodes between the zone cuts.

* Zone: child.w.x.parent.y.z.no-del-mixed-undel-2.basic01.xa
  * Parent zone `parent.y.z.no-del-mixed-undel-2.basic01.xa` is served by `ns1`,
    `ns2` and on `ns4.no-del-mixed-undel-2.basic01.xa`.
  * Grandparent zone `no-del-mixed-undel-2.basic01.xa` is served on `ns1` and `ns4`.
  * There are no zone cuts at `w`, `x`, `y` and `z`.
  * Child zone is not delegated, but there is also an undelegated version, but no
    zone file.
  * Undelegated data:
    * ns3-undelegated-child.basic01.xa
    * ns4-undelegated-child.basic01.xa

### NO-CHILD-1
The child zone is not delegated. Parent zone returns NXDOMAIN.

* Zone: child.parent.no-child-1.basic01.xa
  * Child zone does not exist and is not served by any NS.

### NO-CHILD-2
The child zone is not delegated. Parent zone returns NODATA.

* Zone: child.parent.no-child-2.basic01.xa
  * Child zone does not exist and is not served by any NS.
  * The name child.parent.no-child-2.basic01.xa exists as a TXT record.

### NO-CHLD-PAR-UNDETER-1
The child zone is not delegated. One grandparent NS lacks delegation of parent
and return NXDOMAIN of child. The parent zone lacks delegation of child.

* Zone: child.parent.no-chld-par-undeter-1.basic01.xa
  * Child zone does not exist is not served by any NS.
  * Grandparent `ns1` lacks delegation of parent.
  * Grandparent `ns2` has delegation of parent (to both parent NS).
  * Parent zone lacks delegation of child.

### CHLD-FOUND-PAR-UNDET-1
The child zone is delegated from one grandparent NS and from the parent zone.

* Zone: child.parent.chld-found-par-undet-1.basic01.xa
  * Grandparent `ns1` has delegation of child but lacks delegation of parent.
  * Grandparent `ns2` has delegation of parent (to both parent NS).
  * Parent zone has delegation of child.

### CHLD-FOUND-INCONSIST-1
The child is delegated from one parent NS. The other responds with NXDOMAIN.

* Zone: child.parent.chld-found-inconsist-1.basic01.xa
  * Parent `ns1` has normal delegation of child to two child NS, `ns1` and `ns2`.
  * Parent `ns2` lacks delegation of child (NXDOMAIN).

### CHLD-FOUND-INCONSIST-2
The child is delegated from one parent NS. On the other there is an CNAME
response.

* Zone: child.parent.chld-found-inconsist-2.basic01.xa
  * Parent `ns1` has normal delegation of child to two child NS, `ns1` and `ns2`.
  * Parent `ns2` lacks delegation of child, and has a CNAME on that name,
    pointing at `no-child.parent.chld-found-inconsist-2.basic01.xa`, which has
    two address records (A and AAAA) with the IP addresses of child `ns2`.

### CHLD-FOUND-INCONSIST-3
The child is delegated from one parent NS. On the other there is a CNAME
to another name, and that other name is delegated.

* Zone: child.parent.chld-found-inconsist-3.basic01.xa
  * Parent `ns1` has normal delegation of child to two child NS, `ns1` and `ns2`.
  * Parent `ns2` lacks delegation of child, and has a CNAME on the name,
    pointing at `sister.parent.chld-found-inconsist-3.basic01.xa`, which is
    delegated to `ns1-delegated-child.basic01.xa` and
    `ns2-delegated-child.basic01.xa`.
  * Zone `sister` does not exist.

### CHLD-FOUND-INCONSIST-4
The child is delegated from one parent NS. On the other there is a DNAME to
another name.

* Zone: child.parent.chld-found-inconsist-4.basic01.xa
  * Parent `ns1` has normal delegation of child to two child NS, `ns1` and `ns2`.
  * Parent `ns2` has a DNAME on `child` pointing at
    `sister.parent.chld-found-inconsist-4.basic01.xa` which is delegated to
    `ns1-delegated-child.basic01.xa` and `ns2-delegated-child.basic01.xa`.
  * Zone `sister` does not exist.

### CHLD-FOUND-INCONSIST-5
The child is delegated from one parent NS. On the other there is a NODATA
response.

* Zone: child.parent.chld-found-inconsist-5.basic01.xa
  * Parent `ns1` has normal delegation of child to two child NS, `ns1` and `ns2`.
  * Parent `ns2` lacks delegation of child, instead `child` has two address
    records (A and AAAA) with the IP addresses of child `ns2`.

### CHLD-FOUND-INCONSIST-6
The child is delegated from one parent NS, which is also NS for the child.
On the other there is an NXDOMAIN response.

* Zone: child.parent.chld-found-inconsist-6.basic01.xa
  * Parent `ns1` has normal delegation of child to the two child NS.
  * Parent `ns2` lacks delegation of child (NXDOMAIN).
  * Child shares `ns1.parent.chld-found-inconsist-6.basic01.xa` with parent.
  * Child also uses child `ns2`.
  * Child exists with a zone.

### CHLD-FOUND-INCONSIST-7
The child is delegated from one parent NS, which is also NS for the child. On the
other there is a CNAME response.

* Zone: child.parent.chld-found-inconsist-7.basic01.xa
  * Parent `ns1` has normal delegation of child to two child NS, `ns1` and `ns2`.
  * Parent `ns2` lacks delegation of child, and has a CNAME on that name,
    pointing at `no-child.parent.chld-found-inconsist-7.basic01.xa`, which has
    two address records (A and AAAA) with the IP addresses of child `ns2`.
  * Child shares `ns1.parent.chld-found-inconsist-7.basic01.xa` with parent.
  * Child also uses `ns2`.
  * Child exists with a zone.

### CHLD-FOUND-INCONSIST-8
The child is delegated from one parent NS, which is also NS for the child. On
the other there is a CNAME to another name, and that other name is delegated.

* Zone: child.parent.chld-found-inconsist-8.basic01.xa
  * Parent `ns1` has normal delegation of child to two child NS, `ns1` and `ns2`.
  * Parent `ns2` lacks delegation of child, and has a CNAME on the name,
    pointing at `sister.parent.chld-found-inconsist-8.basic01.xa`, which is
    `ns1-delegated-child.basic01.xa` and `ns2-delegated-child.basic01.xa`.
  * Zone `sister` does not exist.
  * Child shares `ns1.parent.chld-found-inconsist-8.basic01.xa` with parent.
  * Child also uses `ns2`.
  * Child exists with a zone.

### CHLD-FOUND-INCONSIST-9
The child is delegated from one parent NS, which is also NS for the child. On
the other there is a DNAME to another name.

* Zone: child.parent.chld-found-inconsist-9.basic01.xa
  * Parent `ns1` has normal delegation of child to two child NS, `ns1` and `ns2`.
  * Parent `ns2` has a DNAME on `child` pointing at
    `sister.parent.chld-found-inconsist-9.basic01.xa` which is delegated to
    `ns1-delegated-child.basic01.xa` and `ns2-delegated-child.basic01.xa`.
  * Zone `sister` does not exist.
  * Child shares `ns1.parent.chld-found-inconsist-9.basic01.xa` with parent.
  * Child also uses `ns2`.
  * Child exists with a zone.

### CHLD-FOUND-INCONSIST-10
The child is delegated from one parent NS, which is also NS for the child. On the
other there is a NODATA response.

* Zone: child.parent.chld-found-inconsist-10.basic01.xa
  * Parent `ns1` has normal delegation of child to two child NS, `ns1` and `ns2`.
  * Parent `ns2` lacks delegation of child, instead `child` has two address
    records (A and AAAA) with the IP addresses of child `ns2`.
  * Child shares `ns1.parent.chld-found-inconsist-10.basic01.xa` with parent.
  * Child also uses `ns2`.
  * Child exists with a zone.

### NO-DEL-UNDEL-NO-PAR-1
The child is not delegated, but there is undelegated data to test. Both
grandparent NS return SERVFAIL.

* Zone: child.parent.no-del-undel-no-par-1.basic01.xa
  * Grandparent `ns1` and `ns2` both return SERVFAIL.
  * No need of parent zone.
  * Child zone is not delegated, but there is an undelegated version.
  * Undelgated data:
    * ns3-undelegated-child.basic01.xa
    * ns4-undelegated-child.basic01.xa

### NO-DEL-UNDEL-PAR-UND-1
The child is not delegated, but there is an undelegated data to test. One
grandparent NS lacks delegation of parent and return NXDOMAIN of child. The
parent zone lacks delegation of child.

* Zone: child.parent.no-del-undel-par-und-1.basic01.xa
  * Child zone does not exist is not served by any NS.
  * Grandparent `ns1` lacks delegation of parent.
  * Grandparent `ns2` has delegation of parent (to both parent NS).
  * Parent zone lacks delegation of child.
  * Child zone is not delegated, but there is an undelegated version.
  * Undelegated data:
    * ns3-undelegated-child.basic01.xa
    * ns4-undelegated-child.basic01.xa

### NO-CHLD-NO-PAR-1
The child is not delegated. Both grandparent NS return SERVFAIL.

* Zone: child.parent.no-chld-no-par-1.basic01.xa
  * Grandparent `ns1` and `ns2` both return SERVFAIL.
  * No need of parent zone.
  * Child zone is not delegated, and there is no undelegated data.
  * No need of child zone.

### CHILD-ALIAS-1
The child zone does not exist, instead there is a DNAME in the parent zone.

* Zone: child.parent.child-alias-1.basic01.xa
  * Parent has a DNAME on `child` pointing at
    `sister.parent.child-alias-1.basic01.xa` which is delegated to
    `ns1-delegated-child.basic01.xa` and `ns2-delegated-child.basic01.xa`.
  * Zone `sister` does not exist.

### CHILD-ALIAS-2
The child zone does not exist, instead there is a DNAME in the parent zone,
however, different DNAME targets in the two parents.

* Zone: child.parent.child-alias-2.basic01.xa
  * On `ns1` parent has a DNAME on `child` pointing at
    `sister.parent.child-alias-2.basic01.xa` which is delegated to
    `ns1-delegated-child.basic01.xa` and `ns2-delegated-child.basic01.xa`.
  * Zone `sister` does not exist.
  * On `ns2` parent has a DNAME on `child` pointing at
    `brother.parent.child-alias-2.basic01.xa` which is delegated to
    `ns1-delegated-child.basic01.xa` and `ns2-delegated-child.basic01.xa`.
  * Zone `brother` does not exist.

### ZONE-ERR-GRANDPARENT-1
Grandparent `ns2` responds with AA bit unset on queries for grandparent zone.

* Zone: child.parent.zone-err-grandparent-1.basic01.xa
  * Normal response on grandparent `ns1`.
  * Grandparent `ns2` responds with AA bit unset on queries for the
    grandparent zone.

### ZONE-ERR-GRANDPARENT-2
Grandparent `ns2` responds with NODATA on NS query for grandparent zone.

* Zone: child.parent.zone-err-grandparent-2.basic01.xa
  * Normal response on grandparent `ns1`.
  * Grandparent `ns2` responds with NODATA on NS query for the
    grandparent zone.

### ZONE-ERR-GRANDPARENT-3
Grandparent `ns2` responds with wrong owner name on NS
on query for grandparent zone NS.

* Zone: child.parent.zone-err-grandparent-3.basic01.xa
  * Normal response on grandparent `ns1`.
  * Grandparent `ns2` responds with other owner name on NS query for
    `zone-err-grandparent-3.basic01.xa`:
      * Owner name `oncle.zone-err-grandparent-3.basic01.xa` instead.

### ROOT-ZONE
Test on the standard root zone.

* Zone: .
  * No special zone files are to be created.



[Basic01]:                                                        ../../tests/Basic-TP/basic01.md
[RCODE Name]:                                                     https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[Test zone README file]:                                          ../README.md
[Zone setup for test scenarios]:                                  #zone-setup-for-test-scenarios

