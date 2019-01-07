# NAMESERVER02: Test of EDNS0 support

## Test case identifier
**NAMESERVER02**

## Objective

EDNS(0) is a mechanism to announce capabilities of a DNS implementation,
and is now basically required by any new functionality in DNS such as
DNSSEC. EDNS(0) is standardized in [RFC 6891].

This test case checks that all name servers has the capability to do
EDNS(0) or if not, correctly replies to queries containing EDNS
(OPT record).

Servers not supporting EDNS(0) must return FORMERR 
([RFC 6891, section 7]):

> Responders that choose not to implement the protocol extensions
> defined in this document MUST respond with a return code (RCODE) of
> FORMERR to messages containing an OPT record in the additional
> section and MUST NOT include an OPT record in the response.

Servers supporting EDNS(0) must reply with EDNS(0)
([RFC 6891, section 6.1.1]):

> If an OPT record is present in a received request, compliant
> responders MUST include an OPT record in their respective responses.

To eliminating the risk of falsely classifying the server as not supporting
ENDS due e.g. firewall issues, the UDP buffer size is set to 512 bytes 
(octets).

## Inputs

* "Child Zone" - The domain name to be tested.

## Ordered description of steps to be taken to execute the test case

1. Created an SOA query for the *Child Zone* with an OPT record with 
   EDNS version set to "0" and with EDNS(0) option of payload size ("bufsize")
   set to 512 and "DO" bit unset.

2. Create a second SOA query for the *Child Zone* without any OPT record.

3. Obtain the set of name server IP addresses using [Method4] and [Method5]
   ("Name Server IP").

4. For each name server in *Name Server IP* do:

   1. Send the SOA query **with** OPT record to the name server and collect 
      the response.
   2. If there is no DNS response, then:
      1. Send the SOA query **without** OPT record to the name server and 
         collect the response.
      2. If there is no DNS response, then output *[NO_RESPONSE]* and 
         go to next server.
      3. Else (there is a DNS response), then output 
         *[BROKEN_EDNS_SUPPORT]* and go to next server.
   3. Else, if the DNS response meet the following two criteria,
      then output *[NO_EDNS_SUPPORT]*:
      1. It has the RCODE "FORMERR" 
      2. It has no OPT record.
   4. Else, if the DNS response meet the following criteria,
      then just go to the next name server (compliant server):
      1. It has the RCODE "NOERROR".
      2. The answer section contains the SOA record for *Child Zone*.
      3. It has OPT record with EDNS version 0.
   5. Else, if the DNS response meet the following criteria,
      then output *[BROKEN_EDNS_SUPPORT]* and go to next server.
      1. It has the RCODE "NOERROR".
      2. It has no OPT record.
   6. Else, if the DNS response meet the following criteria,
      then output *[BROKEN_EDNS_SUPPORT]* and go to next server.
      1. It has the RCODE "NOERROR".
      2. It has OPT record with EDNS version other than 0.
   7. Else output *[NS_ERROR]* (i.e. other erroneous or unexpected 
      response).

## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

The outcome of this Test case is "pass" in all other cases.

Message                           | Default severity level (when message is outputted)
:---------------------------------|:-----------------------------------
NO_RESPONSE                       | WARNING
NO_EDNS_SUPPORT                   | WARNING
BROKEN_EDNS_SUPPORT               | ERROR
NS_ERROR                          | WARNING

## Special procedural requirements	

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol and log a message reporting
the ignored result.

## Intercase dependencies

None

[RFC 6891]: https://tools.ietf.org/html/rfc6891
[RFC 6891, section 7]: https://tools.ietf.org/html/rfc6891#section-7
[RFC 6891, section 6.1.1]: https://tools.ietf.org/html/rfc6891#section-6.1.1
[Method4]: ../Methods.md#method-4-delegation-name-server-addresses
[Method5]: ../Methods.md#method-5-in-zone-addresses-records-of-name-servers
[NO_RESPONSE]: #outcomes
[NO_EDNS_SUPPORT]: #outcomes
[BROKEN_EDNS_SUPPORT]: #outcomes
[NS_ERROR]: #outcomes

