# Specification of Test Scenarios for Basic02


## Table of contents

* [Background](#background)
* [Test Case](#test-case)
* [Test scenarios](#test-scenarios)
* [Test zone names](#test-zone-names)
* [All message tags](#all-message-tags)
* [Test scenarios and message tags](#test-scenarios-and-message-tags)
* [Test scenarios and setup of test zones]


## Background

See the [test scenario README file].


## Test Case
This document specifies defined test scenarios for test case [Basic02].


## Test scenarios

The purpose of the test scenarios is to cover all reasonable contexts where
different message tags are outputted when [Basic02] is run on a test zone.
The message tags are defined in the test case ([Basic02]) and the scenarios
are defined below.

The test scenarios are structured as stated in the [test scenario README file].

## Test zone names

The test zone or zones for each test scenario in this document is a subdomain
(or lower zone) delegated from the base name (`basic02.xa`) and that subdomain
having the same name as the scenario. The names of those zones are given in
section "[Test scenarios and setup of test zones]" below.


## All message tags
The test case can output any of these message tags, but not necessarily in any
combination. See [Basic02] for the specification of the tags.

* B02_AUTH_RESPONSE_SOA
* B02_NO_DELEGATION
* B02_NO_WORKING_NS
* B02_NS_BROKEN
* B02_NS_NOT_AUTH
* B02_NS_NO_IP_ADDR
* B02_NS_NO_RESPONSE
* B02_UNEXPECTED_RCODE

## Test scenarios and message tags

If a message tag is not listed for the scenario, its presence or non-presence is
irrelevant to the test scenario and must be ignored.

Scenario name                  | Mandatory message tag                      | Forbidden message tags
:------------------------------|:-------------------------------------------|:----------------------
GOOD-1                         | B02_AUTH_RESPONSE_SOA                      | 2)
GOOD-2                         | B02_AUTH_RESPONSE_SOA                      | 2)
GOOD-UNDEL-1                   | B02_AUTH_RESPONSE_SOA                      | 2)
GOOD-UNDEL-2                   | B02_AUTH_RESPONSE_SOA                      | 2)
GOOD-UNDEL-3                   | B02_AUTH_RESPONSE_SOA                      | 2)
GOOD-UNDEL-4                   | B02_AUTH_RESPONSE_SOA                      | 2)
GOOD-UNDEL-5                   | B02_AUTH_RESPONSE_SOA                      | 2)
GOOD-UNDEL-6                   | B02_AUTH_RESPONSE_SOA                      | 2)
GOOD-UNDEL-7                   | B02_AUTH_RESPONSE_SOA                      | 2)
GOOD-UNDEL-8                   | B02_AUTH_RESPONSE_SOA                      | 2)
GOOD-UNDEL-9                   | B02_AUTH_RESPONSE_SOA                      | 2)
GOOD-UNDEL-10                  | B02_AUTH_RESPONSE_SOA                      | 2)
GOOD-UNDEL-11                  | B02_AUTH_RESPONSE_SOA                      | 2)
MIXED-1                        | B02_AUTH_RESPONSE_SOA                      | 2)
NO-DELEGATION-1                | B02_NO_DELEGATION                          | 2)
NS-BROKEN-1                    | B02_NS_BROKEN, B02_NO_WORKING_NS           | 2)
NS-NOT-AUTH-1                  | B02_NS_NOT_AUTH, B02_NO_WORKING_NS         | 2)
NS-NO-IP-1                     | B02_NS_NO_IP_ADDR, B02_NO_WORKING_NS       | 2)
NS-NO-IP-2                     | B02_NS_NO_IP_ADDR, B02_NO_WORKING_NS       | 2)
NS-NO-IP-3                     | B02_NS_NO_IP_ADDR, B02_NO_WORKING_NS       | 2)
NS-NO-IP-UNDEL-1               | B02_NS_NO_IP_ADDR, B02_NO_WORKING_NS       | 2)
NS-NO-IP-UNDEL-2               | B02_NS_NO_IP_ADDR, B02_NO_WORKING_NS       | 2)
NS-NO-RESPONSE-1               | B02_NS_NO_RESPONSE, B02_NO_WORKING_NS      | 2)
UNEXPECTED-RCODE-1             | B02_UNEXPECTED_RCODE, B02_NO_WORKING_NS    | 2)

* (1) All tags except for those specified as "Forbidden message tags" (no instances for these test scenarios)
* (2) All tags except for those specified as "Mandatory message tags"


## Test scenarios and setup of test zones

### Default zone configuration
Unless otherwise specified in the specific scenario specification, the test zone
or zones for the scenario will follow the default setup as stated below. The
`child zone` is the zone to be tested for the scenario.

`basic02.xb` is a zone for out-of-bailiwick name servers for applicable
scenario.

* The child zone is `SCENARIO.basic02.xa`.
  * It is delegated to two name servers, `ns1.SCENARIO.basic02.xa`
    and `ns2.SCENARIO.basic02.xa`.
    * The name server names have A and AAAA records to avoid non-relevant error
      messages.
    * The delegation of the child zone is complete with glue records.
  * There is a zone file for the child zone.
  * All child zone servers give the same response.
* All responses will have the AA bit set.
* All responses will have the [RCODE Name] "NoError".
* NS and any glue matches NS and authoritative address records in zone.
* If NS are out of bailiwick, the names are defined in another zone with correct
  A and AAAA records.

### GOOD-1
A "happy path". Everything is fine.

* Zone: good-1.basic02.xa
  * Zone is set up as default.

### GOOD-2
Like GOOD-1 but name servers are out-of-bailiwick.

* Zone: good-1.basic02.xa
  * ns1 is ns1.good-2.basic02.xb.
  * ns2 is ns2.good-2.basic02.xb.
  * Delegation is without glue.

### Overview of the GOOD-UNDEL-x scenarios

Scenario name  | Delegated zone                | Undelegated data
:--------------|:------------------------------|:--------------------
GOOD-UNDEL-1   | no delegation                 | IB with glue
GOOD-UNDEL-2   | no delegation                 | OOB without glue, NS names are defined
GOOD-UNDEL-3   | IB, no response               | OOB without glue, NS names are defined
GOOD-UNDEL-4   | IB, no glue                   | OOB without glue, NS names are defined
GOOD-UNDEL-5   | IB, no glue                   | IB with glue
GOOD-UNDEL-6   | OOB, no response              | IB with glue
GOOD-UNDEL-7   | OOB, no address records       | OOB with glue, NS names are undefined
GOOD-UNDEL-8   | IB, no response               | IB, IP redefined
GOOD-UNDEL-9   | OOB, no response              | OOB, IP redefined
GOOD-UNDEL-10  | OOB, SERVFAIL/REFUSED         | OOB
GOOD-UNDEL-11  | OOB, cannot look addr up      | OOB, IP through lookup

### GOOD-UNDEL-1
The zone is not delegated. Undelegated data provides a working zone.

* Zone: good-undel-1.basic02.xa
  * The zone is not delegated.
  * Else, the zone from undelegated data is set up as default.
  * Undelegated data:
    * ns1.good-undel-1.basic02.xa/IPv4
    * ns1.good-undel-1.basic02.xa/IPv6
    * ns2.good-undel-1.basic02.xa/IPv4
    * ns2.good-undel-1.basic02.xa/IPv6

### GOOD-UNDEL-2
The zone is not delegated. Undelegated data provides a working zone. NS are
out-of-bailiwick.

* Zone: good-undel-2.basic02.xa
  * The zone is not delegated.
  * The undelegated data has out-of-bailiwick name servers without glue.
  * Normal lookup provides IP addresses for the name server names.
  * Else, the zone from undelegated data is set up as default.
  * Undelegated data:
    * ns1.good-undel-2.basic02.xb
    * ns2.good-undel-2.basic02.xb

### GOOD-UNDEL-3
Delegated zone does not respond. There is a working zone from undelegated data.
Those NS are out-of-bailiwick.

* Zone: good-undel-3.basic02.xa
  * The name servers in delegation are ns1 and ns2.
  * Name servers from delegation do not respond.
  * The undelegated data has out-of-bailiwick name servers without glue.
  * Normal lookup provides IP addresses for the name server names.
  * Else, the zone from undelegated data is set up as default.
  * Undelegated data:
    * ns3.good-undel-3.basic02.xb
    * ns4.good-undel-3.basic02.xb

### GOOD-UNDEL-4
Delegation of zone lacks glue. There is a working zone from undelegated data.
Those NS are out-of-bailiwick.

* Zone: good-undel-4.basic02.xa
  * The name servers in delegation ns1 and ns2.
  * There is no glue for ns1 and ns2.
  * The undelegated data has out-of-bailiwick name servers without glue.
  * Normal lookup provides IP addresses for the name server names.
  * Else, the zone from undelegated data is set up as default.
  * Undelegated data:
    * ns1.good-undel-4.basic02.xb
    * ns2.good-undel-4.basic02.xb

### GOOD-UNDEL-5
Delegation of zone lacks glue. There is a working zone from undelegated data.

* Zone: good-undel-5.basic02.xa
  * The name servers in delegation ns1 and ns2.
  * There is no glue for ns1 and ns2.
  * The undelegated data has the same NS names with glue.
  * Else, the zone from undelegated data is set up as default.
  * Undelegated data:
    * ns1.good-undel-5.basic02.xa/IPv4
    * ns1.good-undel-5.basic02.xa/IPv6
    * ns2.good-undel-5.basic02.xa/IPv4
    * ns2.good-undel-5.basic02.xa/IPv6

### GOOD-UNDEL-6
Zone is delegated to out-of-bailiwick NS, but with no response. There is a
working zone from undelegated data.

* Zone: good-undel-6.basic02.xa
  * The name servers in delegation are ns1.good-undel-6.basic02.xb and
    ns2.good-undel-6.basic02.xb.
  * Normal lookup provides IP addresses for the name server names.
  * The servers in delegation do not respond.
  * The zone from undelegated data is set up as default.
  * Undelegated data:
    * ns3.good-undel-6.basic02.xa/IPv4
    * ns3.good-undel-6.basic02.xa/IPv6
    * ns4.good-undel-6.basic02.xa/IPv4
    * ns4.good-undel-6.basic02.xa/IPv6

### GOOD-UNDEL-7
Zone is delegated to out-of-bailiwick NS, but with no IP for NS. There is a
working zone from undelegated data, also out-of-bailiwick.

* Zone: good-undel-7.basic02.xa
  * The name servers in delegation are ns1.good-undel-7.basic02.xb and
    ns2.good-undel-7.basic02.xb.
    * ns1 and ns2 are defined, but with no address records.
  * The NS in undelegated data use names that are not defined.
  * The zone from undelegated data is set up as default.
  * Undelegated data:
    * ns3.good-undel-7.basic02.xb/IPv4
    * ns3.good-undel-7.basic02.xb/IPv6
    * ns4.good-undel-7.basic02.xb/IPv4
    * ns5.good-undel-7.basic02.xb/IPv6

### GOOD-UNDEL-8
Zone is delegated, but no response from the NS of delegation. There is a working
zone from undelegated data.

* Zone: good-undel-8.basic02.xa
  * The name servers in delegation are dns1 and dns2.
  * There is no response from dns1 and dns2.
  * The NS in undelegated data use the same NS names with other IP addresses.
  * Else, the zone from undelegated data is set up as default.
  * Undelegated data:
    * dns1.good-undel-8.basic02.xa/IPv4
    * dns1.good-undel-8.basic02.xa/IPv6
    * dns2.good-undel-8.basic02.xa/IPv4
    * dns2.good-undel-8.basic02.xa/IPv6

### GOOD-UNDEL-9
Zone is delegated to out-of-bailiwick NS, but with no response. There is a
working zone from undelegated data.

* Zone: good-undel-9.basic02.xa
  * The name servers in delegation are dns1.good-undel-9.basic02.xb and
    dns2.good-undel-9.basic02.xb.
  * Normal lookup provides IP addresses for the name server names.
  * The servers in delegation do not respond.
  * The NS in undelegated data use the same NS names with other IP addresses.
  * The zone from undelegated data is set up as default.
  * Undelegated data:
    * dns1.good-undel-9.basic02.xb/IPv4
    * dns1.good-undel-9.basic02.xb/IPv6
    * dns2.good-undel-9.basic02.xb/IPv4
    * dns2.good-undel-9.basic02.xb/IPv6

### GOOD-UNDEL-10
Zone is delegated to out-of-bailiwick NS, but with SERVFAIL or REFUSED response.
There is a working zone from undelegated data, also out-of-bailiwick.

* Zone: good-undel-10.basic02.xa
  * The name servers in delegation are ns1.good-undel-10.basic02.xb and
    ns2.good-undel-10.basic02.xb.
  * Normal lookup provides IP addresses for the name server names.
  * The servers in delegation respond with SERVFAIL (ns1) or REFUSED (ns2).
  * The NS in undelegated data use other IP addresses.
  * The zone from undelegated data is set up as default.
  * Undelegated data:
    * ns3.good-undel-10.basic02.xb/IPv4
    * ns3.good-undel-10.basic02.xb/IPv6
    * ns4.good-undel-10.basic02.xb/IPv4
    * ns4.good-undel-10.basic02.xb/IPv6

### GOOD-UNDEL-11
Zone is delegated to out-of-bailiwick NS whose names are in a zone that is
not reachable (addresses cannot be looked up). There is a working zone from
undelegated data, also out-of-bailiwick.

* Zone: good-undel-11.basic02.xa
  * The name servers in delegation are ns1.delegated.good-undel-11.basic02.xb
    and ns2.delegated.good-undel-11.basic02.xb.
  * Normal lookup fails to provides IP addresses for the name server names
    since zone delegated.good-undel-11.basic02.xb cannot be reached.
    * delegated.good-undel-11.basic02.xb is delegated to dns1 and dns2 relative
      to that domain.
  * There is no actual zone for the delegated data (not needed).
  * The zone from undelegated data is set up as default.
  * The addresses for the NS for the undelegated zone are found via lookup.
  * Undelegated data:
    * ns3.good-undel-11.basic02.xb
    * ns4.good-undel-11.basic02.xb

### MIXED-1
The zone is delegated to four NS, of which ns1 responds correctly, ns2 does
not respond, ns3 resturns SERVFAIL and ns4 is not authoritative.

* Zone: mixed-1.basic02.xa
  * The zone is set-up as default, but with four NS (ns1-4).
  * ns1 gives correct response.
  * ns2 does not respond.
  * ns3 return SERVFAIL on all queries.
  * ns4 return all responses with AA flag unset.

### NO-DELEGATION
There is no delegation for the zone.

* Zone: no-delegation.basic02.xa
  * No zone.
  * No name servers.
  * No delegation.

### NS-BROKEN-1
The servers for the zone do not respond with SOA record on SOA query.

* Zone: ns-broken-1.basic02.xa
  * No SOA record in response from ns1 and ns2
  * RCODE is NOERROR and AA bit is set.

### NS-NOT-AUTH-1
The servers for the zone do not give authoritative responses.

* Zone: ns-not-auth-1.basic02.xa
  * AA bit is unset in responses from ns1 and ns2.
  
### NS-NO-IP-1
The delegation is without glue.

* Zone: ns-no-ip-1.basic02.xa
  * There is no glue in delegation for ns1 and ns2.
  * No zone is set up.

### NS-NO-IP-2
The name server are out-of-bailiwick but have no address records.

* Zone: ns-no-ip-2.basic02.xa
  * ns1 and ns2 are out-of-bailiwick.
  * ns1 is ns1.ns-no-ip-2.basic02.xb.
  * ns2 is ns2.ns-no-ip-2.basic02.xb.
  * ns1 and ns2 exist as names, but have no address records.
  * No zone is set up.

### NS-NO-IP-3
The name server are out-of-bailiwick but the names are not defined.

* Zone: ns-no-ip-3.basic02.xa
  * ns1 and ns2 are out-of-bailiwick.
  * ns1 is ns1.ns-no-ip-3.basic02.xb.
  * ns2 is ns2.ns-no-ip-3.basic02.xb.
  * ns1 and ns2 do not exist as names.
  * No zone is set up.

### NS-NO-IP-UNDEL-1
The delegated zone works correctly. The undelegated data has in-bailiwick NS
without glue.

* Zone: ns-no-ip-undel-1.basic02.xa
  * ns1 and ns2 serves a working zone.
  * The undelegated data uses the same NS names but without glue.
  * There is no need for a zone for undelegated data.
  * Undelegated data:
    * ns1.ns-no-ip-undel-1.basic02.xa
    * ns2.ns-no-ip-undel-1.basic02.xa

### NS-NO-IP-UNDEL-2
The delegated zone works correctly. The undelegated data has out-of-bailiwick NS
without glue. The NS names have no address records.

* Zone: ns-no-ip-undel-2.basic02.xa
  * ns1 and ns2 serves a working zone.
  * The undelegated data uses out-of-bailiwick NS.
    * NS names exists.
    * NS names do not resolve to address records.
  * There is no need for a zone for undelegated data.
  * Undelegated data:
    * ns1.ns-no-ip-undel-2.basic02.xb
    * ns2.ns-no-ip-undel-2.basic02.xb

### NS-NO-RESPONSE-1
The name servers do not respond on the queries.

* Zone: ns-no-response-1.basic02.xa
  * ns1 and ns2 do not respond to queries.
  * No zone is set up.

### UNEXPECTED-RCODE-1
The name servers responds with NXDOMAIN, REFUSED or SERVFAIL on SOA query.

* Zone: unexpected-rcode-1.basic02.xa
  * ns1 responds with NXDOMAIN.
  * ns2 responds with REFUSED.
  * ns3 responds with SERVFAIL.
  * No actual zone exists.
  



