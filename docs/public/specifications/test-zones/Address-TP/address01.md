# Specification of test scenarios for ADDRESS01


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
This document specifies defined test scenarios for test case [ADDRESS01].

## Test scenarios

The purpose of the test scenarios is to cover all reasonable contexts where
different message tags are outputted when [ADDRESS01] is run on a test zone.
The message tags are defined in the test case ([ADDRESS01]) and the scenarios
are defined below.

The test scenarios are structured as stated in the [test zone README file].

## Test zone names

The test zone for each test scenario in this document is a subdomain delegated
from the base name (`address01.xa`) and that subdomain having the same name as the
scenario. The names of those zones are given in section
"[Zone setup for test scenarios]" below.

## All tags

The test case can output any of these message tags, but not necessarily in any combination.

- A01_ADDR_NOT_GLOBALLY_REACHABLE
- A01_DOCUMENTATION_ADDR
- A01_GLOBALLY_REACHABLE_ADDR
- A01_LOCAL_USE_ADDR
- A01_NO_GLOBALLY_REACHABLE_ADDR 
- A01_NO_NAME_SERVERS_FOUND

## Test scenarios and message tags

If a message tag is not listed for the scenario, its presence or non-presence is
irrelevant to the test scenario and must be ignored.

Scenario name        | Mandatory message tag                                                        | Forbidden message tags
:--------------------|:-----------------------------------------------------------------------------|:-------
GOOD-1               | A01_ADDR_GLOBALLY_REACHABLE                                                  | 2) 
ALL-NON-REACHABLE    | A01_NO_GLOBALLY_REACHABLE_ADDR                                               | 2) 
MIXED-LOCAL-DOC-1    | A01_LOCAL_USE_ADDR, A01_DOCUMENTATION_ADDR                                   | 2) 
MIXED-LOCAL-DOC-2    | A01_LOCAL_USE_ADDR, A01_DOCUMENTATION_ADDR                                   | 2) 
MIXED-LOCAL-OTHER-1  | A01_LOCAL_USE_ADDR, A01_ADDR_NOT_GLOBALLY_REACHABLE                          | 2) 
MIXED-LOCAL-OTHER-2  | A01_LOCAL_USE_ADDR, A01_ADDR_NOT_GLOBALLY_REACHABLE                          | 2) 
MIXED-DOC-OTHER-1    | A01_DOCUMENTATION_ADDR, A01_ADDR_NOT_GLOBALLY_REACHABLE                      | 2) 
MIXED-DOC-OTHER-2    | A01_DOCUMENTATION_ADDR, A01_ADDR_NOT_GLOBALLY_REACHABLE                      | 2) 
MIXED-ALL-1          | A01_ADDR_NOT_GLOBALLY_REACHABLE, A01_DOCUMENTATION_ADDR, A01_LOCAL_USE_ADDR  | 2) 
MIXED-ALL-2          | A01_ADDR_NOT_GLOBALLY_REACHABLE, A01_DOCUMENTATION_ADDR, A01_LOCAL_USE_ADDR  | 2) 
NO-NAME-SERVERS      | A01_NO_NAME_SERVERS_FOUND                                                    | 2)

* (1) All tags except for those specified as "Forbidden message tags" (no instances for these test scenarios)
* (2) All tags except for those specified as "Mandatory message tags"

## Zone setup for test scenarios

Assumptions for the scenario specifications unless otherwise specified for
the specific scenario:
* The child zone is `SCENARIO.address01.xa`.
* There is no zone file or zone data for the child zone.
* For each scenario zone there are two NS records (ns[1-2]).
  * All NS are in-bailiwick
  * All NS have both IPv4 and IPv6 addresses
  * All required glue are present in the delegation.
* EDNS, version 0, is included in all responses on queries with EDNS.
* EDNS is not included in responses on queries without EDNS.

Address designation      | Meaning                                                        
:------------------------|:------------------------------------------------------------------------------------------------
OK                       | Globally routable, public address
LOCAL_USE_ADDR           | Address part of range used for private networks (loopback, RFC1918, Provider shared, etc.)
DOCUMENTATION_ADDR       | Address part of range used for documentation purposes
NOT_GLOBALLY_REACHABLE   | Address part of any other range listed as not globally reachable

Designations are based on the address block ranges from the 
[Special purpose IPv4 addresses] and [Special purpose IPv6 addresses] registries. 

### GOOD-1 
The "happy path". Everything is fine.

* Zone: good-1.address01.xa

### MIXED-LOCAL-DOC-1

* Zone: mixed-local-doc-1.address01.xa
  * ns1 
    * IPv4 address LOCAL_USE_ADDR
    * IPv6 address OK
  * ns2
    * IPv4 address OK
    * IPv6 address DOCUMENTATION_ADDR

### MIXED-LOCAL-DOC-2

* Zone: mixed-local-doc-2.address01.xa
  * ns1 
    * IPv4 address DOCUMENTATION_ADDR
    * IPv6 address OK
  * ns2
    * IPv4 address OK
    * IPv6 address LOCAL_USE_ADDR

### MIXED-DOC-OTHER-1

* Zone: mixed-doc-other-1.address01.xa
  * ns1 
    * IPv4 address DOCUMENTATION_ADDR
    * IPv6 address OK
  * ns2
    * IPv4 address OK
    * IPv6 address NOT_GLOBALLY_REACHABLE

### MIXED-DOC-OTHER-2

* Zone: mixed-doc-other-2.address01.xa
  * ns1 
    * IPv4 address NOT_GLOBALLY_REACHABLE
    * IPv6 address OK
  * ns2
    * IPv4 address OK
    * IPv6 address DOCUMENTATION_ADDR 

### MIXED-LOCAL-OTHER-1

* Zone: mixed-local-other-1.address01.xa
  * ns1 
    * IPv4 address LOCAL_USE_ADDR
    * IPv6 address OK
  * ns2
    * IPv4 address OK
    * IPv6 address NOT_GLOBALLY_REACHABLE 

### MIXED-LOCAL-OTHER-2

* Zone: mixed-local-other-2.address01.xa
  * ns1 
    * IPv4 address NOT_GLOBALLY_REACHABLE
    * IPv6 address OK
  * ns2
    * IPv4 address OK
    * IPv6 address LOCAL_USE_ADDR  

### MIXED-ALL-1

* Zone: mixed-all-1.address01.xa
  * ns1 
    * IPv4 address LOCAL_USE_ADDR 
    * IPv6 address OK
  * ns2
    * IPv4 address DOCUMENTATION_ADDR
    * IPv6 address NOT_GLOBALLY_REACHABLE 

### MIXED-ALL-2

* Zone: mixed-all-2.address01.xa
  * ns1 
    * IPv4 address NOT_GLOBALLY_REACHABLE
    * IPv6 address LOCAL_USE_ADDR
  * ns2
    * IPv4 address OK
    * IPv6 address DOCUMENTATION_ADDR

### ALL-NON-REACHABLE
All addresses of all nameservers falls within one of the address blocks listed 
as not globally reachable. Delegation contains three name servers to cover all
combinations of defined address block types.

* Zone: all-non-reachable.address01.xa
  * ns1 
    * IPv4 address LOCAL_USE_ADDR
    * IPv6 address NOT_GLOBALLY_REACHABLE
  * ns2
    * IPv4 address DOCUMENTATION_ADDR
    * IPv6 address LOCAL_USE_ADDR
  + ns3
    * IPv4 address NOT_GLOBALLY_REACHABLE 
    * IPv6 address DOCUMENTATION_ADDR

### NO_NAME_SERVERS
No delegation for the zone and the zone does not exist.

* Zone: no-name-servers.address01.xa
  * No delegation
  * No zone

[ADDRESS01]:                        ../../tests/Address-TP/address01.md
[RCODE Name]:                       https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[Special purpose IPv4 addresses]:   https://www.iana.org/assignments/iana-ipv4-special-registry/iana-ipv4-special-registry.xml 
[Special purpose IPv6 addresses]:   https://www.iana.org/assignments/iana-ipv6-special-registry/iana-ipv6-special-registry.xml
[Test zone README file]:            ../README.md
[Zone setup for test scenarios]:    #zone-setup-for-test-scenarios
