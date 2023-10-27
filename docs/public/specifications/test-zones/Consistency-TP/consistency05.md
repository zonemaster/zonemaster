# Specification of test zones for CONSISTENCY05


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
This document specifies defined test zones for test case [CONSISTENCY05].


## Test scenarios

The purpose of the test scenarios is to cover all reasonable contexts where
different message tags are outputted when [CONSISTENCY05] is run on a test zone.
The message tags are defined in the test case ([CONSISTENCY05]) and the scenarios
are defined below.

The test scenarios are structured as stated in the [test zone README file].

## Test zone names

The test zone for each test scenario in this document is a subdomain delegated
from the base name (`consistency05.xa`) and that subdomain having the same name as the
scenario. The names of those zones are given in section
"[Zone setup for test scenarios]" below.


## Test scenarios and message tags

If a message tag is not listed for the scenario, its presence or non-presence is
irrelevant to the test scenario and must be ignored.

Scenario name             | Mandatory message tag            | Forbidden message tags
:-------------------------|:---------------------------------|:-------------------------------------------
ADDRESSES-MATCH-1         | ADDRESSES_MATCH                  | IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, CHILD_ZONE_LAME, CHILD_NS_FAILED, NO_RESPONSE
ADDRESSES-MATCH-2         | ADDRESSES_MATCH                  | IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, CHILD_ZONE_LAME, CHILD_NS_FAILED, NO_RESPONSE
ADDRESSES-MATCH-3         | ADDRESSES_MATCH, CHILD_NS_FAILED | IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, CHILD_ZONE_LAME, NO_RESPONSE
ADDRESSES-MATCH-4         | ADDRESSES_MATCH, CHILD_NS_FAILED | IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, CHILD_ZONE_LAME, NO_RESPONSE
ADDRESSES-MATCH-5         | ADDRESSES_MATCH, NO_RESPONSE     | IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, CHILD_ZONE_LAME, CHILD_NS_FAILED
ADDRESSES-MATCH-6         | ADDRESSES_MATCH                  | IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, CHILD_ZONE_LAME, CHILD_NS_FAILED, NO_RESPONSE
ADDRESSES-MATCH-7         | ADDRESSES_MATCH                  | IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, CHILD_ZONE_LAME, CHILD_NS_FAILED, NO_RESPONSE
CHILD-ZONE-LAME-1         | CHILD_ZONE_LAME, CHILD_NS_FAILED | IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, NO_RESPONSE, ADDRESSES_MATCH
CHILD-ZONE-LAME-2         | CHILD_ZONE_LAME, NO_RESPONSE     | IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, CHILD_NS_FAILED, ADDRESSES_MATCH
IB-ADDR-MISMATCH          | IN_BAILIWICK_ADDR_MISMATCH       | OUT_OF_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, CHILD_ZONE_LAME, CHILD_NS_FAILED, NO_RESPONSE, ADDRESSES_MATCH
EXTRA-ADDRESS-CHILD       | EXTRA_ADDRESS_CHILD              | IN_BAILIWICK_ADDR_MISMATCH, OUT_OF_BAILIWICK_ADDR_MISMATCH, CHILD_ZONE_LAME, CHILD_NS_FAILED, NO_RESPONSE, ADDRESSES_MATCH
OOB-ADDR-MISMATCH         | OUT_OF_BAILIWICK_ADDR_MISMATCH   | IN_BAILIWICK_ADDR_MISMATCH, EXTRA_ADDRESS_CHILD, CHILD_ZONE_LAME, CHILD_NS_FAILED, NO_RESPONSE, ADDRESSES_MATCH


## Zone setup for test scenarios

Assumptions for the scenario specifications unless otherwise specified for
the specific scenario:
* For each scenario zone there are two name server configured.
  * Both NS (ns1 and ns2) are equal in delegation and in zone.
  * Both NS are in-bailiwick
  * Both NS have both IPv4 and IPv6 addresses
  * All required glue are present in the delegation.
  * All glue exactly matches the authoritative address records in correct
    zone (not more and not less records).
  * All NS IP addresses respond with identical zone content.
* Responds with a A record for the zone on query for A.
* Responds with a AAAA record for the zone on query for AAAA.
* All responses are authoritative with [RCODE Name] "NoError"
* EDNS, version 0, is included in all responses on queries with EDNS.
* EDNS is not included in responses on queries without EDNS.

### ADDRESSES-MATCH-1
* The "happy path". Everything is fine.
* Zone: "addresses-match-1.consistency05.xa."

### ADDRESSES-MATCH-2
* Also the "happy path". Out-of-bailiwick NS this time. And no glue.
* Zone: "addresses-match-2.consistency05.xa."
  * Both ns1 and ns2 are out-of-bailiwick under the xb tree.
  * ns1 is "ns1.addresses-match-2.consistency05.xb"
  * ns2 is "ns2.addresses-match-2.consistency05.xb"
  * Delegation is without glue.
  * The zone has no address records for the NS names
  * The "addresses-match-2.consistency05.xb" zone has a full set of the
    address records for ns1 and ns2.

### ADDRESSES-MATCH-3
* One NS does not give AA answer, but else fine.
* Zone: "addresses-match-3.consistency05.xa."
  * ns1 responds with AA flag unset.

### ADDRESSES-MATCH-4
* One NS does give SERVFAIL response, but else fine.
* Zone: "addresses-match-4.consistency05.xa."
  * ns1 responds with [RCODE Name] "ServFail".

### ADDRESSES-MATCH-5
* One NS does not respond, but else fine.
* Zone: "addresses-match-5.consistency05.xa."
  * ns1 gives no response at all.

### ADDRESSES-MATCH-6
* Also "happy path". Out-of-bailiwick NS, but with glue.
* Zone: "child.addresses-match-6.consistency05.xa."
  * Both ns1 and ns2 are out-of-bailiwick
  * ns1 is "ns1.sibbling.addresses-match-6.consistency05.xa"
  * ns2 is "ns2.sibbling.addresses-match-6.consistency05.xa"
  * Delegation is with glue.
  * The test zone ("child") has no address records for the NS names, but the
    "sibbling" zone has full set of address records.

### ADDRESSES-MATCH-7
* Also "happy path". NS in subdomain.
* Zone: "addresses-match-7.consistency05.xa."
  * ns1 is "ns1.subdomain.addresses-match-7.consistency05.xa."
  * ns2 is "ns2.subdomain.addresses-match-7.consistency05.xa."
  * Delegation is with glue.
  * "subdomain.addresses-match-7.consistency05.xa" is delegated to the same
    ns1 and ns2.
  * ns1 and ns2 are defined with address records in the "subdomain" zone.

### CHILD-ZONE-LAME-1
* Lame. No NS responds.
* Zone: "child-zone-lame-1.consistency05.xa."
  * ns1 and ns2 do not respond.

### CHILD-ZONE-LAME-2
* Lame. One NS non-AA and one NS SERVFAIL.
* Zone: "child-zone-lame-2.consistency05.xa."
  * ns1 respones with AA bit unset.
  * ns2 responds with [RCODE Name] "ServFail".

### IB-ADDR-MISMATCH
* For one NS (in-bailiwick) glue does not match AA address response.
* Zone: "ib-addr-mismatch.consistency05.xa."
  * ns2 is defined in the zone, but with other addresses (IPv4 and IPv6)
  * Both sets of IP addresses of ns2 must be identical as name servers.

### EXTRA-ADDRESS-CHILD
* Child zone has one extra address record on the NS name.
* Zone: "extra-address-child.consistency05.xa."
  * The zone has address records for ns2 that match glue, but in addition
    the zone has extra A and AAAA records for ns2.
  * All IP address for ns2 must be identical as name servers.

### OOB-ADDR-MISMATCH
* For one NS (out-of-bailiwick, but with glue) glue does not match
  AA address response.
* Zone: "child.oob-addr-mismatch.consistency05.xa."
  * Both ns1 and ns2 are out-of-bailiwick
  * ns1 is "ns1.sibbling.oob-addr-mismatch.consistency05.xa"
  * ns2 is "ns2.sibbling.oob-addr-mismatch.consistency05.xa"
  * Delegation is with glue.
  * The test zone ("child") has no address records for the NS names.
  * The "sibbling" zone has full set of address records
  * ns1 in the "sibbling" zone matches the addresses of glue.
  * ns2 in the "sibbling" zone does not match the addresses of glue.
  * All IP addresses of ns1 and ns2 must server the identical versions
    of the zone.


[CONSISTENCY05]:                                                  ../../tests/Consistency-TP/consistency05.md
[RCODE Name]:                                                     https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[Test zone README file]:                                          ../README.md
[Zone setup for test scenarios]:                                  #zone-setup-for-test-scenarios

