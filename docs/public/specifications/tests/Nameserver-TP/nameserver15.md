# NAMESERVER15: Checking for software version

## Test case identifier

**NAMESERVER15**

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

This Test Case verifies if a name server responds to TXT queries in the CHAOS class, specifically
about its software version as it may sometimes be desirable not to reveal that information.

A description of DNS classes can be found in [RFC2929], section 3.2.

## Scope

It is assumed that *Child Zone* is also tested and reported by [Connectivity01].
This Test Case will just ignore non-responsive name servers or name servers not
giving a correct DNS response for an authoritative name server.

## Inputs

* "Child Zone" - The domain name to be tested.

## Summary

Message Tag                 | Level   | Arguments                     | Message ID for message tag
:---------------------------|:--------|:------------------------------|:---------------------------------------------------------------------------------------
N15_BIND_VERSION            | INFO    | ns_ip_list, string            | Name server(s) "{ns_ip_list}" respond(s) to CHAOS TXT query "version.bind" with value "{string}".

The value in the Level column is the default severity level of the message. The
severity level can be changed in the [Zonemaster-Engine Profile]. Also see the
[Severity Level Definitions] document.

The argument names in the Arguments column lists the arguments used in the
message. The argument names are defined in the [Argument List].

## Test procedure

1. Create the following empty sets:
   1. Name server IP and string ("TXT Data")

2. Create [DNS Query] with query type TXT, query class CHAOS and
   query name "version.bind" ("TXT Query").

3. Obtain the set of name server IP addresses using [Method4] and [Method5]
   ("Name Server IP").

4. For each name server in *Name Server IP* do:
   1. [Send] *TXT Query* to the name server and collect the response.
   2. If at least one of the following criteria is met, go to next name server:
      1. There is no DNS response.
      2. The [DNS Response] does not have the [RCODE Name] NoError.
      3. The [DNS Response] does not have any TXT record in the
         answer section with owner name "version.bind".
   3. Extract the string from the RDATA of the TXT record in the
      answer section of the [DNS Response].
   4. Add *Name Server IP* and the extracted string to the *TXT Data* set.

5. If the *TXT Data* set is non-empty, then do:
   1. For each unique TXT string in the set, output *[N15_BIND_VERSION]*
      with name server IP list and the TXT string.

## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *[ERROR]* or *[CRITICAL]*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *[WARNING]*, but no message with severity level
*[ERROR]* or *[CRITICAL]*.

In other cases, no message or only messages with severity level
*[INFO]* or *[NOTICE]*, the outcome of this Test Case is "pass".

## Special procedural requirements

The *Child Zone* must be a valid name meeting
"[Requirements and normalization of domain names in input]".

## Intercase dependencies

None

## Terminology

* "Send" - The term is used when a DNS query is sent to
  a specific name server (name server IP address).

[Argument List]:                                                https://github.com/zonemaster/zonemaster-engine/blob/master/docs/logentry_args.md
[CRITICAL]:                                                     ../SeverityLevelDefinitions.md#critical
[DEBUG]:                                                        ../SeverityLevelDefinitions.md#notice
[DNS Query and Response Defaults]:                              ../DNSQueryAndResponseDefaults.md
[DNS Query]:                                                    ../DNSQueryAndResponseDefaults.md#default-setting-in-dns-query
[DNS Response]:                                                 ./DNSQueryAndResponseDefaults.md#default-handling-of-a-dns-response
[ERROR]:                                                        ../SeverityLevelDefinitions.md#error
[INFO]:                                                         ../SeverityLevelDefinitions.md#info
[Message Tag Specification]:                                    ../../../../internal/templates/specifications/tests/MessageTagSpecification.md
[Methods]:                                                      ../Methods.md
[NOTICE]:                                                       ../SeverityLevelDefinitions.md#notice
[RCODE Name]:                                                   https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[Requirements and normalization of domain names in input]:      https://github.com/zonemaster/zonemaster/blob/develop/docs/specifications/tests/RequirementsAndNormalizationOfDomainNames.md
[RFC2929]:                                                      https://datatracker.ietf.org/doc/html/rfc2929#section-3.2
[Send]:                                                         #terminology
[Severity Level Definitions]:                                   ../SeverityLevelDefinitions.md
[Test Case Identifier Specification]:                           ../../../../internal/templates/specifications/tests/TestCaseIdentifierSpecification.md
[WARNING]:                                                      ../SeverityLevelDefinitions.md#warning
[Zonemaster-Engine Profile]:                                    https://github.com/zonemaster/zonemaster-engine/blob/master/docs/Profiles.md