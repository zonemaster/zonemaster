# CONNECTIVITY01: UDP connectivity to name servers

## Test case identifier
**CONNECTIVITY01**


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

UDP is the fundamental protocol to reach a general purpose name server hosting
a zone, "DNS servers MUST be able to service UDP [...]" ([RFC 1123], section
6.1.3.2, page 75), also restated in [RFC 7766][RFC 7766#5], section 5.

This Test Case will verify if the name servers in the delegation of and zone of
*Child Zone* are reachable over UDP.

Most Zonemaster Test Cases will query the name servers in the delegation or the
name servers appointed by the NS records in the zone for the NS or SOA record,
or both. It is crucial that problems are reported, but instead of letting several
Test Cases report the same problems found, most Test Cases assume that this test
case is run. Only this Test Case will report problems found in the following
areas over UDP:

* Name Server not responding to a query without EDNS.
* Name Server not including SOA record of *Child Zone* in the answer section in
  the response on a SOA query for *Child Zone*.
* Name Server not including NS record of *Child Zone* in the answer section in
  the response on an NS query for *Child Zone*.
* Name Server not setting the AA flag in a response with SOA or NS in answer
  section.
* Name Server responding with unexpected [RCODE Name] (any except "NoError") on
  query for SOA or NS for *Child Zone*.

In addition, this test case will output a message if transport over IPv4 or IPv6
has been disabled.

## Scope

The only UDP port defined for DNS is port 53 ([RFC 1035][RFC 1035#4.2.1], section
4.2.1), and that is the only port used by this and other Test Cases for DNS
queries to the name servers.


## Inputs

* "Child Zone" - The domain name to be tested.


## Summary

Message Tag                         |Level  |Arguments  | Message ID for message tag
:-----------------------------------|:------|:----------|:------------------------------------------------------------------------------------------
CN01_IPV4_DISABLED                  | NOTICE| ns_list   | IPv4 is disabled. No DNS queries are sent to these name servers: "{ns_list}".
CN01_IPV6_DISABLED                  | NOTICE| ns_list   | IPv6 is disabled. No DNS queries are sent to these name servers: "{ns_list}".
CN01_MISSING_NS_RECORD_UDP          |WARNING| ns        | Nameserver {ns} reponds to a NS query with no NS records in the answer section over UDP.
CN01_MISSING_SOA_RECORD_UDP         |WARNING| ns        | Nameserver {ns} reponds to a SOA query with no SOA records in the answer section over UDP.
CN01_NO_RESPONSE_NS_QUERY_UDP       |WARNING| ns        | Nameserver {ns} does not respond to NS queries over UDP.
CN01_NO_RESPONSE_SOA_QUERY_UDP      |WARNING| ns        | Nameserver {ns} does not respond to SOA queries over UDP.
CN01_NO_RESPONSE_UDP                |WARNING| ns        | Nameserver {ns} does not respond to any queries over UDP.
CN01_NS_RECORD_NOT_AA_UDP           |WARNING| ns        | Nameserver {ns} does not give an authoritative response on an NS query over UDP.
CN01_SOA_RECORD_NOT_AA_UDP          |WARNING| ns        | Nameserver {ns} does not give an authoritative response on an SOA query over UDP.
CN01_UNEXPECTED_RCODE_NS_QUERY_UDP  |WARNING| ns, rcode | Nameserver {ns} responds with an unexpected RCODE ({rcode}) on an NS query over UDP.
CN01_UNEXPECTED_RCODE_SOA_QUERY_UDP |WARNING| ns, rcode | Nameserver {ns} responds with an unexpected RCODE ({rcode}) on an SOA query over UDP.
CN01_WRONG_NS_RECORD_UDP            |WARNING| ns, domain_found, domain_expected | Nameserver {ns} responds with a wrong owner name ({domain_found} instead of {domain_expected}) on NS queries over UDP.
CN01_WRONG_SOA_RECORD_UDP           |WARNING| ns, domain_found, domain_expected | Nameserver {ns} responds with a wrong owner name ({domain_found} instead of {domain_expected}) on SOA queries over UDP.


The value in the Level column is the default severity level of the message. The
severity level can be changed in the [Zonemaster-Engine profile]. Also see the
[Severity Level Definitions] document.

The argument names in the Arguments column lists the arguments used in the
message. The argument names are defined in the [argument list].


## Test procedure

In this section and unless otherwise specified below, the term "[DNS Query]"
follows the specification for DNS queries as specified in
[DNS Query and Response Defaults]. The handling of the DNS responses on the DNS
queries follow, unless otherwise specified below, what is specified for
[DNS Response] in the same specification.

1. Create [DNS Queries][DNS Query]:
   1. Query type SOA and query name *Child Zone* ("SOA Query").
   1. Query type NS and query name *Child Zone* ("NS Query").

2. Obtain the set of name server IP addresses using [Method4] and [Method5]
   ("Name Server IP").

3. If IPv4 is disabled then do:
   1. Extract all name servers with IPv4 address from *Name Server IP*.
   2. If the set of IPv4 name servers is non-empty then output
      *[CN01_IPV4_DISABLED]* with the set of IPv4 name servers (names and IP
      addresses).

4. If IPv6 is disabled then do:
   1. Extract all name servers with IPv6 address from *Name Server IP*.
   2. If the set of IPv6 name servers is non-empty then output
      *[CN01_IPV6_DISABLED]* with the set of IPv6 name servers (names and IP
      addresses).

5. For each name server in *Name Server IP* do:

   1. Send *SOA Query* and *NS Query* to the name server and collect
      the [DNS Responses][DNS Response].
   2. If there is no DNS response on neither query, then:
      1. Output *[CN01_NO_RESPONSE_UDP]* with name and IP address of the name
         server.
      2. Go to next name server.
   3. Else:
      1. Process the response on *SOA Query*:
         1. If there is no [DNS response], then output
            *[CN01_NO_RESPONSE_SOA_QUERY_UDP]* with name and IP address of the
            name server.
         2. Else, if [RCODE Name] is not "NoError" then output
            *[CN01_UNEXPECTED_RCODE_SOA_QUERY_UDP]* with [RCODE Name] and name
            and IP address of the name server.
         3. Else, if there is no SOA record in the answer section, then
            output *[CN01_MISSING_SOA_RECORD_UDP]* with name and IP address of
            the name server.
         4. Else, if the SOA record has owner name other than *Child Zone*
            then output *[CN01_WRONG_SOA_RECORD_UDP]* with name and IP address of
            the name server, the SOA record owner name and *Child Zone*.
         5. Else, if AA flag is unset, then output *[CN01_SOA_RECORD_NOT_AA_UDP]*
            with name and IP address of the name server.
      2. Process the response on *NS Query*:
         1. If there is no [DNS Response], then output
            *[CN01_NO_RESPONSE_NS_QUERY_UDP]* with name and IP address of the
            name server.
         2. Else, if [RCODE Name] is not "NoError" then output
            *[CN01_UNEXPECTED_RCODE_NS_QUERY_UDP]* with [RCODE Name] and name and
            IP address of the name server.
         3. Else, if there is no NS record in the answer section, then
            output *[CN01_MISSING_NS_RECORD_UDP]* with name and IP address of the
            name server.
         4. Else, if the NS record has owner name other than *Child Zone*
            then output *[CN01_WRONG_NS_RECORD_UDP]* with name and IP address of
            the name server, the NS record owner name and *Child Zone*.
         5. Else, if AA flag is unset, then output *[CN01_NS_RECORD_NOT_AA_UDP]*
            with name and IP address of the name server.


## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *[ERROR]* or *[CRITICAL]*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *[WARNING]*, but no message with severity level
*ERROR* or *CRITICAL*.

In other cases, no message or only messages with severity level
*[INFO]* or *[NOTICE]*, the outcome of this Test Case is "pass".


## Special procedural requirements	

If either IPv4 or IPv6 transport is disabled, skip sending queries over that
transport protocol.


## Intercase dependencies

None.


## Terminology

No special terminology for this test case.


[Argument list]:                                                  https://github.com/zonemaster/zonemaster-engine/blob/master/docs/logentry_args.md
[Basic02]:                                                        basic02.md
[CN01_IPV4_DISABLED]:                                             #summary
[CN01_IPV6_DISABLED]:                                             #summary
[CN01_MISSING_NS_RECORD_UDP]:                                     #summary
[CN01_MISSING_SOA_RECORD_UDP]:                                    #summary
[CN01_NO_RESPONSE_NS_QUERY_UDP]:                                  #summary
[CN01_NO_RESPONSE_SOA_QUERY_UDP]:                                 #summary
[CN01_NO_RESPONSE_UDP]:                                           #summary
[CN01_NS_RECORD_NOT_AA_UDP]:                                      #summary
[CN01_SOA_RECORD_NOT_AA_UDP]:                                     #summary
[CN01_UNEXPECTED_RCODE_NS_QUERY_UDP]:                             #summary
[CN01_UNEXPECTED_RCODE_SOA_QUERY_UDP]:                            #summary
[CN01_WRONG_NS_RECORD_UDP]:                                       #summary
[CN01_WRONG_SOA_RECORD_UDP]:                                      #summary
[CRITICAL]:                                                       ../SeverityLevelDefinitions.md#critical
[DEBUG]:                                                          ../SeverityLevelDefinitions.md#notice
[DNS Query and Response Defaults]:                                ../DNSQueryAndResponseDefaults.md
[DNS Query]:                                                      ../DNSQueryAndResponseDefaults.md#default-setting-in-dns-query
[DNS Response]:                                                   ../DNSQueryAndResponseDefaults.md#default-handling-of-a-dns-response
[ERROR]:                                                          ../SeverityLevelDefinitions.md#error
[INFO]:                                                           ../SeverityLevelDefinitions.md#info
[Method4]:                                                        ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                                                        ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[NOTICE]:                                                         ../SeverityLevelDefinitions.md#notice
[RCODE Name]:                                                     https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[RFC 1035#4.2.1]:                                                 https://www.rfc-editor.org/rfc/rfc1035#section-4.2.1
[RFC 1123]:                                                       https://www.rfc-editor.org/rfc/rfc1123
[RFC 7766#5]:                                                     https://www.rfc-editor.org/rfc/rfc7766#section-5
[Severity Level Definitions]:                                     ../SeverityLevelDefinitions.md
[WARNING]:                                                        ../SeverityLevelDefinitions.md#warning
[Zonemaster-Engine profile]:                                      https://github.com/zonemaster/zonemaster-engine/blob/master/docs/Profiles.md


