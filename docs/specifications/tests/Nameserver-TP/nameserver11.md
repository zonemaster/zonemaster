# NAMESERVER11: Test for unknown EDNS OPTION-CODE

## Test case identifier
**NAMESERVER11** 

## Table of contents

* [Objective](#Objective)
* [Scope](#Scope)
* [Inputs](#Inputs)
* [Summary](#Summary)
* [Test procedure](#Test-procedure)
* [Outcome(s)](#Outcomes)
* [Special procedural requirements](#Special-procedural-requirements)
* [Intercase dependencies](#Intercase-dependencies)
* [Terminology](#Terminology)

## Objective

EDNS is a mechanism to announce capabilities of a DNS implementation,
and is now basically required by any new functionality in DNS such as
DNSSEC ([RFC 6891]).

[RFC 6891][RFC 6891, section 6.1.2], section 6.1.2, states that any OPTION-CODE values
not understood by a responder or requestor MUST be ignored. Unknown OPTION-CODE values
must be processed as though the OPTION-CODE was not even there.

In this test case, we will query with an unknown EDNS OPTION-CODE and expect
that the OPTION-CODE is not present in the response for the query.

## Scope

It is assumed that *Child Zone* has been tested and reported by [Basic04]. This
test case will just ignore non-responsive name servers or name servers not
giving a correct DNS response for an authoritative name server.

It is assumed that *Child Zone* has been tested and reported by [Nameserver02].
Running this test case without running [Nameserver02] can give an incomplete
report status of *Child Zone*.

## Inputs

"Child Zone" - The domain name to be tested.

## Summary

Message Tag                            | Level     | Arguments           | Message ID for message tag
:--------------------------------------|:----------|---------------------|---------------------------------------------
NS11_UNKNOWN_OPTION_CODE               | WARNING   | ns_ip_list          | The DNS response contains an unknown EDNS option-code.
                                       |           |                     | Returned from name servers "{ns_ip_list}".

The value in the Level column is the default severity level of the message. The
severity level can be changed in the [Zonemaster-Engine profile]. Also see the
[Severity Level Definitions] document.

The argument names in the Arguments column lists the arguments used in the
message. The argument names are defined in the [argument list].

## Test procedure

In this section and unless otherwise specified below, the term "[EDNS Query]"
follows the specification for DNS queries as specified in [DNS Query and Response Defaults].
The handling of the DNS responses on the DNS queries follow, unless otherwise specified below, 
what is specified for [EDNS Response] in the same specification.

1. Create the following empty sets:
   1. Name server IP address ("Unknown Option Code")

2. Create a [EDNS Query] with query type SOA, *Child Zone* as query name and with
   EDNS OPTION-CODE set to anything other than what is already assigned in
   the [IANA-DNSSYSTEM-PARAMETERS] and no other EDNS options or flags ("SOA Query").

3. Obtain the set of name server IP addresses using [Method4] and [Method5] 
   ("Name Server IP").

4. For each name server in *Name Server IP* do:

   1. Send *SOA query* to the name server and collect the response.
   2. If there is no EDNS response, then go to next name server.
   3. Else, if the EDNS response has the [RCODE Name] "FormErr", then go to next name server.
   4. Else, if there is an "OPTION-CODE" present in the response, then add name server IP
      to the *Unknown Option Code* set and go to next name server.
   5. Else, if the EDNS response meet the following four criteria,
      then go to next name server (no error):
      1. The SOA is obtained as response in the ANSWER section.
      2. If the EDNS response has the [RCODE Name] "NoError".
      3. The pseudo-section response has an OPT record with version set to 0.
      4. There is no "OPTION-CODE" present in the response.

5. If the *Unknown Option Code* set is non-empty, then output *[NS11_UNKNOWN_OPTION_CODE]* 
   with the name servers IP addresses from the set.

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

[Argument list]:                        https://github.com/zonemaster/zonemaster-engine/blob/master/docs/logentry_args.md
[Basic04]:                              ../Basic-TP/basic04.md
[CRITICAL]:                             https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/SeverityLevelDefinitions.md#critical
[DNS Query and Response Defaults]:      ../DNSQueryAndResponseDefaults.md
[EDNS Query]:                            ../DNSQueryAndResponseDefaults.md#default-setting-in-edns-query
[EDNS Response]:                         ../DNSQueryAndResponseDefaults.md#default-handling-of-an-edns-response
[ERROR]:                                https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/SeverityLevelDefinitions.md#error
[IANA-DNSSYSTEM-PARAMETERS]:            https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-11
[INFO]:                                 https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/SeverityLevelDefinitions.md#info
[Message Tag Specification]:            MessageTagSpecification.md
[Methods]:                              ../Methods.md
[Method4]:                              ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                              ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[Nameserver02]:                         ../Nameserver-TP/nameserver02.md
[NOTICE]:                               https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/SeverityLevelDefinitions.md#notice
[NS11_UNKNOWN_OPTION_CODE]:             #summary
[RCODE Name]:                           https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[RFC 6891, section 6.1.2]:              https://tools.ietf.org/html/rfc6891#section-6.1.2
[RFC 6891]:                             https://tools.ietf.org/html/rfc6891
[Severity Level Definitions]:           https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/SeverityLevelDefinitions.md
[Test Case Identifier Specification]:   TestCaseIdentifierSpecification.md
[WARNING]:                              https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/SeverityLevelDefinitions.md#warning
[Zonemaster-Engine profile]:            https://github.com/zonemaster/zonemaster-engine/blob/master/docs/Profiles.md