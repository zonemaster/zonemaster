# NAMESERVER10: Test for undefined EDNS version


## Test case identifier

**NAMESERVER10**


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

EDNS ([RFC 6891]) is a mechanism to announce capabilities of a DNS
implementation, and is required by new functionality in DNS such as DNSSEC
([RFC 4033][RFC 4033#section-3], section 3).

[RFC 6891][RFC 6891#section-6.1.3], section 6.1.3, states that if a nameserver
has implemented EDNS but has not implemented the version level of the request,
then it MUST respond with RCODE "BADVERS". Only version "0" has been defined for
EDNS.

Note that RCODE "BADVERS" is an extended RCODE which is calculated from the
combination of the normal RCODE field in the DNS package header
([RFC 1035][RFC 1035#section-4.1.1], section 4.1.1) and the OPT record
EXTENDED-RCODE field ([RFC 6891][RFC 6891#section-6.1.3], section 6.1.3). Also
see [IANA RCODE Registry].


## Scope

It is assumed that *Child Zone* has been tested by [Basic04] and [Nameserver02].
Issues covered by [Basic04] (basic name server issues) or [Nameserver02] (basic
EDNS issues) will no result in messagess from this test case.


## Inputs

* "Child Zone" - The domain name to be tested.

## Summary

* Only relevant for a zone whose name servers correctly support EDNS, version 0.

Message Tag outputted         | Level   | Arguments         | Description of when message tag is outputted
:-----------------------------|:--------|:------------------|:--------------------------------------------
N10_NO_RESPONSE_EDNS1_QUERY   | WARNING | ns_ip_list        | Response when EDNS ver=0, but not when 1.
N10_UNEXPECTED_RCODE          | WARNING | ns_ip_list, rcode | Unexpected RCODE value when EDNS ver=1.
N10_EDNS_RESPONSE_ERROR       | WARNING | ns_ip_list        | Expected RCODE value when EDNS ver=1, but error in response.

The value in the Level column is the default severity level of the message. The
severity level can be changed in the [Zonemaster-Engine profile]. Also see the
[Severity Level Definitions] document.

The argument names in the Arguments column lists the arguments used in the
message. The argument names are defined in the [argument list].


## Test procedure

1. Create the following empty sets:

  1. Name server IP ("No Response EDNS1 Query").
  2. Name server IP and associated RCODE ("Unexpected RCODE").
  3. Name server IP ("EDNS Response Error").


1. Create an SOA query for the *Child Zone* with an OPT record with EDNS version
   set to "0" and with EDNS option of payload size ("bufsize") set to 512 and
   other EDNS options and flags unset ("Query One").

2. Create an SOA query for the *Child Zone* with an OPT record with EDNS version
   set to "1" and with EDNS option of payload size ("bufsize") set to 512 and
   other EDNS options and flags unset ("Query Two").

3. Obtain the set of name server IP addresses using [Method4] and [Method5]
   ("Name Server IP").

4. For each name server in *Name Server IP* do:

  1. Send *Query One* over UDP to the name server, collect the response and do:
     1. If there is no DNS response then go to next name server.
     2. Else, if the RCODE value is not "NOERROR" then go to next name server.
  2. Send *Query Two* over UDP to the name server, collect the response and do:
     1. If there is no DNS response, then add the name server IP to the
        *No Response EDNS1 Query* set.
     2. Else, if the DNS response does not have RCODE with value "BADVERS", then
        add the name server IP and RCODE value to the *Unexpected RCODE* set.
     3. Else, if the DNS response meet all the following three criteria, then
        just go to the next name server (correct response):
        1. It has the RCODE "BADVERS".
        2. It has EDNS version 0.
        3. The answer section is empty.
     4. Else add the name server IP to the *EDNS Response Error* set.

5. If the *No Response EDNS1 Query* set is non-empty, then output
   *[N10_NO_RESPONSE_EDNS1_QUERY]* with the name server IP addresses from the
   set.

6. If the *Unexpected RCODE* set is non-empty, then for each RCODE value in the
   set do:
   * Output *[N10_UNEXPECTED_RCODE]* with the RCODE value and the name server
     IP addresses for that RCODE value.

7. If the *EDNS Response Error* set is non-empty, then output
   *[N10_EDNS_RESPONSE_ERROR]* with the name server IP addresses from the set.


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

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the result
of any test using that transport protocol. Log a message reporting on the ignored
result.


## Intercase dependencies

None


## Terminology

No special terminology for this test case.





[Basic04]:                                 ../Basic-TP/basic04.md
[IANA RCODE Registry]:                     https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[Method4]:                                 ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                                 ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[N10_EDNS_RESPONSE_ERROR]:                 #Summary
[N10_NO_RESPONSE_EDNS1_QUERY]:             #Summary
[N10_UNEXPECTED_RCODE]:                    #Summary
[Nameserver02]:                            ../Nameserver-TP/nameserver02.md
[RFC 1035#section-4.1.1]:                  https://tools.ietf.org/html/rfc1035#section-4.1.1
[RFC 4033#section-3]:                      https://tools.ietf.org/html/rfc4033#section-3
[RFC 6891#section-6.1.3]:                  https://tools.ietf.org/html/rfc6891#section-6.1.3
[RFC 6891]:                                https://tools.ietf.org/html/rfc6891

