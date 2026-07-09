# ZONE09: MX record present


## Test case identifier
**ZONE09**


## Table of contents

* [Objective](#objective)
* [Scope](#scope)
* [Inputs](#inputs)
* [Summary](#summary)
* [Test procedure](#test-procedure)
* [Outcome(s)](#outcomes)
* [Special procedural requirements](#special-procedural-requirements)
* [Intercase dependencies](#intercase-dependencies)
* [Terminology](#terminology)


## Objective

It is strongly recommended in [RFC 2142][RFC 2142#section-7],
section 7, that every domain should have a mailbox named
HOSTMASTER@domain (where "domain" is *Child Zone* in this test case).

> For simplicity and regularity, it is strongly recommended that the
> well known mailbox name HOSTMASTER always be used
> \<HOSTMASTER@domain\>.

This test case therefore expects for every domain (zone), excluding some cases
described below, to publish an MX record in apex of the zone (i.e. in the same
node as the SOA record).

If MX is not present, SMTP *can* deliver email using an address record (A or
AAAA) as specified in [RFC 5321][RFC 5321#section-5.1], section 5.1, but that
possibility is not in common use. This test case only checks for MX record and
ignores the possibility to use address records for email.

Even if not mentioned in [RFC 2142], there are some exceptions to the
rule to include MX and a mail exchange for a domain.

The purpose of a zone in the .ARPA tree is to hold infrastructural identifiers,
and it is not expected that such a zone name is used as [Email Domain]
([RFC 3172]). This also means that the well known mailbox is not expected for
reverse zones (zone under in-addr.arpa or ip6.arpa). Such zone are therefore
excluded by this test case from the requirement of MX in the apex.

The root zone cannot be an [Email Domain] since the email domain is
the part to the left of the trailing dot, and the root zone owner name has
nothing left of the trailing dot. The root zone is excluded by this test case from
the requirement of MX in the apex.

Top-level domains ([TLDs][TLD]) can technically function as
[Email Domains][Email Domain] ([RCF 5321][RFC 5321#section-2.3.5], section 2.3.5)
but they rarely have that function and are probably not meant to be included in
the specification in [RFC 2142]. [Internet Architecture Board]
concludes in a report "[Dotless Domains Considered Harmful][IAB Statement]" that
domain names that only consists of one label, e.g. "se", "fr" or "com", should
not be used for various Internet services. This means [TLD] names should not be
used as [Email Domains][Email Domain]. In this test case [TLDs][TLD] are not only
excluded from the requirement of being an [Email Domain], if found to be, a
message will be generated that points that out.

[RFC 7505] standardizes "[Null MX]" which means that there is no email service
for the domain. A "[Null MX]" is accepted for any type of domain.
[RFC 7505][RFC 7505#section-3], section 3, also specifies that the "[Null MX]"
must be the sole MX record and its preference must be zero.

In this test case, the following zone types are excluded from the requirement of
MX:

* Root zone
* [TLD] zone
* Zone in the .ARPA tree

The following zone type is expected not to have any MX (considered harmful,
see [IAB Statement]):

* [TLD] zone


## Scope

It is assumed that *Child Zone* is tested and reported by [Connectivity01]. This test
case will just ignore non-responsive name servers or name servers not giving a
correct DNS response for an authoritative name server.


## Inputs

* "Child Zone" - The domain name to be tested.


## Summary

* A notify is issued if MX is missing, except for root, a zone in the ARPA tree
  or a [TLD].
* A warning is issued if a [TLD] *has* a [non-Null MX][Null MX].

| Message Tag                | Level   | Arguments             | Message ID for message tag                                                                         |
|:---------------------------|:--------|:----------------------|:---------------------------------------------------------------------------------------------------|
| Z09_INCONSISTENT_MX        | WARNING |                       | Some name servers return an MX RRset while others return none.                                     |
| Z09_INCONSISTENT_MX_DATA   | WARNING |                       | The MX RRset data is inconsistent between the name servers.                                        |
| Z09_MISSING_MAIL_EXCHANGE  | NOTICE  |                       | The child zone has no mail exchange (no MX).                                                       |
| Z09_MX_DATA                | INFO    | ns_list, mxrdata_list | The MX RDATA in the MX RRset, "{mxrdata_list}", as returned by name servers "{ns_list}".           |
| Z09_MX_FOUND               | INFO    | ns_list               | MX RRset was returned by name servers "{ns_list}".                                                 |
| Z09_NON_AUTH_MX_RESPONSE   | WARNING | ns_list               | Non-authoritative response on MX query from name servers "{ns_list}".                              |
| Z09_NO_MX_FOUND            | INFO    | ns_list               | No MX RRset was returned by name servers "{ns_list}".                                              |
| Z09_NO_SERVERS_MX_RESPONSE | WARNING |                       | No server responds to MX query.                                                                    |
| Z09_NO_RESPONSE_MX_QUERY   | WARNING | ns_list               | No response on MX query from name servers "{ns_list}".                                             |
| Z09_NULL_MX_NON_ZERO_PREF  | NOTICE  |                       | The zone has a Null MX with non-zero preference.                                                   |
| Z09_NULL_MX_WITH_OTHER_MX  | WARNING | mxdata_list           | The zone has a Null MX mixed with other MX records "{mxrdata_list}".                               |
| Z09_ROOT_EMAIL_DOMAIN      | NOTICE  |                       | Root zone with an unexpected MX RRset (non-Null MX).                                               |
| Z09_TLD_EMAIL_DOMAIN       | NOTICE  |                       | The zone is a TLD and has an unexpected MX RRset (non-Null MX).                                    |
| Z09_UNEXPECTED_RCODE_MX    | WARNING | ns_list, rcode        | Unexpected RCODE value ({rcode}) in response to MX query. Responses from name servers "{ns_list}". |

The value in the Level column is the default severity level of the message. The
severity level can be changed in the [Zonemaster-Engine profile]. Also see the
[Severity Level Definitions] document.

The argument names in the Arguments column lists the arguments used in the
message. The argument names are defined in the [argument list].

The name server names are assumed to be available at the time when the msgid
is created, if the argument name is "ns" or "ns_list" even when in the
"[Test procedure]" below it is only referred to the IP address of the name
servers.

## Test procedure

In this section and unless otherwise specified below, the terms "[DNS Query]"
follow the specification for DNS queries as specified in
[DNS Query and Response Defaults]. The handling of the DNS responses on the DNS
queries follow, unless otherwise specified below, what is specified for
[DNS Response] in the same specification.

1.  Create a [DNS Query] with query type  SOA and query name *Child Zone*
    ("SOA Query").

2.  Create a [DNS Query] with query type  MX and query name *Child Zone*
    ("MX Query").

3.  Obtain the set of name server IP addresses using [Method4] and [Method5]
    ("Name Server IP").

4. Create the following empty sets

    1.  Name server IP address ("No Response MX Query").
    2.  Name server IP address and associated RCODE value
        ("Unexpected RCODE MX Response").
    3.  Name server IP address ("Non-authoritative MX").
    4.  Name server IP address ("No MX RRset").
    5.  Name server IP address and associated ordered list of MX RDATA
        ("MX RDATA Lists").

5.  For each name server IP in *Name Server IP* do:

    1. Send *SOA Query* over UDP to the name server.
    2. Go to next name server IP if at least one of the following criteria is
       met:
       1. There is no DNS response.
       2. The RCODE of the response is not "NoError" ([IANA RCODE List]).
       3. The AA flag is not set in the response.
       4. There is no SOA record with owner name matching the query.

    2. Send *MX Query* over UDP to the name server and collect the
       response, and:
       1. If the response has the TC flag set, re-query over TCP and use that
          response instead.
       2. If there is no DNS response, then add the name server IP to the
          *No Response MX Query* set.
       3. Else, if the RCODE of response is not "NoError" ([IANA RCODE List]),
          then add the name server IP and the RCODE to the
          *Unexpected RCODE MX Response* set.
       4. Else, if the AA flag is not set in the response, then add the name
          server IP to the *Non-authoritative MX* set.
       5. Else, if there is no MX record with matching owner name in the answer
          section, then add the name server (IP) to the *No MX RRset* set.
       6. Else do:
          1. Extract the MX records from the response.
          2. For each MX record down case the (mail) exchange (domain name).
          2. For each MX record extract the RDATA as a text string of space
             separated preference (integer) and exchange, i.e. in the same format
             as MX RDATA is shown in presentation format.
          2. Create a sorted list of the RDATA text strings where primary sort
             key is the preference (ascending order) and the secondary sort key
             is the exchange (ascending order).
          3. Add the name server IP and the sorted list to the *MX RDATA Lists*
             set.

6.  If the set *No Response MX Query* is non-empty, then output
    *[Z09_NO_RESPONSE_MX_QUERY]* with the name server IP addresses from the set.

7.  If the set *Unexpected RCODE MX Response* is non-empty, then for each RCODE
    in the set, do:
    * Output *[Z09_UNEXPECTED_RCODE_MX]* with the RCODE value
      ([IANA RCODE List]) and the name server IP addresses from the set.

8.  If the set *Non-authoritative MX* is non-empty, then output
    *[Z09_NON_AUTH_MX_RESPONSE]* with the name server IP addresses from
    the set.

9.  If both *No MX RRset* set and *MX RDATA Lists* set are non-empty then:
    1. Output *[Z09_INCONSISTENT_MX]*.
    2. Output *[Z09_NO_MX_FOUND]* with the name server IP addresses from the
       *No MX RRset* set.
    3. Output *[Z09_MX_FOUND]* with the name server IP addresses from the
       *MX RDATA Lists* set.

10. If the *MX RDATA Lists* set is non-empty (the *No MX RRset* set is empty or
    non-empty), then do:
    1. If the lists in *MX RDATA Lists* are not equal for all name servers then
       do:
       1. Output *[Z09_INCONSISTENT_MX_DATA]*.
       2. For each unique list in *MX RDATA Lists*, output *[Z09_MX_DATA]* with
          the list and the associated name server IP addresses in the set.
    2. Else do:
       1. Extract the unique list of RDATA from *MX RDATA Lists*.
       2. If any of the (mail) exchanges in the list is a [Null MX] RDATA then
          do:
          1. If there are more than one item in the list, then output
             *[Z09_NULL_MX_WITH_OTHER_MX]* with the list.
          2. If the preference of the [Null MX] RDATA in the list is non-zero
             then output *[Z09_NULL_MX_NON_ZERO_PREF]*.
       2. Else, if *Child Zone* is a [TLD] with a [non-Null MX][Null MX] RDATA
          in the list then output *[Z09_TLD_EMAIL_DOMAIN]*.
       3. Else, if *Child Zone* is the root zone with a [non-Null MX][Null MX]
          RDATA in the list then output *[Z09_ROOT_EMAIL_DOMAIN]*.
       4. Else, output *[Z09_MX_DATA]* with the list of the RDATA and the
          associated name server IP addresses in the set.

11. If the *No MX RRset* set is non-empty and the *MX RDATA Lists* set is empty,
    then output *[Z09_MISSING_MAIL_EXCHANGE]* unless
      1. *Child Zone* is the root zone ("."), or
      2. *Child Zone* is a [TLD], or
      3. *Child Zone* is a zone in the .ARPA tree.

12. If both the *No MX RRset* set and the *MX RDATA Lists* set are empty, then
    output *[Z09_NO_SERVERS_MX_RESPONSE]*.


## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *[ERROR]* or *[CRITICAL]*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *[WARNING]*, but no message with severity level
*ERROR* or *CRITICAL*.

In other cases, no message or only messages with severity level
*[INFO]* or *[NOTICE]*, the outcome of this Test Case is "pass".


## Special procedural requirements

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol and log a message reporting
the ignored result.


## Intercase dependencies

None.


## Terminology

The term "Null MX" is used for an MX record where the preference is 0 and the
(mail) exchange is "." as defined in [RFC 7505] with the specific restrictions
given in [section 3][RFC 7505#section-3] of that RFC.

The term "TLD" is used for "Top Level Domain", i.e. a zone whose name consists
of a single label (ignoring the empty label after the final dot).

The term "Email Domain" is used for the domain name at right of the at-sign ("@")
in an email address.

[Argument list]:                              ../ArgumentsForTestCaseMessages.md
[Connectivity01]:                             ../Connectivity-TP/connectivity01.md
[CRITICAL]:                                   ../SeverityLevelDefinitions.md#critical
[DNS Query and Response Defaults]:            ../DNSQueryAndResponseDefaults.md
[DNS Query]:                                  ../DNSQueryAndResponseDefaults.md#default-setting-in-dns-query
[DNS Response]:                               ../DNSQueryAndResponseDefaults.md#default-handling-of-a-dns-response
[ERROR]:                                      ../SeverityLevelDefinitions.md#error
[Email Domain]:                               #terminology
[IAB Statement]:                              https://www.iab.org/documents/correspondence-reports-documents/2013-2/iab-statement-dotless-domains-considered-harmful/
[IANA RCODE List]:                            https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[INFO]:                                       ../SeverityLevelDefinitions.md#info
[Internet Architecture Board]:                https://en.wikipedia.org/wiki/Internet_Architecture_Board
[Method4]:                                    ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                                    ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[NOTICE]:                                     ../SeverityLevelDefinitions.md#notice
[Null MX]:                                    #terminology
[RFC 2142#section-7]:                         https://datatracker.ietf.org/doc/html/rfc2142#section-7
[RFC 2142]:                                   https://datatracker.ietf.org/doc/html/rfc2142
[RFC 3172]:                                   https://datatracker.ietf.org/doc/html/rfc3172
[RFC 5321#section-2.3.5]:                     https://datatracker.ietf.org/doc/html/rfc5321#section-2.3.5
[RFC 5321#section-5.1]:                       https://datatracker.ietf.org/doc/html/rfc5321#section-5.1
[RFC 7505#section-3]:                         https://datatracker.ietf.org/doc/html/rfc7505#section-3
[RFC 7505]:                                   https://datatracker.ietf.org/doc/html/rfc7505
[Severity Level Definitions]:                 ../SeverityLevelDefinitions.md
[TLD]:                                        #terminology
[WARNING]:                                    ../SeverityLevelDefinitions.md#warning
[Z09_INCONSISTENT_MX]:                        #summary
[Z09_INCONSISTENT_MX_DATA]:                   #summary
[Z09_MISSING_MAIL_EXCHANGE]:                  #summary
[Z09_MX_DATA]:                                #summary
[Z09_MX_FOUND]:                               #summary
[Z09_NON_AUTH_MX_RESPONSE]:                   #summary
[Z09_NO_MX_FOUND]:                            #summary
[Z09_NO_RESPONSE_MX_QUERY]:                   #summary
[Z09_NO_SERVERS_MX_RESPONSE]:                 #summary
[Z09_NULL_MX_NON_ZERO_PREF]:                  #summary
[Z09_NULL_MX_WITH_OTHER_MX]:                  #summary
[Z09_ROOT_EMAIL_DOMAIN]:                      #summary
[Z09_TLD_EMAIL_DOMAIN]:                       #summary
[Z09_UNEXPECTED_RCODE_MX]:                    #summary
[Zonemaster-Engine profile]:                  ../../../configuration/profiles.md
