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

[RFC 6891, section 6.1.2] states that any OPTION-CODE values not understood by
a responder or requestor MUST be ignored. Unknown OPTION-CODE values must be
processed as though the OPTION-CODE was not even there.

In this test case, we will query with an unknown EDNS OPTION-CODE and expect
that the OPTION-CODE is not present in the response for the query.

## Scope

It is assumed that *Child Zone* has been tested and reported by [Basic04]. This
test case will just ignore non-responsive name servers or name servers not
giving a correct DNS response for an authoritative name server.

It is assumed that *Child Zone* has been tested and reported by [Nameserver02].
Running this test case without running [Nameserver02] can give an incomplete
report status of Child Zone.

## Inputs

"Child Zone" - The domain name to be tested.

## Summary

Message                                | Level     | Arguments           | Description of when message tag is outputted
:--------------------------------------|:----------|---------------------|---------------------------------------------
NS11_UNKNOWN_OPTION_CODE               | WARNING   |                     | The DNS response contains an unknown EDNS option-code

The value in the Level column is the default severity level of the message. The
severity level can be changed in the [Zonemaster-Engine profile]. Also see the
[Severity Level Definitions] document.

The argument names in the Arguments column lists the arguments used in the
message. The argument names are defined in the [argument list].


## Test procedure

1. Create a SOA query for the *Child Zone* with an OPT record with 
   EDNS OPTION-CODE set to anything other than it is already assigned as in
   the [IANA-DNSSYSTEM-PARAMETERS] and no other EDNS options or flags.

2. Obtain the set of name server IP addresses using [Method4] and [Method5] 
   ("Name Server IP").

3. For each name server in *Name Server IP* do:

   1. Send the SOA query to the name server and collect the response.
   2. If there is no DNS response, then go to next name server.
   3. Else, if the DNS response has the RCODE "FORMERR", then go to next name server.
   4. Else, if there is an "OPTION-CODE" present in the response, then
      output *[UNKNOWN_OPTION_CODE]* and go to next name server.
   5. Else, if the DNS response meet the following four criteria,
      then go to next name server (no error):
      1. The SOA is obtained as response in the ANSWER section.
      2. If the DNS response has the RCODE "NOERROR".
      3. The pseudo-section response has an OPT record with version set to 0.
      4. There is no "OPTION-CODE" present in the response.
   6. Else, go to next name server.

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

When the term "using Method" is used, names and IP addresses are fetched
using the defined [Methods].

The term "send" (to an IP address) is used when a DNS query is sent to
a specific name server.

[NS11_UNKNOWN_OPTION_CODE]:             #summary

[Argument list]:                        https://github.com/zonemaster/zonemaster-engine/blob/master/docs/logentry_args.md
[Basic04]:                              ../Basic-TP/basic04.md
[CRITICAL]:                             https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/SeverityLevelDefinitions.md#critical
[ERROR]:                                https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/SeverityLevelDefinitions.md#error
[IANA-DNSSYSTEM-PARAMETERS]:            https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-11
[INFO]:                                 https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/SeverityLevelDefinitions.md#info
[Message Tag Specification]:            MessageTagSpecification.md
[Methods]:                              ../Methods.md
[Method4]:                              ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                              ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[NOTICE]:                               https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/SeverityLevelDefinitions.md#notice
[RFC 6891, section 6.1.2]:              https://tools.ietf.org/html/rfc6891#section-6.1.2
[RFC 6891]:                             https://tools.ietf.org/html/rfc6891
[Severity Level Definitions]:           https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/SeverityLevelDefinitions.md
[Test Case Identifier Specification]:   TestCaseIdentifierSpecification.md
[WARNING]:                              https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/SeverityLevelDefinitions.md#warning
[Zonemaster-Engine profile]:            https://github.com/zonemaster/zonemaster-engine/blob/master/docs/Profiles.md