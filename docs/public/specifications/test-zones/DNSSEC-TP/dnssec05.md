# Specification of Test Scenarios for DNSSEC05


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

This document specifies defined test scenarios for test case [DNSSEC05].


## Test scenarios

The purpose of the test scenarios is to cover all reasonable contexts where
different message tags are outputted when [DNSSEC05] is run on a test zone. The
message tags are defined in the test case ([DNSSEC05]) and the scenarios are
defined below.

The test scenarios are structured as stated in the [test scenario README file].


## Test zone names

The test zone or zones for each test scenario in this document is a subdomain
(or lower zone) delegated from the base name (`dnssec05.xa`) and that subdomain
having the same name as the scenario. The names of those zones are given in
section "[Test scenarios and setup of test zones]" below.


## All message tags

The test case can output any of these message tags, but not necessarily in any
combination. See [DNSSEC05] for the specification of the tags.

* DS05_ALGO_DEPRECATED
* DS05_ALGO_NOT_RECOMMENDED
* DS05_ALGO_NOT_ZONE_SIGN
* DS05_ALGO_OK
* DS05_ALGO_PRIVATE
* DS05_ALGO_RESERVED
* DS05_ALGO_UNASSIGNED
* DS05_NO_RESPONSE
* DS05_SERVER_NO_DNSSEC
* DS05_ZONE_NO_DNSSEC


## Test scenarios and message tags

If a message tag is not listed for the scenario, its presence or non-presence is
irrelevant to the test scenario and must be ignored.

| Scenario name           | Mandatory message tags                                        | Forbidden message tags |
|:------------------------|:--------------------------------------------------------------|:-----------------------|
| ALGO-DEPRECATED-1       | DS05_ALGO_DEPRECATED                                          | 2)                     |
| ALGO-DEPRECATED-3       | DS05_ALGO_DEPRECATED                                          | 2)                     |
| ALGO-DEPRECATED-5       | DS05_ALGO_DEPRECATED                                          | 2)                     |
| ALGO-DEPRECATED-6       | DS05_ALGO_DEPRECATED                                          | 2)                     |
| ALGO-DEPRECATED-7       | DS05_ALGO_DEPRECATED                                          | 2)                     |
| ALGO-DEPRECATED-12      | DS05_ALGO_DEPRECATED                                          | 2)                     |
| ALGO-NOT-RECOMMENDED-10 | DS05_ALGO_NOT_RECOMMENDED                                     | 2)                     |
| ALGO-NOT-ZONE-SIGN-0    | DS05_ALGO_NOT_ZONE_SIGN                                       | 2)                     |
| ALGO-NOT-ZONE-SIGN-2    | DS05_ALGO_NOT_ZONE_SIGN                                       | 2)                     |
| ALGO-NOT-ZONE-SIGN-252  | DS05_ALGO_NOT_ZONE_SIGN                                       | 2)                     |
| ALGO-OK-13              | DS05_ALGO_OK                                                  | 2)                     |
| ALGO-OK-14              | DS05_ALGO_OK                                                  | 2)                     |
| ALGO-OK-15              | DS05_ALGO_OK                                                  | 2)                     |
| ALGO-OK-16              | DS05_ALGO_OK                                                  | 2)                     |
| ALGO-OK-17              | DS05_ALGO_OK                                                  | 2)                     |
| ALGO-OK-23              | DS05_ALGO_OK                                                  | 2)                     |
| ALGO-OK-8               | DS05_ALGO_OK                                                  | 2)                     |
| ALGO-PRIVATE-253        | DS05_ALGO_PRIVATE                                             | 2)                     |
| ALGO-PRIVATE-254        | DS05_ALGO_PRIVATE                                             | 2)                     |
| ALGO-RESERVED-11        | DS05_ALGO_RESERVED                                            | 2)                     |
| ALGO-RESERVED-123       | DS05_ALGO_RESERVED                                            | 2)                     |
| ALGO-RESERVED-251       | DS05_ALGO_RESERVED                                            | 2)                     |
| ALGO-RESERVED-255       | DS05_ALGO_RESERVED                                            | 2)                     |
| ALGO-RESERVED-4         | DS05_ALGO_RESERVED                                            | 2)                     |
| ALGO-RESERVED-9         | DS05_ALGO_RESERVED                                            | 2)                     |
| ALGO-UNASSIGNED-122     | DS05_ALGO_UNASSIGNED                                          | 2)                     |
| ALGO-UNASSIGNED-20      | DS05_ALGO_UNASSIGNED                                          | 2)                     |
| MIXED-ALGO-1            | DS05_ALGO_DEPRECATED, DS05_ALGO_NOT_RECOMMENDED, DS05_ALGO_OK | 2)                     |
| NO-RESPONSE-1           | DS05_NO_RESPONSE                                              | 2)                     |
| NO-RESPONSE-2           | DS05_NO_RESPONSE                                              | 2)                     |
| SERVER_NO_DNSSEC-1      | DS05_SERVER_NO_DNSSEC, DS05_ALGO_OK                           | 2)                     |
| SHARED-IP-1             | DS05_ALGO_OK                                                  | 2)                     |
| ZONE_NO_DNSSEC-1        | DS05_ZONE_NO_DNSSEC                                           | 2)                     |

* (1) All tags except for those specified as "Forbidden message tags" (no instances for these test scenarios)
* (2) All tags except for those specified as "Mandatory message tags"


## Test scenarios and setup of test zones

### Default zone configuration
Unless otherwise specified in the specific scenario specification, the test zone
or zones for the scenario will follow the default setup as stated below. The
`child zone` is the zone to be tested for the scenario.

* The child zone is `SCENARIO.dnssec05.xa`.
  * It is delegated to two name servers, `ns1.SCENARIO.dnssec05.xa`
    and `ns2.SCENARIO.dnssec05.xa`.
    * The name server names have A and AAAA records to avoid non-relevant error
      messages.
    * The delegation of the child zone is to an OOB NS.
      * NS can be resolved through the `dnssec05.xa` zone.
  * There is a zone file for the child zone.
  * All child zone servers give the same response.
  * The only responses that can be assumed are queries for
    * DNSKEY
    * NS
    * SOA
  * The zone will respond with one DNSKEY record.
* The parent zone is `dnssec05.xa`.
  * It is served by two in-bailiwick NS (ns1 and ns2).
  * ns1 and ns2 have the same zone content.
  * ns1 and ns2 have both IPv4 and IPv6 glue.
  * The records matching glue in the zone are complete.
* All responses will have the AA bit set.
* All responses will have the [RCODE Name] "NoError".
* The DNSKEY algorithm is 13 unless specified for the scenario.
  * The DNSKEY record can be technically invalid. Only the format is valid and
    only the algorithm value is checked.
* The zone is not signed.

### ALGO-DEPRECATED-1
The DNSKEY algo is 1

* Zone: "algo-deprecated-1.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 1.

### ALGO-DEPRECATED-3
The DNSKEY algo is 3

* Zone: "algo-deprecated-3.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 3.

### ALGO-DEPRECATED-5
The DNSKEY algo is 5

* Zone: "algo-deprecated-5.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 5.

### ALGO-DEPRECATED-6
The DNSKEY algo is 6

* Zone: "algo-deprecated-6.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 6.

### ALGO-DEPRECATED-7
The DNSKEY algo is 7

* Zone: "algo-deprecated-7.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 7.

### ALGO-DEPRECATED-12
The DNSKEY algo is 12

* Zone: "algo-deprecated-12.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 12.

### ALGO-RESERVED-4
The DNSKEY algo is 4

* Zone: "algo-reserved-4.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 4.

### ALGO-RESERVED-9
The DNSKEY algo is 9

* Zone: "algo-reserved-9.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 9.

### ALGO-RESERVED-11
The DNSKEY algo is 11

* Zone: "algo-reserved-11.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 11.

### ALGO-RESERVED-123
The DNSKEY algo is 123

* Zone: "algo-reserved-123.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 123.

### ALGO-RESERVED-251
The DNSKEY algo is 251

* Zone: "algo-reserved-251.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 251.

### ALGO-RESERVED-255
The DNSKEY algo is 255

* Zone: "algo-reserved-255.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 255.

### ALGO-UNASSIGNED-20
The DNSKEY algo is 20

* Zone: "algo-unassigned-17.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 17.

### ALGO-UNASSIGNED-122
The DNSKEY algo is 122

* Zone: "algo-unassigned-122.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 122.

### ALGO-PRIVATE-253
The DNSKEY algo is 253

* Zone: "algo-private-253.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 253.

### ALGO-PRIVATE-254
The DNSKEY algo is 254

* Zone: "algo-private-254.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 254.

### ALGO-NOT-ZONE-SIGN-0
The DNSKEY algo is 0

* Zone: "algo-not-zone-sign-0.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 0.

### ALGO-NOT-ZONE-SIGN-2
The DNSKEY algo is 2

* Zone: "algo-not-zone-sign-2.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 2.

### ALGO-NOT-ZONE-SIGN-252
The DNSKEY algo is 252

* Zone: "algo-not-zone-sign-252.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 252.

### ALGO-NOT-RECOMMENDED-10
The DNSKEY algo is 10

* Zone: "algo-not-recommended-10.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 10.

### ALGO-OK-8
The DNSKEY algo is 8

* Zone: "algo-ok-8.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 8.

### ALGO-OK-13
The DNSKEY algo is 13

* Zone: "algo-ok-13.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 13.

### ALGO-OK-14
The DNSKEY algo is 14

* Zone: "algo-ok-14.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 14.

### ALGO-OK-15
The DNSKEY algo is 15

* Zone: "algo-ok-15.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 15.

### ALGO-OK-16
The DNSKEY algo is 16

* Zone: "algo-ok-16.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 16.

### ALGO-OK-17
The DNSKEY algo is 17

* Zone: "algorithm-ok-17.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 17.

### ALGO-OK-23
The DNSKEY algo is 23

* Zone: "algorithm-ok-23.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 23.

## MIXED-ALGO-1
Three DNSKEY with different algorithms.

* Zone: "mixed-algo-1.dnssec05.xa."
  * The response has three DNSKEY with different algorithms:
    * 7
    * 10
    * 13

### NO-RESPONSE-1
No valid response from any of the servers.

* Zone: "no-response-1.dnssec05.xa."
  * No response at all from ns1.
  * Response from ns2 does not have the AA bit set.

### NO-RESPONSE-2
No valid response from any of the servers.

* Zone: "no-response-2.dnssec05.xa."
  * Response from ns1 has RCODE SERVFAIL.
  * Response from ns2 has RCODE REFUSED.

### SERVER_NO_DNSSEC-1
No DNSKEY from ns1.

* Zone: "server_no_dnssec-1.dnssec05.xa."
  * Response from ns1 is NODATA (no DNSKEY).
  * Response from ns2 is normal.

### SHARED-IP-1
Two NS names, but only one IP. IPv4 only.

* Zone: "shared-ip-1.dnssec05.xa."
  * ns1a and ns1b are in bailiwick, but use the same IP.
    * IPv4 only.
  * The message should list both name server names, both with the same IP.

### ZONE_NO_DNSSEC-1
No DNSKEY from neither ns1 nor ns2.

* Zone: "zone_no_dnssec-1.dnssec05.xa."
  * Responses from ns1 and ns2 are NODATA (no DNSKEY).


[DNSSEC01]:                                                       ../../tests/DNSSEC-TP/dnssec01.md
[DNSSEC05]:                                                       ../../tests/DNSSEC-TP/dnssec05.md
[DNSSEC05]:                                                       ../../tests/DNSSEC-TP/dnssec05.md
[DNSSEC14]:                                                       ../../tests/DNSSEC-TP/dnssec14.md
[RCODE Name]:                                                     https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[Test scenario README file]:                                      ../README.md
[Test scenarios and setup of test zones]:                         #test-scenarios-and-setup-of-test-zones
[Zone setup for test scenarios]:                                  #zone-setup-for-test-scenarios

