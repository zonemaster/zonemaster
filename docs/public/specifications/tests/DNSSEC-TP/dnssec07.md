# DNSSEC07: DNSSEC signed zone and DS in parent for signed zone

## Test case identifier
**DNSSEC07**


## Table of contents

* [Objective](#objective)
* [Scope](#scope)
* [Inputs](#inputs)
* [Summary](#summary)
  * [Restrictions on combinations of the message tags](#restrictions-on-combinations-of-the-message-tags)
* [Test procedure]
* [Outcome(s)](#outcomes)
* [Special procedural requirements](#special-procedural-requirements)
* [Intercase dependencies](#intercase-dependencies)
* [Terminology](#terminology)


## Objective

DNSSEC is the security upgrade of DNS, just as TLS is the security upgrade of
HTTP (but done in very different ways). If a zone is upgraded to DNSSEC it means
that it is signed by DNSSEC keys. This test case will verify if the zone has been
DNSSEC signed, and if so, also verify that there is at least one DS record in the
parent zone for the tested zone.

The public half of the DNSSEC keys are stored in the zone. For a zone to be
correctly signed it is not enough to have DNSKEY records, but this test case
assumes that the existence of at least one DNSKEY record with at least one RRSIG
record covering the DNSKEY RRset means that the zone is signed.

It is not enough to have a signed zone. The parent zone must have a DS record to
create a chain of trust from root. If the zone is signed (i.e. has at least one
DNSKEY record) this test case will check if the parent zone has any DS records
for the zone.

The method for authentication a DNS response is described in section 5 of
[RFC 4035][RFC 4035#section-5]. The DNSKEY record is defined in section 2 of
[RFC 4034][RFC 4034#section-2], and the DS record is defined in section 5 of
[RFC 4034][RFC 4034#section-5].

Signing the zone and providing DS records for a signed zone is not required by
the protocol, but it is a deviation from best practices that should trigger an
alert. A WARNING is therefore raised if the zone is not signed, or if DS
records are absent for a signed zone.


## Inputs

* "Child Zone" - The domain name to be tested.
* "Undelegated DS" - The DS record or records submitted. Empty unless submitted.
* "Undelegated Test" - TRUE if undelegated NS has been provided for the test.


## Summary

* If no DNSKEY records are found, then further investigation will not be done
  and no messages will be outputted.

| Message Tag outputted         | Level   | Arguments      | Message ID for message tag                                                                                                                 |
|:------------------------------|:--------|:---------------|:-------------------------------------------------------------------------------------------------------------------------------------------|
| DS07_DS_FOR_SIGNED_ZONE       | INFO    |                | The parent zone has DS record or records for the signed child zone.                                                                        |
| DS07_DS_ON_PARENT_SERVER      | INFO    | ns_list        | The following parent name servers responds with DS record or records for the child zone. Name servers: {ns_list}                           |
| DS07_INCONSISTENT_DS          | ERROR   |                | Inconsistent responses from parent name servers. Some include DS, others do not.                                                           |
| DS07_INCONSISTENT_SIGNED      | ERROR   |                | Inconsistent responses from name servers. Some include signed responses, others do not.                                                    |
| DS07_NON_AUTH_RESPONSE_DNSKEY | WARNING | ns_list        | The following name servers give a non authoritative response on DNSKEY query with DO bit set. Name servers: {ns_list}                      |
| DS07_NOT_SIGNED               | WARNING |                | The zone is not signed.                                                                                                                    |
| DS07_NOT_SIGNED_ON_SERVER     | WARNING | ns_list        | The following name servers responds with no DNSKEY (unsigned child zone). Name servers: {ns_list}.                                         |
| DS07_NO_DS_ON_PARENT_SERVER   | WARNING | ns_list        | The following parent name servers responds without DS record for the child zone. Name servers: {ns_list}.                                   |
| DS07_NO_DS_FOR_SIGNED_ZONE    | WARNING |                | The parent zone has no DS record for the signed child zone.                                                                                |
| DS07_NO_RESPONSE_DNSKEY       | WARNING | ns_list        | The following name servers do not respond on DNSKEY query with DO bit set. Name servers: {ns_list}                                         |
| DS07_SIGNED                   | INFO    |                | The zone is signed.                                                                                                                        |
| DS07_SIGNED_ON_SERVER         | INFO    | ns_list        | The following name servers responds with DNSKEY (signed child zone). Name servers: {ns_list}.                                              |
| DS07_UNEXP_RCODE_RESP_DNSKEY  | WARNING | ns_list, rcode | The following name servers responded with RCODE "{rcode}" instead of expected "NOERROR" on DNSKEY query with DO bit set. Name servers: {ns_list} |

The value in the Level column is the default severity level of the message. The
severity level can be changed in the [Zonemaster-Engine profile]. Also see the
[Severity Level Definitions] document.

The argument names in the Arguments column lists the arguments used in the
message. The argument names are defined in the [argument list].

The name server names are assumed to be available at the time when the msgid
is created, if the argument name is "ns" or "ns_list" even when in the
"[Test procedure]" below it is only referred to the IP address of the name
servers.


### Restrictions on combinations of the message tags

Below are some restrictions on how some of the message tags, defined above, can
be combined.

* For each test exactly one of either *DS07_INCONSISTENT_SIGNED*, *DS07_SIGNED* and
  *DS07_NOT_SIGNED* is outputted.
* For each test only one of *DS07_INCONSISTENT_DS*, *DS07_DS_FOR_SIGNED_ZONE* and
  *DS07_NO_DS_FOR_SIGNED_ZONE* can be outputted.
* If *DS07_NOT_SIGNED* is outputted, then none of *DS07_INCONSISTENT_DS*,
  *DS07_DS_FOR_SIGNED_ZONE* and *DS07_NO_DS_FOR_SIGNED_ZONE* is outputted.

## Test procedure

In this section and unless otherwise specified below, the terms "[DNS Query]"
and "[DNSSEC Query]", respectively, follow the specification for DNS queries as
specified in [DNS Query and Response Defaults]. The handling of the DNS responses
on the DNS queries follow, unless otherwise specified below, what is specified
for [DNS Response] and [DNSSEC Response], respectively, in the same
specification.

A complete list of all DNS Resource Record types can be found in the
[IANA RR Type List].

1. Create a [DNS Query] with query type SOA and query name *Child Zone*
   ("SOA Query").

2. Create a [DNSSEC Query] with query type DNSKEY and query name *Child Zone*
   ("DNSKEY Query").

3. Create a [DNSSEC Query] with query type DS and query name *Child Zone*
   ("DS Query") (for the parent name servers).

4. Retrieve all name server names and IP addresses for *Child Zone* using methods
   [Get-Del-NS-Names-and-IPs] and [Get-Zone-NS-Names-and-IPs] ("Child NS IP").

5.  Create the following empty sets:

    1.  Name server IP address ("Ignored Child NS").
    2.  Name server IP address ("No Response DNSKEY Query").
    3.  Name server IP address ("No Auth DNSKEY Response").
    4.  Name server IP address and [RCODE Name] ("Error RCODE DNSKEY Response").
    5.  Name server IP address ("No DNSKEY").
    6.  Name server IP address ("Signed Response").
    7.  Name server IP address ("Ignored Parent NS IP").
    8.  Name server IP address ("No DS").
    9.  Name server IP address ("DS in Response").

6.  For each name server IP address in *Child NS IP* do:

    1.  Send *SOA Query* to the name server IP.
    2.  Add the name server IP to the *Ignored Child NS* set and go to next name
        server IP if at least one of the following criteria is met:
          1. There is no DNS response.
          2. The [RCODE Name] in the response is not "NoError".
          3. The AA flag is not set in the response.
          4. The SOA record is missing in the answer section.
    3.  Send *DNSKEY Query* to the name server IP.
    4.  Add the name server IP to the *No Response DNSKEY Query* set and go to
        next name server IP if there is no DNS response to the query.
    5.  Add the name server IP to the *No Auth DNSKEY Response* set and go to
        next name server IP if the AA bit is not set in the response.
    6.  Add the name server IP and the [RCODE Name] to the
        *Error RCODE DNSKEY Response* set and go to next name server IP if the
        [RCODE Name] is not NOERROR.
    7.  Add the name server IP to the "Signed Response" set and go to next name
        server IP if the answer section contains the following DNS records:
        * At least one DNSKEY record.
        * At least one RRSIG record covering the DNSKEY RRset.
    8.  Else add the name server IP to the *No DNSKEY* set and go to
        next name server IP.

7.  Retrieve all name server IP addresses for the parent of *Child Zone* using
    method [Get-Parent-NS-IP] ("Parent NS IP").

8.  If *Undelegated DS* is non-empty then do:

    1. Add name server IP as "-" to the *DS in Response* set.
    2. Make *Parent NS IP* an empty set.

9.  If the *Signed Response* set is empty, make *Parent NS IP* and
    *DS in Response* empty sets. I.e. skip looking for DS if *Child Zone* is not
    signed.

>   Note: *Parent NS IP* will be empty if any of the followng is true:
>     * *Undelegated test* is TRUE.
>     * *Undelegated DS* is non-empty.
>     * *Child Zone* is ".", i.e. root zone.
>     * The *Signed Response* set is empty.

10. For each parent name server IP in *Parent NS IP* do:
    1. Send *DS Query* to the name server IP.
    2. If at least one of the following criteria is met, then add name server IP
       to the "Ignored Parent NS IP" set and go to next parent name server:
       1. There is no [DNSSEC Response].
       2. The RCODE in the [DNSSEC Response] is not "NoError"
          ([IANA RCODE List]).
       3. The OPT record is absent in the [DNSSEC Response].
       4. The DO flag is unset in the [DNSSEC Response].
       5. The AA flag is not set in the [DNSSEC Response].
    3. Add the parent name server IP to the *DS in Response* set and go to the
       next parent name server IP if the answer section contains the following
       DNS records:
       * At least one DS record with *Child Zone* as owner name.
       * At least one RRSIG covering the DS RRset.
    4. Else add the parent name server IP to the *No DS* set and go
       to next parent name server IP.

11. If the following sets combined is identical to the *Child NS IP* set, output
    *[DS07_NOT_SIGNED]*.
    * *Ignored Child NS*
    * *No Response DNSKEY Query*
    * *No Auth DNSKEY Response*
    * *Error RCODE DNSKEY Response*

12. If the *No Response DNSKEY Query* set is non-empty then output
    *[DS07_NO_RESPONSE_DNSKEY]* with the list of name servers from the
    *No Response DNSKEY Query* set.

13. If the *No Auth DNSKEY Response* set is non-empty then output
    *[DS07_NON_AUTH_RESPONSE_DNSKEY]* with the list of name servers from the
    *No Auth DNSKEY Response* set.

14. If the *Error RCODE DNSKEY Response* set is non-empty then for each
    [RCODE Name] in the set output *[DS07_UNEXP_RCODE_RESP_DNSKEY]* with the
    [RCODE Name] and list of name servers from the *Error RCODE DNSKEY Response*
    set.

15. If the *Signed Response* set is non-empty then output
    *[DS07_SIGNED_ON_SERVER]* with the list of name servers from the
    *Signed Response* set.

16. If the *No DNSKEY* set is non-empty then output *[DS07_NOT_SIGNED_ON_SERVER]*
    with the list of name servers from the *No DNSKEY* set.

17. If both the *Signed Response* and *No DNSKEY* sets are non-empty then output
    *[DS07_INCONSISTENT_SIGNED]*.

18. If the *Signed Response* is non-empty and the *No DNSKEY* set is empty then
    output *[DS07_SIGNED]*.

19. If the *Signed Response* is empty and the *No DNSKEY* set is non-empty then
    output *[DS07_NOT_SIGNED]*.

20. If the *No DS* sets is non-empty, then output *[DS07_NO_DS_ON_PARENT_SERVER]*
    with the list of name servers from the *No DS* set.

21. If the *DS in Response* sets non-empty, then output
    *[DS07_DS_ON_PARENT_SERVER]* with the list of name servers from the
    *DS in Response* set.

22. If both the *No DS* and the *DS in Response* sets are non-empty, then output
    *[DS07_INCONSISTENT_DS]*.

23. If the *No DNSKEY* set is empty and the *Signed Response* set is non-empty,
    then do:
    1. If the *No DS* is non-empty and the *DS in Response* set is empty, then
       output *[DS07_NO_DS_FOR_SIGNED_ZONE]*.
    2. If the *No DS* is empty and the *DS in Response* set is non-empty, then
       output *[DS07_DS_FOR_SIGNED_ZONE]*.


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
result of any test using this transport protocol. Log a message reporting
on the ignored result.

This test case should always be the first test case to be run in the
DNSSEC Module. The second test case to be run is [DNSSEC11]. If this test case
outputs *[DS07_NOT_SIGNED]* for a test, then no other
[test case of the DNSSEC module][DNSSEC#test-case-list] should be run.


## Intercase dependencies

None.


## Terminology

No special terminology for this test case.


[Argument list]:                              ../ArgumentsForTestCaseMessages.md
[CRITICAL]:                                   ../SeverityLevelDefinitions.md#critical
[Connectivity01]:                             ../Connectivity-TP/connectivity01.md
[DNS Query and Response Defaults]:            ../DNSQueryAndResponseDefaults.md
[DNS Query]:                                  ../DNSQueryAndResponseDefaults.md#default-setting-in-dns-query
[DNS Response]:                               ../DNSQueryAndResponseDefaults.md#default-handling-of-a-dns-response
[DNSSEC Query]:                               ../DNSQueryAndResponseDefaults.md#default-setting-in-dnssec-query
[DNSSEC README]:                              README.md
[DNSSEC#test-case-list]:                      README.md#test-case-list
[DNSSEC Response]:                            ../DNSQueryAndResponseDefaults.md#default-handling-of-a-dnssec-response
[DNSSEC11]:                                   dnssec11.md
[DS07_DS_FOR_SIGNED_ZONE]:                    #summary
[DS07_DS_ON_PARENT_SERVER]:                   #summary
[DS07_INCONSISTENT_DS]:                       #summary
[DS07_INCONSISTENT_SIGNED]:                   #summary
[DS07_NON_AUTH_RESPONSE_DNSKEY]:              #summary
[DS07_NOT_SIGNED]:                            #summary
[DS07_NOT_SIGNED_ON_SERVER]:                  #summary
[DS07_NO_DS_ON_PARENT_SERVER]:                #summary
[DS07_NO_DS_FOR_SIGNED_ZONE]:                 #summary
[DS07_NO_RESPONSE_DNSKEY]:                    #summary
[DS07_SIGNED]:                                #summary
[DS07_SIGNED_ON_SERVER]:                      #summary
[DS07_UNEXP_RCODE_RESP_DNSKEY]:               #summary
[ERROR]:                                      ../SeverityLevelDefinitions.md#error
[Get-Del-NS-Names-and-IPs]:                   ../MethodsV2.md#method-get-delegation-ns-names-and-ip-addresses
[Get-Zone-NS-Names-and-IPs]:                  ../MethodsV2.md#method-get-zone-ns-names-and-ip-addresses
[IANA RR Type List]:                          https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-4
[INFO]:                                       ../SeverityLevelDefinitions.md#info
[NOTICE]:                                     ../SeverityLevelDefinitions.md#notice
[RCODE Name]:                                 https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[RFC 4034#section-2]:                         https://datatracker.ietf.org/doc/html/rfc4034#section-2
[RFC 4034#section-5]:                         https://datatracker.ietf.org/doc/html/rfc4034#section-5
[RFC 4035#section-5]:                         https://datatracker.ietf.org/doc/html/rfc4035#section-5
[Severity Level Definitions]:                 ../SeverityLevelDefinitions.md
[Test procedure]:                             #test-procedure
[WARNING]:                                    ../SeverityLevelDefinitions.md#warning
[Zonemaster-Engine profile]:                  ../../../configuration/profiles.md
