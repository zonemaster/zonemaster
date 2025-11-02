# Specification of Test Scenarios for DNSSEC07


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

This document specifies defined test scenarios for test case [DNSSEC07].


## Test scenarios

The purpose of the test scenarios is to cover all reasonable contexts where
different message tags are outputted when [DNSSEC07] is run on a test zone. The
message tags are defined in the test case ([DNSSEC07]) and the scenarios are
defined below.

The test scenarios are structured as stated in the [test scenario README file].


## Test zone names

The test zone or zones for each test scenario in this document is a subdomain
(or lower zone) delegated from the base name (`dnssec07.xa`) and that subdomain
having the same name as the scenario. The names of those zones are given in
section "[Test scenarios and setup of test zones]" below.


## All message tags

The test case can output any of these message tags, but not necessarily in any
combination. See [DNSSEC07] for the specification of the tags.

* DS07_DS_FOR_SIGNED_ZONE
* DS07_DS_ON_PARENT_SERVER
* DS07_INCONSISTENT_DS
* DS07_INCONSISTENT_SIGNED
* DS07_NON_AUTH_RESPONSE_DNSKEY
* DS07_NOT_SIGNED
* DS07_NOT_SIGNED_ON_SERVER
* DS07_NO_DS_ON_PARENT_SERVER
* DS07_NO_DS_FOR_SIGNED_ZONE
* DS07_NO_RESPONSE_DNSKEY
* DS07_SIGNED
* DS07_SIGNED_ON_SERVER
* DS07_UNEXP_RCODE_RESP_DNSKEY


## Test scenarios and message tags

If a message tag is not listed for the scenario, its presence or non-presence is
irrelevant to the test scenario and must be ignored.

| Scenario name              | Mandatory tags                                                                                                  | Forbidden tags |
|:---------------------------|:----------------------------------------------------------------------------------------------------------------|:---------------|
| SIGNED-AND-DS-1            | DS07_DS_FOR_SIGNED_ZONE, DS07_DS_ON_PARENT_SERVER, DS07_SIGNED, DS07_SIGNED_ON_SERVER                           | 2)             |
| SIGNED-NO-DS-1             | DS07_NO_DS_ON_PARENT_SERVER, DS07_NO_DS_FOR_SIGNED_ZONE, DS07_SIGNED, DS07_SIGNED_ON_SERVER                     | 2)             |
| INCONSIST-SIGNED-AND-DS-1  | DS07_DS_ON_PARENT_SERVER, DS07_INCONSISTENT_SIGNED, DS07_NOT_SIGNED_ON_SERVER, DS07_SIGNED_ON_SERVER            | 2)             |
| INCONSIST-SIGNED-NO-DS-1   | DS07_INCONSISTENT_SIGNED, DS07_NOT_SIGNED_ON_SERVER, DS07_NO_DS_ON_PARENT_SERVER, DS07_SIGNED_ON_SERVER         | 2)             |
| SIGNED-AND-INCONSIST-DS-1  | DS07_DS_ON_PARENT_SERVER, DS07_INCONSISTENT_DS, DS07_NO_DS_ON_PARENT_SERVER, DS07_SIGNED, DS07_SIGNED_ON_SERVER | 2)             |
| UNSIGNED-AND-DS-1          | DS07_NOT_SIGNED, DS07_NOT_SIGNED_ON_SERVER                                                                      | 2)             |
| UNSIGNED-NO-DS-1           | DS07_NOT_SIGNED, DS07_NOT_SIGNED_ON_SERVER                                                                      | 2)             |
| NON-AUTH-RESPONSE-DNSKEY-1 | DS07_NON_AUTH_RESPONSE_DNSKEY, DS07_SIGNED, DS07_SIGNED_ON_SERVER, DS07_DS_ON_PARENT_SERVER, DS07_DS_FOR_SIGNED_ZONE | 2)             |
| NO-RESPONSE-DNSKEY-1       | DS07_SIGNED, DS07_SIGNED_ON_SERVER, DS07_NO_RESPONSE_DNSKEY, DS07_DS_ON_PARENT_SERVER, DS07_DS_FOR_SIGNED_ZONE  | 2)             |
| UNEXP-RCODE-RESP-DNSKEY-1  | DS07_SIGNED, DS07_SIGNED_ON_SERVER, DS07_UNEXP_RCODE_RESP_DNSKEY                                                | 2)             |


* (1) All tags except for those specified as "Forbidden tags" (no instances for these test scenarios)
* (2) All tags except for those specified as "Mandatory tags"

## Test scenarios and setup of test zones

### Default zone configuration
Unless otherwise specified in the specific scenario specification, the test zone
or zones for the scenario will follow the default setup as stated below. The
`child zone` is the zone to be tested for the scenario.

* The child zone is `SCENARIO.dnssec07.xa`.
  * It is delegated to two name servers, `ns1.SCENARIO.dnssec07.xa`
    and `ns2.SCENARIO.dnssec07.xa`.
    * The name server names have A and AAAA records to avoid non-relevant error
      messages.
    * The delegation of the child zone is to an IB NS.
  * There is a zone file for the child zone.
  * All child zone servers give the same response.
  * The only responses, with data queried for, to the child zone that can be assumed are queries for
    * NS
    * SOA
    * DNSKEY
  * Response on DNSKEY query will include RRSIG, others will not.
* The parent zone is `dnssec07.xa`.
  * It is served by two in-bailiwick NS (ns1 and ns2).
  * ns1 and ns2 have the same zone content.
  * ns1 and ns2 have both IPv4 and IPv6 glue.
  * The records matching glue in the zone are complete.
  * The parent zone will respond with one DS record per child zone.
  * The only responses to the parent zone that can be assumed are queries for
    * NS
    * SOA
    * DNSKEY
    * delegation of the child
    * DS for child
  * Response on DS query will include RRSIG, others will not.
* All responses will have the AA bit set.
* All responses will have the [RCODE Name] "NoError".
* The DS digest algorithm is 2.
  * The DS will not correctly match DNSKEY.
* The zones are not signed.

### SIGNED-AND-DS-1
All is good with signed zone and DS record in parent.

* Zone: signed-and-ds-1.dnssec07.xa.
  * All default settings.

### SIGNED-NO-DS-1
The child zone is signed, but no DS in parent.

* Zone: signed-no-ds-1.dnssec07.xa.
  * The child zone has default settings.
  * The parent zone has no DS for the child zone.

### INCONSIST-SIGNED-AND-DS-1
The child is signed on ns1 but not on ns2.

* Zone: inconsist-signed-and-ds-1.dnssec07.xa.
  * Response from ns1 with DNSKEY.
  * Response from ns2 without DNSKEY

### INCONSIST-SIGNED-NO-DS-1
The child is signed on ns1 but not on ns2.

* Zone: inconsist-signed-no-ds-1.dnssec07.xa.
  * Response from ns1 with DNSKEY.
  * Response from ns2 without DNSKEY
  * Parent provids no DS.

### SIGNED-AND-INCONSIST-DS-1
Parent provids DS on one server, but not the other.

* Zone: child.signed-and-inconsist-ds-1.dnssec07.xa.
  * Grandparent zone is dnssec07.xa.
  * Parent zone is signed-and-inconsist-ds-1.dnssec07.xa.
    * ns1 provids DS, ns2 does not.
  * Child zone is child.signed-and-inconsist-ds-1.dnssec07.xa.
    * Child zone is signed.

### UNSIGNED-AND-DS-1
Both NS respond with no DNSKEY. Parent has NS but it is disregarded.

* Zone: unsigned-and-ds-1.dnssec07.xa.
  * ns1 and ns2 respond with NO DATA on DNSKEY query.
  * Parent provides DS record, but it is not expected to be queried for.

### UNSIGNED-NO-DS-1
Both NS respond with no DNSKEY. Parent has NS but it is disregarded.

* Zone: unsigned-no-ds-1.dnssec07.xa.
  * ns1 and ns2 respond with NODATA on DNSKEY query.
  * Parent provides no DS record, but it is not expected to be queried for.

### NON-AUTH-RESPONSE-DNSKEY-1
One server responds with non-authoritative DNSKEY response.

* Zone: non-auth-response-dnskey-1.dnssec07.xa.
  * ns1 responds with AA bit unset on DNSKEY query.
    * Other queries normal responses.
  * Normal responses from ns2.

### NO-RESPONSE-DNSKEY-1
One server does not respond on DNSKEY query.

* Zone: no-response-dnskey-1.dnssec07.xa.
  * ns1 does not respond on the DNSKEY query.
    * Other queries normal responses.
  * Normal responses from ns2.

### UNEXP-RCODE-RESP-DNSKEY-1
One server give unexpected RCODE in response on DNSKEY query.

* Zone: unexp-rcode-resp-dnskey-1.dnssec07.xa.
  * ns1 responds with RCODE REFUSED on the DNSKEY query.
    * Other queries normal responses.
  * Normal responses from ns2.


[DNSSEC07]:                                                       ../../tests/DNSSEC-TP/dnssec07.md
[RCODE Name]:                                                     https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[Test scenario README file]:                                      ../README.md
[Test scenarios and setup of test zones]:                         #test-scenarios-and-setup-of-test-zones
