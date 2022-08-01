# BASIC04: Test of basic nameserver and zone functionality

## Test case identifier
**BASIC04**


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

Many test cases will query the name servers in the delegation or the
name servers appointed by the NS records in the zone for the NS or SOA
record or both. Reporting problem is crucial, but instead of letting
several test cases report the same problems found, most test cases
assume that this test case has been run. Only this test case will
report problems found in the following areas:

* Name Server not responding to a query without EDNS over UDP.
* Name Server responding to TCP but not UDP.
* Name Server not including SOA record of *Child Zone* in the answer
  section in the response on a SOA query for *Child Zone*.
* Name Server not including NS record of *Child Zone* in the answer
  section in the response on an NS query for *Child Zone*.
* Name Server not setting the AA flag in a response with SOA or NS in
  answer section.
* Name Server responding with unexpected RCODE (any except "NOERROR")
  on query for SOA or NS for *Child Zone*.


## Scope

This test case is expected to run before [Basic02] but neither its
execution nor outcome are dependent on the order.


## Inputs

* "Child Zone" - The domain name to be tested.


## Summary

Message Tag                       | Level   | Arguments            | Message ID for message tag
:---------------------------------|:--------|:---------------------|:---------------------------------------------------------------------------------
B04_MISSING_NS_RECORD             | WARNING | ns                   | Nameserver {ns} reponds to a NS query with no NS records in the answer section.
B04_MISSING_SOA_RECORD            | WARNING | ns                   | Nameserver {ns} reponds to a SOA query with no SOA records in the answer section.
B04_NO_RESPONSE                   | WARNING | ns                   | Nameserver {ns} does not respond over neither UDP nor TCP.
B04_NO_RESPONSE_NS_QUERY          | WARNING | ns                   | Nameserver {ns} does not respond to NS queries.
B04_NO_RESPONSE_SOA_QUERY         | WARNING | ns                   | Nameserver {ns} does not respond to SOA queries.
B04_NS_RECORD_NOT_AA              | WARNING | ns                   | Nameserver {ns} does not give an authoritative response on an NS query.
B04_RESPONSE_TCP_NOT_UDP          | WARNING | ns                   | Nameserver {ns} does not respond over UDP.
B04_SOA_RECORD_NOT_AA             | WARNING | ns                   | Nameserver {ns} does not give an authoritative response on an SOA query.
B04_UNEXPECTED_RCODE_NS_QUERY     | WARNING | ns                   | Nameserver {ns} responds with an unexpected RCODE ({rcode}) on an NS query.
B04_UNEXPECTED_RCODE_SOA_QUERY    | WARNING | ns                   | Nameserver {ns} responds with an unexpected RCODE ({rcode}) on an SOA query.
B04_WRONG_NS_RECORD               | WARNING | ns                   | Nameserver {ns} responds with a wrong owner name ({owner} instead of {name}) on NS queries.
B04_WRONG_SOA_RECORD              | WARNING | ns                   | Nameserver {ns} responds with a wrong owner name ({owner} instead of {name}) on SOA queries.

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

1. Create [DNS Queries][DNS Query] over UDP:
   1. Query type SOA and query name *Child Zone* ("SOA Query UDP").
   1. Query type NS and query name *Child Zone* ("NS Query UDP").

2. Create [DNS Query] over TCP:
   1. Query type SOA and query name *Child Zone* ("SOA Query TCP").

3. Obtain the set of name server IP addresses using [Method4] and [Method5]
   ("Name Server IP").

4. For each name server in *Name Server IP* do:

   1. Send *SOA Query UDP* and *NS Query UDP* to the name server and collect
      the [DNS Responses][DNS Response].
   2. If there is no DNS response on neither query), then:
      1. Send *SOA Query TCP* to the name server and collect the [DNS Response].
      2. If there is no [DNS Response], then output *[B04_NO_RESPONSE]* and go
         to next server.
      3. Else, then output *[B04_RESPONSE_TCP_NOT_UDP]* and go to next server.
   3. Else:
      1. Process the response on *SOA Query UDP*:
         1. If there is no [DNS response], then output
            *[B04_NO_RESPONSE_SOA_QUERY]*.
         2. Else, if the RCODE is not "NOERROR" then output
            *[B04_UNEXPECTED_RCODE_SOA_QUERY]*.
         3. Else, if there is no SOA record in the answer section, then
            output *[B04_MISSING_SOA_RECORD]*.
         4. Else, if the SOA record has owner name other than *Child Zone*
            then output *[B04_WRONG_SOA_RECORD]*.
         5. Else, AA flag is unset, then output *[B04_SOA_RECORD_NOT_AA]*.
      2. Process the response on *NS Query UDP*:
         1. If there is no [DNS Response], then output
            *[B04_NO_RESPONSE_NS_QUERY]*.
         2. Else, if the RCODE is not "NOERROR" then output
            *[B04_UNEXPECTED_RCODE_NS_QUERY]*.
         3. Else, if there is no NS record in the answer section, then
            output *[B04_MISSING_NS_RECORD]*.
         4. Else, if the NS record has owner name other than *Child Zone*
            then output *[B04_WRONG_NS_RECORD]*.
         5. Else, AA flag is unset, then output *[B04_NS_RECORD_NOT_AA]*.


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
transport protocol. A message will be outputted reporting that the transport
protocol has been skipped.


## Intercase dependencies

None.


## Terminology

No special terminology for this test case.


[Argument list]:                                                  https://github.com/zonemaster/zonemaster-engine/blob/master/docs/logentry_args.md
[B04_MISSING_NS_RECORD]:                                          #summary
[B04_MISSING_SOA_RECORD]:                                         #summary
[B04_NO_RESPONSE]:                                                #summary
[B04_NO_RESPONSE_NS_QUERY]:                                       #summary
[B04_NO_RESPONSE_SOA_QUERY]:                                      #summary
[B04_NS_RECORD_NOT_AA]:                                           #summary
[B04_RESPONSE_TCP_NOT_UDP]:                                       #summary
[B04_SOA_RECORD_NOT_AA]:                                          #summary
[B04_UNEXPECTED_RCODE_NS_QUERY]:                                  #summary
[B04_UNEXPECTED_RCODE_SOA_QUERY]:                                 #summary
[B04_WRONG_NS_RECORD]:                                            #summary
[B04_WRONG_SOA_RECORD]:                                           #summary
[Basic02]:                                                        basic02.md
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
[Severity Level Definitions]:                                     ../SeverityLevelDefinitions.md
[WARNING]:                                                        ../SeverityLevelDefinitions.md#warning
[Zonemaster-Engine profile]:                                      https://github.com/zonemaster/zonemaster-engine/blob/master/docs/Profiles.md


