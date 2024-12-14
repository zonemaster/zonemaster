# Specification of test Scenarios for DNSSEC05


## Table of contents

* [Background](#background)
* [Test Case](#test-case)
* [Test scenarios](#test-scenarios)
* [Test zone names](#test-zone-names)
* [Test scenarios and message tags](#test-scenarios-and-message-tags)
* [Zone setup for test scenarios]


## Background

See the [test scenario README file].


## Test Case

This document specifies defined test zones for test case [DNSSEC05].


## Test scenarios

The purpose of the test scenarios is to cover all reasonable contexts where
different message tags are outputted when [DNSSEC05] is run on a test zone. The
message tags are defined in the test case ([DNSSEC05]) and the scenarios are
defined below.

The test scenarios are structured as stated in the [test scenario README file].


## Test zone names

The test zone for each test scenario in this document is a subdomain delegated
from the base name (`dnssec05.xa`) and that subdomain having the same name as the
scenario. The names of those zones are given in section
"[Zone setup for test scenarios]" below.


## All message tags

The test case can output any of these message tags, but not necessarily in any
combination. See [DNSSEC05] for the specification of the tags.

* NO_RESPONSE
* NO_RESPONSE_DNSKEY
* ALGORITHM_DEPRECATED
* ALGORITHM_RESERVED
* ALGORITHM_UNASSIGNED
* ALGORITHM_NOT_RECOMMENDED
* ALGORITHM_PRIVATE
* ALGORITHM_NOT_ZONE_SIGN
* ALGORITHM_OK

## Test scenarios and message tags

If a message tag is not listed for the scenario, its presence or non-presence is
irrelevant to the test scenario and must be ignored.


Scenario name                | Mandatory message tags    | Forbidden message tags
:----------------------------|:--------------------------|:-------------------------------------------
NO-RESPONSE                  | NO_RESPONSE               | NO_RESPONSE_DNSKEY, ALGORITHM_DEPRECATED, ALGORITHM_RESERVED, ALGORITHM_UNASSIGNED, ALGORITHM_NOT_RECOMMENDED, ALGORITHM_PRIVATE, ALGORITHM_NOT_ZONE_SIGN, ALGORITHM_OK
NO-RESPONSE-DNSKEY           | NO_RESPONSE_DNSKEY        | NO_RESPONSE, ALGORITHM_DEPRECATED, ALGORITHM_RESERVED, ALGORITHM_UNASSIGNED, ALGORITHM_NOT_RECOMMENDED, ALGORITHM_PRIVATE, ALGORITHM_NOT_ZONE_SIGN, ALGORITHM_OK
ALGORITHM-DEPRECATED-1       | ALGORITHM_DEPRECATED      | NO_RESPONSE, NO_RESPONSE_DNSKEY, ALGORITHM_RESERVED, ALGORITHM_UNASSIGNED, ALGORITHM_NOT_RECOMMENDED, ALGORITHM_PRIVATE, ALGORITHM_NOT_ZONE_SIGN, ALGORITHM_OK
ALGORITHM-DEPRECATED-3       | ALGORITHM_DEPRECATED      | NO_RESPONSE, NO_RESPONSE_DNSKEY, ALGORITHM_RESERVED, ALGORITHM_UNASSIGNED, ALGORITHM_NOT_RECOMMENDED, ALGORITHM_PRIVATE, ALGORITHM_NOT_ZONE_SIGN, ALGORITHM_OK
ALGORITHM-DEPRECATED-6       | ALGORITHM_DEPRECATED      | NO_RESPONSE, NO_RESPONSE_DNSKEY, ALGORITHM_RESERVED, ALGORITHM_UNASSIGNED, ALGORITHM_NOT_RECOMMENDED, ALGORITHM_PRIVATE, ALGORITHM_NOT_ZONE_SIGN, ALGORITHM_OK
ALGORITHM-DEPRECATED-12      | ALGORITHM_DEPRECATED      | NO_RESPONSE, NO_RESPONSE_DNSKEY, ALGORITHM_RESERVED, ALGORITHM_UNASSIGNED, ALGORITHM_NOT_RECOMMENDED, ALGORITHM_PRIVATE, ALGORITHM_NOT_ZONE_SIGN, ALGORITHM_OK
ALGORITHM-RESERVED-4         | ALGORITHM_RESERVED        | NO_RESPONSE, NO_RESPONSE_DNSKEY, ALGORITHM_DEPRECATED, ALGORITHM_UNASSIGNED, ALGORITHM_NOT_RECOMMENDED, ALGORITHM_PRIVATE, ALGORITHM_NOT_ZONE_SIGN, ALGORITHM_OK
ALGORITHM-RESERVED-9         | ALGORITHM_RESERVED        | NO_RESPONSE, NO_RESPONSE_DNSKEY, ALGORITHM_DEPRECATED, ALGORITHM_UNASSIGNED, ALGORITHM_NOT_RECOMMENDED, ALGORITHM_PRIVATE, ALGORITHM_NOT_ZONE_SIGN, ALGORITHM_OK
ALGORITHM-RESERVED-11        | ALGORITHM_RESERVED        | NO_RESPONSE, NO_RESPONSE_DNSKEY, ALGORITHM_DEPRECATED, ALGORITHM_UNASSIGNED, ALGORITHM_NOT_RECOMMENDED, ALGORITHM_PRIVATE, ALGORITHM_NOT_ZONE_SIGN, ALGORITHM_OK
ALGORITHM-RESERVED-123       | ALGORITHM_RESERVED        | NO_RESPONSE, NO_RESPONSE_DNSKEY, ALGORITHM_DEPRECATED, ALGORITHM_UNASSIGNED, ALGORITHM_NOT_RECOMMENDED, ALGORITHM_PRIVATE, ALGORITHM_NOT_ZONE_SIGN, ALGORITHM_OK
ALGORITHM-RESERVED-251       | ALGORITHM_RESERVED        | NO_RESPONSE, NO_RESPONSE_DNSKEY, ALGORITHM_DEPRECATED, ALGORITHM_UNASSIGNED, ALGORITHM_NOT_RECOMMENDED, ALGORITHM_PRIVATE, ALGORITHM_NOT_ZONE_SIGN, ALGORITHM_OK
ALGORITHM-RESERVED-255       | ALGORITHM_RESERVED        | NO_RESPONSE, NO_RESPONSE_DNSKEY, ALGORITHM_DEPRECATED, ALGORITHM_UNASSIGNED, ALGORITHM_NOT_RECOMMENDED, ALGORITHM_PRIVATE, ALGORITHM_NOT_ZONE_SIGN, ALGORITHM_OK
ALGORITHM-UNASSIGNED-17      | ALGORITHM_UNASSIGNED      | NO_RESPONSE, NO_RESPONSE_DNSKEY, ALGORITHM_DEPRECATED, ALGORITHM_RESERVED, ALGORITHM_NOT_RECOMMENDED, ALGORITHM_PRIVATE, ALGORITHM_NOT_ZONE_SIGN, ALGORITHM_OK
ALGORITHM-UNASSIGNED-122     | ALGORITHM_UNASSIGNED      | NO_RESPONSE, NO_RESPONSE_DNSKEY, ALGORITHM_DEPRECATED, ALGORITHM_RESERVED, ALGORITHM_NOT_RECOMMENDED, ALGORITHM_PRIVATE, ALGORITHM_NOT_ZONE_SIGN, ALGORITHM_OK
ALGORITHM-PRIVATE-253        | ALGORITHM_PRIVATE         | NO_RESPONSE, NO_RESPONSE_DNSKEY, ALGORITHM_DEPRECATED, ALGORITHM_RESERVED, ALGORITHM_UNASSIGNED, ALGORITHM_NOT_RECOMMENDED, ALGORITHM_NOT_ZONE_SIGN, ALGORITHM_OK
ALGORITHM-PRIVATE-254        | ALGORITHM_PRIVATE         | NO_RESPONSE, NO_RESPONSE_DNSKEY, ALGORITHM_DEPRECATED, ALGORITHM_RESERVED, ALGORITHM_UNASSIGNED, ALGORITHM_NOT_RECOMMENDED, ALGORITHM_NOT_ZONE_SIGN, ALGORITHM_OK
ALGORITHM-NOT-ZONE-SIGN-0    | ALGORITHM_NOT_ZONE_SIGN   | NO_RESPONSE, NO_RESPONSE_DNSKEY, ALGORITHM_DEPRECATED, ALGORITHM_RESERVED, ALGORITHM_UNASSIGNED, ALGORITHM_NOT_RECOMMENDED, ALGORITHM_PRIVATE, ALGORITHM_OK
ALGORITHM-NOT-ZONE-SIGN-2    | ALGORITHM_NOT_ZONE_SIGN   | NO_RESPONSE, NO_RESPONSE_DNSKEY, ALGORITHM_DEPRECATED, ALGORITHM_RESERVED, ALGORITHM_UNASSIGNED, ALGORITHM_NOT_RECOMMENDED, ALGORITHM_PRIVATE, ALGORITHM_OK
ALGORITHM-NOT-ZONE-SIGN-252  | ALGORITHM_NOT_ZONE_SIGN   | NO_RESPONSE, NO_RESPONSE_DNSKEY, ALGORITHM_DEPRECATED, ALGORITHM_RESERVED, ALGORITHM_UNASSIGNED, ALGORITHM_NOT_RECOMMENDED, ALGORITHM_PRIVATE, ALGORITHM_OK
ALGORITHM-NOT-RECOMMENDED-5  | ALGORITHM_NOT_RECOMMENDED | NO_RESPONSE, NO_RESPONSE_DNSKEY, ALGORITHM_DEPRECATED, ALGORITHM_RESERVED, ALGORITHM_UNASSIGNED, ALGORITHM_PRIVATE, ALGORITHM_NOT_ZONE_SIGN, ALGORITHM_OK
ALGORITHM-NOT-RECOMMENDED-7  | ALGORITHM_NOT_RECOMMENDED | NO_RESPONSE, NO_RESPONSE_DNSKEY, ALGORITHM_DEPRECATED, ALGORITHM_RESERVED, ALGORITHM_UNASSIGNED, ALGORITHM_PRIVATE, ALGORITHM_NOT_ZONE_SIGN, ALGORITHM_OK
ALGORITHM-NOT-RECOMMENDED-10 | ALGORITHM_NOT_RECOMMENDED | NO_RESPONSE, NO_RESPONSE_DNSKEY, ALGORITHM_DEPRECATED, ALGORITHM_RESERVED, ALGORITHM_UNASSIGNED, ALGORITHM_PRIVATE, ALGORITHM_NOT_ZONE_SIGN, ALGORITHM_OK
ALGORITHM-OK-8               | ALGORITHM_OK              | NO_RESPONSE, NO_RESPONSE_DNSKEY, ALGORITHM_DEPRECATED, ALGORITHM_RESERVED, ALGORITHM_UNASSIGNED, ALGORITHM_NOT_RECOMMENDED, ALGORITHM_PRIVATE, ALGORITHM_NOT_ZONE_SIGN
ALGORITHM-OK-13              | ALGORITHM_OK              | NO_RESPONSE, NO_RESPONSE_DNSKEY, ALGORITHM_DEPRECATED, ALGORITHM_RESERVED, ALGORITHM_UNASSIGNED, ALGORITHM_NOT_RECOMMENDED, ALGORITHM_PRIVATE, ALGORITHM_NOT_ZONE_SIGN
ALGORITHM-OK-14              | ALGORITHM_OK              | NO_RESPONSE, NO_RESPONSE_DNSKEY, ALGORITHM_DEPRECATED, ALGORITHM_RESERVED, ALGORITHM_UNASSIGNED, ALGORITHM_NOT_RECOMMENDED, ALGORITHM_PRIVATE, ALGORITHM_NOT_ZONE_SIGN
ALGORITHM-OK-15              | ALGORITHM_OK              | NO_RESPONSE, NO_RESPONSE_DNSKEY, ALGORITHM_DEPRECATED, ALGORITHM_RESERVED, ALGORITHM_UNASSIGNED, ALGORITHM_NOT_RECOMMENDED, ALGORITHM_PRIVATE, ALGORITHM_NOT_ZONE_SIGN
ALGORITHM-OK-16              | ALGORITHM_OK              | NO_RESPONSE, NO_RESPONSE_DNSKEY, ALGORITHM_DEPRECATED, ALGORITHM_RESERVED, ALGORITHM_UNASSIGNED, ALGORITHM_NOT_RECOMMENDED, ALGORITHM_PRIVATE, ALGORITHM_NOT_ZONE_SIGN


## Zone setup for test scenarios

Assumptions for the scenario specifications unless otherwise specified for the
specific scenario:
* The zone is served by one nameserver, ns1
* All nameservers are in-bailiwick
* All nameservers are served by both IPv4 and IPv6
* The delegation has full glue for the nameservers
* Only DNSKEY records in apex are considered.
* All name servers respond authoritatively with [RCODE Name] "NoError" and with
  a single DNSKEY record in "answer section" on DNSKEY queries.
* The algorithm of the DNSKEY record is specified for each scenario.

### NO-RESPONSE
The NS does not respond.

* Zone: "no-response.dnssec05.xa."
  * No response at all from ns1.

### NO-RESPONSE-DNSKEY
The NS does not respond with DNSKEY

* Zone: "no-response-dnskey.dnssec05.xa."
  * ns1 does not include any DNSKEY in the response. The response is NODATA.

### ALGORITHM-DEPRECATED-1
The DNSKEY algo is 1

* Zone: "algorithm-deprecated-1.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 1.

### ALGORITHM-DEPRECATED-3
The DNSKEY algo is 3

* Zone: "algorithm-deprecated-3.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 3.

### ALGORITHM-DEPRECATED-6
The DNSKEY algo is 6

* Zone: "algorithm-deprecated-6.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 6.

### ALGORITHM-DEPRECATED-12
The DNSKEY algo is 12

* Zone: "algorithm-deprecated-12.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 12.

### ALGORITHM-RESERVED-4
The DNSKEY algo is 4

* Zone: "algorithm-reserved-4.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 4.

### ALGORITHM-RESERVED-9
The DNSKEY algo is 9

* Zone: "algorithm-reserved-9.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 9.

### ALGORITHM-RESERVED-11
The DNSKEY algo is 11

* Zone: "algorithm-reserved-11.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 11.

### ALGORITHM-RESERVED-123
The DNSKEY algo is 123

* Zone: "algorithm-reserved-123.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 123.

### ALGORITHM-RESERVED-251
The DNSKEY algo is 251

* Zone: "algorithm-reserved-251.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 251.

### ALGORITHM-RESERVED-255
The DNSKEY algo is 255

* Zone: "algorithm-reserved-255.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 255.

### ALGORITHM-UNASSIGNED-17
The DNSKEY algo is 17

* Zone: "algorithm-unassigned-17.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 17.

### ALGORITHM-UNASSIGNED-122
The DNSKEY algo is 122

* Zone: "algorithm-unassigned-122.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 122.

### ALGORITHM-PRIVATE-253
The DNSKEY algo is 253

* Zone: "algorithm-private-253.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 253.

### ALGORITHM-PRIVATE-254
The DNSKEY algo is 254

* Zone: "algorithm-private-254.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 254.

### ALGORITHM-NOT-ZONE-SIGN-0
The DNSKEY algo is 0

* Zone: "algorithm-not-zone-sign-0.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 0.

### ALGORITHM-NOT-ZONE-SIGN-2
The DNSKEY algo is 2

* Zone: "algorithm-not-zone-sign-2.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 2.

### ALGORITHM-NOT-ZONE-SIGN-252
The DNSKEY algo is 252

* Zone: "algorithm-not-zone-sign-252.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 252.

### ALGORITHM-NOT-RECOMMENDED-5
The DNSKEY algo is 5

* Zone: "algorithm-not-recommended-5.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 5.

### ALGORITHM-NOT-RECOMMENDED-7
The DNSKEY algo is 7

* Zone: "algorithm-not-recommended-7.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 7.

### ALGORITHM-NOT-RECOMMENDED-10
The DNSKEY algo is 10

* Zone: "algorithm-not-recommended-10.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 10.

### ALGORITHM-OK-8
The DNSKEY algo is 8

* Zone: "algorithm-ok-8.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 8.

### ALGORITHM-OK-13
The DNSKEY algo is 13

* Zone: "algorithm-ok-13.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 13.

### ALGORITHM-OK-14
The DNSKEY algo is 14

* Zone: "algorithm-ok-14.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 14.

### ALGORITHM-OK-15
The DNSKEY algo is 15

* Zone: "algorithm-ok-15.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 15.

### ALGORITHM-OK-16
The DNSKEY algo is 16

* Zone: "algorithm-ok-16.dnssec05.xa."
  * The algorithm of the DNSKEY in the response is 16.



[DNSSEC01]:                                                       ../../tests/DNSSEC-TP/dnssec01.md
[DNSSEC05]:                                                       ../../tests/DNSSEC-TP/dnssec05.md
[DNSSEC14]:                                                       ../../tests/DNSSEC-TP/dnssec14.md
[DNSSEC05]:                                                       ../../tests/DNSSEC-TP/dnssec05.md
[RCODE Name]:                                                     https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[Test scenario README file]:                                      ../README.md
[Zone setup for test scenarios]:                                  #zone-setup-for-test-scenarios

