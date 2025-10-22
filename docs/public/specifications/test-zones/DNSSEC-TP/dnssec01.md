# Specification of Test Scenarios for DNSSEC01


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

This document specifies defined test scenarios for test case [DNSSEC01].


## Test scenarios

The purpose of the test scenarios is to cover all reasonable contexts where
different message tags are outputted when [DNSSEC01] is run on a test zone. The
message tags are defined in the test case ([DNSSEC01]) and the scenarios are
defined below.

The test scenarios are structured as stated in the [test scenario README file].


## Test zone names

The test zone or zones for each test scenario in this document is a subdomain
(or lower zone) delegated from the base name (`dnssec01.xa`) and that subdomain
having the same name as the scenario. The names of those zones are given in
section "[Test scenarios and setup of test zones]" below.


## All message tags

The test case can output any of these message tags, but not necessarily in any
combination. See [DNSSEC01] for the specification of the tags.

* DS01_DS_ALGO_2_MISSING
* DS01_DS_ALGO_DEPRECATED
* DS01_DS_ALGO_NOT_DS
* DS01_DS_ALGO_OK
* DS01_DS_ALGO_PRIVATE
* DS01_DS_ALGO_RESERVED
* DS01_DS_ALGO_UNASSIGNED
* DS01_NO_RESPONSE
* DS01_PARENT_SERVER_NO_DS
* DS01_PARENT_ZONE_NO_DS
* DS01_ROOT_N_NO_UNDEL_DS
* DS01_UNDEL_N_NO_UNDEL_DS


## Test scenarios and message tags

If a message tag is not listed for the scenario, its presence or non-presence is
irrelevant to the test scenario and must be ignored.

| Scenario name         | Mandatory tags                                                 | Forbidden tags |
|:----------------------|:---------------------------------------------------------------|:---------------|
| ALGO-DEPRECATED-1     | DS01_DS_ALGO_DEPRECATED, DS01_DS_ALGO_2_MISSING                | 2)             |
| ALGO-DEPRECATED-3     | DS01_DS_ALGO_DEPRECATED, DS01_DS_ALGO_2_MISSING                | 2)             |
| ALGO-NOT-DS-0         | DS01_DS_ALGO_NOT_DS, DS01_DS_ALGO_2_MISSING                    | 2)             |
| ALGO-OK-2             | DS01_DS_ALGO_OK                                                | 2)             |
| ALGO-OK-4             | DS01_DS_ALGO_OK, DS01_DS_ALGO_2_MISSING                        | 2)             |
| ALGO-OK-5             | DS01_DS_ALGO_OK, DS01_DS_ALGO_2_MISSING                        | 2)             |
| ALGO-OK-6             | DS01_DS_ALGO_OK, DS01_DS_ALGO_2_MISSING                        | 2)             |
| ALGO-PRIVATE-253      | DS01_DS_ALGO_PRIVATE, DS01_DS_ALGO_2_MISSING                   | 2)             |
| ALGO-PRIVATE-254      | DS01_DS_ALGO_PRIVATE, DS01_DS_ALGO_2_MISSING                   | 2)             |
| ALGO-RESERVED-128     | DS01_DS_ALGO_RESERVED, DS01_DS_ALGO_2_MISSING                  | 2)             |
| ALGO-RESERVED-188     | DS01_DS_ALGO_RESERVED, DS01_DS_ALGO_2_MISSING                  | 2)             |
| ALGO-RESERVED-252     | DS01_DS_ALGO_RESERVED, DS01_DS_ALGO_2_MISSING                  | 2)             |
| ALGO-UNASSIGNED-7     | DS01_DS_ALGO_UNASSIGNED, DS01_DS_ALGO_2_MISSING                | 2)             |
| ALGO-UNASSIGNED-67    | DS01_DS_ALGO_UNASSIGNED, DS01_DS_ALGO_2_MISSING                | 2)             |
| ALGO-UNASSIGNED-127   | DS01_DS_ALGO_UNASSIGNED, DS01_DS_ALGO_2_MISSING                | 2)             |
| MIXED-ALGO-1          | DS01_DS_ALGO_DEPRECATED, DS01_DS_ALGO_PRIVATE, DS01_DS_ALGO_OK | 2)             |
| SHARED-IP-1           | DS01_DS_ALGO_OK                                                | 2)             |
| SHARED-IP-2           | DS01_DS_ALGO_OK                                                | 2)             |
| NO-RESPONSE-1         | DS01_NO_RESPONSE                                               | 2)             |
| NO-VALID-RESPONSE-1   | DS01_NO_RESPONSE                                               | 2)             |
| PARENT-SERVER-NO-DS-1 | DS01_PARENT_SERVER_NO_DS, DS01_DS_ALGO_OK                      | 2)             |
| PARENT-ZONE-NO-DS-1   | DS01_PARENT_ZONE_NO_DS                                         | 2)             |
| UNDEL-NO-UNDEL-DS-1   | DS01_UNDEL_N_NO_UNDEL_DS                                       | 2)             |
| UNDEL-WITH-UNDEL-DS-1 | DS01_DS_ALGO_OK                                                | 2)             |
| ROOT-NO-UNDEL-DS-1    | DS01_ROOT_N_NO_UNDEL_DS                                        | 2)             |
| ROOT-WITH-UNDEL-DS-1  | DS01_DS_ALGO_OK                                                | 2)             |

* (1) All tags except for those specified as "Forbidden tags" (no instances for these test scenarios)
* (2) All tags except for those specified as "Mandatory tags"

## Test scenarios and setup of test zones

### Default zone configuration
Unless otherwise specified in the specific scenario specification, the test zone
or zones for the scenario will follow the default setup as stated below. The
`child zone` is the zone to be tested for the scenario.

* The child zone is `SCENARIO.dnssec01.xa`.
  * It is delegated to two name servers, `ns1.SCENARIO.dnssec01.xa`
    and `ns2.SCENARIO.dnssec01.xa`.
    * The name server names have A and AAAA records to avoid non-relevant error
      messages.
    * The delegation of the child zone is to an OOB NS.
      * NS can be resolved through the `dnssec01.xa` zone.
  * There is a zone file for the child zone.
  * All child zone servers give the same response.
  * The only responses that can be assumed are queries for
    * NS
    * SOA
  * The parent zone will respond with one DS record per child zone.
* The parent zone is `dnssec01.xa`.
  * It is served by two in-bailiwick NS (ns1 and ns2).
  * ns1 and ns2 have the same zone content.
  * ns1 and ns2 have both IPv4 and IPv6 glue.
  * The records matching glue in the zone are complete.
* All responses will have the AA bit set.
* All responses will have the [RCODE Name] "NoError".
* The DS digest algorithm is 2 unless specified for the scenario.
  * The DS record can be technically invalid. Only the format is valid and
    only the digest algorithm value is checked.
* The zone is not signed.

### ALGO-DEPRECATED-1
The DS digest algorithm number is 1

* Zone: algo-deprecated-1.dnssec01.xa.
  * The algorithm of the DS digest in the response is 1.

### ALGO-DEPRECATED-3
The DS digest algorithm number is 3

* Zone: algo-deprecated-3.dnssec01.xa.
  * The algorithm of the DS digest in the response is 3.

### ALGO-RESERVED-128
The DS digest algorithm number is 128

* Zone: algo-reserved-128.dnssec01.xa.
  * The algorithm of the DS digest in the response is 128.

### ALGO-RESERVED-188
The DS digest algorithm number is 188

* Zone: algo-reserved-188.dnssec01.xa.
  * The algorithm of the DS digest in the response is 188.

### ALGO-RESERVED-252
The DS digest algorithm number is 252

* Zone: algo-reserved-252.dnssec01.xa.
  * The algorithm of the DS digest in the response is 252.

### ALGO-UNASSIGNED-7
The DS digest algorithm number is 7

* Zone: algo-unassigned-7.dnssec01.xa.
  * The algorithm of the DS digest in the response is 7.

### ALGO-UNASSIGNED-67
The DS digest algorithm number is 67

* Zone: algo-unassigned-67.dnssec01.xa.
  * The algorithm of the DS digest in the response is 67.

### ALGO-UNASSIGNED-127
The DS digest algorithm number is 127

* Zone: algo-unassigned-127.dnssec01.xa.
  * The algorithm of the DS digest in the response is 127.

### ALGO-PRIVATE-253
The DS digest algorithm number is 253

* Zone: algo-private-253.dnssec01.xa.
  * The algorithm of the DS digest in the response is 253.

### ALGO-PRIVATE-254
The DS digest algorithm number is 254

* Zone: algo-private-254.dnssec01.xa.
  * The algorithm of the DS digest in the response is 254.

### ALGO-NOT-DS-0
The DS digest algorithm number is 0

* Zone: algo-not-ds-0.dnssec01.xa.
  * The algorithm of the DS digest in the response is 0.

### ALGO-OK-2
The DS digest algorithm number is 2

* Zone: algo-ok-2.dnssec01.xa.
  * The algorithm of the DS digest in the response is 2.

### ALGO-OK-4
The DS digest algorithm number is 4

* Zone: algo-ok-4.dnssec01.xa.
  * The algorithm of the DS digest in the response is 4.

### ALGO-OK-5
The DS digest algorithm number is 5

* Zone: algo-ok-5.dnssec01.xa.
  * The algorithm of the DS digest in the response is 5.

### ALGO-OK-6
The DS digest algorithm number is 6

* Zone: algo-ok-6.dnssec01.xa.
  * The algorithm of the DS digest in the response is 6.

### MIXED-ALGO-1
Three DS with different algorithms.

* Zone: mixed-algo-1.dnssec01.xa.
  * The response has three DS with different algorithms:
    * 1
    * 2
    * 253

### SHARED-IP-1
Two parent name servers resolv to the same IP address.

* Zone: child.shared-ip-1.dnssec01.xa.
  * The parent zone is "shared-ip-1.dnssec01.xa" and the grandparent zone is
    "dnssec01.xa".
  * The parent is delegated to IB ns1a and ns1b with the same IPv4 and IPv6
    addresses.

### SHARED-IP-2
Delegation of parent does not use the same name server name as parent zone.

* Zone: child.shared-ip-2.dnssec01.xa.
  * The parent zone is "shared-ip-2.dnssec01.xa" and the grandparent zone is
    "dnssec01.xa".
  * The parent is delegated to IB ns1 and ns2, but in the parent zone the names
    are dns1 and dns2.
    * ns1 and dns1 resolve to the same IP addresses.
    * ns2 and dns2 resolve to the same IP addresses.

### NO-RESPONSE-1
No response from any of the servers on the DS query.

* Zone: child.no-response-1.dnssec01.xa.
  * No response at all from parent ns1 and ns2.

### NO-VALID-RESPONSE-1
No valid response from any of the servers on the DS query.

* Zone: child.no-valid-response-1.dnssec01.xa.
  * Response from parent ns1 has RCODE SERVFAIL.
  * Response from parent ns2 has RCODE REFUSED.
  * Child zone does not exist

### PARENT-SERVER-NO-DS-1
No DS from parent ns1.

* Zone: child.parent-server-no-ds-1.dnssec01.xa.
  * Response from parent ns1 is NODATA (no DS).
  * Response from parent ns2 is normal.

### PARENT-ZONE-NO-DS-1
No DS from neither parent ns1 nor parent ns2.

* Zone: parent-zone-no-ds-1.dnssec01.xa.
  * Responses from parent ns1 and parent ns2 are NODATA (no DS).

### UNDEL-NO-UNDEL-DS-1
Zone is not delegated, but undelegated data is provided. No DS.

* Zone: undel-no-undel-ds-1.dnssec01.xa.
  * The zone is not delegated, but there is undelegated data.
  * ns1 and ns2 are OOB.
  * No undelegated DS is provided.

### UNDEL-WITH-UNDEL-DS-1
Zone is not delegated, but undelegated data is provided with DS.

* Zone: undel-with-undel-ds-1.dnssec01.xa.
  * The zone is not delegated, but there is undelegated data.
  * ns1 and ns2 are OOB.
  * Undelegated DS is provided.

### ROOT-NO-UNDEL-DS-1
Zone is the root zone, and no undelegated DS is provided.

* Zone: "."
  * ns1 and ns2 are IB
  * The zone exists.

### ROOT-WITH-UNDEL-DS-1
Zone is the root zone, and undelegated DS is provided.

* Zone: "."
  * ns1 and ns2 are IB
  * The zone exists.


[DNSSEC01]:                                                       ../../tests/DNSSEC-TP/dnssec01.md
[RCODE Name]:                                                     https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[Test scenario README file]:                                      ../README.md
[Test scenarios and setup of test zones]:                         #test-scenarios-and-setup-of-test-zones
