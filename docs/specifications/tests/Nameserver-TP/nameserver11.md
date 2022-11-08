# NAMESERVER11: Test for unknown EDNS OPTION-CODE

## Test case identifier
**NAMESERVER11**

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

Message Tag                       | Level   | Arguments         | Message ID for message tag
:---------------------------------|:--------|-------------------|---------------------------------------------
N11_NO_EDNS                       | WARNING | ns_ip_list        | The DNS response, on query with unknown EDNS option-code, does not contain any EDNS from name servers "{ns_ip_list}".
N11_NO_RESPONSE                   | WARNING | ns_ip_list        | There is no response on query with unknown EDNS option-code from name servers "{ns_ip_list}".
N11_RETURNS_UNKNOWN_OPTION_CODE   | WARNING | ns_ip_list        | The DNS response, on query with unknown EDNS option-code, contains an unknown EDNS option-code from name servers "{ns_ip_list}".
N11_UNEXPECTED_ANSWER_SECTION     | WARNING | ns_ip_list        | The DNS response, on query with unknown EDNS option-code, does not contain the expected SOA record in the answer section from name servers "{ns_ip_list}".
N11_UNEXPECTED_RCODE              | WARNING | ns_ip_list, rcode | The DNS response, on query with unknown EDNS option-code, has unexpected RCODE name "{rcode}" from name servers "{ns_ip_list}".
N11_UNSET_AA                      | WARNING | ns_ip_list        | The DNS response, on query with unknown EDNS option-code, is unexpectedly not authoritative from name servers "{ns_ip_list}".


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
   1. Name server IP address ("No Response on Unknown Option Code")
   2. Name server IP address and [RCODE Name] ("Unexpected RCODE on Unknown Option Code")
   3. Name server IP address ("No EDNS on Unknown Option Code")
   4. Name server IP address ("Unexpected Answer Section on Unknown Option Code")
   5. Name server IP address ("Unset AA on Unknown Option Code")
   6. Name server IP address ("Returns Unknown Option Code")

2. Create a [EDNS Query] with query type SOA, *Child Zone* as query name and with
   no EDNS options or flags ("SOA Query").

3. Create a [EDNS Query] with query type SOA, *Child Zone* as query name and with
   EDNS OPTION-CODE set to anything other than what is already assigned in
   the [IANA-DNSSYSTEM-PARAMETERS] and no other EDNS options or flags
   ("SOA Query with EDNS Option").

4. Obtain the set of name server IP addresses using [Method4] and [Method5]
   ("Name Server IP").

5. For each name server in *Name Server IP* do:

   1. Send *SOA Query* to the name server and collect the response.
   2. Go to next name server if at least one of the following criteria is met:
      1. There is no DNS response from the server.
      2. EDNS is unset in the response.
      3. The [RCODE Name] in the response is not "NoError".
      4. The AA flag is unset in the response.
      5. The answer section has no SOA record with *Child Zone* as owner name.
   3. Send *SOA Query with EDNS Option* to the name server and collect the
      response.
      1. If there is no DNS response from the server then add the name server to
         the *No Response on Unknown Option Code* set.
      2. Else, if the [RCODE Name] in the response is not "NoError" then add the
         name server and [RCODE Name] to the
         *Unexpected RCODE on Unknown Option Code* set.
         server.
      3. Else, if EDNS is unset in the response then add the name server to
         the *No EDNS on Unknown Option Code* set.
      4. Else, if the answer section has no SOA record with *Child Zone* as owner
         name then add the name server to the
         *Unexpected Answer Section on Unknown Option Code* set.
      5. Else, if the AA flag is unset in the response then add the name server
         to the *Unset AA on Unknown Option Code* set.
      6. Else, if the "OPTION-CODE" from the query is present in the response,
         then add name server to the *Returns Unknown Option Code* set.
      7. Else, no issues were found.

5. If the *No Response on Unknown Option Code* set is non-empty, then output
   *[N11_NO_RESPONSE]* with the name servers IP addresses from the set.

6. If the *Unexpected RCODE on Unknown Option Code* set is non-empty, then for
   each [RCODE NAME] in the set output *[N11_UNEXPECTED_RCODE]* with the
   [RCODE Name] and the name servers IP addresses for that [RCODE NAME] in the
   set.

7. If the *No EDNS on Unknown Option Code* set is non-empty, then output
   *[N11_NO_EDNS]* with the name servers IP addresses from the set.

8. If the *Unexpected Answer Section on Unknown Option Code* set is non-empty,
   then output *[N11_UNEXPECTED_ANSWER_SECTION]* with the name servers IP
   addresses from the set.

9. If the *Unset AA on Unknown Option Code* set is non-empty, then output
   *[N11_UNSET_AA]* with the name servers IP addresses from the set.

11. If the *Returns Unknown Option Code* set is non-empty, then output
    *[N11_RETURNS_UNKNOWN_OPTION_CODE]* with the name servers IP addresses from
    the set.


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
[Method4]:                              ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                              ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[Methods]:                              ../Methods.md
[N11_NO_EDNS]:                          #summary
[N11_NO_RESPONSE]:                      #summary
[N11_RETURNS_UNKNOWN_OPTION_CODE]:      #summary
[N11_UNEXPECTED_ANSWER_SECTION]:        #summary
[N11_UNEXPECTED_RCODE]:                 #summary
[N11_UNSET_AA]:                         #summary
[NOTICE]:                               https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/SeverityLevelDefinitions.md#notice
[Nameserver02]:                         ../Nameserver-TP/nameserver02.md
[RCODE Name]:                           https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[RFC 6891, section 6.1.2]:              https://tools.ietf.org/html/rfc6891#section-6.1.2
[RFC 6891]:                             https://tools.ietf.org/html/rfc6891
[Severity Level Definitions]:           https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/SeverityLevelDefinitions.md
[Test Case Identifier Specification]:   TestCaseIdentifierSpecification.md
[WARNING]:                              https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/SeverityLevelDefinitions.md#warning
[Zonemaster-Engine profile]:            https://github.com/zonemaster/zonemaster-engine/blob/master/docs/Profiles.md
