# Delegation01 Test Zones Output

# Table of contents
* [Introduction](#introduction)
* [All message tags](#all-message-tags)
* [All scenarios](#all-scenarios)
* [zonemaster-cli commands and their output for each test scenario](#zonemaster-cli-commands-and-their-output-for-each-test-scenario)


**Until the implementation has been completed this file is only a draft.**


## Introduction

In this file the output of running `zonemaster-cli` for every test zone is
found. This file is created during the development of the test zones and should
be updated as the implementation of the test case or the test scenarios or test
zones are updated or corrected.

During development and any update this document serves as tracking and log tool.
It also serves as a template for future development of test zones for
scenarios for other test cases.

## All message tags

* DS10_ALGO_NOT_SUPPORTED_BY_ZM
* DS10_ERR_MULT_NSEC
* DS10_ERR_MULT_NSEC3
* DS10_ERR_MULT_NSEC3PARAM
* DS10_EXPECTED_NSEC_NSEC3_MISSING
* DS10_HAS_NSEC
* DS10_HAS_NSEC3
* DS10_INCONSISTENT_NSEC
* DS10_INCONSISTENT_NSEC3
* DS10_INCONSISTENT_NSEC_NSEC3
* DS10_MIXED_NSEC_NSEC3
* DS10_NSEC3PARAM_GIVES_ERR_ANSWER
* DS10_NSEC3PARAM_MISMATCHES_APEX
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


## All scenarios

Scenario name                  | Zone name
:------------------------------|:---------------------------------------------
GOOD-NSEC-1                    | good-nsec-1.dnssec10.xa
GOOD-NSEC3-1                   | good-nsec3-1.dnssec10.xa
ALGO-NOT-SUPP-BY-ZM-1          | algo-not-supp-by-zm-1.dnssec10.xa
ALGO-NOT-SUPP-BY-ZM-2          | algo-not-supp-by-zm-2.dnssec10.xa
ERR-MULT-NSEC-1                | err-mult-nsec-1.dnssec10.xa
ERR-MULT-NSEC-2                | err-mult-nsec-2.dnssec10.xa
ERR-MULT-NSEC3-1               | err-mult-nsec3-1.dnssec10.xa
ERR-MULT-NSEC3PARAM-1          | err-mult-nsec3param-1.dnssec10.xa
EXP-NSEC-NSEC3-MISS-1          | exp-nsec-nsec3-miss-1.dnssec10.xa
INCONSISTENT-NSEC-1            | inconsistent-nsec-1.dnssec10.xa
INCONSISTENT-NSEC3-1           | inconsistent-nsec3-1.dnssec10.xa
INCONSIST-NSEC-NSEC3-1         | inconsist-nsec-nsec3-1.dnssec10.xa
INCONSIST-NSEC-NSEC3-2         | inconsist-nsec-nsec3-2.dnssec10.xa
MIXED-NSEC-NSEC3-1             | mixed-nsec-nsec3-1.dnssec10.xa
MIXED-NSEC-NSEC3-1             | mixed-nsec-nsec3-2.dnssec10.xa
NSEC3PARAM-GIVES-ERR-ANSWER-1  | nsec3param-gives-err-answer-1.dnssec10.xa
NSEC3PARAM-GIVES-ERR-ANSWER-2  | nsec3param-gives-err-answer-1.dnssec10.xa
NSEC3PARAM-MISMATCHES-APEX-1   | nsec3param-mismatches-apex-1.dnssec10.xa
NSEC3PARAM-Q-RESPONSE-ERR-1    | nsec3param-q-response-err-1.dnssec10.xa
NSEC3PARAM-Q-RESPONSE-ERR-2    | nsec3param-q-response-err-2.dnssec10.xa
NSEC3PARAM-Q-RESPONSE-ERR-3    | nsec3param-q-response-err-3.dnssec10.xa
NSEC3-ERR-TYPE-LIST-1          | nsec3-err-type-list-1.dnssec10.xa
NSEC3-ERR-TYPE-LIST-2          | nsec3-err-type-list-2.dnssec10.xa
NSEC3-MISMATCHES-APEX-1        | nsec3-mismatches-apex-1.dnssec10.xa
NSEC3-MISSING-SIGNATURE-1      | nsec3-missing-signature-1.dnssec10.xa
NSEC3-NODATA-MISSING-SOA-1     | nsec3-nodata-missing-soa-1.dnssec10.xa
NSEC3-NODATA-WRONG-SOA-1       | nsec3-nodata-wrong-soa-1.dnssec10.xa
NSEC3-NO-VERIFIED-SIGNATURE-1  | nsec3-no-verified-signature-1.dnssec10.xa
NSEC3-NO-VERIFIED-SIGNATURE-2  | nsec3-no-verified-signature-2.dnssec10.xa
NSEC3-NO-VERIFIED-SIGNATURE-3  | nsec3-no-verified-signature-3.dnssec10.xa
NSEC3-NO-VERIFIED-SIGNATURE-4  | nsec3-no-verified-signature-4.dnssec10.xa
NSEC-ERR-TYPE-LIST-1           | nsec-err-type-list-1.dnssec10.xa
NSEC-ERR-TYPE-LIST-2           | nsec-err-type-list-2.dnssec10.xa
NSEC-GIVES-ERR-ANSWER-1        | nsec-gives-err-answer-1.dnssec10.xa
NSEC-GIVES-ERR-ANSWER-2        | nsec-gives-err-answer-2.dnssec10.xa
NSEC-MISMATCHES-APEX-1         | nsec-mismatches-apex-1.dnssec10.xa
NSEC-MISMATCHES-APEX-2         | nsec-mismatches-apex-2.dnssec10.xa
NSEC-MISSING-SIGNATURE-1       | nsec-missing-signature-1.dnssec10.xa
NSEC-NODATA-MISSING-SOA-1      | nsec-nodata-missing-soa-1.dnssec10.xa
NSEC-NODATA-WRONG-SOA-1        | nsec-nodata-wrong-soa-1.dnssec10.xa
NSEC-NO-VERIFIED-SIGNATURE-1   | nsec-no-verified-signature-1.dnssec10.xa
NSEC-NO-VERIFIED-SIGNATURE-2   | nsec-no-verified-signature-2.dnssec10.xa
NSEC-NO-VERIFIED-SIGNATURE-3   | nsec-no-verified-signature-3.dnssec10.xa
NSEC-NO-VERIFIED-SIGNATURE-4   | nsec-no-verified-signature-4.dnssec10.xa
NSEC-QUERY-RESPONSE-ERR-1      | nsec-query-response-err-1.dnssec10.xa
NSEC-QUERY-RESPONSE-ERR-2      | nsec-query-response-err-2.dnssec10.xa
NSEC-QUERY-RESPONSE-ERR-3      | nsec-query-response-err-3.dnssec10.xa
SERVER-NO-DNSSEC-1             | server-no-dnssec-1.dnssec10.xa
SERVER-NO-DNSSEC-2             | server-no-dnssec-2.dnssec10.xa
ZONE-NO-DNSSEC-1               | zone-no-dnssec-1.dnssec10.xa

## zonemaster-cli commands and their output for each test scenario

For this test case it is only meaningful to test the test zones with `--level=info --test=dnssec10`.

All commands are run from the same directory as this file is in.


**Before the implementation has been updated it is not meaningful to run the tests here.**


Scenario name                  | Mandatory message tag                                                        | Forbidden message tags
:------------------------------|:-----------------------------------------------------------------------------|:--------------------
GOOD-NSEC-1                    | DS10_HAS_NSEC                                                                | 2)

* (2) All tags except for those specified as "Mandatory message tags"

```
$ zonemaster-cli --show-testcase --level INFO --test dnssec10 --hint ../../COMMON/hintfile GOOD-NSEC-1.dnssec10.xa

Seconds Level    Testcase       Message
======= ======== ============== =======
   0.00 INFO     Unspecified    Using version v6.0.0 of the Zonemaster engine.
```

Scenario name                  | Mandatory message tag                                                        | Forbidden message tags
:------------------------------|:-----------------------------------------------------------------------------|:--------------------
GOOD-NSEC-1                    | DS10_HAS_NSEC                                                                | 2)
GOOD-NSEC3-1                   | DS10_HAS_NSEC3                                                               | 2)
ALGO-NOT-SUPP-BY-ZM-1          | DS10_ALGO_NOT_SUPPORTED_BY_ZM, DS10_HAS_NSEC                                 | 2)
ALGO-NOT-SUPP-BY-ZM-2          | DS10_ALGO_NOT_SUPPORTED_BY_ZM, DS10_HAS_NSEC3                                | 2)
ERR-MULT-NSEC-1                | DS10_ERR_MULT_NSEC, DS10_HAS_NSEC                                            | 2)
ERR-MULT-NSEC-2                | DS10_ERR_MULT_NSEC, DS10_HAS_NSEC                                            | 2)
ERR-MULT-NSEC3-1               | DS10_ERR_MULT_NSEC3, DS10_HAS_NSEC3                                          | 2)
ERR-MULT-NSEC3PARAM-1          | DS10_ERR_MULT_NSEC3PARAM, DS10_HAS_NSEC3                                     | 2)
EXP-NSEC-NSEC3-MISS-1          | DS10_EXPECTED_NSEC_NSEC3_MISSING                                             | 2)
INCONSISTENT-NSEC-1            | DS10_INCONSISTENT_NSEC, DS10_HAS_NSEC                                        | 2)
INCONSISTENT-NSEC3-1           | DS10_INCONSISTENT_NSEC3, DS10_HAS_NSEC3                                      | 2)
INCONSIST-NSEC-NSEC3-1         | DS10_INCONSISTENT_NSEC_NSEC3                                                 | 2)
INCONSIST-NSEC-NSEC3-2         | DS10_INCONSISTENT_NSEC_NSEC3, DS10_INCONSISTENT_NSEC, DS10_INCONSISTENT_NSEC3| 2)
MIXED-NSEC-NSEC3-1             | DS10_MIXED_NSEC_NSEC3                                                        | 2)
MIXED-NSEC-NSEC3-2             | DS10_MIXED_NSEC_NSEC3                                                        | 2)
NSEC3PARAM-GIVES-ERR-ANSWER-1  | DS10_NSEC3PARAM_GIVES_ERR_ANSWER, DS10_HAS_NSEC3, DS10_INCONSISTENT_NSEC3    | 2)
NSEC3PARAM-GIVES-ERR-ANSWER-2  | DS10_NSEC3PARAM_GIVES_ERR_ANSWER, DS10_EXPECTED_NSEC_NSEC3_MISSING, DS10_INCONSISTENT_NSEC3 and DS10_HAS_NSEC3 | 2)
NSEC3PARAM-MISMATCHES-APEX-1   | DS10_NSEC3PARAM_MISMATCHES_APEX, DS10_HAS_NSEC3                              | 2)
NSEC3PARAM-Q-RESPONSE-ERR-1    | DS10_NSEC3PARAM_QUERY_RESPONSE_ERR, DS10_HAS_NSEC3, DS10_INCONSISTENT_NSEC3  | 2)
NSEC3PARAM-Q-RESPONSE-ERR-2    | DS10_NSEC3PARAM_QUERY_RESPONSE_ERR, DS10_HAS_NSEC3, DS10_INCONSISTENT_NSEC3  | 2)
NSEC3PARAM-Q-RESPONSE-ERR-3    | DS10_NSEC3PARAM_QUERY_RESPONSE_ERR, DS10_EXPECTED_NSEC_NSEC3_MISSING, DS10_INCONSISTENT_NSEC3 | 2)
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
NSEC-GIVES-ERR-ANSWER-1        | DS10_NSEC_GIVES_ERR_ANSWER, DS10_HAS_NSEC, DS10_INCONSISTENT_NSEC            | 2)
NSEC-GIVES-ERR-ANSWER-2        | DS10_NSEC_GIVES_ERR_ANSWER, DS10_EXPECTED_NSEC_NSEC3_MISSING, DS10_INCONSISTENT_NSEC, DS10_HAS_NSEC | 2)
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

