# ZONE09: MX record present

## Test case identifier
**ZONE09**

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

The root zone cannot be a mail domain since the mail domain is
the part to the left of the trailing dot, e.g. "example.com" is the
the maildomain for tha apex of "example.com.". The root zone is
excluded from the requirement.

Top-level domains (TLDs) can technically function as mail domains
([RCF 5321][RFC 5321#section-2.3.5], section 2.3.5) but they rarely
have that function and are probably not meant to be included in the
specification in [RFC 2142]. On the contrary,
[Internet Architecture Board] concludes in a report
"[Dotless Domains Considered Harmful][IAB Statement]" that TLD names
should not be mail domains. In this test case TLDs are not only
excluded from the requirement of being an mail domain, if found to
be, a warning will be generated that points that out.

It is therefore expected for every domain (zone), excluding those
excepted above, to publish an MX record in apex of the zone (i.e.
in the same position as the SOA record). If MX is not present, SMTP
*can* deliver email using an address record (A or AAAA) as specified
in [RFC 5321][RFC 5321#section-5.1], section 5.1, but that possibility
is not in common use. This test case only checks for MX record since
that is the absolutely dominating way to configure support for email.
If an address record is found in apex it is more often used for web
service rather than mail service.

[RFC 7505] standardizes "Null MX" which in means that there is no
mail service for the domain. If a "Null MX" is found, it is considered
to be the same as there is no MX.

In this test case, the follwoing zone types are excepted from the
requirement of MX:

* Root zone
* TLD zone
* Zone in the .ARPA tree

The following zone type is expected not to have an MX:

* TLD zone


## Inputs

* "Child Zone" - The domain name to be tested.


## Ordered description of steps to be taken to execute the test case

1.  If *Child Zone* is the root zone (".") then do:
    1. Output *[Z09_ROOT_NOT_MAIL_DOMAIN]*
    2. Exit this test case.

2.  Create an SOA query for the *Child Zone* without any OPT record (no EDNS).

3.  Create an MX query for the *Child Zone* without any OPT record (no EDNS).

4.  Obtain the set of name server IP addresses using [Method4] and [Method5]
    ("Name Server IP").

5.  Create an empty set of name server IP addresses, "No Response MX Query".

6.  Create an empty set of name server IP addresses and associated RCODE,
    "Unexpected RCODE MX Query".

7.  Create an empty set of name server IP addresses, "Non-authoritative MX".

8.  Create an empty set of name server IP addresses, "No MX Record".

9.  Create an empty set of name server IP addresses and associated MX
    record RDATA, "MX Record RDATA".

10. For each name server in *Name Server IP* do:

    1. Send the SOA query over UDP to the name server, collect the response
       and go to next server if
       1. there is no DNS response on the SOA query, or
       2. the RCODE of the response is not "NoError" (IANA RCODE List), or
       3. the AA flag is not set in the response, or
       4. there is no SOA record with owner name matching the query.

    2. Else, send the MX query over UDP to the name server and collect the
       response, and:
       1. If the response has the TC flag set, re-query over TCP and use that
          response instead.
       2. If there is no DNS response, then add the name server (IP) to the
          set *No Response MX Query*.
       3. Else, if the RCODE of response is not "NoError" ([IANA RCODE List]),
          then add the name server (IP) and the RCODE to the set
          *Unexpected RCODE MX Query*.
       4. Else, if the AA flag is not set in the response, then add the name
          server (IP) to the set *Non-authoritative MX*.
       5. Else, if there is no MX record with matching owner name in the
          answer section, then add the name server (IP) to the set
          *No MX Record*.
       6. Else add the name server (IP) and the MX record RDATA set to the set
          *MX Record RDATA*. (One MX record RDATA set can contain RDATA from
          more than one MX record.)

11. If the set *No Response MX Query* is non-empty, then output
    *[Z09_NO_RESPONSE_MX_QUERY]* and list those name servers.

12. If the set *Unexpected RCODE MX Query* is non-empty, then for each RCODE
    in the set, do:
    1. Output *[Z09_UNEXPECTED_RCODE_MX_RESPONSE]* and print the RCODE name
       ([IANA RCODE List]) and list the those name servers.

13. If the set *Non-authoritative MX* is non-empty, then output
    *[Z09_NON-AUTHORITATIVE_MX_RESPONSE]* and list those name servers.

14. If both sets *No MX Record* and *MX Record RDATA* are empty do output
    *[Z09_INDETERMINED_MAIL_TARGET]*.

15. If both sets *No MX Record* and *MX Record RDATA* are non-empty or if
    *MX Record RDATA* lists more than one RDATA set (if two name servers have
    the same RDATA set, that is one set), then:
    1. Output *[Z09_INCONSISTENT_MAIL_DOMAIN_TARGET]*.
    2. If *No MX Record* is non-empty, then output *[Z09_NO_MX]* and list
       those name servers.
    3. For each RDATA set in *MX Record RDATA*, output *[Z09_MX_FOUND]*
       with mail target or targets from RDATA set and list those name
       servers.

16. If the set *No MX Record* is non-empty and the set *MX Record RDATA*
    is empty, then do:
    1. If *Child Zone* is a TLD (top-level domain) then output
       *[Z09_TLD_MAIL_DOMAIN_NOT_EXPECTED]*.
    2. Else, if *Child Zone* is a zone in the .ARPA tree then output
       *[Z09_ARPA_MAIL_DOMAIN_NOT_REQUIRED]*.
    3. Else, output *[Z09_NO_MX_FOR_MAIL_TARGET]*.

17. If the set *No MX Record* is empty and the set *MX Record RDATA*
    is non-empty, then do:
    1. If the RDATA set in *MX Record RDATA* is not the same for all
       name servers then do:
       1. Output *[Z09_INCONSISTENT_MAIL_DOMAIN_TARGET]*.
       2. For each RDATA set in *MX Record RDATA*, output *[Z09_MX_FOUND]*
          with mail target from RDATA set and list those name servers.
    2. Else, if the RDATA with the lowest preference in the RDATA set in
       *MX Record RDATA* is a "[Null MX][RFC 7505#section-3]" then
       output *[Z09_NULL_MX_FOUND]*.
       1. If the preference of the "Null MX" is non-zero then output
          *[Z09_NULL_MX_WITH_NON_ZERO_PREFERENCE]*.
       2. If there are more than one MX RDATA in the RDATA set, then output
          *[Z09_NULL_MX_WITH_OTHER_MX]*.
       3. If *Child Zone* is a TLD (top-level domain) then output
          *[Z09_TLD_MAIL_DOMAIN_NOT_EXPECTED]*.
       4. Else, if *Child Zone* is a zone in the .ARPA tree then output
          *[Z09_ARPA_MAIL_DOMAIN_NOT_REQUIRED]*.
       5. Else, output *[Z09_NO_MAIL_TARGET]*.
    3. Else, if *Child Zone* is a TLD (top-level domain) then output
       *[Z09_TLD_MAIL_DOMAIN_HARMFUL]* and print mail target or targets
       (mail server/servers) in order of preference (lowest first).
    4. Else output *[Z09_MX_FOR_MAIL_TARGET_FOUND]* and print mail target
       or targets (mail server/servers) in order of preference (lowest
       first).


## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

The outcome of this Test case is "pass" in all other cases.

Message                             | Default severity level of message
:-----------------------------------|:-----------------------------------
Z09_ARPA_MAIL_DOMAIN_NOT_REQUIRED   | INFO
Z09_INCONSISTENT_MAIL_DOMAIN_TARGET | WARNING
Z09_INDETERMINED_MAIL_TARGET        | WARNING
Z09_MX_FOR_MAIL_TARGET_FOUND        | INFO
Z09_MX_FOUND                        | INFO
Z09_NON-AUTHORITATIVE_MX_RESPONSE   | WARNING
Z09_NO_MAIL_TARGET                  | NOTICE
Z09_NO_MX                           | NOTICE
Z09_NO_MX_FOR_MAIL_TARGET           | NOTICE
Z09_NO_RESPONSE_MX_QUERY            | WARNING
Z09_NULL_MX_FOUND                   | INFO
Z09_NULL_MX_WITH_NON_ZERO_PREFERENCE| NOTICE
Z09_NULL_MX_WITH_OTHER_MX           | WARNING
Z09_ROOT_NOT_MAIL_DOMAIN            | INFO
Z09_TLD_MAIL_DOMAIN_HARMFUL         | WARNING
Z09_TLD_MAIL_DOMAIN_NOT_EXPECTED    | INFO
Z09_UNEXPECTED_RCODE_MX_RESPONSE    | WARNING

## Special procedural requirements

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol and log a message reporting
the ignored result.

Errors associated with the response to the query for the SOA record are
expected to have been caught by [Basic04].


## Intercase dependencies

None.

## Terminology

[Basic04]:                             ../Basic-TP/basic04.md
[IAB Statement]:                       https://www.iab.org/documents/correspondence-reports-documents/2013-2/iab-statement-dotless-domains-considered-harmful/
[IANA RCODE List]:                     https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[Internet Architecture Board]:         https://en.wikipedia.org/wiki/Internet_Architecture_Board
[Method4]:                             ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                             ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[RFC 2142#section-7]:                  https://tools.ietf.org/html/rfc2142#section-7
[RFC 2142]:                            https://tools.ietf.org/html/rfc2142
[RFC 3172]:                            https://tools.ietf.org/html/rfc3172
[RFC 5321#section-2.3.5]:              https://tools.ietf.org/html/rfc5321#section-2.3.5
[RFC 5321#section-5.1]:                https://tools.ietf.org/html/rfc5321#section-5.1
[RFC 7505#section-3]:                  https://tools.ietf.org/html/rfc7505#section-3
[RFC 7505]:                            https://tools.ietf.org/html/rfc7505
[Z09_ARPA_MAIL_DOMAIN_NOT_REQUIRED]:   #outcomes
[Z09_INCONSISTENT_MAIL_DOMAIN_TARGET]: #outcomes
[Z09_INDETERMINED_MAIL_TARGET]:        #outcomes
[Z09_MX_FOR_MAIL_TARGET_FOUND]:        #outcomes
[Z09_MX_FOUND]:                        #outcomes
[Z09_NON-AUTHORITATIVE_MX_RESPONSE]:   #outcomes
[Z09_NO_MAIL_TARGET]:                  #outcomes
[Z09_NO_MX]:                           #outcomes
[Z09_NO_MX_FOR_MAIL_TARGET]:           #outcomes
[Z09_NO_RESPONSE_MX_QUERY]:            #outcomes
[Z09_NULL_MX_FOUND]:                   #outcomes
[Z09_NULL_MX_WITH_NON_ZERO_PREFERENCE]:#outcomes
[Z09_NULL_MX_WITH_OTHER_MX]:           #outcomes
[Z09_ROOT_NOT_MAIL_DOMAIN]:            #outcomes
[Z09_TLD_MAIL_DOMAIN_HARMFUL]:         #outcomes
[Z09_TLD_MAIL_DOMAIN_NOT_EXPECTED]:    #outcomes
[Z09_UNEXPECTED_RCODE_MX_RESPONSE]:    #outcomes




