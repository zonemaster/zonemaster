# NAMESERVER10: Test for undefined EDNS version

## Test case identifier

**NAMESERVER10**

## Objective

EDNS ([RFC 6891]) is a mechanism to announce capabilities of a DNS
implementation, and is required by new functionality in DNS such as
DNSSEC ([RFC 4033][RFC 4033#3], section 3).

[RFC 6891][RFC 6891#6.1.3], section 6.1.3,
states that if a nameserver has implemented
EDNS but has not implemented the version level of the request, then it
MUST respond with RCODE "BADVERS". Only version "0" has been defined for
EDNS.

Note that RCODE "BADVERS" is an extended RCODE which is calculated from
the combination of the normal RCODE field in the DNS package header
([RFC 1035][RFC 1035#4.1.1], section 4.1.1) and the OPT record
EXTENDED-RCODE field ([RFC 6891][RFC 6891#6.1.3], section 6.1.3). Also see
[IANA RCODE Registry].

## Scope

It is assumed that *Child Zone* has been tested by [Basic04]. This test
case will set DEBUG level on messages for non-responsive name servers.

## Inputs

* "Child Zone" - The domain name to be tested.

## Ordered description of steps to be taken to execute the test case

1. Created an SOA query for the *Child Zone* with an OPT record with
   EDNS version set to "1" and no other EDNS options or flags.

2. Obtain the set of name server IP addresses using [Method4] and [Method5]
   ("Name Server IP").

3. For each name server in *Name Server IP* do:

   1. Send the SOA query to the name server and collect the response.
   2. If there is no DNS response, output *[NO_RESPONSE]*.
   3. Else, if the DNS response has the RCODE "FORMERR" then output
      *[NO_EDNS_SUPPORT]*.
   4. Else, if the DNS response has the RCODE "NOERROR" then
      output *[UNSUPPORTED_EDNS_VER]*.
   5. Else, if the DNS response meet the following three criteria,
      then just go to the next name server (no error):
      1. It has the RCODE "BADVERS".
      2. It has EDNS version 0.
      3. The answer section is empty.
   6. Else output *[NS_ERROR]*.


## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

The outcome of this Test case is "pass" in all other cases.

Message                           | Default severity level (when message is outputted)
:---------------------------------|:-----------------------------------
NO_RESPONSE                       | DEBUG
NO_EDNS_SUPPORT                   | WARNING
UNSUPPORTED_EDNS_VER              | WARNING
NS_ERROR                          | WARNING

## Special procedural requirements	

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol and log a message reporting
the ignored result.

## Intercase dependencies

None


[Basic04]:              ../Basic-TP/basic04.md
[IANA RCODE Registry]:  https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[Method4]:              ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:              ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[NO_EDNS_SUPPORT]:      #outcomes
[NO_RESPONSE]:          #outcomes
[NS_ERROR]:             #outcomes
[RFC 1035#4.1.1]:       https://tools.ietf.org/html/rfc1035#section-4.1.1
[RFC 4033#3]:           https://tools.ietf.org/html/rfc4033#section-3
[RFC 6891#6.1.3]:       https://tools.ietf.org/html/rfc6891#section-6.1.3
[RFC 6891]:             https://tools.ietf.org/html/rfc6891
[UNSUPPORTED_EDNS_VER]: #outcomes

