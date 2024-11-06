# Specification of Test Scenarios for DNSSEC10


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
This document specifies defined test scenarios for test case [DNSSEC10].


## Test scenarios

The purpose of the test scenarios is to cover all reasonable contexts where
different message tags are outputted when [DNSSEC10] is run on a test zone.
The message tags are defined in the test case ([DNSSEC10]) and the scenarios
are defined below.

The test scenarios are structured as stated in the [test scenario README file].

## Test zone names

The test zone or zones for each test scenario in this document is a subdomain
(or lower zone) delegated from the base name (`dnssec10.xa`) and that subdomain
having the same name as the scenario. The names of those zones are given in
section "[Test scenarios and setup of test zones]" below.


## All message tags
The test case can output any of these message tags, but not necessarily in any
combination. See [DNSSEC10] for the specification of the tags.

* DS10_ALGO_NOT_SUPPORTED_BY_ZM
* DS10_ERR_MULT_NSEC
* DS10_ERR_MULT_NSEC3
* DS10_EXPECTED_NSEC_NSEC3_MISSING
* DS10_HAS_NSEC
* DS10_HAS_NSEC3
* DS10_INCONSISTENT_NSEC
* DS10_INCONSISTENT_NSEC3
* DS10_INCONSISTENT_NSEC_NSEC3
* DS10_MIXED_NSEC_NSEC3
* DS10_NSEC3PARAM_GIVES_ERR_ANSWER
* DS10_NSEC3PARAM_QUERY_RESPONSE_ERR
* DS10_NSEC3_ERR_TYPE_LIST
* DS10_NSEC3_MISMATCHES_APEX
* DS10_NSEC3_MISSING_SIGNATURE
* DS10_NSEC3_NODATA_MISSING_SOA
* DS10_NSEC3_NODATA_WRONG_SOA
* DS10_NSEC3_NO_VERIFIED_SIGNATURE
* DS10_NSEC3_RRSIG_EXPIRED
* DS10_NSEC3_RRSIG_NOT_YET_VALID
* DS10_NSEC3_RRSIG_NO_DNSKEY
* DS10_NSEC3_RRSIG_VERIFY_ERROR
* DS10_NSEC_ERR_TYPE_LIST
* DS10_NSEC_GIVES_ERR_ANSWER
* DS10_NSEC_MISMATCHES_APEX
* DS10_NSEC_MISSING_SIGNATURE
* DS10_NSEC_NODATA_MISSING_SOA
* DS10_NSEC_NODATA_WRONG_SOA
* DS10_NSEC_NO_VERIFIED_SIGNATURE
* DS10_NSEC_QUERY_RESPONSE_ERR
* DS10_NSEC_RRSIG_EXPIRED
* DS10_NSEC_RRSIG_NOT_YET_VALID
* DS10_NSEC_RRSIG_NO_DNSKEY
* DS10_NSEC_RRSIG_VERIFY_ERROR
* DS10_SERVER_NO_DNSSEC
* DS10_ZONE_NO_DNSSEC


## Test scenarios and message tags

If a message tag is not listed for the scenario, its presence or non-presence is
irrelevant to the test scenario and must be ignored.

Scenario name                  | Mandatory message tag                                                        | Forbidden message tags
:------------------------------|:-----------------------------------------------------------------------------|:--------------------
GOOD-NSEC-1                    | DS10_HAS_NSEC                                                                | 2)
GOOD-NSEC3-1                   | DS10_HAS_NSEC3                                                               | 2)
ALGO-NOT-SUPP-BY-ZM-1          | DS10_ALGO_NOT_SUPPORTED_BY_ZM, DS10_HAS_NSEC                                 | 2)
ALGO-NOT-SUPP-BY-ZM-2          | DS10_ALGO_NOT_SUPPORTED_BY_ZM, DS10_HAS_NSEC3                                | 2)
ERR-MULT-NSEC-1                | DS10_ERR_MULT_NSEC, DS10_HAS_NSEC                                            | 2)
ERR-MULT-NSEC-2                | DS10_ERR_MULT_NSEC, DS10_HAS_NSEC                                            | 2)
ERR-MULT-NSEC3-1               | DS10_ERR_MULT_NSEC3, DS10_HAS_NSEC3                                          | 2)
EXP-NSEC-NSEC3-MISS-1          | DS10_EXPECTED_NSEC_NSEC3_MISSING                                             | 2)
INCONSISTENT-NSEC-1            | DS10_INCONSISTENT_NSEC, DS10_HAS_NSEC                                        | 2)
INCONSISTENT-NSEC3-1           | DS10_INCONSISTENT_NSEC3, DS10_HAS_NSEC3                                      | 2)
INCONSIST-NSEC-NSEC3-1         | DS10_INCONSISTENT_NSEC_NSEC3                                                 | 2)
INCONSIST-NSEC-NSEC3-2         | DS10_INCONSISTENT_NSEC_NSEC3, DS10_INCONSISTENT_NSEC, DS10_INCONSISTENT_NSEC3| 2)
MIXED-NSEC-NSEC3-1             | DS10_MIXED_NSEC_NSEC3                                                        | 2)
MIXED-NSEC-NSEC3-1             | DS10_MIXED_NSEC_NSEC3                                                        | 2)
NSEC3PARAM-GIVES-ERR-ANSWER-1  | DS10_NSEC3PARAM_GIVES_ERR_ANSWER, DS10_HAS_NSEC3                             | 2)
NSEC3PARAM-GIVES-ERR-ANSWER-2  | DS10_NSEC3PARAM_GIVES_ERR_ANSWER, DS10_EXPECTED_NSEC_NSEC3_MISSING           | 2)
NSEC3PARAM-GIVES-ERR-ANSWER-3  | DS10_NSEC3PARAM_GIVES_ERR_ANSWER, DS10_HAS_NSEC3                             | 2)
NSEC3PARAM-Q-RESPONSE-ERR-1    | DS10_NSEC3PARAM_QUERY_RESPONSE_ERR, DS10_HAS_NSEC3                           | 2)
NSEC3PARAM-Q-RESPONSE-ERR-2    | DS10_NSEC3PARAM_QUERY_RESPONSE_ERR, DS10_HAS_NSEC3                           | 2)
NSEC3PARAM-Q-RESPONSE-ERR-3    | DS10_NSEC3PARAM_QUERY_RESPONSE_ERR, DS10_EXPECTED_NSEC_NSEC3_MISSING         | 2)
NSEC3-ERR-TYPE-LIST-1          | DS10_NSEC3_ERR_TYPE_LIST, DS10_HAS_NSEC3                                     | 2)
NSEC3-ERR-TYPE-LIST-2          | DS10_NSEC3_ERR_TYPE_LIST, DS10_HAS_NSEC3                                     | 2)
NSEC3-MISMATCHES-APEX-1        | DS10_NSEC3_MISMATCHES_APEX, DS10_HAS_NSEC3                                   | 2)
NSEC3-MISSING-SIGNATURE-1      | DS10_NSEC3_MISSING_SIGNATURE, DS10_HAS_NSEC3                                 | 2)
NSEC3-NODATA-MISSING-SOA-1     | DS10_NSEC3_NODATA_MISSING_SOA, DS10_HAS_NSEC3                                | 2)
NSEC3-NODATA-WRONG-SOA-1       | DS10_NSEC3_NODATA_WRONG_SOA, DS10_HAS_NSEC3                                  | 2)
NSEC3-NO-VERIFIED-SIGNATURE-1  | DS10_NSEC3_NO_VERIFIED_SIGNATURE, DS10_HAS_NSEC3, DS10_NSEC3_RRSIG_NO_DNSKEY | 2)
NSEC3-NO-VERIFIED-SIGNATURE-2  | DS10_NSEC3_NO_VERIFIED_SIGNATURE, DS10_HAS_NSEC3, DS10_NSEC3_RRSIG_EXPIRED   | 2)
NSEC3-NO-VERIFIED-SIGNATURE-3  | DS10_NSEC3_NO_VERIFIED_SIGNATURE, DS10_HAS_NSEC3, DS10_NSEC3_RRSIG_NOT_YET_VALID | 2)
NSEC3-NO-VERIFIED-SIGNATURE-4  | DS10_NSEC3_NO_VERIFIED_SIGNATURE, DS10_HAS_NSEC3, DS10_NSEC3_RRSIG_VERIFY_ERROR  | 2)
NSEC-ERR-TYPE-LIST-1           | DS10_NSEC_ERR_TYPE_LIST, DS10_HAS_NSEC                                       | 2)
NSEC-ERR-TYPE-LIST-2           | DS10_NSEC_ERR_TYPE_LIST, DS10_HAS_NSEC                                       | 2)
NSEC-GIVES-ERR-ANSWER-1        | DS10_NSEC_GIVES_ERR_ANSWER, DS10_HAS_NSEC                                    | 2)
NSEC-GIVES-ERR-ANSWER-2        | DS10_NSEC_GIVES_ERR_ANSWER, DS10_EXPECTED_NSEC_NSEC3_MISSING                 | 2)
NSEC-MISMATCHES-APEX-1         | DS10_NSEC_MISMATCHES_APEX, DS10_HAS_NSEC                                     | 2)
NSEC-MISMATCHES-APEX-2         | DS10_NSEC_MISMATCHES_APEX, DS10_HAS_NSEC                                     | 2)
NSEC-MISSING-SIGNATURE-1       | DS10_NSEC_MISSING_SIGNATURE, DS10_HAS_NSEC                                   | 2)
NSEC-NODATA-MISSING-SOA-1      | DS10_NSEC_NODATA_MISSING_SOA, DS10_HAS_NSEC                                  | 2)
NSEC-NODATA-WRONG-SOA-1        | DS10_NSEC_NODATA_WRONG_SOA, DS10_HAS_NSEC                                    | 2)
NSEC-NO-VERIFIED-SIGNATURE-1   | DS10_NSEC_NO_VERIFIED_SIGNATURE, DS10_HAS_NSEC, DS10_NSEC_RRSIG_NO_DNSKEY    | 2)
NSEC-NO-VERIFIED-SIGNATURE-2   | DS10_NSEC_NO_VERIFIED_SIGNATURE, DS10_HAS_NSEC, DS10_NSEC_RRSIG_EXPIRED      | 2)
NSEC-NO-VERIFIED-SIGNATURE-3   | DS10_NSEC_NO_VERIFIED_SIGNATURE, DS10_HAS_NSEC, DS10_NSEC_RRSIG_NOT_YET_VALID| 2)
NSEC-NO-VERIFIED-SIGNATURE-4   | DS10_NSEC_NO_VERIFIED_SIGNATURE, DS10_HAS_NSEC, DS10_NSEC_RRSIG_VERIFY_ERROR | 2)
NSEC-QUERY-RESPONSE-ERR-1      | DS10_NSEC_QUERY_RESPONSE_ERR, DS10_HAS_NSEC                                  | 2)
NSEC-QUERY-RESPONSE-ERR-2      | DS10_NSEC_QUERY_RESPONSE_ERR, DS10_HAS_NSEC                                  | 2)
NSEC-QUERY-RESPONSE-ERR-3      | DS10_NSEC_QUERY_RESPONSE_ERR, DS10_EXPECTED_NSEC_NSEC3_MISSING               | 2)
SERVER-NO-DNSSEC-1             | DS10_SERVER_NO_DNSSEC, DS10_HAS_NSEC                                         | 2)
SERVER-NO-DNSSEC-2             | DS10_SERVER_NO_DNSSEC, DS10_HAS_NSEC3                                        | 2)
ZONE-NO-DNSSEC-1               | DS10_ZONE_NO_DNSSEC                                                          | 2)

* (1) All tags except for those specified as "Forbidden message tags" (no instances for these test scenarios)
* (2) All tags except for those specified as "Mandatory message tags"


## Test scenarios and setup of test zones

### Default zone configuration
Unless otherwise specified in the specific scenario specification, the test zone
or zones for the scenario will follow the default setup as stated below. The
`child zone` is the zone to be tested for the scenario.

* The child zone is `SCENARIO.dnssec10.xa`.
  * It is delegated to two name servers, `ns1.SCENARIO.dnssec10.xa`
    and `ns2.SCENARIO.dnssec10.xa`.
    * The name server names have A and AAAA records to avoid non-relevant error
      messages.
    * The delegation of the child zone is complete with glue records.
  * There is a zone file for the child zone.
  * All child zone servers give the same response.
  * The responses are either with NSEC record (NSEC zone) or NSEC3 record (NSEC3
    zone), not mixed.
* The parent zone is `dnssec10.xa`.
  * It is served by two in-bailiwick NS (ns1 and ns2).
  * ns1 and ns2 have the same zone content.
  * ns1 and ns2 have both IPv4 and IPv6 glue.
  * The records matching glue in the zone are complete.
* If the child zone is an NSEC zone:
  * Responds with an NSEC response on the NSEC3PARAM query.
  * Responds with an NSEC record in answer section on the NSEC query.
* If the child zone is an NSEC3 zone:
  * Responds with an NSEC3 response on the NSEC query.
  * Responds with an NSEC3PARAM record in answer section on the NSEC3PARAM query.
* All responses will have the AA bit set.
* All responses will have the [RCODE Name] "NoError".

### GOOD-NSEC-1
An NSEC zone and a "happy path". Everything is fine.

* Zone: good-nsec-1.dnssec10.xa

### GOOD-NSEC3-1
An NSEC3 zone and a "happy path". Everything is fine.

* Zone: good-nsec3-1.dnssec10.xa

### ALGO-NOT-SUPP-BY-ZM-1
An NSEC zone. Unknown algorithm of a DNSKEY.

* Zone: algo-not-supp-by-zm-1.dnssec10.xa
  * There is an extra RRSIG for the NSEC record (as the response to the
    NSEC3PARAM query).
    * That RRSIG has been created by [algorithm 255][IANA registry], which is
      private algorithm never supported.
    * A matching DNSKEY ([algorithm 255][IANA registry]) is available.
    * For this test scenario a fake signature and a fake public key are used.
  * The extra DNSKEY is in the DNSKEY RRset which is resigned by the valid
    KSK.

### ALGO-NOT-SUPP-BY-ZM-2
An NSEC3 zone. Unknown algorithm of a DNSKEY.

* Zone: algo-not-supp-by-zm-2.dnssec10.xa
  * There is an extra RRSIG for the NSEC3 record (as the response to the
    NSEC query).
    * That RRSIG has been created by [algorithm 255][IANA registry], which is
      private algorithm never supported.
    * A matching DNSKEY ([algorithm 255][IANA registry]) is available.
  * For this test scenario a fake signature and a fake public key are used.
  * The extra DNSKEY is in the DNSKEY RRset which is resigned by the valid
    KSK.

### ERR-MULT-NSEC-1
An NSEC zone. An extra NSEC record is returned on the NSEC3PARAM query.

* Zone: err-mult-nsec-1.dnssec10.xa
  * An extra NSEC record is returned in the response to the NSEC3PARAM query.
    * The extra NSEC record has the same owner name, but different value in
      "Next Domain Name" field.
  * RRSIG is recalculated.

### ERR-MULT-NSEC-2
An NSEC zone. An extra NSEC record is returned on the NSEC query.

* Zone: err-mult-nsec-2.dnssec10.xa
  * An extra NSEC record is returned in the response to the NSEC query.
    * The extra NSEC record has the same owner name, but different value in
      "Type List" field.
  * RRSIG is recalculated.

### ERR-MULT-NSEC3-1
An NSEC3 zone. An extra NSEC3 record is returned.

* Zone: err-mult-nsec3-1.dnssec10.xa
  * An extra NSEC3 record is returned in the response to the NSEC query.
    * The extra NSEC3 record has the same hashowner name, but different value in
      "Next Hashed Owner Name" field.
  * For this test scenario a fake signature can be used.

### EXP-NSEC-NSEC3-MISS-1
A zone without NSEC and NSEC3. There is no NSEC or NSEC3 function.

* Zone: exp-nsec-nsec3-miss-1.dnssec10.xa
  * The NSEC query gives a NODATA response with no NSEC or NSEC3 record.
  * The NSEC3PARAM query gives a NODATA response with no NSEC or NSEC3 record.

### INCONSISTENT-NSEC-1
An NSEC zone. Some errors in NSEC handling.

* Zone: inconsistent-nsec-1.dnssec10.xa
  * ns1 includes no NSEC record in the nodata response on the NSEC3PARAM query.
  * ns2 includes no NSEC record in the nodata response on the NSEC query.

### INCONSISTENT-NSEC3-1
An NSEC3 zone. Some errors in NSEC3 handling.

* Zone: inconsistent-nsec3-1.dnssec10.xa
  * ns1 includes no NSEC3 record in the NODATA response on the NSEC query.
  * ns2 includes no NSEC3PARAM or NSEC3 record in the NODATA response on the
    NSEC3PARAM query.

### INCONSIST-NSEC-NSEC3-1
Mixing beteen NSEC and NSEC3.

* Zone: inconsist-nsec-nsec3-1.dnssec10.xa
  * ns1 holds an NSEC version of the zone.
  * ns2 holds an NSEC3 version of the zone.

### INCONSIST-NSEC-NSEC3-2
NSEC on one server and NSEC3 on the other plus errors in NSEC and NSEC3 handling.

* Zone: inconsist-nsec-nsec3-2.dnssec10.xa
  * ns1 holds an NSEC version of the zone.
    * It responds with a NODATA respond without NSEC record on the NSEC3PARAM
      query.
    * It does respond with an NSEC record to the NSEC query.
  * ns2 holds an NSEC3 version of the zone.
    * It responds with a NODATA respond without NSEC3 record on the NSEC query.
    * It does respond with an NSEC3PARAM record to the NSEC3PARAM query.

### MIXED-NSEC-NSEC3-1
Servers gives both NSEC and NSEC3

* Zone: mixed-nsec-nsec3-1.dnssec10.xa
  * The zone gives an NSEC record in response to NSEC query.
  * The zone gives an NSEC3PARAM record in response to the NSEC3PARAM query.

### MIXED-NSEC-NSEC3-2
Servers gives both NSEC and NSEC3

* Zone: mixed-nsec-nsec3-2.dnssec10.xa
  * The zone gives a NODATA response with NSEC3 record in response to NSEC
    query.
  * The zone gives a NODATA response with NSEC record in response to the
    NSEC3PARAM query.

### NSEC3PARAM-GIVES-ERR-ANSWER-1
An NSEC3 zone. Error in response to NSEC3PARAM query.

* Zone: nsec3param-gives-err-answer-1.dnssec10.xa
  * The zone gives a TXT record, but no NSEC3PARAM record, in response to the
    NSEC3PARAM query.

### NSEC3PARAM-GIVES-ERR-ANSWER-2
An NSEC3 zone. Error in response to NSEC3PARAM query on ns1. No NSEC or NSEC3 on
ns2.

* Zone: nsec3param-gives-err-answer-1.dnssec10.xa
  * On ns1, the zone gives a TXT record, but no NSEC3PARAM record, in response to
    the NSEC3PARAM query.
  * On ns2, the zone gives NODATA responses without NSEC or NSEC3 record for both
    the NSEC3PARAM query and the NSEC query.

### NSEC3PARAM-GIVES-ERR-ANSWER-3
An NSEC3 zone. Error in response to NSEC3PARAM query.

* Zone: nsec3param-gives-err-answer-3.dnssec10.xa
  * The owner name of the NSEC3PARAM record in response to the NSEC3PARAM query
    is errouneous and does not match apex.
    * The owner name is `sub.nsec3param-gives-err-answer-3.dnssec10.xa` instead
      of expected `nsec3param-gives-err-answer-3.dnssec10.xa`.

## NSEC3PARAM-Q-RESPONSE-ERR-1
An NSEC3 zone. Error in response to NSEC3PARAM query.

* Zone: nsec3param-q-response-err-1.dnssec10.xa
  * No DNS response on the NSEC3PARAM query.

## NSEC3PARAM-Q-RESPONSE-ERR-2
An NSEC3 zone. Error in response to NSEC3PARAM query.

* Zone: nsec3param-q-response-err-2.dnssec10.xa
  * The response on the NSEC3PARAM query has the [RCODE Name] "REFUSED".

## NSEC3PARAM-Q-RESPONSE-ERR-3
An NSEC3 zone. Error in response to NSEC3PARAM query on ns1. No NSEC or NSEC3 on
ns2.

* Zone: nsec3param-q-response-err-3.dnssec10.xa
  * The response from ns1 on the NSEC3PARAM query has the AA flag unset.
  * On ns2, the zone gives NODATA responses without NSEC or NSEC3 record for both
    the NSEC3PARAM query and the NSEC query.

### NSEC3-ERR-TYPE-LIST-1
An NSEC3 zone. The type list of the NSEC3 record is erroneous.

* Zone: nsec3-err-type-list-1.dnssec10.xa
  * The type list of the NSEC3 record includes NSEC.

### NSEC3-ERR-TYPE-LIST-2
An NSEC3 zone. The type list of the NSEC3 record is erroneous.

* Zone: nsec3-err-type-list-2.dnssec10.xa
  * The type list of the NSEC3 record misses RRSIG.

### NSEC3-MISMATCHES-APEX-1
An NSEC3 zone. The hash owner name of the NSEC3 record is erroneous.

* Zone: nsec3-mismatches-apex-1.dnssec10.xa
  * The hash owner name of the NSEC3 record in response to the NSEC query is
    erroneous and does not match apex.

### NSEC3-MISSING-SIGNATURE-1
An NSEC3 zone. The RRSIG is missing

* Zone: nsec3-missing-signature-1.dnssec10.xa
  * There is no RRSIG for the NSEC3 record in the response with NSEC3 record.

### NSEC3-NODATA-MISSING-SOA-1
An NSEC3 zone. The SOA record is missing in the NODATA response.

* Zone: nsec3-nodata-missing-soa-1.dnssec10.xa
  * In the NODATA response to the NSEC query the SOA record is missing.

### NSEC3-NODATA-WRONG-SOA-1
An NSEC3 zone. In the NODATA response the SOA record has the wrong owner name.

* Zone: nsec3-nodata-wrong-soa-1.dnssec10.xa
  * The owner name of the SOA record in the NODATA response to the NSEC query
    is `sub.nsec3-nodata-wrong-soa-1.dnssec10.xa` instead of expected
    `nsec3-nodata-wrong-soa-1.dnssec10.xa`.

### NSEC3-NO-VERIFIED-SIGNATURE-1
An NSEC3 zone. The RRSIG for the NSEC3 record cannot be verified.

* Zone: nsec3-no-verified-signature-1.dnssec10.xa
  * The RRSIG record for the NSEC3 record in the NODATA response to the NSEC
    query cannot be verified.
    * There is no matching DNSKEY for the RRSIG for the NSEC3 record.

### NSEC3-NO-VERIFIED-SIGNATURE-2
An NSEC3 zone. The RRSIG for the NSEC3 record cannot be verified.

* Zone: nsec3-no-verified-signature-2.dnssec10.xa
  * The RRSIG record for the NSEC3 record in the NODATA response to the NSEC
    query cannot be verified.
    * The RRSIG has expired, i.e. the current date-time is beyond the last valid
      date-time.

### NSEC3-NO-VERIFIED-SIGNATURE-3
An NSEC3 zone. The RRSIG for the NSEC3 record cannot be verified.

* Zone: nsec3-no-verified-signature-3.dnssec10.xa
  * The RRSIG record for the NSEC3 record in the NODATA response to the NSEC
    query cannot be verified.
    * The RRSIG it not yet valid, i.e. the current date-time is before the first
      valid date-time.

### NSEC3-NO-VERIFIED-SIGNATURE-4
An NSEC3 zone. The RRSIG for the NSEC3 record cannot be verified.

* Zone: nsec3-no-verified-signature-4.dnssec10.xa
  * The RRSIG record for the NSEC3 record in the NODATA response to the NSEC
    query cannot be verified.
    * The RRSIG signature does not match the NSEC record and appointed DNSKEY.

### NSEC-ERR-TYPE-LIST-1
An NSEC zone. The type list of the NSEC record is erroneous.

* Zone: nsec-err-type-list-1.dnssec10.xa
  * The type list of the NSEC record includes NSEC3PARAM.

### NSEC-ERR-TYPE-LIST-2
An NSEC zone. The type list of the NSEC record is erroneous.

* Zone: nsec-err-type-list-2.dnssec10.xa
  * The type list of the NSEC record misses RRSIG.

### NSEC-GIVES-ERR-ANSWER-1
An NSEC zone. Error in response to NSEC query.

* Zone: nsec-gives-err-answer-1.dnssec10.xa
  * The zone gives a TXT record, but no NSEC record, in response to the NSEC
    query.

### NSEC-GIVES-ERR-ANSWER-2
An NSEC zone. Error in response to NSEC query on ns1. No NSEC or NSEC3 on ns2.

* Zone: nsec-gives-err-answer-2.dnssec10.xa
  * On ns1, the zone gives a TXT record, but no NSEC record, in response to the
    NSEC query.
  * On ns2, the zone gives NODATA responses without NSEC or NSEC3 record for both
    the NSEC3PARAM query and the NSEC query.

### NSEC-MISMATCHES-APEX-1
An NSEC zone. The owner name of the NSEC record is errouneous.

* Zone: nsec-mismatches-apex-1.dnssec10.xa
  * The owner name of the NSEC record in response to the NSEC3PARAM query is
    errouneous and does not match apex.
    * The owner name is `sub.nsec-mismatches-apex-1.dnssec10.xa` instead of
      expected `nsec-mismatches-apex-1.dnssec10.xa`.

### NSEC-MISMATCHES-APEX-2
An NSEC zone. The owner name of the NSEC record is errouneous.

* Zone: nsec-mismatches-apex-2.dnssec10.xa
  * The owner name of the NSEC record in response to the NSEC query is
    errouneous and does not match apex.
    * The owner name is `sub.nsec-mismatches-apex-2.dnssec10.xa` instead of
      expected `nsec-mismatches-apex-2.dnssec10.xa`.

### NSEC-MISSING-SIGNATURE-1
An NSEC zone. The RRSIG is missing.

* Zone: nsec-missing-signature-1.dnssec10.xa
  * There is no RRSIG for the NSEC record in the response with NSEC record on the
    NSEC3PARAM query.

### NSEC-NODATA-MISSING-SOA-1
An NSEC zone. The SOA record is missing in the NODATA response.

* Zone: nsec-nodata-missing-soa-1.dnssec10.xa
  * In the NODATA response to the NSEC3PARAM query the SOA record is missing.

### NSEC-NODATA-WRONG-SOA-1
An NSEC zone. In the NODATA response the SOA record has the wrong owner name.

* Zone: nsec-nodata-wrong-soa-1.dnssec10.xa
  * The owner name of the SOA record in the NODATA response to the NSEC3PARAM
    query is `sub.nsec-nodata-wrong-soa-1.dnssec10.xa` instead of expected
    `nsec-nodata-wrong-soa-1.dnssec10.xa`.

### NSEC-NO-VERIFIED-SIGNATURE-1
An NSEC zone. The RRSIG for the NSEC record cannot be verified.

* Zone: nsec-no-verified-signature-1.dnssec10.xa
  * The RRSIG record for the NSEC record in the NODATA response to the NSEC3PARAM
    query cannot be verified.
    * There is no matching DNSKEY for the RRSIG for that NSEC record.

### NSEC-NO-VERIFIED-SIGNATURE-2
An NSEC zone. The RRSIG for the NSEC record cannot be verified.

* Zone: nsec-no-verified-signature-2.dnssec10.xa
  * The RRSIG record for the NSEC record in the NODATA response to the NSEC3PARAM
    query cannot be verified.
    * The RRSIG has expired, i.e. the current date-time is beyond the last valid
      date-time.

### NSEC-NO-VERIFIED-SIGNATURE-3
An NSEC zone. The RRSIG for the NSEC record cannot be verified.

* Zone: nsec-no-verified-signature-3.dnssec10.xa
  * The RRSIG record for the NSEC record in the NODATA response to the NSEC3PARAM
    query cannot be verified.
    * The RRSIG it not yet valid, i.e. the current date-time is before the first
      valid date-time.

### NSEC-NO-VERIFIED-SIGNATURE-4
An NSEC zone. The RRSIG for the NSEC record cannot be verified.

* Zone: nsec-no-verified-signature-4.dnssec10.xa
  * The RRSIG record for the NSEC record in the NODATA response to the NSEC3PARAM
    query cannot be verified.
    * The RRSIG signature does not match the RRSIG record and appointed DNSKEY.

### NSEC-QUERY-RESPONSE-ERR-1
An NSEC zone. Error in response to NSEC query.

* Zone: nsec-query-response-err-1.dnssec10.xa
  * No DNS response on the NSEC query.

### NSEC-QUERY-RESPONSE-ERR-2
An NSEC zone. Error in response to NSEC query.

* Zone: nsec-query-response-err-2.dnssec10.xa
  * The response on the NSEC query has the [RCODE Name] "REFUSED".

### NSEC-QUERY-RESPONSE-ERR-3
An NSEC zone. Error in response to NSEC query on ns1. No NSEC or NSEC3 in
responsess from ns2.

* Zone: nsec-query-response-err-3.dnssec10.xa
  * The response from ns1 on the NSEC query has the AA flag unset.
  * On ns2, the zone gives NODATA responses without NSEC or NSEC3 record for both
    the NSEC3PARAM query and the NSEC query.

### SERVER-NO-DNSSEC-1
An NSEC zone. No DNSKEY in response from ns1. Normal response from ns2.

* Zone: server-no-dnssec-1.dnssec10.xa
  * The answer section in response from ns1 on the DNSKEY query is empty. Unsigned
    NODATA response without NSEC or NSEC3.
  * The NSEC and NSEC3PARAM queries are irrelevant, but they also give a Unsigned
    NODATA response without NSEC or NSEC3 on ns1.

### SERVER-NO-DNSSEC-2
An NSEC3 zone. No DNSKEY in response from ns1. Normal response from ns2.

* Zone: server-no-dnssec-2.dnssec10.xa
  * The answer section in response from ns1 on the DNSKEY query is empty. Unsigned
    NODATA response without NSEC or NSEC3.
  * The NSEC and NSEC3PARAM queries are irrelevant, but they also give a Unsigned
    NODATA response without NSEC or NSEC3 on ns1.

### ZONE-NO-DNSSEC-1
No DNSKEY in response. 

* Zone: zone-no-dnssec-1.dnssec10.xa
  * The answer section in response on the DNSKEY query is empty. Unsigned NODATA
    response without NSEC or NSEC3.
  * The NSEC and NSEC3PARAM queries are irrelevant, but they also give a Unsigned
    NODATA response without NSEC or NSEC3.


[DNSSEC10]:                                                        ../../tests/DNSSEC-TP/dnssec10.md
[IANA registry]:                                                  https://www.iana.org/assignments/dns-sec-alg-numbers/dns-sec-alg-numbers.xml
[RCODE Name]:                                                     https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[Test scenario README file]:                                      ../README.md
[Test scenarios and setup of test zones]:                         #test-scenarios-and-setup-of-test-zones

