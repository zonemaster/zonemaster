# ZONE09: MX record present


## Test case identifier
**ZONE09**


## Table of contents

* [Objective](#Objective)
* [Scope](#Scope)
* [Inputs](#Inputs)
* [Summary](#Summary)
* [Test procedure](#Test-procedure)
* [Outcome(s)](#Outcomes)
* [Special procedural requirements](#Special-procedural-requirements)
* [Intercase dependencies](#Intercase-dependencies)
* [Terminology](#terminology)


## Objective

It is strongly recommended in [RFC 2142][RFC 2142#section-7],
section 7, that every domain should have a mailbox named
hostmaster@DOMAIN (where DOMAIN is *Child Zone* in this test case).

> For simplicity and regularity, it is strongly recommended that the
> well known mailbox name HOSTMASTER always be used
> \<HOSTMASTER@domain\>.

Even if not mentioned in [RFC 2142], there are some exception to the
rule above.

Zones in the .ARPA tree are meant for infrastructural identifier,
and email domains are not expected for those ([RFC 3172]). This means
that the well known mailbox is not expected for reverse zones
(in-addr.arpa, ip6.arpa). Those are excluded from the requirement in
this test case.

The root zone cannot be an email domain since the email domain is
the part to the left of the trailing dot, e.g. "example.com" is the
email domain for the apex of "example.com.". The root zone is
excluded from the requirement.

Top-level domains (TLDs) can technically function as email domains
([RCF 5321][RFC 5321#section-2.3.5], section 2.3.5) but they rarely have that
function and are probably not meant to be included in the specification in
[RFC 2142]. On the contrary, [Internet Architecture Board] concludes in a report
"[Dotless Domains Considered Harmful][IAB Statement]" that domain names that only
consists of one label, e.g. "se", "fr" or "com", should not be used for various
Internet services. This means TLD names should not be used as email domains.
In this test case TLDs are not only excluded from the requirement of being an
email domain, if found to be, a warning will be generated that points that out.

It is therefore expected for every domain (zone), excluding those above, to
publish an MX record in apex of the zone (i.e. in the same position as the SOA
record). If MX is not present, SMTP *can* deliver email using an address record
(A or AAAA) as specified in [RFC 5321][RFC 5321#section-5.1], section 5.1, but
that possibility is not in common use. This test case only checks for MX record
and ignores the possibility to use address records for email since the absolutely
dominating way to configure support for email is to use MX. If an address record
is found in apex it is more often used for web service rather than email service.

[RFC 7505] standardizes "Null MX" which in means that there is no
email service for the domain. If a "Null MX" is found, it is considered
to be the same as there is no MX.

In this test case, the following zone types are excluded from the requirement of
MX:

* Root zone
* TLD zone
* Zone in the .ARPA tree

The following zone type is expected not to have an MX (considered harmful):

* TLD zone


## Scope

It is assumed that *Child Zone* is tested and reported by [Basic04]. This test
case will just ignore non-responsive name servers or name servers not giving a
correct DNS response for an authoritative name server.


## Inputs

* "Child Zone" - The domain name to be tested.


## Summary

* Basic name server problems are not reported by this test case.
* A notify is issued if MX is missing, except for root, an ARPA zone and a TLD.
* A warning is issued if a TLD *has* an MX.

Message Tag outputted               | Level   | Arguments               | Description of when message tag is outputted
:-----------------------------------|:--------|:------------------------|:--------------------------------------------
Z09_INCONSISTENT_MX_RRSETS          | WARNING |                         | Some name servers returns MX RRset and other none.
Z09_MISSING_MAIL_TARGET             | NOTICE  |                         | The child zone has no mail target (no MX).
Z09_MX_DATA                         | INFO    | ns_ip_list, domain_list | The mail targets in the MX RRset returned by some name servers, and a list of those.
Z09_MX_FOUND                        | INFO    | ns_ip_list              | List of name servers that return MX RRset.
Z09_NON_AUTHORITATIVE_MX_RESPONSE   | WARNING | ns_ip_list              | List of name servers that gave non-authoritative response on the MX query.
Z09_NO_MX_FOUND                     | INFO    | ns_ip_list              | List of name servers that did not return MX RRset.
Z09_NO_RESPONSE_MX_QUERY            | WARNING | ns_ip_list              | List of name servers that did not respond on MX query.
Z09_NULL_MX_WITH_NON_ZERO_PREFERENCE| NOTICE  |                         | The child zone has a null MX with incorrect preference (must be 0).
Z09_NULL_MX_WITH_OTHER_MX           | WARNING |                         | The child zone has a null MX but incorrectly mixed with other MX records.
Z09_ROOT_EMAIL_DOMAIN_MEANINGLESS   | NOTIFY  |                         | The root zone has an MX RRset, which is meaningless.
Z09_TLD_EMAIL_DOMAIN_HARMFUL        | WARNING |                         | The child zone is a TLD and has MX, which is considered harmful.
Z09_UNEXPECTED_RCODE_MX_RESPONSE    | WARNING | ns_ip_list, rcode       | The name servers listed returns unexpected RCODE value (listed) on the MX query.

The value in the Level column is the default severity level of the message. The
severity level can be changed in the [Zonemaster-Engine profile]. Also see the
[Severity Level Definitions] document.

The argument names in the Arguments column lists the arguments used in the
message. The argument names are defined in the [argument list].


## Test procedure

1.  Create an SOA query for the *Child Zone* without OPT record (no EDNS)
    ("SOA Query").

2.  Create an MX query for the *Child Zone* without OPT record (no EDNS)
    ("MX Query").

3.  Obtain the set of name server IP addresses using [Method4] and [Method5]
    ("Name Server IP").

4. Create the following empty sets

    1.  Name server IP addresses ("No Response MX Query").
    2.  Name server IP addresses and RCODE value ("Unexpected RCODE MX Query").
    3.  Name server IP addresses ("Non-authoritative MX").
    4.  Name server IP addresses ("No MX RRset").
    5.  Name server IP addresses and MX RRset ("MX RRset").

5.  For each name server IP in *Name Server IP* do:

    1. Send *SOA Query" over UDP to the name server.
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
          *Unexpected RCODE MX Query* set.
       4. Else, if the AA flag is not set in the response, then add the name
          server IP to the *Non-authoritative MX* set.
       5. Else, if there is no MX record with matching owner name in the answer
          section, then add the name server (IP) to the *No MX RRset* set.
       6. Else do:
          1. Extract the MX RRset from the response.
          2. Add the name server IP and the MX RRset to the *MX RRset* set.

6.  If the set *No Response MX Query* is non-empty, then output
    *[Z09_NO_RESPONSE_MX_QUERY]* with the name server IP addresses from the set.

7.  If the set *Unexpected RCODE MX Query* is non-empty, then for each RCODE
    in the set, do:
    * Output *[Z09_UNEXPECTED_RCODE_MX_RESPONSE]* with the RCODE value
      ([IANA RCODE List]) and the name server IP addresses from the set.

8.  If the set *Non-authoritative MX* is non-empty, then output
    *[Z09_NON_AUTHORITATIVE_MX_RESPONSE]* with the name server IP addresses from
    the set.

9.  If both *No MX RRset* set and *MX RRset* set are non-empty then:
    1. Output *[Z09_INCONSISTENT_MX_RRSETS]*.
    2. Output *[Z09_NO_MX_FOUND]* with the name server IP addresses from the
       *No MX RRset* set.
    3. Output *[Z09_MX_FOUND]* with the name server IP addresses from the
       *MX RRset* set.

10. If the *MX RRset* set is non-empty, then do:
    1. If the RRsets in *MX RRset* are not equal for all name servers then do:
       1. Output *[Z09_INCONSISTENT_MX_RRSETS]*.
       2. For each RRset in *MX RRset*, output *[Z09_MX_DATA]* with the mail
          target from the RDATA and the associated name server IP addresses in
          the set.
    2. Else do:
       1. If the mailtarget of any of the MX records in the RRset in *MX RRset*
          is "." ("[Null MX][RFC 7505#section-3]") then do:
          1. If there are more than one record in the MX RRset, then output
             *[Z09_NULL_MX_WITH_OTHER_MX]* with the mail targets from the RDATA
             of MX records.
          2. If the preference of the "Null MX" is non-zero then output
             *[Z09_NULL_MX_WITH_NON_ZERO_PREFERENCE]*.
       2. Output *[Z09_TLD_EMAIL_DOMAIN_HARMFUL]* if *Child Zone* is a TLD
          (top-level domain), unless the MX RRset is a single
          "[Null MX][RFC 7505#section-3]" record (mail target is ".").
       3. Output *[Z09_ROOT_EMAIL_DOMAIN_MEANINGLESS]* if *Child Zone* is the root
          zone, unless the MX RRset is a single "[Null MX][RFC 7505#section-3]"
          record (mail target is ".").

11. Else, if the *No MX RRset* set is non-empty then do:
    * Output *[Z09_MISSING_MAIL_TARGET]* unless
      1. *Child Zone* is the root zone ("."), or
      1. *Child Zone* is a TLD (top-level domain), or
      2. *Child Zone* is a zone in the .ARPA tree.


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

No special terminology for this test case.

[Argument list]:                              https://github.com/zonemaster/zonemaster-engine/blob/master/docs/logentry_args.md
[Basic04]:                                    ../Basic-TP/basic04.md
[CRITICAL]:                                   ../SeverityLevelDefinitions.md#critical
[ERROR]:                                      ../SeverityLevelDefinitions.md#error
[IAB Statement]:                              https://www.iab.org/documents/correspondence-reports-documents/2013-2/iab-statement-dotless-domains-considered-harmful/
[IANA RCODE List]:                            https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[INFO]:                                       ../SeverityLevelDefinitions.md#info
[Internet Architecture Board]:                https://en.wikipedia.org/wiki/Internet_Architecture_Board
[Method4]:                                    ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                                    ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[NOTICE]:                                     ../SeverityLevelDefinitions.md#notice
[RFC 2142#section-7]:                         https://tools.ietf.org/html/rfc2142#section-7
[RFC 2142]:                                   https://tools.ietf.org/html/rfc2142
[RFC 3172]:                                   https://tools.ietf.org/html/rfc3172
[RFC 5321#section-2.3.5]:                     https://tools.ietf.org/html/rfc5321#section-2.3.5
[RFC 5321#section-5.1]:                       https://tools.ietf.org/html/rfc5321#section-5.1
[RFC 7505#section-3]:                         https://tools.ietf.org/html/rfc7505#section-3
[RFC 7505]:                                   https://tools.ietf.org/html/rfc7505
[Severity Level Definitions]:                 ../SeverityLevelDefinitions.md
[WARNING]:                                    ../SeverityLevelDefinitions.md#warning
[Z09_INCONSISTENT_MX_RRSETS]:                 #Summary
[Z09_MISSING_MAIL_TARGET]:                    #Summary
[Z09_MX_DATA]:                                #Summary
[Z09_MX_FOUND]:                               #Summary
[Z09_NON_AUTHORITATIVE_MX_RESPONSE]:          #Summary
[Z09_NO_MX_FOUND]:                            #Summary
[Z09_NO_RESPONSE_MX_QUERY]:                   #Summary
[Z09_NULL_MX_WITH_NON_ZERO_PREFERENCE]:       #Summary
[Z09_NULL_MX_WITH_OTHER_MX]:                  #Summary
[Z09_ROOT_EMAIL_DOMAIN_MEANINGLESS]:          #Summary
[Z09_TLD_EMAIL_DOMAIN_HARMFUL]:               #Summary
[Z09_UNEXPECTED_RCODE_MX_RESPONSE]:           #Summary
[Zonemaster-Engine profile]:                  https://github.com/zonemaster/zonemaster-engine/blob/master/docs/Profiles.md



