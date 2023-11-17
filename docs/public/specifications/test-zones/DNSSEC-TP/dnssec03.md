# Specification of test zones for DNSSEC03


## Table of contents

* [Background](#background)
* [Test Case](#test-case)
* [Test scenarios](#test-scenarios)
* [Test zone names](#test-zone-names)
* [Test scenarios and message tags](#test-scenarios-and-message-tags)
* [Zone setup for test scenarios]
* [Terminology](#terminology)


## Background

See the [test zone README file].


## Test Case

This document specifies defined test zones for test case [DNSSEC03].


## Test scenarios

The purpose of the test scenarios is to cover all reasonable contexts where
different message tags are outputted when [DNSSEC03] is run on a test zone. The
message tags are defined in the test case ([DNSSEC03]) and the scenarios are
defined below.

The test scenarios are structured as stated in the [test zone README file].


## Test zone names

The test zone for each test scenario in this document is a subdomain delegated
from the base name (`dnssec03.xa`) and that subdomain having the same name as the
scenario except where the test domain must be the root zone, a TLD or a domain
under `.arpa`. The names of those zones are given in section
"[Zone setup for test scenarios]" below.


## Test scenarios and message tags

If a message tag is not listed for the scenario, its presence or non-presence is
irrelevant to the test scenario and must be ignored.


Scenario name                | Mandatory message tags                            | Forbidden message tags
:----------------------------|:--------------------------------------------------|:-------------------------------------------
NO-DNSSEC-SUPPORT            | DS03_NO_DNSSEC_SUPPORT                            | DS03_ERR_MULT_NSEC3, DS03_ILLEGAL_HASH_ALGO, DS03_ILLEGAL_ITERATION_VALUE, DS03_ILLEGAL_SALT_LENGTH, DS03_INCONSISTENT_HASH_ALGO, DS03_INCONSISTENT_ITERATION, DS03_INCONSISTENT_NSEC3_FLAGS, DS03_INCONSISTENT_SALT_LENGTH, DS03_LEGAL_EMPTY_SALT, DS03_LEGAL_HASH_ALGO, DS03_LEGAL_ITERATION_VALUE, DS03_NO_NSEC3, DS03_NSEC3_OPT_OUT_DISABLED, DS03_NSEC3_OPT_OUT_ENABLED_NON_TLD, DS03_NSEC3_OPT_OUT_ENABLED_TLD, DS03_SERVER_NO_DNSSEC_SUPPORT, DS03_SERVER_NO_NSEC3, DS03_UNASSIGNED_FLAG_USED
NO-NSEC3                     | DS03_NO_NSEC3                                     | DS03_ERR_MULT_NSEC3, DS03_ILLEGAL_HASH_ALGO, DS03_ILLEGAL_ITERATION_VALUE, DS03_ILLEGAL_SALT_LENGTH, DS03_INCONSISTENT_HASH_ALGO, DS03_INCONSISTENT_ITERATION, DS03_INCONSISTENT_NSEC3_FLAGS, DS03_INCONSISTENT_SALT_LENGTH, DS03_LEGAL_EMPTY_SALT, DS03_LEGAL_HASH_ALGO, DS03_LEGAL_ITERATION_VALUE, DS03_NO_DNSSEC_SUPPORT, DS03_NSEC3_OPT_OUT_DISABLED, DS03_NSEC3_OPT_OUT_ENABLED_NON_TLD, DS03_NSEC3_OPT_OUT_ENABLED_TLD, DS03_SERVER_NO_DNSSEC_SUPPORT, DS03_SERVER_NO_NSEC3, DS03_UNASSIGNED_FLAG_USED
GOOD-VALUES                  | DS03_LEGAL_EMPTY_SALT, DS03_LEGAL_HASH_ALGO, DS03_LEGAL_ITERATION_VALUE, DS03_NSEC3_OPT_OUT_DISABLED | DS03_ERR_MULT_NSEC3, DS03_ILLEGAL_HASH_ALGO, DS03_ILLEGAL_ITERATION_VALUE, DS03_ILLEGAL_SALT_LENGTH, DS03_INCONSISTENT_HASH_ALGO, DS03_INCONSISTENT_ITERATION, DS03_INCONSISTENT_NSEC3_FLAGS, DS03_INCONSISTENT_SALT_LENGTH, DS03_NO_DNSSEC_SUPPORT, DS03_NO_NSEC3, DS03_NSEC3_OPT_OUT_ENABLED_NON_TLD, DS03_NSEC3_OPT_OUT_ENABLED_TLD, DS03_SERVER_NO_DNSSEC_SUPPORT, DS03_SERVER_NO_NSEC3, DS03_UNASSIGNED_FLAG_USED
ERR-MULT-NSEC3               | DS03_ERR_MULT_NSEC3, DS03_LEGAL_EMPTY_SALT, DS03_LEGAL_HASH_ALGO, DS03_LEGAL_ITERATION_VALU, DS03_NSEC3_OPT_OUT_DISABLED | DS03_ILLEGAL_HASH_ALGO, DS03_ILLEGAL_ITERATION_VALUE, DS03_ILLEGAL_SALT_LENGTH, DS03_INCONSISTENT_HASH_ALGO, DS03_INCONSISTENT_ITERATION, DS03_INCONSISTENT_NSEC3_FLAGS, DS03_INCONSISTENT_SALT_LENGTH, DS03_NO_DNSSEC_SUPPORT, DS03_NO_NSEC3, DS03_NSEC3_OPT_OUT_ENABLED_NON_TLD, DS03_NSEC3_OPT_OUT_ENABLED_TLD, DS03_SERVER_NO_DNSSEC_SUPPORT, DS03_SERVER_NO_NSEC3, DS03_UNASSIGNED_FLAG_USED
BAD-VALUES                   | DS03_ILLEGAL_HASH_ALGO, DS03_ILLEGAL_ITERATION_VALUE, DS03_ILLEGAL_SALT_LENGTH, DS03_NSEC3_OPT_OUT_ENABLED_NON_TLD | DS03_ERR_MULT_NSEC3, DS03_INCONSISTENT_HASH_ALGO, DS03_INCONSISTENT_ITERATION, DS03_INCONSISTENT_NSEC3_FLAGS, DS03_INCONSISTENT_SALT_LENGTH, DS03_LEGAL_EMPTY_SALT, DS03_LEGAL_HASH_ALGO, DS03_LEGAL_ITERATION_VALUE, DS03_NO_DNSSEC_SUPPORT, DS03_NO_NSEC3, DS03_NSEC3_OPT_OUT_DISABLED, DS03_NSEC3_OPT_OUT_ENABLED_TLD, DS03_SERVER_NO_DNSSEC_SUPPORT, DS03_SERVER_NO_NSEC3, DS03_UNASSIGNED_FLAG_USED
INCONSISTENT-VALUES          | DS03_ILLEGAL_HASH_ALGO, DS03_ILLEGAL_ITERATION_VALUE, DS03_ILLEGAL_SALT_LENGTH, DS03_INCONSISTENT_HASH_ALGO, DS03_INCONSISTENT_ITERATION, DS03_INCONSISTENT_NSEC3_FLAGS, DS03_INCONSISTENT_SALT_LENGTH, DS03_LEGAL_EMPTY_SALT, DS03_LEGAL_HASH_ALGO, DS03_LEGAL_ITERATION_VALUE, DS03_NSEC3_OPT_OUT_DISABLED, DS03_NSEC3_OPT_OUT_ENABLED_NON_TLD | DS03_ERR_MULT_NSEC3, DS03_NO_DNSSEC_SUPPORT, DS03_NO_NSEC3, DS03_NSEC3_OPT_OUT_ENABLED_TLD, DS03_SERVER_NO_DNSSEC_SUPPORT, DS03_SERVER_NO_NSEC3, DS03_UNASSIGNED_FLAG_USED
NSEC3-OPT-OUT-ENABLED-TLD    | DS03_NSEC3_OPT_OUT_ENABLED_TLD, DS03_LEGAL_EMPTY_SALT, DS03_LEGAL_HASH_ALGO, DS03_LEGAL_ITERATION_VALUE | DS03_ERR_MULT_NSEC3, DS03_ILLEGAL_HASH_ALGO, DS03_ILLEGAL_ITERATION_VALUE, DS03_ILLEGAL_SALT_LENGTH, DS03_INCONSISTENT_HASH_ALGO, DS03_INCONSISTENT_ITERATION, DS03_INCONSISTENT_NSEC3_FLAGS, DS03_INCONSISTENT_SALT_LENGTH, DS03_NO_DNSSEC_SUPPORT, DS03_NO_NSEC3, DS03_NSEC3_OPT_OUT_DISABLED, DS03_NSEC3_OPT_OUT_ENABLED_NON_TLD, DS03_SERVER_NO_DNSSEC_SUPPORT, DS03_SERVER_NO_NSEC3, DS03_UNASSIGNED_FLAG_USED
SERVER-NO-DNSSEC-SUPPORT    | DS03_SERVER_NO_DNSSEC_SUPPORT, DS03_LEGAL_EMPTY_SALT, DS03_LEGAL_HASH_ALGO, DS03_LEGAL_ITERATION_VALUE, DS03_NSEC3_OPT_OUT_DISABLED | DS03_ERR_MULT_NSEC3, DS03_ILLEGAL_HASH_ALGO, DS03_ILLEGAL_ITERATION_VALUE, DS03_ILLEGAL_SALT_LENGTH, DS03_INCONSISTENT_HASH_ALGO, DS03_INCONSISTENT_ITERATION, DS03_INCONSISTENT_NSEC3_FLAGS, DS03_INCONSISTENT_SALT_LENGTH, DS03_NO_DNSSEC_SUPPORT, DS03_NO_NSEC3, DS03_NSEC3_OPT_OUT_ENABLED_NON_TLD, DS03_NSEC3_OPT_OUT_ENABLED_TLD, DS03_SERVER_NO_NSEC3, DS03_UNASSIGNED_FLAG_USED
SERVER-NO-NSEC3             | DS03_SERVER_NO_NSEC3, DS03_LEGAL_EMPTY_SALT, DS03_LEGAL_HASH_ALGO, DS03_LEGAL_ITERATION_VALUE, DS03_NSEC3_OPT_OUT_DISABLED | DS03_ERR_MULT_NSEC3, DS03_ILLEGAL_HASH_ALGO, DS03_ILLEGAL_ITERATION_VALUE, DS03_ILLEGAL_SALT_LENGTH, DS03_INCONSISTENT_HASH_ALGO, DS03_INCONSISTENT_ITERATION, DS03_INCONSISTENT_NSEC3_FLAGS, DS03_INCONSISTENT_SALT_LENGTH, DS03_NO_DNSSEC_SUPPORT, DS03_NO_NSEC3, DS03_NSEC3_OPT_OUT_ENABLED_NON_TLD, DS03_NSEC3_OPT_OUT_ENABLED_TLD, DS03_SERVER_NO_DNSSEC_SUPPORT, DS03_UNASSIGNED_FLAG_USED
UNASSIGNED-FLAG-USED        | DS03_UNASSIGNED_FLAG_USED, DS03_LEGAL_EMPTY_SALT, DS03_LEGAL_HASH_ALGO, DS03_LEGAL_ITERATION_VALUE, DS03_NSEC3_OPT_OUT_DISABLED | DS03_ERR_MULT_NSEC3, DS03_ILLEGAL_HASH_ALGO, DS03_ILLEGAL_ITERATION_VALUE, DS03_ILLEGAL_SALT_LENGTH, DS03_INCONSISTENT_HASH_ALGO, DS03_INCONSISTENT_ITERATION, DS03_INCONSISTENT_NSEC3_FLAGS, DS03_INCONSISTENT_SALT_LENGTH, DS03_NO_DNSSEC_SUPPORT, DS03_NO_NSEC3, DS03_NSEC3_OPT_OUT_ENABLED_NON_TLD, DS03_NSEC3_OPT_OUT_ENABLED_TLD, DS03_SERVER_NO_DNSSEC_SUPPORT, DS03_SERVER_NO_NSEC3


## Zone setup for test scenarios

Assumptions for the scenario specifications, unless stated otherwise for the
specific scenario:
1. Each zone is hosted by two NS, ns1 and ns2.
2. Both ns have equal hosting.
3. NS in delegation is equal to NS in zone.
4. All responses are authoritative.
5. RRSIG in responses are disregarded.
6. The actual owner name of the NSEC3 record will not be verified.
7. The record type list of the NSEC3 record will not be verified.
8. The zone is to respond with one SOA record with the zone name as owner name
   on SOA query.
9. The zone is to respond with one DNSKEY record with the zone name as owner
   name on DNSKEY query.
10. The zone is to respond with one NSEC3 record with a hash owner name in
    authority section on NSEC query (note, NSEC not NSEC3). NODATA response.
11. The NSEC3 record is to have the following settings:
  * Hash algo = 1
  * Flags = 0
  * Iteration = 0
  * Salt = "-" (no salt)

### NO-DNSSEC-SUPPORT
No DNSSEC support in the zone.

* Zone: "no-dnssec-support.dnssec03.xa."
  * No DNSKEY in query for DNSKEY (9).

### NO-NSEC3
No NSEC3 support in the zone.

* Zone: "no-nsec3.dnssec03.xa."
  * No NSEC3 in query for NSEC (10).

### GOOD-VALUES
Happy path

* Zone: "good-values.dnssec03.xa."

### ERR-MULT-NSEC3
Strange response with two NSEC3 records.

* Zone: "err-mult-nsec3.dnssec03.xa."
  * Two NSEC3 records, with different hash owner name are to be included in the
    response. RDATA can be identical. (10)
    
### BAD-VALUES
The NSEC3 record has values no permitted by RFC 9276, see the specification of
test case [DNSSEC03].

* Zone: "bad-values.dnssec03.xa."
  * The following values in NSEC3 (11):
    * Hash algo = 2
    * Flags = 1
    * Iteration = 1
    * Salt = "8104"

### INCONSISTENT-VALUES
The NSEC3 records returned from the two NS are not equal.

* Zone: "inconsistent-values.dnssec03.xa."
  * Both NS give the same owner name of the NSEC3 record, but
    ns1 gives standard values, whereas ns2 responds with an NSEC3 record with
    the following values: (2, 11)
    * Hash algo = 2
    * Flags = 1
    * Iteration = 1
    * Salt = "8104"
    
### NSEC3-OPT-OUT-ENABLED-TLD
On a TLD, opt-out just gives an INFO message.

* Zone: "nsec3-opt-out-enabled-tld-dnssec03." (TLD)
  * NSEC3 record with the following value: (11)
    * Flags = 1

### SERVER-NO-DNSSEC-SUPPORT
One NS of two does not support DNSSEC (no DNSKEY)

* Zone: "server-no-dnssec-support.dnssec03.xa"
  * ns2 does not return any DNSKEY record on DNSKEY query (2, 9)

### SERVER-NO-NSEC3
One NS of two does not have NSEC3

* Zone: "server-no-nsec3.dnssec03.xa"
  * ns2 does not return any NSEC3 record on NSEC query (2, 10)

### UNASSIGNED-FLAG-USED
Unassigned flag used.

* Zone: "unassigned-flag-used.dnssec03.xa"
  * NSEC3 record with the following value: (11)
    * Flags = 3


[DNSSEC03]:                                                       ../../tests/DNSSEC-TP/dnssec03.md
[RCODE Name]:                                                     https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[Test zone README file]:                                          ../README.md
[Well Formed CDS Record]:                                         #terminology
[Well Formed DNSKEY Record]:                                      #terminology
[Zone setup for test scenarios]:                                  #zone-setup-for-test-scenarios

