# Specification of Test Scenarios for CONSISTENCY05


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

The term "in-bailiwick" has been replaced with "in-domain" in this version of the
document. That is to match an update of the Consistency05 specification
([Consistency05]) and more details and the definition of the new term "in-domain"
can be found there. The previous term "out-of-bailiwick" has been replaced by the
term "out-of-domain" and was used as the negation of "in-bailiwick".


## Test Case
This document specifies defined test zones for test case [Consistency05].


## Test scenarios

The purpose of the test scenarios is to cover all reasonable contexts where
different message tags are outputted when [Consistency05] is run on a test zone.
The message tags are defined in the test case ([Consistency05]) and the scenarios
are defined below.

The test scenarios are structured as stated in the [test scenario README file].

## Test zone names

The test zone for each test scenario in this document is a subdomain delegated
from the base name (`consistency05.xa`) and that subdomain having the same name
as the scenario. For some scenarios the test zone is a child zone to that zone.
The names of those zones are given in section "[Zone setup for test scenarios]"
below.


## All message tags
The test case can output any of these message tags, but not necessarily in any
combination. See [Consistency05] for the specification of the tags.

* CS05_CHILD_ZONE_LAME
* CS05_DELEGATION
* CS05_EXTRA_ADDR_CHILD
* CS05_ID_ADDR_MISMATCH
* CS05_ID_ADDR_MISSING
* CS05_INCONSISTENT_DELEGATION
* CS05_MISSING_GLUE_FOR_NS
* CS05_MISSING_GLUE_FOR_NS_UNDEL
* CS05_NO_MISMATCH_GLUE_ZONE
* CS05_NO_NS_ADDR_CHILD
* CS05_OOD_ADDR_MISMATCH

## Test scenarios and message tags

If a message tag is not listed for the scenario, its presence or non-presence is
irrelevant to the test scenario and must be ignored.

| Scenario name             | Mandatory message tag                           | Forbidden message tags |
|:--------------------------|:------------------------------------------------|:-----------------------|
| ADDR-MATCH-DEL-UNDEL-1    | CS05_NO_MISMATCH_GLUE_ZONE                      | 2)                     |
| ADDR-MATCH-DEL-UNDEL-2    | CS05_NO_MISMATCH_GLUE_ZONE                      | 2)                     |
| ADDR-MATCH-NO-DEL-UNDEL-1 | CS05_NO_MISMATCH_GLUE_ZONE                      | 2)                     |
| ADDR-MATCH-NO-DEL-UNDEL-2 | CS05_NO_MISMATCH_GLUE_ZONE                      | 2)                     |
| ADDRESSES-MATCH-1         | CS05_NO_MISMATCH_GLUE_ZONE                      | 2)                     |
| ADDRESSES-MATCH-2         | CS05_NO_MISMATCH_GLUE_ZONE                      | 2)                     |
| ADDRESSES-MATCH-3         | CS05_NO_MISMATCH_GLUE_ZONE                      | 2)                     |
| ADDRESSES-MATCH-4         | CS05_NO_MISMATCH_GLUE_ZONE                      | 2)                     |
| ADDRESSES-MATCH-5         | CS05_NO_MISMATCH_GLUE_ZONE                      | 2)                     |
| ADDRESSES-MATCH-6         | CS05_NO_MISMATCH_GLUE_ZONE                      | 2)                     |
| ADDRESSES-MATCH-7         | CS05_NO_MISMATCH_GLUE_ZONE                      | 2)                     |
| ADDRESSES-MATCH-8         | CS05_NO_MISMATCH_GLUE_ZONE                      | 2)                     |
| ADDRESSES-MATCH-9         | CS05_NO_MISMATCH_GLUE_ZONE                      | 2)                     |
| CHILD-ZONE-LAME-1         | CS05_CHILD_ZONE_LAME                            | 2)                     |
| CHILD-ZONE-LAME-2         | CS05_CHILD_ZONE_LAME                            | 2)                     |
| CHILD-ZONE-LAME-3         | CS05_CHILD_ZONE_LAME                            | 2)                     |
| EXTRA-ADDRESS-CHILD       | CS05_EXTRA_ADDR_CHILD                           | 2)                     |
| ID-ADDR-MISMATCH-1        | CS05_ID_ADDR_MISMATCH                           | 2)                     |
| ID-ADDR-MISMATCH-2        | CS05_ID_ADDR_MISMATCH                           | 2)                     |
| ID-ADDR-MISMATCH-3        | CS05_ID_ADDR_MISMATCH                           | 2)                     |
| ID-ADDR-MISSING-1         | CS05_ID_ADDR_MISSING                            | 2)                     |
| INCONSISTENT-DELEGATION-1 | CS05_INCONSISTENT_DELEGATION, CS05_DELEGATION   | 2)                     |
| INCONSISTENT-DELEGATION-2 | CS05_INCONSISTENT_DELEGATION, CS05_DELEGATION   | 2)                     |
| MISSING-GLUE-FOR-NS-1     | CS05_MISSING_GLUE_FOR_NS                        | 2)                     |
| MISSING-GLUE-FOR-NS-2     | CS05_MISSING_GLUE_FOR_NS_UNDEL                  | 2)                     |
| NO-NS-ADDR-CHILD-1        | CS05_NO_NS_ADDR_CHILD, CS05_MISSING_GLUE_FOR_NS | 2)                     |
| NO-NS-ADDR-CHILD-2        | CS05_NO_NS_ADDR_CHILD                           | 2)                     |
| OOD-ADDR-MISMATCH         | CS05_OOD_ADDR_MISMATCH                          | 2)                     |
| ROOT-MATCH-1              | CS05_NO_MISMATCH_GLUE_ZONE                      | 2)                     |
| ROOT-MISSING-GLUE-UNDEL-1 | CS05_MISSING_GLUE_FOR_NS_UNDEL                  | 2)                     |
| Z-ROOT-MATCH-1            | CS05_NO_MISMATCH_GLUE_ZONE                      | 2)                     |
| Z-ROOT-INCOMPLETE-HINT    | CS05_MISSING_GLUE_FOR_NS                        | 2)                     |


## Zone setup for test scenarios

Assumptions for the scenario specifications unless otherwise specified for
the specific scenario:
* For each scenario zone there are two name servers configured.
  * Both NS (ns1 and ns2) are equal in delegation and in zone.
  * Both NS are in-domain
  * Both NS have both IPv4 and IPv6 addresses
  * All required glue are present in the delegation.
  * All glue exactly matches the authoritative address records in correct
    zone (not more and not less records).
  * All NS IP addresses respond with identical zone content.
* Responds with an A record for the zone on query for A.
* Responds with a AAAA record for the zone on query for AAAA.
* All responses are authoritative with [RCODE Name] "NoError"
* EDNS, version 0, is included in all responses on queries with EDNS.
* EDNS is not included in responses on queries without EDNS.
* In undelegated data, `IPv4` and `IPv6`, respectively, are placeholders for the
  actual IP addresses used for the scenario. They are to be found where the data
  is specified.
  * If no placeholder is given with the name server name, then no IP address is
    given and might be looked up.
  * The format for undelegated data follow the format used for `zonemaster-cli`
    (after `--ns`).

### ADDR-MATCH-DEL-UNDEL-1
Also the "happy path". But there is an undelegated zone to be tested.

* Zone: addr-match-del-undel-1.consistency05.xa
  * Delegated zone on ns1 and ns2.
  * Undelegated zone on ns3 and ns4.
  * Delegated zone has neither ns1, ns2, ns3 nor ns4 as address records.
  * Undelegated zone has neither ns1 nor ns2 as an address record, but it
    has both ns3 and ns4 as address records.
  * Undelegated data:
    * ns3.addr-match-del-undel-1.consistency05.xa/IPv4
    * ns3.addr-match-del-undel-1.consistency05.xa/IPv6
    * ns4.addr-match-del-undel-1.consistency05.xa/IPv4
    * ns4.addr-match-del-undel-1.consistency05.xa/IPv6

### ADDR-MATCH-DEL-UNDEL-2
Also the "happy path". But there is an undelegated zone to be tested, and its
NS are out-of-domain.

* Zone: addr-match-del-undel-2.consistency05.xa
  * Delegated zone on ns1 and ns2.
  * Undelegated zone on "ns3.addr-match-del-undel-2.consistency05.xb" and
    "ns4.addr-match-del-undel-2.consistency05.xb".
  * Delegated and undelegated zone, respectively, do not have neither ns1 nor ns2
    as an address record.
  * Undelegated data:
    * ns3.addr-match-del-undel-2.consistency05.xb
    * ns4.addr-match-del-undel-2.consistency05.xb

### ADDR-MATCH-NO-DEL-UNDEL-1
Also the "happy path". No delegation but there is an undelegated zone to be
tested.

* Zone: addr-match-no-del-undel-1.consistency05.xa
  * No delegated zone.
  * Undelegated zone on ns1 and ns2.
  * Undelegated data:
    * ns1.addr-match-no-del-undel-1.consistency05.xa/IPv4
    * ns1.addr-match-no-del-undel-1.consistency05.xa/IPv6
    * ns2.addr-match-no-del-undel-1.consistency05.xa/IPv4
    * ns2.addr-match-no-del-undel-1.consistency05.xa/IPv6

### ADDR-MATCH-NO-DEL-UNDEL-2
Also the "happy path". No delegation but there is an undelegated zone to be
tested. NS are out-of-domain.

* Zone: addr-match-no-del-undel-2.consistency05.xa
  * No delegated zone.
  * Undelegated zone on "ns3.addr-match-no-del-undel-2.consistency05.xb" and
    "ns4.addr-match-no-del-undel-2.consistency05.xb".
  * Undelegated data:
    * ns3.addr-match-no-del-undel-2.consistency05.xb
    * ns4.addr-match-no-del-undel-2.consistency05.xb

### ADDRESSES-MATCH-1
The "happy path". Everything is fine.

* Zone: addresses-match-1.consistency05.xa

### ADDRESSES-MATCH-2
Also the "happy path". Out-of-domain NS this time. And no glue.

* Zone: addresses-match-2.consistency05.xa
  * Both ns3 and ns4 are out-of-domain under the xb tree.
  * ns3 is "ns3.addresses-match-2.consistency05.xb"
  * ns4 is "ns4.addresses-match-2.consistency05.xb"
  * Delegation is without glue.
  * The zone has no address records for the NS names
  * The "consistency05.xb" zone has a full set of the address records for ns3
    and ns4.

### ADDRESSES-MATCH-3
One NS does not give AA answer, but else fine.

* Zone: addresses-match-3.consistency05.xa
  * ns1 responds with AA flag unset.

### ADDRESSES-MATCH-4
One NS does give SERVFAIL response, but else fine.

* Zone: addresses-match-4.consistency05.xa
  * ns1 responds with [RCODE Name] "ServFail".

### ADDRESSES-MATCH-5
One NS does not respond, but else fine.

* Zone: addresses-match-5.consistency05.xa
  * ns1 gives no response at all.

### ADDRESSES-MATCH-6
Also "happy path". Out-of-domain NS, but with glue.

* Zone: child.addresses-match-6.consistency05.xa
  * Both ns1 and ns2 are out-of-domain
  * ns1 is "ns1.sibbling.addresses-match-6.consistency05.xa"
  * ns2 is "ns2.sibbling.addresses-match-6.consistency05.xa"
  * Delegation is with glue.
  * The test zone ("child") has no address records for the NS names, but the
    "sibbling" zone has full set of address records.

### ADDRESSES-MATCH-7
Also "happy path". NS in subdomain.

* Zone: addresses-match-7.consistency05.xa
  * ns1 is "ns1.subdomain.addresses-match-7.consistency05.xa."
  * ns2 is "ns2.subdomain.addresses-match-7.consistency05.xa."
  * Delegation is with glue.
  * "subdomain.addresses-match-7.consistency05.xa" is delegated to the same
    ns1 and ns2.
  * ns1 and ns2 are defined with address records in the "subdomain" zone.

### ADDRESSES-MATCH-8
It is much like ADDRESSES-MATCH-2, a "happy path". All NS are out-of-domain.
The child is a few steps below and one of the servers of the parent zone also
host a root zone with wildcard address records, but that should be irrelevant.

* Zone: child.a.b.addresses-match-8.consistency05.xa
  * "addresses-match-8.consistency05.xa" is the parent zone.
    * ns3, ns4 and ns39 are out-of-domain under the xb tree.
    * ns3 is "ns3.addresses-match-8.consistency05.xb"
    * ns4 is "ns4.addresses-match-8.consistency05.xb"
    * ns39 is "ns39.addresses-match-8.consistency05.xb"
  * Delegation is without glue.
  * The child zone has no address records for the NS names
  * The child zone is on different servers:
    * ns41 and ns42 are out-of-domain under the xb tree.
    * ns41 is "ns41.child.a.b.addresses-match-8.consistency05.xb"
    * ns42 is "ns42.child.a.b.addresses-match-8.consistency05.xb"
  * The "consistency05.xb" zone has a full set of the address records for all NS
  * ns39 happens to also host a root zone with wildcard records for "*.xa" and
    "*.xb"
    * The root zone should be irrelevant to Zonemaster.

### ADDRESSES-MATCH-9
It is very much like ADDRESSES-MATCH-8. Child is directly under parent.

* Zone: child.addresses-match-9.consistency05.xa
  * "addresses-match-9.consistency05.xa" is the parent zone.
    * ns3, ns4 and ns39 are out-of-domain under the xb tree.
    * ns3 is "ns3.addresses-match-9.consistency05.xb"
    * ns4 is "ns4.addresses-match-9.consistency05.xb"
    * ns39 is "ns39.addresses-match-9.consistency05.xb"
  * Delegation is without glue.
  * The child zone has no address records for the NS names
  * The child zone is on different servers:
    * ns41 and ns42 are out-of-domain under the xb tree.
    * ns41 is "ns41.child.addresses-match-9.consistency05.xb"
    * ns42 is "ns42.child.addresses-match-9.consistency05.xb"
  * The "consistency05.xb" zone has a full set of the address records for all NS
  * ns39 happens to also host a root zone with wildcard records for "*.xa" and
    "*.xb"
    * The root zone should be irrelevant to Zonemaster.

### CHILD-ZONE-LAME-1
Lame. No NS responds.

* Zone: child-zone-lame-1.consistency05.xa
  * ns1 and ns2 do not respond.

### CHILD-ZONE-LAME-2
Lame. One NS non-AA and one NS SERVFAIL.

* Zone: child-zone-lame-2.consistency05.xa
  * ns1 responses with AA bit unset.
  * ns2 responds with [RCODE Name] "ServFail".

### CHILD-ZONE-LAME-3
Lame. No NS in response.

* Zone: child-zone-lame-3.consistency05.xa
  * Both ns1 and ns2 responds with NODATA on NS query
  * Else normal zone

### EXTRA-ADDRESS-CHILD
Child zone has one extra address record on the NS name.

* Zone: extra-address-child.consistency05.xa
  * The zone has address records for ns2 that match glue, but in addition
    the zone has extra A and AAAA records for ns2.
  * Both ns2 servers (both sets of IP addresses from child) must give identical
    DNS responses.

### ID-ADDR-MISMATCH-1
For one NS (in-domain), the addresses in the glue do not match those in the
authoritative data from the zone.

* Zone: id-addr-mismatch-1.consistency05.xa
  * ns2 is defined in the zone, but with different addresses (IPv4 and IPv6),
    i.e. not the same as in glue.
  * Both ns2 servers (IP address sets from glue and child, respectively) must
    give identical DNS responses.

### ID-ADDR-MISMATCH-2
For one NS (in-domain), address records exist in the glue, but not in the
authoritative data for the zone.

* Zone: id-addr-mismatch-2.consistency05.xa
  * ns2 is not defined in the zone, i.e. there are no address records for ns2
    (IPv4 or IPv6) in the zone.

### ID-ADDR-MISMATCH-3
For ns2 (in-domain), there is no NS for ns2 and the glue does not match any
address records in the zone. Furthermore, ns2 does not respond.

* Zone: id-addr-mismatch-3.consistency05.xa
  * Normal delegation to ns1 and ns2.
  * There is no NS record for ns2 in the zone.
  * No address records for ns2 (IPv4 or IPv6) in the zone.
  * ns2 does not respond.

### ID-ADDR-MISSING-1
Both NS are in-domain and exist with correct glue in the delegation, but there
are no address records in the zone matching the name server names.

* Zone: id-addr-missing-1.consistency05.xa
  * Neither ns1 nor ns2 are defined in the zone as address records.
  * The correct NS records are in the zone.

### INCONSISTENT-DELEGATION-1
Delegation from parent zone is inconsistent.

* Zone: child.inconsistent-delegation-1.consistency05.xa
  * Parent zone is inconsistent-delegation-1.consistency05.xa
    * Parent ns1 delegates to child ns41 and ns42
    * Parent ns2 delegates to child ns41 and ns43
  * Child ns are in-domain
    * ns41, ns42 and n43
    * Child is consistent

### INCONSISTENT-DELEGATION-2
Delegation from parent zone is inconsistent.

* Zone: child.inconsistent-delegation-2.consistency05.xa
  * Parent zone is inconsistent-delegation-2.consistency05.xa
    * Parent ns1 delegates to child ns1 and ns2
    * Parent ns2 delegates to child ns1 and ns3
  * Child ns are out-of-domain
    * ns1, ns2 and n3
    * Child is consistent

### MISSING-GLUE-FOR-NS-1
Delegation lacks mandatory glue for ns41.

* Zone: child.missing-glue-for-ns-1.consistency05.xa
  * Parent ns1 and ns2 have the same delegation of child.
  * Child runs on ns41 and ns42.
  * Delegation lacks glue for ns41.


### MISSING-GLUE-FOR-NS-2
The child zone is undelegated with undelegated data. Undelegated data lacks
mandatory glue for ns1.

* Zone: missing-glue-for-ns-2.consistency05.xa
  * No delegated zone.
  * Undelegated zone on ns1 and ns2.
  * Glue is missing for ns1 in undelegated data.
  * Undelegated data:
    * ns1.missing-glue-for-ns-2.consistency05.xa
    * ns1.missing-glue-for-ns-2.consistency05.xa
    * ns2.missing-glue-for-ns-2.consistency05.xa/IPv4
    * ns2.missing-glue-for-ns-2.consistency05.xa/IPv6

### NO-NS-ADDR-CHILD-1
Lame. There are no IP addresses to the child zone

* Zone: child.no-ns-addr-child-1.consistency05.xa
  * Delegation is missing glue.
  * Child zone does not have to be created.

### NO-NS-ADDR-CHILD-2
Lame. There are no IP addresses to the child zone

* Zone: child.no-ns-addr-child-2.consistency05.xa
  * ns1 and ns2 are out-of-domain.
  * No glue in delegation.
  * Authoriative records of ns1 and ns2 do not exist.
  * Child zone does not have to be created.

### OOD-ADDR-MISMATCH
For one NS (out-of-domain, but with glue) glue does not match AA address
response.

* Zone: child.ood-addr-mismatch.consistency05.xa
  * Both ns1 and ns2 are out-of-domain
  * ns1 is "ns1.sibbling.ood-addr-mismatch.consistency05.xa"
  * ns2 is "ns2.sibbling.ood-addr-mismatch.consistency05.xa"
  * Delegation is with glue.
  * The "sibling" zone has full set of address records
  * ns1 in the "sibling" zone matches the addresses of glue.
  * ns2 in the "sibling" zone does not match the addresses of glue.
  * All IP addresses of ns1 and ns2 must serve identical versions of the zone.


### ROOT-MATCH-1
Default root zone and hintfile, and all matches.

* Zone: . (root)
  * Dedicated hintfile not needed.


### ROOT-MISSING-GLUE-UNDEL-1
Default root zone and hintfile. Undelegated is used for another root zone. Glue
is missing.

* Zone: . (root)
  * Dedicated hintfile not needed.
  * Undelegated data:
    * ns1
    * ns1
    * ns2/IPv4
    * ns2/IPv6


### Z-ROOT-MATCH-1
The hintfile loads a broken root zone. The tested root zone is the dedicated root
zone via undelegated data, and all matches.

* Zone: . (root)
  * Dedicated hintfile.
  * Undelegated data:
    * ns1/IPv4
    * ns1/IPv6
    * ns2/IPv4
    * ns2/IPv6


### Z-ROOT-INCOMPLETE-HINT
Incomplete hintfile (missing address records) but the default root zone.

* Zone: . (root)
  * Dedicated hintfile.
  * Hint file misses the address records for ns1.


[Consistency05]:                                                  ../../tests/Consistency-TP/consistency05.md
[RCODE Name]:                                                     https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[Test scenario README file]:                                      ../README.md
[Zone setup for test scenarios]:                                  #zone-setup-for-test-scenarios

