# Specification of test zones for NAMESERVER15


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
This document specifies defined test zones for test case [NAMESERVER15].


## Test scenarios

The purpose of the test scenarios is to cover all reasonable contexts where
different message tags are outputted when [NAMESERVER15] is run on a test zone.
The message tags are defined in the test case ([NAMESERVER15]) and the scenarios
are defined below.

The test scenarios are structured as stated in the [test zone README file].

## Test zone names

The test zone for each test scenario in this document is a subdomain delegated
from the base name (`nameserver15.xa`) and that subdomain having the same name as the
scenario. The names of those zones are given in section
"[Zone setup for test scenarios]" below.


## Test scenarios and message tags

If a message tag is not listed for the scenario, its presence or non-presence is
irrelevant to the test scenario and must be ignored.

Scenario name             | Mandatory message tag                 | Forbidden message tags
:-------------------------|:--------------------------------------|:-------------------------------------------
NO-VERSION-REVEALED-1     | N15_NO_VERSION_REVEALED               | N15_ERROR_ON_VERSION_QUERY, N15_SOFTWARE_VERSION, N15_WRONG_CLASS
NO-VERSION-REVEALED-2     | N15_NO_VERSION_REVEALED               | N15_ERROR_ON_VERSION_QUERY, N15_SOFTWARE_VERSION, N15_WRONG_CLASS
NO-VERSION-REVEALED-3     | N15_NO_VERSION_REVEALED               | N15_ERROR_ON_VERSION_QUERY, N15_SOFTWARE_VERSION, N15_WRONG_CLASS
NO-VERSION-REVEALED-4     | N15_NO_VERSION_REVEALED               | N15_ERROR_ON_VERSION_QUERY, N15_SOFTWARE_VERSION, N15_WRONG_CLASS
NO-VERSION-REVEALED-5     | N15_NO_VERSION_REVEALED               | N15_ERROR_ON_VERSION_QUERY, N15_SOFTWARE_VERSION, N15_WRONG_CLASS
NO-VERSION-REVEALED-6     | N15_NO_VERSION_REVEALED               | N15_ERROR_ON_VERSION_QUERY, N15_SOFTWARE_VERSION, N15_WRONG_CLASS
ERROR-ON-VERSION-QUERY-1  | N15_ERROR_ON_VERSION_QUERY, N15_NO_VERSION_REVEALED | N15_SOFTWARE_VERSION, N15_WRONG_CLASS
ERROR-ON-VERSION-QUERY-2  | N15_ERROR_ON_VERSION_QUERY, N15_NO_VERSION_REVEALED | N15_SOFTWARE_VERSION, N15_WRONG_CLASS
SOFTWARE-VERSION-1        | N15_SOFTWARE_VERSION                  | N15_ERROR_ON_VERSION_QUERY, N15_NO_VERSION_REVEALED, N15_WRONG_CLASS
SOFTWARE-VERSION-2        | N15_SOFTWARE_VERSION                  | N15_ERROR_ON_VERSION_QUERY, N15_NO_VERSION_REVEALED, N15_WRONG_CLASS
WRONG-CLASS-1             | N15_SOFTWARE_VERSION, N15_WRONG_CLASS | N15_ERROR_ON_VERSION_QUERY, N15_NO_VERSION_REVEALED
WRONG-CLASS-2             | N15_SOFTWARE_VERSION, N15_WRONG_CLASS | N15_ERROR_ON_VERSION_QUERY, N15_NO_VERSION_REVEALED


## Zone setup for test scenarios

Assumptions for the scenario specifications:
* For each scenario zone there is one name server configured.
* Unless stated otherwise, all name servers respond as follows:
  * Responds with a SOA record for the zone on query for SOA.
  * Responds with CH class on queries on CH class.
  * Software version query names are "version.bind" and "version.server".
  * All responses are [RCODE Name] "NoError".
  * EDNS, version 0, is included in all responses on queries with EDNS.
  * EDNS is not included in responses on queries without EDNS.

### NO-VERSION-REVEALED-1
This is a happy path

* Zone: "no-version-revealed-1.nameserver15.xa."
  * The name server responds with empty answer section on both software version
    query names.

### NO-VERSION-REVEALED-2
This is a happy path

* Zone: "no-version-revealed-2.nameserver15.xa."
  * The name server responds with empty answer section on both software version
    query names.
  * The name server responds with [RCODE Name] "NxDomain" on both software
    version query names.

### NO-VERSION-REVEALED-3
This is a happy path

* Zone: "no-version-revealed-3.nameserver15.xa."
  * The name server responds with empty answer section on both software version
    query names.
  * The name server responds with [RCODE Name] "Refused" on both software
    version query names.

### NO-VERSION-REVEALED-4
This is a happy path

* Zone: "no-version-revealed-4.nameserver15.xa."
  * The name server responds with a single CNAME record and no other record in
    answer section on both software version query names.
    * "version.bind. CNAME version.server." when query name is version.bind.
    * "version.server. CNAME version.bind." when query name is version.server.

### NO-VERSION-REVEALED-5
This is a happy path

* Zone: "no-version-revealed-5.nameserver15.xa."
  * RDATA of the TXT records for both software version query names is the empty
    string.

### NO-VERSION-REVEALED-6
This is a happy path

* Zone: "no-version-revealed-6.nameserver15.xa."
  * RDATA of the TXT records for both software version query names only consists
    of space characters.

### ERROR-ON-VERSION-QUERY-1
Unexpected response from server

* Zone: "error-on-version-query-1.nameserver15.xa."
  * The name server responds with empty answer section on both software version
    query names.
  * The name server responds with [RCODE Name] "ServFail" on both software
    version query names.

### ERROR-ON-VERSION-QUERY-2
Unexpected response from server

* Zone: "error-on-version-query-2.nameserver15.xa."
  * The name server does not respond at all to the queries with the software
    version query names.

### SOFTWARE-VERSION-1
Normal version string

* Zone: "software-version-1.nameserver15.xa."
  * Empty response on software query name "version.bind".
  * TXT record with RDATA "v0" in response on software query name
    "version.server" in answer section.

### SOFTWARE-VERSION-2
Normal version string

* Zone: "software-version-2.nameserver15.xa."
  * Empty response on software query name "version.server".
  * TXT record with RDATA "v0" in response on software query name
    "version.bind" in answer section.

### WRONG-CLASS-1
Version string returned in wrong class

* Zone: "wrong-class-1.nameserver15.xa."
  * Empty response on software query name "version.bind".
  * TXT record with RDATA "v0" in response on software query name
    "version.server" in answer section.
    * TXT record is in IN class, not CH class.

### WRONG-CLASS-2
Version string returned in wrong class

* Zone: "wrong-class-2.nameserver15.xa."
  * Empty response on software query name "version.server".
  * TXT record with RDATA "v0" in response on software query name
    "version.bind" in answer section.
    * TXT record is in IN class, not CH class.




[NAMESERVER15]:                                                   ../../tests/Nameserver-TP/nameserver15.md
[RCODE Name]:                                                     https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[Test zone README file]:                                          ../README.md
[Zone setup for test scenarios]:                                  #zone-setup-for-test-scenarios

