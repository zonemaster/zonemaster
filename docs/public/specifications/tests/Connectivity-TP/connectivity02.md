# CONNECTIVITY02: TCP connectivity to name servers

## Test case identifier
**CONNECTIVITY02**


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

TCP is a protocol to reach a general purpose name server hosting a zone, "All
general-purpose DNS implementations MUST support [...] TCP transport"
([RFC 7766][RFC 7766#5], section 5).

This Test Case will verify if the name servers of *Child Zone* are reachable over
TCP. The name servers tested are both those in the delegation of *Child Zone* and
those in the NS records in the *Child Zone* itself.

This Test Case will mimic the tests done by [Connectivity01], but over TCP
instead:

* Name Server responding to a query.
* Name Server including SOA record of *Child Zone* in the answer section in the
  response on a SOA query for *Child Zone*.
* Name Server including NS record of *Child Zone* in the answer section in the
  response on an NS query for *Child Zone*.
* Name Server setting the AA flag in a response with SOA or NS in answer section.
* Name Server responding with expected [RCODE Name] ("NoError") on query for SOA
  or NS for *Child Zone*.


## Scope

The only TCP port defined for DNS is port 53 ([RFC 1035][RFC 1035#4.2.1], section
4.2.1), and that is the only port used by this and other Test Cases for DNS
queries to the name servers.

UDP connectivity is tested by Test Case [Connectivity01].


## Inputs

* "Child Zone" - The domain name to be tested.


## Summary

Message Tag                         |Level  |Arguments  | Message ID for message tag
:-----------------------------------|:------|:----------|:---------------------------------------------------------------------------------------
CN02_MISSING_NS_RECORD_TCP          |WARNING| ns        | Nameserver {ns} reponds to a NS query with no NS records in the answer section over TCP.
CN02_MISSING_SOA_RECORD_TCP         |WARNING| ns        | Nameserver {ns} reponds to a SOA query with no SOA records in the answer section over TCP.
CN02_NO_RESPONSE_NS_QUERY_TCP       |WARNING| ns        | Nameserver {ns} does not respond to NS queries over TCP.
CN02_NO_RESPONSE_SOA_QUERY_TCP      |WARNING| ns        | Nameserver {ns} does not respond to SOA queries over TCP.
CN02_NO_RESPONSE_TCP                |WARNING| ns        | Nameserver {ns} does not respond to any queries over TCP.
CN02_NS_RECORD_NOT_AA_TCP           |WARNING| ns        | Nameserver {ns} does not give an authoritative response on an NS query over TCP.
CN02_SOA_RECORD_NOT_AA_TCP          |WARNING| ns        | Nameserver {ns} does not give an authoritative response on an SOA query over TCP.
CN02_UNEXPECTED_RCODE_NS_QUERY_TCP  |WARNING| ns, rcode | Nameserver {ns} responds with an unexpected RCODE ({rcode}) on an NS query over TCP.
CN02_UNEXPECTED_RCODE_SOA_QUERY_TCP |WARNING| ns, rcode | Nameserver {ns} responds with an unexpected RCODE ({rcode}) on an SOA query over TCP.
CN02_WRONG_NS_RECORD_TCP            |WARNING| ns, , domain_found, domain_expected | Nameserver {ns} responds with a wrong owner name ({domain_found} instead of {domain_expected}) on NS queries over TCP.
CN02_WRONG_SOA_RECORD_TCP           |WARNING| ns, , domain_found, domain_expected | Nameserver {ns} responds with a wrong owner name ({domain_found} instead of {domain_expected}) on SOA queries over TCP.

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
   1. Query type SOA and query name *Child Zone* over TCP ("SOA Query TCP").
   1. Query type NS and query name *Child Zone* over TCP ("NS Query TCP").

2. Obtain the set of name server IP addresses using [Method4] and [Method5]
   ("Name Server IP").

3. For each name server in *Name Server IP* do:

   1. Send *SOA Query TCP* and *NS Query TCP* to the name server and collect
      the [DNS Responses][DNS Response].
   2. If there is no DNS response on neither query, then:
      1. Output *[CN02_NO_RESPONSE_TCP]* with name and IP address of the name
         server.
      2. Go to next name server.
   3. Else:
      1. Process the response on *SOA Query TCP*:
         1. If there is no [DNS response], then output
            *[CN02_NO_RESPONSE_SOA_QUERY_TCP]* with name and IP address of the
            name server.
         2. Else, if [RCODE Name] is not "NoError" then output
            *[CN02_UNEXPECTED_RCODE_SOA_QUERY_TCP]* with [RCODE Name] and name
            and IP address of the name server.
         3. Else, if there is no SOA record in the answer section, then
            output *[CN02_MISSING_SOA_RECORD_TCP]* with name and IP address of
            the name server.
         4. Else, if the SOA record has owner name other than *Child Zone*
            then output *[CN02_WRONG_SOA_RECORD_TCP]* with name and IP address of
            the name server, the SOA record owner name and *Child Zone*.
         5. Else, if AA flag is unset, then output *[CN02_SOA_RECORD_NOT_AA_TCP]*
            with name and IP address of the name server.
      2. Process the response on *NS Query TCP*:
         1. If there is no [DNS Response], then output
            *[CN02_NO_RESPONSE_NS_QUERY_TCP]* with name and IP address of the
            name server.
         2. Else, if [RCODE Name] is not "NoError" then output
            *[CN02_UNEXPECTED_RCODE_NS_QUERY_TCP]* with [RCODE Name] and name and
            IP address of the name server.
         3. Else, if there is no NS record in the answer section, then
            output *[CN02_MISSING_NS_RECORD_TCP]* with name and IP address of the
            name server.
         4. Else, if the NS record has owner name other than *Child Zone*
            then output *[CN02_WRONG_NS_RECORD_TCP]* with name and IP address of
            the name server, the NS record owner name and *Child Zone*.
         5. Else, if AA flag is unset, then output *[CN02_NS_RECORD_NOT_AA_TCP]*
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

No special terminology for this Test Case.


[Argument list]:                                                  ../ArgumentsForTestCaseMessages.md
[CN02_MISSING_NS_RECORD_TCP]:                                     #summary
[CN02_MISSING_SOA_RECORD_TCP]:                                    #summary
[CN02_NO_RESPONSE_NS_QUERY_TCP]:                                  #summary
[CN02_NO_RESPONSE_SOA_QUERY_TCP]:                                 #summary
[CN02_NO_RESPONSE_TCP]:                                           #summary
[CN02_NS_RECORD_NOT_AA_TCP]:                                      #summary
[CN02_SOA_RECORD_NOT_AA_TCP]:                                     #summary
[CN02_UNEXPECTED_RCODE_NS_QUERY_TCP]:                             #summary
[CN02_UNEXPECTED_RCODE_SOA_QUERY_TCP]:                            #summary
[CN02_WRONG_NS_RECORD_TCP]:                                       #summary
[CN02_WRONG_SOA_RECORD_TCP]:                                      #summary
[CRITICAL]:                                                       ../SeverityLevelDefinitions.md#critical
[Connectivity01]:                                                 connectivity01.md
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
[RFC 7766#5]:                                                     https://www.rfc-editor.org/rfc/rfc7766#section-5
[Severity Level Definitions]:                                     ../SeverityLevelDefinitions.md
[WARNING]:                                                        ../SeverityLevelDefinitions.md#warning
[Zonemaster-Engine profile]:                                      ../../../configuration/profiles.md
