# Specification of Test Scenarios for ZONE09

## Table of contents

* [Background](#background)
* [Test Case](#test-case)
* [Test scenarios](#test-scenarios)
* [Test zone names](#test-zone-names)
* [All message tags](#all-message-tags)
* [Test scenarios and message tags](#test-scenarios-and-message-tags)
* [Zone setup for test scenarios]


## Background

See the [test scenario README file].


## Test Case

This document specifies defined test zones for test case [Zone09].


## Test scenarios

The purpose of the test scenarios is to cover all reasonable contexts where
different message tags are outputted when [Zone09] is run on a test zone. The
message tags are defined in the test case ([Zone09]) and the scenarios are
defined below.

The test scenarios are structured as stated in the [test scenario README file].


## Test zone names

The test zone for each test scenario in this document is a subdomain delegated
from the base name (`zone09.xa`) and that subdomain having the same name as the
scenario except where the test domain must be the root zone, a TLD or a domain
under `.arpa`. The names of those zones are given in section
"[Zone setup for test scenarios]" below.


## All message tags
The test case can output any of these message tags, but not necessarily in any
combination. See [Zone09] for the specification of the tags.

* Z09_ARPA_EMAIL_DOMAIN
* Z09_INCONSISTENT_MX
* Z09_INCONSISTENT_MX_DATA
* Z09_MISSING_MAIL_EXCHANGE
* Z09_MX_DATA
* Z09_MX_FOUND
* Z09_NON_AUTH_MX_RESPONSE
* Z09_NO_MX_FOUND
* Z09_NO_MX_FOUND_OR_EXPECTED
* Z09_NO_SERVERS_MX_RESPONSE
* Z09_NO_RESPONSE_MX_QUERY
* Z09_NULL_MX_NON_ZERO_PREF
* Z09_NULL_MX_WITH_OTHER_MX
* Z09_ROOT_EMAIL_DOMAIN
* Z09_TLD_EMAIL_DOMAIN
* Z09_UNEXPECTED_RCODE_MX
* Z09_VALID_NULL_MX


## Test scenarios and message tags

If a message tag is not listed for the scenario, its presence or non-presence is
irrelevant to the test scenario and must be ignored.

| Scenario name          | Mandatory message tags                                              | Forbidden message tags |
|:-----------------------|:--------------------------------------------------------------------|:-----------------------|
| NO-RESPONSE-MX-QUERY-1 | Z09_NO_RESPONSE_MX_QUERY, Z09_MX_DATA                               | 2)                     |
| NO-RESPONSE-MX-QUERY-2 | Z09_NO_RESPONSE_MX_QUERY, Z09_NO_SERVERS_MX_RESPONSE                | 2)                     |
| UNEXPECTED-RCODE-MX    | Z09_UNEXPECTED_RCODE_MX, Z09_MISSING_MAIL_EXCHANGE                  | 2)                     |
| NON-AUTH-MX-RESPONSE   | Z09_NON_AUTH_MX_RESPONSE, Z09_MX_DATA                               | 2)                     |
| INCONSISTENT-MX        | Z09_INCONSISTENT_MX, Z09_MX_FOUND Z09, Z09_NO_MX_FOUND, Z09_MX_DATA | 2)                     |
| INCONSISTENT-MX-DATA-1 | Z09_INCONSISTENT_MX_DATA, Z09_MX_DATA                               | 2)                     |
| INCONSISTENT-MX-DATA-1 | Z09_INCONSISTENT_MX_DATA, Z09_MX_DATA                               | 2)                     |
| INCONSISTENT-MX-DATA-1 | Z09_INCONSISTENT_MX_DATA, Z09_MX_DATA                               | 2)                     |
| MIXED-TTL-1            | Z09_MX_DATA                                                         | 2)                     |
| MIXED-TTL-2            | Z09_MX_DATA                                                         | 2)                     |
| NULL-MX-WITH-OTHER-MX  | Z09_NULL_MX_WITH_OTHER_MX, Z09_MX_DATA                              | 2)                     |
| NULL-MX-NON-ZERO-PREF  | Z09_NULL_MX_NON_ZERO_PREF, Z09_MX_DATA                              | 2)                     |
| TLD-EMAIL-DOMAIN       | Z09_TLD_EMAIL_DOMAIN, Z09_MX_DATA                                   | 2)                     |
| ROOT-EMAIL-DOMAIN      | Z09_ROOT_EMAIL_DOMAIN, Z09_MX_DATA                                  | 2)                     |
| ARPA-EMAIL-DOMAIN      | Z09_ARPA_EMAIL_DOMAIN, Z09_MX_DATA                                  | 2)                     |
| MX-DATA                | Z09_MX_DATA                                                         | 2)                     |
| NULL-MX-TLD            | Z09_MX_DATA, Z09_VALID_NULL_MX                                      | 2)                     |
| NULL-MX-ROOT           | Z09_MX_DATA, Z09_VALID_NULL_MX                                      | 2)                     |
| NULL-MX-ARPA           | Z09_MX_DATA, Z09_VALID_NULL_MX                                      | 2)                     |
| NULL-MX-SLD            | Z09_MX_DATA, Z09_VALID_NULL_MX                                      | 2)                     |
| NO-MX-SLD              | Z09_MISSING_MAIL_EXCHANGE                                           | 2)                     |
| NO-MX-TLD              | Z09_NO_MX_FOUND_OR_EXPECTED                                         | 2)                     |
| NO-MX-ROOT             | Z09_NO_MX_FOUND_OR_EXPECTED                                         | 2)                     |
| NO-MX-ARPA             | Z09_NO_MX_FOUND_OR_EXPECTED                                         | 2)                     |

* (1) All tags except for those specified as "Forbidden message tags" (no instances for these test scenarios)
* (2) All tags except for those specified as "Mandatory message tags"

## Zone setup for test scenarios

Assumptions for the zone setup for the test scenarios:
* Only MX records in apex are considered.
* Unless otherwise stated, all name servers respond authoritatively with the
  SOA record on SOA queries.
* Unless otherwise stated, all name servers respond authoritatively with (or
  without) MX records on MX queries.
* Unless otherwise stated, all responses are authoritative and with [RCODE Name]
  "NoError".
* Unless otherwise stated all name servers for the zone responds with an
  identical, non-empty, non-Null MX RRset on MX query.
* Unless otherwise stated all zones are served by two name severs whose name are
  in-domain.

### NO-RESPONSE-MX-QUERY-1
* Zone: "no-response-mx-query-1.zone09.xa."
  * One name server does not respond on MX query.

### NO-RESPONSE-MX-QUERY-2
* Zone: "no-response-mx-query-2.zone09.xa."
  * No name server responds on MX query.

### UNEXPECTED-RCODE-MX
* Zone: "unexpected-rcode-mx.zone09.xa."
  * One name server returns with any [RCODE Name] except "NoError".
  * The other returns no MX.

### NON-AUTH-MX-RESPONSE
* Zone: "non-auth-mx-response.zone09.xa."
  * One name server returns with [RCODE Name] "NoError" and non-AA on MX query.

### INCONSISTENT-MX
* Zone: "inconsistent-mx.zone09.xa."
  * One name server responds without MX RRset (NODATA).

### INCONSISTENT-MX-DATA-1
* Zone: "inconsistent-mx-data-1.zone09.xa."
  * The name servers respond with MX RRsets that are not equal, two MX records
    from one server, and just one of the two MX records from the other.

### INCONSISTENT-MX-DATA-2
* Zone: "inconsistent-mx-data-2.zone09.xa."
  * Both name servers respond with one MX record which has the same mail exchange
    names from both servers, but the preferences different.

### INCONSISTENT-MX-DATA-3
* Zone: "inconsistent-mx-data-3.zone09.xa."
  * Both name servers respond with two MX records and the same two mail exchange
    names are used, but the orders between the the two records, as defined by
    the preference, are different between the two servers.

### MIXED-TTL-1
* Zone: "mixed-ttl-1.zone09.xa."
  * The TTL of the MX RRset are different on the two NS.

### MIXED-TTL-2
* Zone: "mixed-ttl-2.zone09.xa."
  * The TTL of the records in the MX RRset are different.

### NULL-MX-WITH-OTHER-MX
* Zone: "null-mx-with-other-mx.zone09.xa."
  * The MX RRset is a mix of Null MX and non-Null MX.

### NULL-MX-NON-ZERO-PREF
* Zone: "null-mx-non-zero-pref.zone09.xa."
  * The MX RRset has a single Null MX record with a non-zero preference.

### TLD-EMAIL-DOMAIN
* Zone: "tld-email-domain-zone09." (TLD, dash "-", not dot ".")
  * The test zone is a TLD zone.

### ROOT-EMAIL-DOMAIN
* Zone: "." (root zone)
  * The test zone is the root zone.

### ARPA-EMAIL-DOMAIN
* Zone: "arpa-email-domain.zone09.arpa."
  * The test zone is under .ARPA.

### MX-DATA
* Zone: "mx-data.zone09.xa."

### NULL-MX-TLD
* Zone: "null-mx-tld-zone09." (TLD, dash "-", not dot ".")
  * The test zone is a TLD.
  * The MX RRset has a single, valid NULL MX.

### NULL-MX-ROOT
* Zone: "." (root zone)
  * The test zone is the root zone.
  * The MX RRset has a single, valid NULL MX.

### NULL-MX-ARPA
* Zone: "null-mx-arpa.zone09.arpa."
  * The test zone is under .ARPA.
  * The MX RRset has a single, valid NULL MX.

### NULL-MX-SLD
* Zone: "null-mx-sld.zone09.xa."
  * The MX RRset has a single, valid NULL MX.

### NO-MX-SLD
* Zone: "no-mx-sld.zone09.xa."
  * The test zone is neither root, TLD or under .ARPA.
  * All name servers respond with no MX RRset (NODATA).

### NO-MX-TLD
* Zone: "no-mx-tld-zone09." (TLD, dash "-", not dot ".")
  * The test zone is a TLD.
  * All name servers respond with no MX RRset (NODATA).

### NO-MX-ROOT
* Zone: "." (root zone)
  * The test zone is the root zone.
  * All name servers respond with no MX RRset (NODATA).

### NO-MX-ARPA
* Zone: "no-mx-arpa.zone09.arpa."
  * The test zone is under .ARPA.
  * All name servers respond with no MX RRset (NODATA).


[RCODE Name]:                                                     https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[Test scenario README file]:                                      ../README.md
[Zone setup for test scenarios]:                                  #zone-setup-for-test-scenarios
[Zone09]:                                                         ../../tests/Zone-TP/zone09.md
