# Specification of Test Scenarios for Connectivity04


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
This document specifies defined test scenarios for test case [Connectivity04].


## Test scenarios

The purpose of the test scenarios is to cover all reasonable contexts where
different message tags are outputted when [Connectivity04] is run on a test zone.
The message tags are defined in the test case ([Connectivity04]) and the
scenarios are defined below.

The test scenarios are structured as stated in the [test scenario README file].

## Test zone names

The test zone or zones for each test scenario in this document is a subdomain
(or lower zone) delegated from the base name (`connectivity04.xa`) and that subdomain
having the same name as the scenario. The names of those zones are given in
section "[Test scenarios and setup of test zones]" below.


## All message tags
The test case can output any of these message tags, but not necessarily in any
combination. See [Connectivity04] for the specification of the tags.

* CN04_EMPTY_PREFIX_SET
* CN04_ERROR_PREFIX_DATABASE
* CN04_IPV4_DIFFERENT_PREFIX
* CN04_IPV4_SAME_PREFIX
* CN04_IPV4_SINGLE_PREFIX
* CN04_IPV6_DIFFERENT_PREFIX
* CN04_IPV6_SAME_PREFIX
* CN04_IPV6_SINGLE_PREFIX

## Test scenarios and message tags

If a message tag is not listed for the scenario, its presence or non-presence is
irrelevant to the test scenario and must be ignored.

Scenario name            | Mandatory message tag                                                             | Forbidden message tags
:------------------------|:----------------------------------------------------------------------------------|:--------------------
GOOD-1                   | CN04_IPV4_DIFFERENT_PREFIX, CN04_IPV6_DIFFERENT_PREFIX                            | 2)
GOOD-2                   | CN04_IPV4_DIFFERENT_PREFIX                                                        | 2)
GOOD-3                   | CN04_IPV6_DIFFERENT_PREFIX                                                        | 2)
EMPTY-PREFIX-SET-1       | CN04_EMPTY_PREFIX_SET                                                             | 2)
EMPTY-PREFIX-SET-2       | CN04_EMPTY_PREFIX_SET                                                             | 2)
ERROR-PREFIX-DATABASE-1  | CN04_ERROR_PREFIX_DATABASE                                                        | 2)
ERROR-PREFIX-DATABASE-2  | CN04_ERROR_PREFIX_DATABASE                                                        | 2)
ERROR-PREFIX-DATABASE-3  | CN04_ERROR_PREFIX_DATABASE                                                        | 2)
ERROR-PREFIX-DATABASE-4  | CN04_IPV4_DIFFERENT_PREFIX, CN04_IPV6_DIFFERENT_PREFIX, CN04_ERROR_PREFIX_DATABASE| 2)
ERROR-PREFIX-DATABASE-5  | CN04_ERROR_PREFIX_DATABASE                                                        | 2)
ERROR-PREFIX-DATABASE-6  | CN04_IPV4_DIFFERENT_PREFIX, CN04_IPV6_DIFFERENT_PREFIX, CN04_ERROR_PREFIX_DATABASE| 2)
ERROR-PREFIX-DATABASE-7  | CN04_ERROR_PREFIX_DATABASE                                                        | 2)
ERROR-PREFIX-DATABASE-8  | CN04_ERROR_PREFIX_DATABASE                                                        | 2)
IPV4-ONE-PREFIX-1        | CN04_IPV4_SAME_PREFIX, CN04_IPV4_SINGLE_PREFIX                                    | 2)
IPV4-TWO-PREFIXES-1      | CN04_IPV4_SAME_PREFIX, CN04_IPV4_DIFFERENT_PREFIX                                 | 2)
IPV6-ONE-PREFIX-1        | CN04_IPV6_SAME_PREFIX, CN04_IPV6_SINGLE_PREFIX                                    | 2)
IPV6-TWO-PREFIXES-1      | CN04_IPV6_SAME_PREFIX, CN04_IPV6_SINGLE_PREFIX                                    | 2)
IPV4-SINGLE-NS-1         | CN04_IPV4_SINGLE_PREFIX, CN04_IPV4_DIFFERENT_PREFIX                               | 2)
IPV6-SINGLE-NS-1         | CN04_IPV6_SINGLE_PREFIX, CN04_IPV6_DIFFERENT_PREFIX                               | 2)
DOUBLE-PREFIX-1          | CN04_IPV4_DIFFERENT_PREFIX, CN04_IPV6_DIFFERENT_PREFIX                            | 2)
DOUBLE-PREFIX-2          | CN04_IPV4_DIFFERENT_PREFIX, CN04_IPV6_DIFFERENT_PREFIX                            | 2)

* (1) All tags except for those specified as "Forbidden message tags" (no instances for these test scenarios)
* (2) All tags except for those specified as "Mandatory message tags"


## Test scenarios and setup of test zones

### Default zone configuration
Unless otherwise specified in the specific scenario specification, the test zone
or zones for the scenario will follow the default setup as stated below. The
`child zone` is the zone to be tested for the scenario.

* The child zone is `SCENARIO.connectivity04.xa`.
  * It is delegated to out-of-bailiwick NS, specified per scenario.
    * The names of the NS exist in the parent zone.
  * The NS for a child will only reply to NS query and do that
    consistently.
* The parent zone is `connectivity04.xa`.
  * It is served by two in-bailiwick NS (ns1 and ns2).
  * ns1 and ns2 have the same zone content.
  * ns1 and ns2 have both IPv4 and IPv6 glue.
  * The records matching glue in the zone are complete.
* All responses will have the [RCODE Name] "NoError".

### GOOD-1
Everything is fine.

* Zone: good-1.connectivity04.xa
  * 2 NS.
    * Both with IPv4 and IPv6.
    * Each NS IP in different prefixes.

### GOOD-2
Everything is fine. IPv4 only.

* Zone: good-2.connectivity04.xa
  * 2 NS.
    * IPv4 only.
    * Each NS IP in different prefixes.

### GOOD-3
Everything is fine. IPv6 only.

* Zone: good-3.connectivity04.xa
  * 2 NS.
    * IPv4 only.
    * Each NS IP in different prefixes.

### EMPTY-PREFIX-SET-1
No ASN data (NXDOMAIN).

* Zone: empty-prefix-set-1.connectivity04.xa
  * 1 NS.
    * IPv4 and IPv6 on NS.
    * The ASN-lookup returns [RCODE Name] NXDOMAIN.

### EMPTY-PREFIX-SET-2
No ASN data (NODATA).

* Zone: empty-prefix-set-2.connectivity04.xa
  * 1 NS.
    * IPv4 and IPv6 on NS.
    * The ASN-lookup returns no TXT record (NODATA).

### ERROR-PREFIX-DATABASE-1
No ASN data, SERVFAIL.

* Zone: error-prefix-database-1.connectivity04.xa
  * 1 NS.
    * IPv4 and IPv6 on NS.
    * The ASN-lookup returns SERVFAIL.

### ERROR-PREFIX-DATABASE-2
No ASN data, REFUSED.

* Zone: error-prefix-database-2.connectivity04.xa
  * 1 NS.
    * IPv4 and IPv6 on NS.
    * The ASN-lookup returns REFUSED.

### ERROR-PREFIX-DATABASE-3
No ASN data, no DNS response at all.

* Zone: error-prefix-database-3.connectivity04.xa
  * 1 NS.
    * IPv4 and IPv6 on NS.
    * The ASN-lookup returns no DNS response (no response at all).

### ERROR-PREFIX-DATABASE-4
IPv4 and IPv6. Extra non-ASN lookup TXT record.

* Zone: error-prefix-database-4.connectivity04.xa
  * 2 NS.
    * Both with IPv4 and IPv6.
    * Each NS IP in different prefixes.
      * For one NS (both IP) the ASN lookup returns an extra TXT record with the
        text "This is not ASN data".

### ERROR-PREFIX-DATABASE-5
No ASN data, some other TXT record.

* Zone: error-prefix-database-5.connectivity04.xa
  * 1 NS.
    * IPv4 and IPv6 on NS.
    * The ASN-lookup returns one TXT record for both IP with the string
      "This is not ASN data".

### ERROR-PREFIX-DATABASE-6
IPv4 and IPv6. Extra ASN lookup TXT record with wrong IP prefix.

* Zone: error-prefix-database-6.connectivity04.xa
  * 2 NS.
    * Both with IPv4 and IPv6.
    * Each NS IP in different prefixes.
      * For one NS (both IP) the ASN lookup returns an extra TXT with an IP prefix
        that does not match the IP address.

### ERROR-PREFIX-DATABASE-7
IPv4 and IPv6. ASN lookup TXT record with wrong IP prefix.

* Zone: error-prefix-database-7.connectivity04.xa
  * 1 NS.
    * IPv4 and IPv6 on NS.
    * The ASN-lookup returns one TXT record for both IP with an IP prefix that
      does not match the IP address.

### ERROR-PREFIX-DATABASE-8
IPv4 and IPv6. ASN lookup gives no TXT-record but a CNAME.

* Zone: error-prefix-database-7.connectivity04.xa
  * 1 NS.
    * IPv4 and IPv6 on NS.
    * The ASN-lookup returns no TXT record for both IP but a CNAME record.

### IPV4-ONE-PREFIX-1
All NS IP in the same prefix. IPv4 only.

* Zone: ipv4-one-prefix-1.connectivity04.xa
  * 2 NS.
    * IPv4 only.
    * Both NS in the same prefix.

### IPV4-TWO-PREFIXES-1
Two NS in the same prefix. One NS in its own prefix. IPv4 only.

* Zone: ipv4-two-prefixes-1.connectivity04.xa
  * 3 NS.
    * IPv4 only.
    * Two NS in the same prefix.
    * One NS in its own prefix.

### IPV6-ONE-PREFIX-1
All NS IP in the same prefix. Ipv6 only.

* Zone: ipv6-one-prefix-1.connectivity04.xa
  * 2 NS.
    * Ipv6 only.
    * Both NS in the same prefix.

### IPV6-TWO-PREFIXES-1
Two NS in the same prefix. One NS in its own prefix. Ipv6 only.

* Zone: ipv6-two-prefixes-1.connectivity04.xa
  * 3 NS.
    * Ipv6 only.
    * Two NS in the same prefix.
    * One NS in its own prefix.

### IPV4-SINGLE-NS-1
One NS, IPv4 only.

* Zone: ipv4-single-ns-1.connectivity04.xa
  * 1 NS.
    * IPv4 only.

### IPV6-SINGLE-NS-1
One NS, IPv6 only.

* Zone: ipv6-single-ns-1.connectivity04.xa
  * 1 NS.
    * IPv4 only.

### DOUBLE-PREFIX-1
The IP addresses of the NS are announced from both a larger prefix and a more
specific one.

* Zone: double-prefix-1.connectivity04.xa
  * 2 NS
  * IPv4 and IPv6.
  * The two IPv4 addresses are announced from one large prefix that include
    both IP addresses.
  * They are also each annouced from a more specific prefix only including
    that address.
  * Same with IPv6.


### DOUBLE-PREFIX-2
The IP addresses of the NS are announced from both a larger prefix that include
both NS IP. The addresses of one NS are also announced from more specific
prefixes.

* Zone: double-prefix-2.connectivity04.xa
  * 2 NS
  * IPv4 and IPv6.
  * The two IPv4 addresses are announced from one large prefix that includes
    both IP addresses.
  * The address of one of the NS is also announced from a more specific prefix.
  * Same with IPv6.

[Connectivity04]:                                                 ../../tests/Connectivity-TP/connectivity04.md
[RCODE Name]:                                                     https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[Test scenario README file]:                                      ../README.md
[Test scenarios and setup of test zones]:                         #test-scenarios-and-setup-of-test-zones

