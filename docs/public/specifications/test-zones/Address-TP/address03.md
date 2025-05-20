# Specification of Test Scenarios for Address03


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

This document specifies defined test scenarios for test case [Address03].


## Test scenarios

The purpose of the test scenarios is to cover all reasonable contexts where
different message tags are outputted when [Address03] is run on a test zone.
The message tags are defined in the test case ([Address03]) and the scenarios
are defined below.

The test scenarios are structured as stated in the [test scenario README file].

## Test zone names

The test zone for each test scenario in this document is a subdomain delegated
from the base name (`address03.xa`) and that subdomain having the same name as
the scenario. The names of those zones are given in section "[Test scenarios
and setup of test zones]" below.

## All message tags

The test case can output any of these message tags, but not necessarily in any
combination. See [Address03] for the specification of the tags.

* NAMESERVER_IP_PTR_MATCH
* NAMESERVER_IP_PTR_MISMATCH
* NAMESERVER_IP_WITHOUT_REVERSE
* NO_RESPONSE_PTR_QUERY


## Test scenarios and message tags

If a message tag is not listed for the scenario, its presence or non-presence is
irrelevant to the test scenario and must be ignored.

| Scenario name              | Mandatory message tags        | Forbidden message tags                              |
|:---------------------------|:------------------------------|:----------------------------------------------------|
| ALL-NS-HAVE-PTR-1          | NAMESERVER_IP_PTR_MATCH       | 2)                                                  |
| ALL-NS-HAVE-PTR-2          | NAMESERVER_IP_PTR_MATCH       | 2)                                                  |
| NO-NS-HAVE-PTR             | NAMESERVER_IP_WITHOUT_REVERSE | 2)                                                  |
| INCOMPLETE-PTR-1           | NAMESERVER_IP_WITHOUT_REVERSE | 2)                                                  |
| INCOMPLETE-PTR-2           | NAMESERVER_IP_WITHOUT_REVERSE | 2)                                                  |
| NON-MATCHING-NAMES         | NAMESERVER_IP_PTR_MISMATCH    | 2)                                                  |
| PTR-IS-GOOD-CNAME-1        | NAMESERVER_IP_PTR_MATCH       | 2)                                                  |
| PTR-IS-GOOD-CNAME-2        | NAMESERVER_IP_PTR_MATCH       | 2)                                                  |
| PTR-IS-DANGLING-CNAME      | NAMESERVER_IP_WITHOUT_REVERSE | 2)                                                  |
| PTR-IS-ILLEGAL-CNAME       | NAMESERVER_IP_WITHOUT_REVERSE | NAMESERVER_IP_PTR_MATCH, NAMESERVER_IP_PTR_MISMATCH |
| PTR-RESOLUTION-NO-RESPONSE | NO_RESPONSE_PTR_QUERY         | NAMESERVER_IP_PTR_MATCH, NAMESERVER_IP_PTR_MISMATCH |
| PTR-RESOLUTION-SERVFAIL    | NO_RESPONSE_PTR_QUERY         | NAMESERVER_IP_PTR_MATCH, NAMESERVER_IP_PTR_MISMATCH |

* (1) All tags except for those specified as "Forbidden message tags" (no instances for these test scenarios)
* (2) All tags except for those specified as "Mandatory message tags"


## Test scenarios and setup of test zones

### Default zone configuration
Unless otherwise specified in the specific scenario specification, the test zone
for the scenario will follow the default setup as stated below. The `child zone`
is the zone to be tested for the scenario.

* The child zone is `SCENARIO.address03.xa`.
  * There is a zone file for the child zone.
  * The child zone is delegated to two out-of-bailiwick name servers.
  * Both name servers have the same content.
  * The authoritative name servers for the zone all have an IPv4 and an IPv6
    address, and the reverse zones contain a single PTR resource record
    matching their names for all of their addresses.
  * The NS record set in the child zone is consistent with the parent zone’s
    delegation.
* The parent zone is `address03.xa`.
  * It is served by two in-bailiwick NS (ns1.address03.xa and
    ns2.address03.xa).
  * ns1 and ns2 have the same zone content.
  * ns1 and ns2 have both IPv4 and IPv6 glue in the delegation of the parent
    zone.
  * The records matching glue in the zone are identical to the glue records.
* All authoritative name servers for the scenario’s child zones have names
  matching ns\<NUMBER\>.child.address03.xa. These name servers’s names are
  abbreviated by leaving out address03.xa from their names.
* All responses will have the AA bit set.
* All responses will have the [RCODE Name] "NoError".

### ALL-NS-HAVE-PTR-1

A happy path: a zone whose name server IP addresses have single and correct
PTR records.

* Zone: all-ns-have-ptr-1.address03.xa
  * Delegated to: ns1.child and ns2.child.

### ALL-NS-HAVE-PTR-2

Another happy path: like ALL-NS-HAVE-PTR-1, but for one of the name servers,
both its IPv4 and IPv6 addresses have multiple PTR records. In each PTR
resource record set, one of the PTR records matches the name server’s name.

* Zone: all-ns-have-ptr-2.address03.xa
  * Delegated to: ns1.child and ns3.child.
  * ns3.child’s IP addresses have multiple PTR records, among which one points
    to ns3.child.

### NO-NS-HAVE-PTR

None of the name server’s IP addresses have PTR records at all. For one of
them, NODATA is returned on PTR query; for the other, NXDOMAIN is returned.

* Zone: no-ns-have-ptr.address03.xa
  * Delegated to: ns4.child and ns5.child.
  * ns4.child’s IP addresses have no PTR records; the reverse zone is
    configured to provoke NODATA responses on PTR queries by making the
    expected node an empty non-terminal.
  * ns5.child’s IP addresses have no PTR records; the reverse zone is
    configured to provoke NXDOMAIN responses on PTR queries.

### INCOMPLETE-PTR-1

For one of the name servers, the PTR record is missing for its IPv4 address.

* Zone: incomplete-ptr-1.address03.xa
  * Delegated to: ns1.child and ns6.child.
  * ns6.child’s IPv4 address has no PTR record, but its IPv6 address does.

### INCOMPLETE-PTR-2

For one of the name servers, the PTR record is missing for its IPv6 address.

* Zone: incomplete-ptr-2.address03.xa
  * Delegated to: ns1.child and ns7.child.
  * ns7.child’s IPv4 address has a PTR record, but its IPv6 address does not.

### NON-MATCHING-NAMES

Both name server’s IP addresses have one or more PTR records, but none
matching the name server name.

* Zone: non-matching-names.address03.xa
  * Delegated to: ns8.child and ns9.child.
  * ns8.child’s IP addresses have a single PTR record, but its hostname in
    RDATA is different from the name server’s name.
  * ns9.child’s IP addresses have more than one PTR record, and each of them
    has a hostname in RDATA different from the name server’s name.

### PTR-IS-GOOD-CNAME-1

The reverse name of one of the name servers’ IP address has an alias (CNAME)
whose target, with a PTR record, is in the same reverse zone.

* Zone: ptr-is-good-cname-1.address03.xa
  * Delegated to: ns1.child and ns10.child.
  * ns10.child’s IP addresses have reverse names that are aliased (CNAME) to
    another name in the same zone. In other words, resolving the PTR resource
    records for their IP addresses returns a CNAME resource record and the PTR
    record after walking the CNAME chain.

### PTR-IS-GOOD-CNAME-2

The reverse name of one of the name servers’ IP address has an alias (CNAME)
whose target, with a PTR record, is in a different zone.

* Zone: ptr-is-good-cname-2.address03.xa
  * Delegated to: ns1.child and ns11.child.
  * ns11.child’s IP addresses have reverse names that are aliased (CNAME) to
    another name in a different zone. In other words, resolving the PTR
    resource records for their IP addresses returns only a CNAME resource
    record, and another query for the name at the target of the CNAME resource
    record is needed.

### PTR-IS-DANGLING-CNAME

The reverse name of one of the name servers’ IP address has an alias (CNAME)
whose target does not exist.

* Zone: ptr-is-dangling-cname.address03.xa
  * Delegated to: ns5.child and ns12.child.
  * ns5.child is configured as described in the NO-NS-HAVE-PTR scenario.
  * ns12.child’s IP addresses have reverse names that are aliased to a
    nonexistent node. In other words, there is a CNAME pointing to a node
    that does not exist.

### PTR-IS-ILLEGAL-CNAME

One of the name servers has IP addresses whose reverse names contain more than
one CNAME resource record.

* Zone: ptr-is-illegal-cname.address03.xa
  * Delegated to: ns4.child and ns13.child.
  * ns4.child is configured as described in the NO-NS-HAVE-PTR scenario.
  * ns13.child’s IP addresses have reverse names that give two CNAME
    resource records.
    
Whether or not NO_RESPONSE_PTR_QUERY is allowed to be outputted is
intentionally left unspecified.
    
### PTR-RESOLUTION-NO-RESPONSE

One of the name servers has IP addresses whose reverse names fail to resolve
because the authoritative name server for the reverse zone does not respond.

One of the name servers’ IP addresses fail to resolve to PTR records because
an attempt at querying corresponding node in the `in-addr.arpa` or `ip6.arpa`
subtrees returns no response.

* Zone: ptr-resolution-no-response.address03.xa
  * Delegated to: ns1.child and ns14.child.
  * Querying the PTR records for ns14.child’s IP addresses return no response.
  
Whether or not NAMESERVER_IP_WITHOUT_REVERSE is allowed to be outputted is
intentionally left unspecified.

### PTR-RESOLUTION-SERVFAIL

One of the name servers has IP addresses whose reverse names fail to resolve
because the authoritative name server for the reverse zone gives a response
whose [RCODE Name] is neither "NoError" nor "NXDomain".

* Zone: ptr-resolution-no-response.address03.xa
  * Delegated to: ns1.child and ns15.child.
  * Querying the PTR records for ns15.child’s IP addresses return a "ServFail"
    response.

Whether or not NAMESERVER_IP_WITHOUT_REVERSE is allowed to be outputted is
intentionally left unspecified.

[ADDRESS03]:                     ../../tests/Address-TP/address03.md
[RCODE Name]:                    https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[test scenario README file]:     ../README.md
[Zone setup for test scenarios]: #zone-setup-for-test-scenarios
