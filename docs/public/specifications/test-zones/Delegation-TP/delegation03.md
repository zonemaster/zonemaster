# Specification of test zones for DELEGATION03


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
This document specifies defined test zones for test case [DELEGATION03].


## Test scenarios

The purpose of the test scenarios is to cover all reasonable contexts where
different message tags are outputted when [DELEGATION03] is run on a test zone.
The message tags are defined in the test case ([DELEGATION03]) and the scenarios
are defined below.

The test scenarios are structured as stated in the [test zone README file].

## Test zone names

The test zone for each test scenario in this document is a subdomain delegated
from the base name (`delegation03.xa`) and that subdomain having the same name as the
scenario. The names of those zones are given in section
"[Zone setup for test scenarios]" below.


## Test scenarios and message tags

If a message tag is not listed for the scenario, its presence or non-presence is
irrelevant to the test scenario and must be ignored.


Scenario name                 | Mandatory message tag                    | Forbidden message tags
:-----------------------------|:-----------------------------------------|:-------------------------------------------
REFERRAL-SIZE-OK              | REFERRAL_SIZE_OK                         | REFERRAL_SIZE_TOO_LARGE
REFERRAL-SIZE-TOO-LARGE-1     | REFERRAL_SIZE_TOO_LARGE                  | REFERRAL_SIZE_OK
REFERRAL-SIZE-TOO-LARGE-2     | REFERRAL_SIZE_TOO_LARGE                  | REFERRAL_SIZE_OK

## Zone setup for test scenarios

Assumptions for the scenario specifications unless otherwise specified for the
specific scenario:
* For each scenario zone there are two name server configured.
  * Both NS (ns1 and ns2) are equal in delegation and in zone.
  * Both NS are in-bailiwick
  * Both NS have both IPv4 and IPv6 addresses
  * All addresses are distinct
  * All required glue are present in the delegation.
  * All glue exactly matches the authoritative address records in correct zone
    (not more and not less records).
  * All NS IP addresses respond with identical zone content.

### REFERRAL-SIZE-OK
This is the happy path.

* Zone: "referral-size-ok.delegation03.xa."

### REFERRAL-SIZE-TOO-LARGE-1
Referal is too large and NS are in-bailiwick

* Zone: "referral-size-too-large-1.delegation03.xa"
  * ns1 is "ns1.abcdefghijklmnopqrstuv.referral-size-too-large-1.delegation03.xa"
  * ns2 is "ns2.abcdefghijklmnopqrstuv.referral-size-too-large-1.delegation03.xa"

### REFERRAL-SIZE-TOO-LARGE-2
Referal is too large and NS are out-of-bailiwick with no glue.

* Zone: "referral-size-too-large-2.delegation03.xa"
  * The zone is delegated to ns1, ns2, ns3 and ns4.
  * ns1 is "ns1.abcdefghijklmnopqrstuvwxyz.abcdefghijklmnopqrstuvwxyz.abcdefghijklmnopqrstuvwxy.referral-size-too-large-2.delegation03.xb"
  * ns2 is "ns2.abcdefghijklmnopqrstuvwxyz.abcdefghijklmnopqrstuvwxyz.abcdefghijklmnopqrstuvwxy.referral-size-too-large-2.delegation03.xb"
  * ns3 is "ns3.abcdefghijklmnopqrstuvwxyz.abcdefghijklmnopqrstuvwxyz.abcdefghijklmnopqrstuvwxy.referral-size-too-large-2.delegation03.xb"
  * ns4 is "ns4.abcdefghijklmnopqrstuvwxyz.abcdefghijklmnopqrstuvwxyz.abcdefghijklmnopqrstuvwxy.referral-size-too-large-2.delegation03.xb"
  * Delegation is without glue.
  * The test zone has no address records for the NS names.
  * The "referral-size-too-large-2.delegation03.xb" zone has full set of address
    records (IPv4 and IPv6).

[DELEGATION03]:                                                   ../../tests/Delegation-TP/delegation03.md
[RCODE Name]:                                                     https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[Test zone README file]:                                          ../README.md
[Zone setup for test scenarios]:                                  #zone-setup-for-test-scenarios

