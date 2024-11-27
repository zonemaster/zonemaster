# Specification of test Scenarios for Delegation03


## Table of contents

* [Background](#background)
* [Test Case](#test-case)
* [Test scenarios](#test-scenarios)
* [Test zone names](#test-zone-names)
* [All message tags](#all-message-tags)
* [Test scenarios and message tags](#test-scenarios-and-message-tags)
* [Test zone setup]


## Background

See the [test scenario README file].


## Test Case
This document specifies test scenarios for test case [Delegation03].


## Test scenarios

The purpose of the test scenarios is to cover all reasonable contexts where
different message tags are output when [Delegation03] is run on a test zone.
The message tags are defined in the test case ([Delegation03]) and the scenarios
are defined below.

The test scenarios are structured as stated in the [test scenario README file].

## Test zone names

The test zone for each test scenario in this document is a subdomain delegated
from the base name (`delegation03.xa`) and that subdomain having the same name as the
scenario. The names of those zones are given in section
[Test zone setup] below.

## All message tags

The test case can output any of these message tags, but not necessarily in any
combination. See [Delegation01] for the specification of the tags.

* REFERRAL_SIZE_OK
* REFERRAL_SIZE_TOO_LARGE

## Test scenarios and message tags

If a message tag is not listed for the scenario, its presence or non-presence is
irrelevant to the test scenario and must be ignored.


Scenario name                 | Mandatory message tag                    | Forbidden message tags
:-----------------------------|:-----------------------------------------|:-------------------------------------------
REFERRAL-SIZE-OK-1            | REFERRAL_SIZE_OK                         | 2)
REFERRAL-SIZE-OK-2            | REFERRAL_SIZE_OK                         | 2)
REFERRAL-SIZE-TOO-LARGE-1     | REFERRAL_SIZE_TOO_LARGE                  | 2)
REFERRAL-SIZE-TOO-LARGE-2     | REFERRAL_SIZE_TOO_LARGE                  | 2)

1\) All tags except for those specified as "Forbidden message tags" (no
  instances for these test scenarios)

2\) All tags except for those specified as "Mandatory message tags"


## Test zone setup

Assumptions for the scenario specifications unless otherwise specified for the
specific scenario:
* For each scenario zone there are two name server configured.
  * Both name servers are in-bailiwick.
  * Both name servers have both IPv4 and IPv6 addresses.
  * All addresses are distinct.
  * All required glue are present in the delegation.
  * There is no actual zone or zone file, only a delegation.
    * For these scenarios only the delegation is needed.

### REFERRAL-SIZE-OK-1
This is the happy path.

* Zone: referral-size-ok-1.delegation03.xa.

### REFERRAL-SIZE-OK-2
Referral is large, but not too large. The name servers are in-bailiwick.

* Zone: referral-size-ok-2.delegation03.xa.
  * ns1 is "ns1.ipv4-large-but-not-too-large.referral-size-ok-2.delegation03.xa".
  * ns1 is "ns1.ipv6-large-but-not-too-large.referral-size-ok-2.delegation03.xa".
  * ns2 is "ns2.ipv4-large-but-not-too-large.referral-size-ok-2.delegation03.xa".
  * ns2 is "ns2.ipv6-large-but-not-too-large.referral-size-ok-2.delegation03.xa".

### REFERRAL-SIZE-TOO-LARGE-1
Referral is too large and name servers are in-bailiwick.

* Zone: referral-size-too-large-1.delegation03.xa
  * Name server names are relative to the zone name:
    * ns1 is "ns1.1abcdefghijklmnopqrstuv.1defghijkl"
    * ns2 is "ns2.2abcdefghijklmnopqrstuv.2defghijkl"
    * ns3 is "ns3.2abcdefghijklmnopqrstuv.3defghijkl"
    * ns4 is "ns4.2abcdefghijklmnopqrstuv.4defghijkl"
    * ns5 is "ns5.2abcdefghijklmnopqrstuv.5defghijkl"


### REFERRAL-SIZE-TOO-LARGE-2
Referral is too large and name servers are out-of-bailiwick with no glue.

* Zone: referral-size-too-large-2.delegation03.xa
  * The zone is delegated to ns1, ns2, ns3 and ns4.
    * ns1 is "ns1.1abcdefghijklmnopqrstuvwxyz.1abcdefghijklmnopqrstuvwxy.1abcdefghijklmnopqrstuvw.referral-size-too-large-2.delegation03.xb"
    * ns2 is "ns2.2abcdefghijklmnopqrstuvwxyz.2abcdefghijklmnopqrstuvwxy.2abcdefghijklmnopqrstuvw.referral-size-too-large-2.delegation03.xb"
    * ns3 is "ns3.3abcdefghijklmnopqrstuvwxyz.3abcdefghijklmnopqrstuvwxy.3abcdefghijklmnopqrstuvw.referral-size-too-large-2.delegation03.xb"
    * ns4 is "ns4.4abcdefghijklmnopqrstuvwxyz.4abcdefghijklmnopqrstuvwxy.4abcdefghijklmnopqrstuvw.referral-size-too-large-2.delegation03.xb"
  * Delegation is without glue.
  * The test zone has no address records for the name server names.
  * The "delegation03.xb" zone has full set of address records (IPv4 and IPv6).

[Delegation03]:                                                   ../../tests/Delegation-TP/delegation03.md
[RCODE Name]:                                                     https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[test scenario README file]:                                      ../README.md
[Test zone setup]:                                                #test-zone-setup



