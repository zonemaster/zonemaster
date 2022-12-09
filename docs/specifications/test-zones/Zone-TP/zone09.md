# Specification of test zones for ZONE09

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
This document specifies defined test zones for test case [Zone09].


## Test scenarios

The purpose of the test scenarios is to cover all reasonable contexts where
different message tags are outputted when [Zone09] is run on a test zone. The
message tags are defined in the test case ([Zone09]) and the scenarios are
defined below.

The scenarios are defined in two parts. The first part defines the expectations
on message tags from [Zone09] when Zonemaster is run against the zone set up for
the scenario:

* What messages must be outputted (mandatory).
* What messages must not be outputted (forbidden).

The second part specifies the zone setup for the scenario.


## Test zone names

The test zone for each test scenario in this docuemtn is a subdomain delegated
from the base name (`zone09.xa`) and that subdomain having the same name as the
scenario except where the test domain must be the root zone, a TLD or a domain
under `.arpa`. The names of those zones are given in section
"[Zone setup for test scenarios]" below.


## Test scenarios and message tags

If a message tag is not listed for the scenario, its presence or non-presence is
irrelevant to the test scenario and must be ignored.

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
NO-RESPONSE-MX-QUERY  | Z09_NO_RESPONSE_MX_QUERY                          | (none)
UNEXPECTED-RCODE-MX   | Z09_UNEXPECTED_RCODE_MX                           | (none)
NON-AUTH-MX-RESPONSE  | Z09_NON_AUTH_MX_RESPONSE                          | (none)
INCONSISTENT-MX       | Z09_INCONSISTENT_MX, Z09_MX_FOUND Z09, NO_MX_FOUND, Z09_MX_DATA | Z09_MISSING_MAIL_TARGET
INCONSISTENT-MX-DATA  | Z09_INCONSISTENT_MX_DATA, Z09_MX_DATA             | Z09_MISSING_MAIL_TARGET, Z09_NULL_MX_NON_ZERO_PREF, Z09_NULL_MX_WITH_OTHER_MX, Z09_ROOT_EMAIL_DOMAIN, Z09_TLD_EMAIL_DOMAIN
NULL-MX-WITH-OTHER-MX | Z09_NULL_MX_WITH_OTHER_MX                         | Z09_INCONSISTENT_MX_DATA, Z09_MX_DATA, Z09_MISSING_MAIL_TARGET, Z09_ROOT_EMAIL_DOMAIN, Z09_TLD_EMAIL_DOMAIN
NULL-MX-NON-ZERO-PREF | Z09_NULL_MX_NON_ZERO_PREF                         | Z09_INCONSISTENT_MX_DATA, Z09_MX_DATA, Z09_MISSING_MAIL_TARGET, Z09_ROOT_EMAIL_DOMAIN, Z09_TLD_EMAIL_DOMAIN
TLD-EMAIL-DOMAIN      | Z09_TLD_EMAIL_DOMAIN                              | Z09_INCONSISTENT_MX_DATA, Z09_MX_DATA, Z09_MISSING_MAIL_TARGET, Z09_ROOT_EMAIL_DOMAIN, Z09_NULL_MX_WITH_OTHER_MX, Z09_NULL_MX_NON_ZERO_PREF
ROOT-EMAIL-DOMAIN     | Z09_ROOT_EMAIL_DOMAIN                             | Z09_INCONSISTENT_MX_DATA, Z09_MX_DATA, Z09_MISSING_MAIL_TARGET, Z09_TLD_EMAIL_DOMAIN, Z09_NULL_MX_WITH_OTHER_MX, Z09_NULL_MX_NON_ZERO_PREF
MX-DATA               | Z09_MX_DATA                                       | Z09_INCONSISTENT_MX_DATA, Z09_MISSING_MAIL_TARGET, Z09_TLD_EMAIL_DOMAIN, Z09_ROOT_EMAIL_DOMAIN, Z09_NULL_MX_WITH_OTHER_MX, Z09_NULL_MX_NON_ZERO_PREF
NULL-MX               | (none)                                            | Z09_INCONSISTENT_MX_DATA, Z09_MX_DATA, Z09_MISSING_MAIL_TARGET, Z09_TLD_EMAIL_DOMAIN, Z09_ROOT_EMAIL_DOMAIN, Z09_NULL_MX_WITH_OTHER_MX, Z09_NULL_MX_NON_ZERO_PREF
NO-MX-SLD             | Z09_MISSING_MAIL_TARGET                           | Z09_INCONSISTENT_MX_DATA, Z09_MX_DATA, Z09_TLD_EMAIL_DOMAIN, Z09_ROOT_EMAIL_DOMAIN, Z09_NULL_MX_WITH_OTHER_MX, Z09_NULL_MX_NON_ZERO_PREF
NO-MX-TLD             | (none)                                            | Z09_INCONSISTENT_MX_DATA, Z09_MX_DATA, Z09_MISSING_MAIL_TARGET, Z09_TLD_EMAIL_DOMAIN, Z09_ROOT_EMAIL_DOMAIN, Z09_NULL_MX_WITH_OTHER_MX, Z09_NULL_MX_NON_ZERO_PREF
NO-MX-ARPA            | (none)                                            | Z09_INCONSISTENT_MX_DATA, Z09_MX_DATA, Z09_MISSING_MAIL_TARGET, Z09_TLD_EMAIL_DOMAIN, Z09_ROOT_EMAIL_DOMAIN, Z09_NULL_MX_WITH_OTHER_MX, Z09_NULL_MX_NON_ZERO_PREF


## Zone setup for test scenarios

Assumptions for the zone setup for the test scenarios:
* Only MX records in apex are considered.
* Unless otherwise stated, all name servers respond authoritatively with the
  SOA record on SOA queries.
* Unless otherwise stated, all name servers respond authoritatively with (or
  without) MX records on MX queries.
* Unless otherwise stated, all respond are authoritative and with [RCODE Name]
  "NoError".

### NO-RESPONSE-MX-QUERY
* Zone: "no-response-mx-query.zone09.xa."
  * The zone has two name servers.
  * Both name servers return an authoritative answer on SOA query.
  * One name server does not respond on MX query.

### UNEXPECTED-RCODE-MX
* Zone: "unexpected-rcode-mx.zone09.xa."
  * The zone has two name servers.
  * Both name servers return an authoritative answer on SOA query.
  * One name server returns with any [RCODE Name] except "NoError".

### NON-AUTH-MX-RESPONSE
* Zone: "non-auth-mx-response.zone09.xa."
  * The zone has two name servers.
  * Both name server return an authoritative answer on SOA query.
  * One name server returns with [RCODE Name] "NoError" and non-AA on MX query.

### INCONSISTENT-MX
* Zone: "inconsistent-mx.zone09.xa."
  * The zone has two name servers.
  * One name server respond with a non-Null MX RRset.
  * The other responds without MX RRset (NODATA).

### INCONSISTENT-MX-DATA
* Zone: "inconsistent-mx-data.zone09.xa."
  * The zone has two name servers.
  * Both name servers respond with an MX RRset.
  * The two MX RRsets are not equal.

### NULL-MX-WITH-OTHER-MX
* Zone: "null-mx-with-other-mx.zone09.xa."
  * All name servers respond with the same MX RRset.
  * The MX RRset is a mix of Null MX and non-Null MX.

### NULL-MX-NON-ZERO-PREF
* Zone: "null-mx-non-zero-pref.zone09.xa."
  * All name servers respond with the same MX RRset.
  * The MX RRset is a single MX record.
  * The MX record is a Null MX with a non-zero preference.

### TLD-EMAIL-DOMAIN
* Zone: "tld-email-domain-zone09." (TLD, dash "-", not dot ".")
  * The test zone is a TLD zone.
  * All name servers respond with the same MX RRset.
  * All MX records are non-Null MX.

### ROOT-EMAIL-DOMAIN
* Zone: "." (root zone)
  * The test zone is the root zone.
  * All name servers respond with the same MX RRset.
  * All MX records are non-Null MX.

### MX-DATA
* Zone: "mx-data.zone09.xa."
  * All name servers respond with the same MX RRset.
  * All MX records are non-Null MX.

### NULL-MX
* Zone: "null-mx.zone09.xa."
  * All name servers respond with the same MX RRset.
  * The MX RRset has a single, valid NULL MX.

### NO-MX-SLD
* Zone: "no-mx-sld.zone09.xa."
  * The test zone is neither root, TLD or under .ARPA.
  * All name servers respond with no MX RRset (NODATA).

### NO-MX-TLD
* Zone: "no-mx-tld-zone09." (TLD, dash "-", not dot ".")
  * The test zone is a TLD.
  * All name servers respond with no MX RRset (NODATA).

### NO-MX-ARPA
* Zone: "no-mx-arpa.zone09.arpa."
  * The test zone is under .ARPA.
  * All name servers respond with no MX RRset (NODATA).


[RCODE Name]:                                                     https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[Test zone README file]:                                          ../README.md
[Zone setup for test scenarios]:                                  #zone-setup-for-test-scenarios
[Zone09]:                                                         ../../specifications/tests/Zone-TP/zone09.md
