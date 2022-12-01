# Specification of test zones for NAMESERVER11


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
This document specifies defined test zones for test case [NAMESERVER11].


## Test scenarios

The purpose of the test scenarios is to cover all reasonable contexts where
different message tags are outputted when [NAMESERVER11] is run on a test zone.
The message tags are defined in the test case ([NAMESERVER11]) and the scenarios
are defined below.

The scenarios are defined in two parts. First part defines the expectations on
message tags from [NAMESERVER11] when Zonemaster is run against zone set up for
the scenario:

* What messages must be outputted (mandatory).
* What messages must not be outputted (forbidden).

The second part specifies the zone setup for the scenario.


## Test zone names

The test zone for each test scenario in this document is a subdomain delegated
from the base name (`nameserver11.xa`) and that subdomain having the same name as the
scenario. The names of those zones are given in section
"[Zone setup for test scenarios]" below.


## Test scenarios and message tags

If a message tag is not listed for the scenario, its presence or non-presence is
irrelevant to the test scenario and must be ignored.


Scenario name             | Mandatory message tag            | Forbidden message tags
:-------------------------|:---------------------------------|:-------------------------------------------
NO-EDNS-ON-UNKNOWN-OC     | N11_NO_EDNS                      | N11_NO_RESPONSE, N11_RETURNS_UNKNOWN_OPTION_CODE, N11_UNEXPECTED_ANSWER_SECTION, N11_UNEXPECTED_RCODE, N11_UNSET_AA
NO-ERROR                  | (none)                           | N11_NO_EDNS, N11_NO_RESPONSE, N11_RETURNS_UNKNOWN_OPTION_CODE, N11_UNEXPECTED_ANSWER_SECTION, N11_UNEXPECTED_RCODE, N11_UNSET_AA
NO-RESPONSE-ON-EDNS       | (none)                           | N11_NO_EDNS, N11_NO_RESPONSE, N11_RETURNS_UNKNOWN_OPTION_CODE, N11_UNEXPECTED_ANSWER_SECTION, N11_UNEXPECTED_RCODE, N11_UNSET_AA
NO-RESPONSE-ON-UNKNOWN-OC | N11_NO_RESPONSE                  | N11_NO_EDNS, N11_RETURNS_UNKNOWN_OPTION_CODE, N11_UNEXPECTED_ANSWER_SECTION, N11_UNEXPECTED_RCODE, N11_UNSET_AA
RETURNS-UNKNOWN-OC        | N11_RETURNS_UNKNOWN_OPTION_CODE  | N11_NO_EDNS, N11_NO_RESPONSE, N11_UNEXPECTED_ANSWER_SECTION, N11_UNEXPECTED_RCODE, N11_UNSET_AA
UNEXPECTED-ANSWER-SECTION | N11_UNEXPECTED_ANSWER_SECTION    | N11_NO_EDNS, N11_NO_RESPONSE, N11_RETURNS_UNKNOWN_OPTION_CODE, N11_UNEXPECTED_RCODE, N11_UNSET_AA
UNEXPECTED-RCODE-FORMERR  | N11_UNEXPECTED_RCODE             | N11_NO_EDNS, N11_NO_RESPONSE, N11_RETURNS_UNKNOWN_OPTION_CODE, N11_UNEXPECTED_ANSWER_SECTION, N11_UNSET_AA
UNEXPECTED-RCODE-REFUSED  | N11_UNEXPECTED_RCODE             | N11_NO_EDNS, N11_NO_RESPONSE, N11_RETURNS_UNKNOWN_OPTION_CODE, N11_UNEXPECTED_ANSWER_SECTION, N11_UNSET_AA
UNSET-AA                  | N11_UNSET_AA                     | N11_NO_EDNS, N11_NO_RESPONSE, N11_RETURNS_UNKNOWN_OPTION_CODE, N11_UNEXPECTED_ANSWER_SECTION, N11_UNEXPECTED_RCODE


## Zone setup for test scenarios

Assumptions for the scenario specifications:
* For each scenario zone there is one name server configured.
* Unless stated otherwise, all name servers respond as follows:
  * Responds with a SOA record for the zone on query for SOA.
  * All responses are authoritative with [RCODE Name] "NoError".
  * EDNS, version 0, is included in all responses on queries with EDNS.
  * EDNS is not included in responses on queries without EDNS.
  * Unknown EDNS option codes are not included in responses.

### NO-EDNS-ON-UNKNOWN-OC
* Zone: "no-edns-on-unknown-oc.nameserver11.xa."
  * The nameserver will respond without EDNS if the query includes an unknown
    EDNS OPTION CODE.

### NO-ERROR
* Zone: "no-error.nameserver11.xa."
  * The nameserver will respond as default (no error).

### NO-RESPONSE-ON-EDNS
* Zone: "no-response-on-edns.nameserver11.xa."
  * The name server will not respond to any query with EDNS.

### NO-RESPONSE-ON-UNKNOWN-OC
* Zone: "no-response-on-unknown-oc.nameserver11.xa."
  * The nameserver will not respond if the query includes an unknown EDNS OPTION
    CODE.
  
### RETURNS-UNKNOWN-OC
* Zone: "returns-unknown-oc.nameserver11.xa."
  * The nameserver will respond with an unknown EDNS OPTION CODE if the query
    includes an unknown EDNS OPTION CODE.

### UNEXPECTED-ANSWER-SECTION
* Zone: "unexpected-answer-section.nameserver11.xa."
  * The nameserver will respond without the SOA record if the query includes an
    unknown EDNS OPTION CODE.
  
### UNEXPECTED-RCODE-FORMERR
* Zone: "unexpected-rcode-formerr.nameserver11.xa."
  * The nameserver will respond with [RCODE Name] "FormErr" if the query includes an
    unknown EDNS OPTION CODE.

### UNEXPECTED-RCODE-REFUSED
* Zone: "unexpected-rcode-refused.nameserver11.xa."
  * The nameserver will respond with [RCODE Name] "Refused" if the query includes an
    unknown EDNS OPTION CODE.

### UNSET-AA
* Zone: "unset-aa.nameserver11.xa."
  * The nameserver will respond with AA unset if the query includes an unknown
    EDNS OPTION CODE.


[NAMESERVER11]:                                                   ../../specifications/tests/Nameserver-TP/nameserver11.md
[RCODE Name]:                                                     https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[Test zone README file]:                                          ../README.md
[Zone setup for test scenarios]:                                  #zone-setup-for-test-scenarios

