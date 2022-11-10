# Specification of test data for ZONE09


## Background

See the [test zone and test data README file].


## Test Case
This document specifies available test data for test case [Zone09].


## Test zone name

The test zone for each test scenario is assumed to be a subdomain delegated from
the base name (`zone09.xa`) and that subdomain having the same name as the
scenario (e.g. `no-response-mx-query.zone09.xa`) except where the test domain must
be the root zone, a TLD or a domain under .ARPA. The names of those zones are
given below.


## Test scenarios and message tags

For each scenario it is defined which tags that must be returned (mandatory) when
the test case is run for the domain name of the scenario, and which tags that
must not be returned (forbidden). The tag may have any severity level. If a
message tag is not listed for the scenario, its presence or non-presence is
irrelevant to the test scenario and can be ignored.

Scenario name         | Mandatory message tags                            | Forbidden message tags
:---------------------|:--------------------------------------------------|:-------------------------------------------
NO-RESPONSE-MX-QUERY  | Z09_NO_RESPONSE_MX_QUERY                          | (none)
UNEXPECTED-RCODE-MX   | Z09_UNEXPECTED_RCODE_MX                           | (none)
NON-AUTH-MX-RESPONSE  | Z09_NON_AUTH_MX_RESPONSE                          | (none)
INCONSISTENT-MX       | Z09_INCONSISTENT_MX, Z09_MX_FOUND Z09_NO_MX_FOUND | Z09_MISSING_MAIL_TARGET
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

Assumptions for the scenario specifications:
* Only MX records in apex are considered.
* Unless otherwise stated, all name servers responds authoritatively with the
  SOA record on SOA queries.
* Unless otherwise stated, all name servers responds authoritatively with (or
  without) MX records on MX queries.

* NO-RESPONSE-MX-QUERY
  * At least one name server returns an authoritative answer on SOA query, but no
    DNS response on MX query.

* UNEXPECTED-RCODE-MX
  * At least one name server returns an authoritative answer on SOA query, but
    non-NOERROR RCODE on MX query.

* NON-AUTH-MX-RESPONSE
  * At least one name server returns an authoritative answer on SOA query, but
    NOERROR RCODE and non-AA on MX query.

* INCONSISTENT-MX
  * At least one name server for the zone return MX and at least one return no MX
    in an authoritative answer.

* INCONSISTENT-MX-DATA
  * At least two name servers for the zone respond, authoritatively, with
    different MX RR sets.

* NULL-MX-WITH-OTHER-MX
  * The test zone has MX and all its name servers that respond with MX RRset
    have the same MX RRset and that is a mix of Null MX and non-Null MX.

* NULL-MX-NON-ZERO-PREF
  * The test zone has MX and all its name servers that respond with MX RRset
    have the same MX RRset and at least one MX record is a Null MX with a
    non-zero preference.

* TLD-EMAIL-DOMAIN (".xa")
  * The test zone is a TLD and has MX and all its name servers that respond with
    MX RRset have the same MX RRset with no Null MX.

* ROOT-EMAIL-DOMAIN (".")
  * The test zone is the root zone and has MX and all its name servers that
    respond with MX RRset have the same MX RRset with no Null MX.

* MX-DATA
  * The test zone is neither root nor a TLD. All name servers responds with the
    same MX RRset. No MX record is a Null MX.

* NULL-MX
  * All name servers for the test zone responds with a single, valid NULL MX.

* NO-MX-SLD
  * The test zone is neither root, TLD or under .ARPA. No name server responds
    with an MX RRset.

* NO-MX-TLD (".xa")
  * The test zone is a TLD. No name server responds with an MX RRset.

* NO-MX-ARPA ("2.0.192.in-addr.arpa")
  * The test zone is under .ARPA. No name server responds with an MX RRset.


[Zone09]:                                       ../../specifications/tests/Zone-TP/zone09.md
[test zone and test data README file]:          ../README.md
