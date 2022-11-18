# Specification of test data for DNSSEC16


## Table of contents

* [Background](#background)
* [Test Case](#test-case)
* [Test scenarios](#test-scenarios)
* [Test zone names](#test-zone-names)
* [Test scenarios and message tags](#test-scenarios-and-message-tags)
* [Zone setup for test scenarios]


## Background

See the [test zone and test data README file].


## Test Case
This document specifies available test data for test case [DNSSEC16].


## Test scenarios

The purpose of the test scenarios is to cover all reasonable contexts where
different message tags are outputted when [DNSSEC16] is run on a test zone. The
message tags are defined in the test case ([DNSSEC16]) and the scenarios are
defined below.

The scenarios are defined in two parts. First part defines the expectations on
message tags from [DNSSEC16] when Zonemaster is run against zone set up for the
scenario:

* What messages must be outputted (mandatory).
* What messages must not be outputted (forbidden).

The second part specifies the zone setup for the scenario.


## Test zone names

The test zone for each test scenario in this docuemtn is a subdomain delegated
from the base name (`dnssec16.xa`) and that subdomain having the same name as the
scenario except where the test domain must be the root zone, a TLD or a domain
under `.arpa`. The names of those zones are given in section
"[Zone setup for test scenarios]" below.


## Test scenarios and message tags

If a message tag is not listed for the scenario, its presence or non-presence is
irrelevant to the test scenario and must be ignored.


Scenario name                | Mandatory message tags                            | Forbidden message tags
:----------------------------|:--------------------------------------------------|:-------------------------------------------
CDS-INVALID-RRSIG            | DS16_CDS_INVALID_RRSIG                            | DS16_CDS_MATCHES_NON_SEP_DNSKEY, DS16_CDS_MATCHES_NON_ZONE_DNSKEY, DS16_CDS_MATCHES_NO_DNSKEY, DS16_CDS_NOT_SIGNED_BY_CDS, DS16_CDS_SIGNED_BY_UNKNOWN_DNSKEY, DS16_CDS_UNSIGNED, DS16_CDS_WITHOUT_DNSKEY, DS16_DELETE_CDS, DS16_DNSKEY_NOT_SIGNED_BY_CDS, DS16_MIXED_DELETE_CDS
CDS-MATCHES-NO-DNSKEY        | DS16_CDS_MATCHES_NO_DNSKEY                        | DS16_CDS_INVALID_RRSIG, DS16_CDS_MATCHES_NON_SEP_DNSKEY, DS16_CDS_MATCHES_NON_ZONE_DNSKEY, DS16_CDS_NOT_SIGNED_BY_CDS, DS16_CDS_SIGNED_BY_UNKNOWN_DNSKEY, DS16_CDS_UNSIGNED, DS16_CDS_WITHOUT_DNSKEY, DS16_DELETE_CDS, DS16_DNSKEY_NOT_SIGNED_BY_CDS, DS16_MIXED_DELETE_CDS
CDS-MATCHES-NON-SEP-DNSKEY   | DS16_CDS_MATCHES_NON_SEP_DNSKEY                   | DS16_CDS_INVALID_RRSIG, DS16_CDS_MATCHES_NON_ZONE_DNSKEY, DS16_CDS_MATCHES_NO_DNSKEY, DS16_CDS_NOT_SIGNED_BY_CDS, DS16_CDS_SIGNED_BY_UNKNOWN_DNSKEY, DS16_CDS_UNSIGNED, DS16_CDS_WITHOUT_DNSKEY, DS16_DELETE_CDS, DS16_DNSKEY_NOT_SIGNED_BY_CDS, DS16_MIXED_DELETE_CDS
CDS-MATCHES-NON-ZONE-DNSKEY  | DS16_CDS_MATCHES_NON_ZONE_DNSKEY                  | DS16_CDS_INVALID_RRSIG, DS16_CDS_MATCHES_NON_SEP_DNSKEY, DS16_CDS_MATCHES_NO_DNSKEY, DS16_CDS_NOT_SIGNED_BY_CDS, DS16_CDS_SIGNED_BY_UNKNOWN_DNSKEY, DS16_CDS_UNSIGNED, DS16_CDS_WITHOUT_DNSKEY, DS16_DELETE_CDS, DS16_DNSKEY_NOT_SIGNED_BY_CDS, DS16_MIXED_DELETE_CDS
CDS-NOT-SIGNED_BY_CDS        | DS16_CDS_NOT_SIGNED_BY_CDS                        | DS16_CDS_INVALID_RRSIG, DS16_CDS_MATCHES_NON_SEP_DNSKEY, DS16_CDS_MATCHES_NON_ZONE_DNSKEY, DS16_CDS_MATCHES_NO_DNSKEY, DS16_CDS_SIGNED_BY_UNKNOWN_DNSKEY, DS16_CDS_UNSIGNED, DS16_CDS_WITHOUT_DNSKEY, DS16_DELETE_CDS, DS16_DNSKEY_NOT_SIGNED_BY_CDS, DS16_MIXED_DELETE_CDS
CDS-SIGNED-BY-UNKNOWN-DNSKEY | DS16_CDS_SIGNED_BY_UNKNOWN_DNSKEY                 | DS16_CDS_INVALID_RRSIG, DS16_CDS_MATCHES_NON_SEP_DNSKEY, DS16_CDS_MATCHES_NON_ZONE_DNSKEY, DS16_CDS_MATCHES_NO_DNSKEY, DS16_CDS_NOT_SIGNED_BY_CDS, DS16_CDS_UNSIGNED, DS16_CDS_WITHOUT_DNSKEY, DS16_DELETE_CDS, DS16_DNSKEY_NOT_SIGNED_BY_CDS, DS16_MIXED_DELETE_CDS
CDS-UNSIGNED                 | DS16_CDS_UNSIGNED                                 | DS16_CDS_INVALID_RRSIG, DS16_CDS_MATCHES_NON_SEP_DNSKEY, DS16_CDS_MATCHES_NON_ZONE_DNSKEY, DS16_CDS_MATCHES_NO_DNSKEY, DS16_CDS_NOT_SIGNED_BY_CDS, DS16_CDS_SIGNED_BY_UNKNOWN_DNSKEY, DS16_CDS_WITHOUT_DNSKEY, DS16_DELETE_CDS, DS16_DNSKEY_NOT_SIGNED_BY_CDS, DS16_MIXED_DELETE_CDS
CDS-WITHOUT-DNSKEY           | DS16_CDS_WITHOUT_DNSKEY                           | DS16_CDS_INVALID_RRSIG, DS16_CDS_MATCHES_NON_SEP_DNSKEY, DS16_CDS_MATCHES_NON_ZONE_DNSKEY, DS16_CDS_MATCHES_NO_DNSKEY, DS16_CDS_NOT_SIGNED_BY_CDS, DS16_CDS_SIGNED_BY_UNKNOWN_DNSKEY, DS16_CDS_UNSIGNED, DS16_DELETE_CDS, DS16_DNSKEY_NOT_SIGNED_BY_CDS, DS16_MIXED_DELETE_CDS
DELETE-CDS                   | DS16_DELETE_CDS                                   | DS16_CDS_INVALID_RRSIG, DS16_CDS_MATCHES_NON_SEP_DNSKEY, DS16_CDS_MATCHES_NON_ZONE_DNSKEY, DS16_CDS_MATCHES_NO_DNSKEY, DS16_CDS_NOT_SIGNED_BY_CDS, DS16_CDS_SIGNED_BY_UNKNOWN_DNSKEY, DS16_CDS_UNSIGNED, DS16_CDS_WITHOUT_DNSKEY, DS16_DNSKEY_NOT_SIGNED_BY_CDS, DS16_MIXED_DELETE_CDS
DNSKEY-NOT-SIGNED-BY-CDS     | DS16_DNSKEY_NOT_SIGNED_BY_CDS                     | DS16_CDS_INVALID_RRSIG, DS16_CDS_MATCHES_NON_SEP_DNSKEY, DS16_CDS_MATCHES_NON_ZONE_DNSKEY, DS16_CDS_MATCHES_NO_DNSKEY, DS16_CDS_NOT_SIGNED_BY_CDS, DS16_CDS_SIGNED_BY_UNKNOWN_DNSKEY, DS16_CDS_UNSIGNED, DS16_CDS_WITHOUT_DNSKEY, DS16_DELETE_CDS, DS16_MIXED_DELETE_CDS
MIXED-DELETE-CDS             | DS16_MIXED_DELETE_CDS                             | DS16_CDS_INVALID_RRSIG, DS16_CDS_MATCHES_NON_SEP_DNSKEY, DS16_CDS_MATCHES_NON_ZONE_DNSKEY, DS16_CDS_MATCHES_NO_DNSKEY, DS16_CDS_NOT_SIGNED_BY_CDS, DS16_CDS_SIGNED_BY_UNKNOWN_DNSKEY, DS16_CDS_UNSIGNED, DS16_CDS_WITHOUT_DNSKEY, DS16_DELETE_CDS, DS16_DNSKEY_NOT_SIGNED_BY_CDS
NO-CDS                       | (none)                                            | DS16_CDS_INVALID_RRSIG, DS16_CDS_MATCHES_NON_SEP_DNSKEY, DS16_CDS_MATCHES_NON_ZONE_DNSKEY, DS16_CDS_MATCHES_NO_DNSKEY, DS16_CDS_NOT_SIGNED_BY_CDS, DS16_CDS_SIGNED_BY_UNKNOWN_DNSKEY, DS16_CDS_UNSIGNED, DS16_CDS_WITHOUT_DNSKEY, DS16_DELETE_CDS, DS16_DNSKEY_NOT_SIGNED_BY_CDS, DS16_MIXED_DELETE_CDS
NOT-AA                       | (none)                                            | DS16_CDS_INVALID_RRSIG, DS16_CDS_MATCHES_NON_SEP_DNSKEY, DS16_CDS_MATCHES_NON_ZONE_DNSKEY, DS16_CDS_MATCHES_NO_DNSKEY, DS16_CDS_NOT_SIGNED_BY_CDS, DS16_CDS_SIGNED_BY_UNKNOWN_DNSKEY, DS16_CDS_UNSIGNED, DS16_CDS_WITHOUT_DNSKEY, DS16_DELETE_CDS, DS16_DNSKEY_NOT_SIGNED_BY_CDS, DS16_MIXED_DELETE_CDS
VALID-CDS                    | (none)                                            | DS16_CDS_INVALID_RRSIG, DS16_CDS_MATCHES_NON_SEP_DNSKEY, DS16_CDS_MATCHES_NON_ZONE_DNSKEY, DS16_CDS_MATCHES_NO_DNSKEY, DS16_CDS_NOT_SIGNED_BY_CDS, DS16_CDS_SIGNED_BY_UNKNOWN_DNSKEY, DS16_CDS_UNSIGNED, DS16_CDS_WITHOUT_DNSKEY, DS16_DELETE_CDS, DS16_DNSKEY_NOT_SIGNED_BY_CDS, DS16_MIXED_DELETE_CDS


## Zone setup for test scenarios

Assumptions for the scenario specifications:
* Only CDS or DNSKEY records in apex are considered.
* Unless stated otherwise, all name servers responds authoritatively with RCODE
  NOERROR on all queries.
* Unless stated otherwise, all name servers responds authoritatively with (or
  without) CDS records on CDS queries and DNSKEY records on DNSKEY queries,
  respectively.
* Unless stated otherwise, all RRSIGs are present where expected and are valid.
* Each zone is served by two nameservers and both responds consistently.
* No DS record is published at parent zone (`dnssec16.xa`).
* In this section, a "Valid DNSKEY Record" meets the following requirements:
  * It is a DNSKEY record in apex.
  * It uses algorithm 10 (RSA/SHA-512) with 2048 octets key length, see
    [DNSSEC05] and [DNSSEC14].
  * Flag bit 7 (zone key) and bit 15 (SEP) are set.
  * The DNSKEY RRset has been signed by the key and the RRSIG is valid.
* In this section, a "Valid CDS Record" meets the following requirements:
  * It is a CDS record in apex.
  * It uses hash digest 2 (SHA-256), see [DNSSEC01].
  * Its digest is a digest of a *Valid DNSKEY Record*.
  * The CDS RRset has been signed by the its DNSKEY and the RRSIG is valid.

### CDS-INVALID-RRSIG
* Zone: "cds-invalid-rrsig.dnssec16.xa."
  * The zone has a *Valid DNSKEY Record* (key 1).
  * The zone has one *Valid CDS Record*, that matches key 1, but the RRSIG of
    the CDS RRset has has expired.

### CDS-MATCHES-NO-DNSKEY
* Zone: "cds-matches-no-dnskey.dnssec16.xa."
  * The zone has one *Valid DNSKEY Record* (key 1).
  * The zone has one *Valid CDS Record* that matches key 1.
  * The zone has a second *Valid CDS Record* that matches no key by key tag.

### CDS-MATCHES-NON-SEP-DNSKEY
* Zone: "cds-matches-non-sep-dnskey.dnssec16.xa."
  * The zone has a *Valid DNSKEY Record*, but but flag bit 15 is unset (key 1).
  * The zone has one *Valid CDS Record* that matches key 1.

### CDS-MATCHES-NON-ZONE-DNSKEY
* Zone: "cds-matches-non-zone-dnskey.dnssec16.xa."
  * The zone has one *Valid DNSKEY Record* (key 1).
  * The zone has a second *Valid DNSKEY Record*, but flag bit 7 is unset and the
    key has not signed the DNSKEY RRset (key 2).
  * The zone has one *Valid CDS Record* and matches key 1 (CDS 1).
  * The zone has a second *Valid CDS Record*, matching key 2, but the key has not
    signed the CDS RRset.

### CDS-NOT-SIGNED-BY-CDS
* Zone: "cds-not-signed-by-cds.dnssec16.xa."
  * The zone has two *Valid DNSKEY Record* (key 1 and 2).
  * The zone has one *Valid CDS Record* that matches key 1.
  * The zone has a second *Valid CDS Record* that matches key 2, but its DNSKEY
    has not signed the CDS RRset.

### CDS-SIGNED-BY-UNKNOWN-DNSKEY
* Zone: "cds-signed-by-unknown-dnskey.dnssec16.xa."
  * The zone has a *Valid DNSKEY Record* (key 1).
  * The zone has one *Valid CDS Record*, and it matches key 1.
  * The CDS RRset has an additional RRSIG that matches no DNSKEY by key tag.

### CDS-UNSIGNED
* Zone: "cds-unsigned.dnssec16.xa."
  * The zone has a *Valid DNSKEY Record* (key 1).
  * The zone has one *Valid CDS Record*, and it matches key 1, but the CDS RRset
    is not signed.

### CDS-WITHOUT-DNSKEY
* Zone: "cds-without-dnskey.dnssec16.xa."
  * The zone has no DNSKEY.
  * The zone has one *Valid CDS Record* that matches no DNSKEY.

### DELETE-CDS
* Zone: "delete-cds.dnssec16.xa."
  * The zone has a *Valid DNSKEY Record*.
  * The zone has one CDS RR that is a Delete CDS.

### DNSKEY-NOT-SIGNED-BY-CDS
* Zone: "dnskey-not-signed-by-cds.dnssec16.xa."
  * The zone has a *Valid DNSKEY Record* (key 1), byt the key has not signed the
    DNSKEY RRset.
  * The zone has one *Valid CDS Record*, and it matches key 1.

### MIXED-DELETE-CDS
* Zone: "mixed-delete-cds.dnssec16.xa."
  * The zone has a *Valid DNSKEY Record* (key 1).
  * The zone has one *Valid CDS Record*, and it matches key 1.
  * The zone has a second CDS RR that is a Delete CDS.

### NO-CDS
* Zone: "no-cds.dnssec16.xa."
  * The name servers gives no CDS RRset on CDS query (NODATA).

### NOT-AA
* Zone: "not-aa.dnssec16.xa."
  * The name servers give non-AA response on CDS queries.

### VALID-CDS
* Zone: "valid-cds.dnssec16.xa."
  * The zone has a *Valid DNSKEY Record* (key 1).
  * The zone has one *Valid CDS Record*, and it matches key 1.



[DNSSEC01]:                                     ../../specifications/tests/DNSSEC-TP/dnssec01.md
[DNSSEC05]:                                     ../../specifications/tests/DNSSEC-TP/dnssec05.md
[DNSSEC14]:                                     ../../specifications/tests/DNSSEC-TP/dnssec14.md
[DNSSEC16]:                                     ../../specifications/tests/DNSSEC-TP/dnssec16.md
[Test zone and test data README file]:          ../README.md
[Zone setup for test scenarios]:                #zone-setup-for-test-scenarios

