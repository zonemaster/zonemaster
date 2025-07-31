# Specification of test scenarios for Zone11


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

This document specifies defined test scenarios for test case [Zone11].


## Test scenarios

The purpose of the test scenarios is to cover all reasonable contexts where
different message tags are outputted when [Zone11] is run on a test zone.
The message tags are defined in the test case ([Zone11]) and the scenarios
are defined below.

The test scenarios are structured as stated in the [test scenario README file].

## Test zone names

Unless specified otherwise, the test zone for each test scenario in this
document is a subdomain delegated from the base name (`zone11.xa`) and that
subdomain having the same name as the scenario. The names of those zones are
given in section "[Test scenarios and setup of test zones]" below.

## All message tags

The test case can output any of these message tags, but not necessarily in any
combination. See [Zone11] for the specification of the tags.

* Z11_DIFFERENT_SPF_POLICIES_FOUND
* Z11_INCONSISTENT_SPF_POLICIES
* Z11_NO_SPF_FOUND
* Z11_NO_SPF_NON_MAIL_DOMAIN
* Z11_NON_NULL_SPF_NON_MAIL_DOMAIN
* Z11_NULL_SPF_NON_MAIL_DOMAIN
* Z11_SPF_MULTIPLE_RECORDS
* Z11_SPF_SYNTAX_ERROR
* Z11_SPF_SYNTAX_OK
* Z11_UNABLE_TO_CHECK_FOR_SPF


## Test scenarios and message tags

If a message tag is not listed for the scenario, its presence or non-presence is
irrelevant to the test scenario and must be ignored.

| Scenario name          | Mandatory message tags                                          | Forbidden message tags |
|:-----------------------|:----------------------------------------------------------------|:-----------------------|
| GOOD-SPF-1             | Z11_SPF_SYNTAX_OK                                               | 2)                     |
| GOOD-SPF-2             | Z11_SPF_SYNTAX_OK                                               | 2)                     |
| SAME-SPF-DIFFERENT-TXT | Z11_SPF_SYNTAX_OK                                               | 2)                     |
| NO-TXT                 | Z11_NO_SPF_FOUND                                                | 2)                     |
| NO-SPF-TXT             | Z11_NO_SPF_FOUND                                                | 2)                     |
| NO-SPF-ROOT-ZONE       | Z11_NO_SPF_NON_MAIL_DOMAIN                                      | 2)                     |
| NO-SPF-TLD-ZONE        | Z11_NO_SPF_NON_MAIL_DOMAIN                                      | 2)                     |
| NO-SPF-ARPA-ZONE       | Z11_NO_SPF_NON_MAIL_DOMAIN                                      | 2)                     |
| NULL-SPF-ROOT-ZONE     | Z11_NULL_SPF_NON_MAIL_DOMAIN                                    | 2)                     |
| NULL-SPF-TLD-ZONE      | Z11_NULL_SPF_NON_MAIL_DOMAIN                                    | 2)                     |
| NULL-SPF-ARPA-ZONE     | Z11_NULL_SPF_NON_MAIL_DOMAIN                                    | 2)                     |
| NON-NULL-SPF-ROOT-ZONE | Z11_NON_NULL_SPF_NON_MAIL_DOMAIN                                | 2)                     |
| NON-NULL-SPF-TLD-ZONE  | Z11_NON_NULL_SPF_NON_MAIL_DOMAIN                                | 2)                     |
| NON-NULL-SPF-ARPA-ZONE | Z11_NON_NULL_SPF_NON_MAIL_DOMAIN                                | 2)                     |
| INVALID-SYNTAX-1       | Z11_SPF_SYNTAX_ERROR                                            | 2)                     |
| INVALID-SYNTAX-2       | Z11_SPF_SYNTAX_ERROR                                            | 2)                     |
| INVALID-SYNTAX-3       | Z11_SPF_SYNTAX_ERROR                                            | 2)                     |
| NON-AUTH-TXT           | Z11_UNABLE_TO_CHECK_FOR_SPF                                     | 2)                     |
| SERVFAIL               | Z11_UNABLE_TO_CHECK_FOR_SPF                                     | 2)                     |
| INCONSISTENT-SPF       | Z11_INCONSISTENT_SPF_POLICIES, Z11_DIFFERENT_SPF_POLICIES_FOUND | 2)                     |
| SPF-MISSING-ON-ONE     | Z11_INCONSISTENT_SPF_POLICIES, Z11_DIFFERENT_SPF_POLICIES_FOUND | 2)                     |
| ALL-DIFFERENT-SPF      | Z11_INCONSISTENT_SPF_POLICIES, Z11_DIFFERENT_SPF_POLICIES_FOUND | 2)                     |
| MULTIPLE-SPF-RECORDS   | Z11_SPF_MULTIPLE_RECORDS                                        | 2)                     |


* (1) All tags except for those specified as "Forbidden message tags" (no instances for these test scenarios)
* (2) All tags except for those specified as "Mandatory message tags"

## Test scenarios and setup of test zones

### Default zone configuration

Unless otherwise specified in the specific scenario specification, the test zone
for the scenario will follow the default setup as stated below. The `child zone`
is the zone to be tested for the scenario.

* The child zone is `SCENARIO.zone11.xa`.
  * There is a zone file for the child zone.
  * It is served by two name servers named ns1 and ns2.child.zone11.xa.
  * ns1 and ns2 have the same zone content.
  * ns1 and ns2 have both IPv4 and IPv6 address records.
* The parent zone is `zone11.xa`.
  * It is served by two in-bailiwick name servers named ns1 and ns2.zone11.xa.
  * ns1 and ns2 have the same zone content.
  * ns1 and ns2 have both IPv4 and IPv6 glue.
  * The records matching glue in the zone are complete.
* All responses will have the AA bit set.
* All responses will have the [RCODE Name] "NoError".

### GOOD-SPF-1

A zone whose SPF record is the shortest legal SPF record possible, namely the
string `v=spf1`. It is valid syntax, albeit not very useful.

* Zone: good-spf-1.zone11.xa
  * The TXT RRset at the apex contains one TXT record with the text `v=spf1`.

### GOOD-SPF-2

A zone whose SPF record is well-formed and contains at least one term.

* Zone: good-spf-2.zone11.xa
  * The TXT RRset at the apex contains one TXT record starting with the text
    `v=spf1`, followed by a space, followed by one or more legal SPF terms.

### SAME-SPF-DIFFERENT-TXT

A zone whose SPF record is identical despite inconsistent TXT RRset records at
the apex.

* Zone: same-spf-different-txt.zone11.xa
  * ns1 serves a TXT RRset containing one SPF record and one non-SPF record.
  * ns2 serves a different TXT RRset containing one SPF record and one non-SPF
    record. The SPF record served by ns2 is identical to the one served
    by ns1. The non-SPF record served by ns2 is different from the one served
    by ns1.

### NO-TXT

A zone containing no TXT record at the apex.

* Zone: no-txt.zone11.xa
  * The TXT RRset at the apex is empty.

### NO-SPF-TXT

A zone containing at least one TXT record, but none of the TXT after
concatenating all strings, gives a string starting with `v=spf1`.

* Zone: no-spf-txt.zone11.xa
  * The TXT RRset at the apex is non-empty, but none of the TXT records are
    recognized as SPF records.

### NO-SPF-ROOT-ZONE

A root zone without SPF records.

* Zone: "." (root zone)
  * It is served by ns1 and ns2.no-spf.root-servers.zone11.xa.
  * The TXT RRset at the apex of the root zone is empty.

### NO-SPF-TLD-ZONE

A TLD zone without SPF records.

* Zone: no-spf-zone11
  * It is served by ns1 and ns2.zone11.xa.
  * The TXT RRset at the apex of the TLD zone is empty.

### NO-SPF-ARPA-ZONE

A zone in .arpa without SPF records.

* Zone: no-spf-arpa-zone.zone11.arpa
  * It is served by ns1 and ns2.child.zone11.xa.
  * The TXT RRset at the apex of the zone is empty.

### NULL-SPF-ROOT-ZONE

A root zone with a null SPF record.

* Zone: "." (root zone)
  * It is served by ns1 and ns2.null-spf.root-servers.zone11.xa.
  * The TXT RRset at the apex of the root zone contains one TXT record with the
    string `v=spf1 -all`.

### NULL-SPF-TLD-ZONE

A TLD zone with null SPF records.

* Zone: null-spf-zone11
  * It is served by ns1 and ns2.zone11.xa.
  * The TXT RRset at the apex of the TLD zone contains one TXT record with the
    string `v=spf1 -all`.

### NULL-SPF-ARPA-ZONE

A zone in .arpa with a null SPF record.

* Zone: null-spf-arpa-zone.zone11.arpa
  * It is served by ns1 and ns2.child.zone11.xa.
  * The TXT RRset at the apex of the zone contains one TXT record with the
    string `v=spf1 -all`.

### NON-NULL-SPF-ROOT-ZONE

A root zone with a non-null SPF record.

* Zone: "." (root zone)
  * It is served by ns1 and ns2.non-null-spf.root-servers.zone11.xa.
  * The TXT RRset at the apex of the root zone contains one TXT record with an
    SPF record that isn’t null (i.e. permits at least one IP address).

### NON-NULL-SPF-TLD-ZONE

A TLD zone with a non-null SPF record.

* Zone: non-null-spf-zone11
  * It is served by ns1 and ns2.zone11.xa.
  * The TXT RRset at the apex of the TLD zone contains one TXT record with an
    SPF record that isn’t null (i.e. permits at least one IP address).

### NON-NULL-SPF-ARPA-ZONE

A zone in .arpa with a non-null SPF record.

* Zone: non-null-spf-arpa-zone.zone11.arpa
  * It is served by ns1 and ns2.child.zone11.xa.
  * The TXT RRset at the apex of the zone contains one TXT record with an SPF
    record that isn’t null (i.e. permits at least one IP address).

### INVALID-SYNTAX-1

A zone whose SPF record is syntactically invalid.

* Zone: invalid-syntax-1.zone11.xa
  * The TXT RRset at the apex contains one SPF record with invalid syntax,
    i.e. beginning with `v=spf1` followed by whitespace but not compliant with
    the ABNF grammar described in [RFC 7208, Section 4.5][RFC 7208#4.5] and
    following sections.

### INVALID-SYNTAX-2

Like INVALID-SYNTAX-1, but two of the name server names in the delegation and in
the zone point to the same IP address. This scenario is there to ensure that
all name servers that serve an ill-formed SPF policy are reported, even if two
of them have the same IP address.

* Zone: invalid-syntax-2.zone11.xa
  * It is served by ns1a, ns1b, and ns2.invalid-syntax.zone11.xa.
  * ns1a and ns1b resolve to the same IPv4 and IPv6 address as
    ns1.child.zone11.xa.
  * ns2 resolves to the same IPv4 and IPv6 address as ns2.child.zone11.xa.
  * The TXT RRset at the apex contains one SPF record with invalid syntax,
    i.e. beginning with `v=spf1` followed by whitespace but not compliant with
    the ABNF grammar described in [RFC 7208, Section 4.5][RFC 7208#4.5] and
    following sections.

### INVALID-SYNTAX-3

A zone whose SPF record contains a few random bytes, with a few non-ASCII
bytes among those.

* Zone: invalid-syntax-3.zone11.xa
  * The TXT RRset at the apex contains one SPF record beginning with `v=spf1`,
    followed by some whitespace and containing some random bytes outside the
    printable ASCII range, which is not compliant with the ABNF grammar
    described in [RFC 7208, Section 4.5][RFC 7208#4.5] and following sections.

### NON-AUTH-TXT

A zone containing one SPF record in its TXT RRset, but served from name
servers that fail to set the AA bit in their responses.

* Zone: non-auth-txt.zone11.xa
  * The TXT RRset at the apex contains one SPF record.
  * Both name servers serve the aforementioned TXT RRset with the AA bit unset
    in the response header.

### SERVFAIL

A zone where responses to queries for the TXT RRset have an RCODE different
from NoError.

* Zone: servfail.zone11.xa
  * Responses to queries for the TXT RRset at the zone’s apex have the
    [RCODE Name] "ServFail".

### INCONSISTENT-SPF

A zone that serves different SPF records depending on the name server being
queried.

* Zone: inconsistent-spf.zone11.xa
  * ns1 serves a TXT RRset at the apex containing one SPF record.
  * ns2 serves a different TXT RRset at the apex containing one SPF record
    that is also different from the SPF record served by ns1.

### SPF-MISSING-ON-ONE

A zone that serves identical SPF records, except on one of the name servers.

* Zone: spf-missing-on-one.zone11.xa
  * The zone is delegated to three name servers named ns1, ns2 and
    ns3.child.zone11.xa.
  * ns2 and ns3 serve an identical TXT RRset at the apex containing one SPF
    record.
  * ns1 serves a different TXT RRset at the apex without an SPF record.

### ALL-DIFFERENT-SPF

A zone that serves different SPF records on all of its name servers.

* Zone: all-different-spf.zone11.xa
  * The zone is delegated to three name servers named ns1, ns2 and
    ns3.child.zone11.xa.
  * ns1 serves a TXT RRset at the apex containing one SPF record
  * ns2 serves a different TXT RRset at the apex containing one SPF record
    that is also different.
  * ns3 serves another different TXT RRset at the apex containing one SPF
    record that is different from the two previous records.

### MULTIPLE-SPF-RECORDS

A zone whose TXT RRset at the apex contains more than one SPF record.

* Zone: multiple-spf-records.zone11.xa
  * The TXT RRset at the apex contains more than one SPF record.


[Zone11]:                                 ../../tests/Zone-TP/zone11.md
[RCODE Name]:                             https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[RFC 7208]:                               https://www.rfc-editor.org/rfc/rfc7208
[RFC 7208#4.5]:                           https://www.rfc-editor.org/rfc/rfc7208#section-4.5
[Test scenario README file]:              ../README.md
[Test scenarios and setup of test zones]: #zone-setup-for-test-scenarios
