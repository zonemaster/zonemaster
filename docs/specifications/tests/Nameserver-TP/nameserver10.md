# NAMESERVER10: Test for undefined EDNS version

## Test case identifier

**Nameserver10**

## Objective

EDNS is a mechanism to announce capabilities of a DNS implementation,
and is now basically required by any new functionality in DNS such as
DNSSEC ([RFC 6891]).

[RFC 6891, section 6.1.3] states that if a nameserver has implemented 
EDNS but has not implemented the version level of the request, then it 
MUST respond with RCODE "BADVERS". Only version "0" has been defined for
EDNS.

## Inputs

* "Child Zone" - The domain name to be tested.

## Ordered description of steps to be taken to execute the test case

1. Created an SOA query for the *Child Zone* with an OPT record with 
   ENDS version set to "1" and no other ENDS options or flags.

2. Obtain the set of name server IP addresses using [Method4] and [Method5]
   ("Name Server IP").

3. For each name server in *Name Server IP* do:

   1. Send the SOA query to the name server and collect the response.
   2. If there is no DNS response, output *[NO_RESPONSE]* and go to
      next server.
   3. If the DNS response has the RCODE "FORMERR" then output
      *[NO_EDNS_SUPPORT]*.
   4. Else, if the DNS response has the RCODE "NOERROR" or "NXDOMAIN"
      output *[BAD_UNSUPPORTED_VER]*.
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
NO_RESPONSE                       | WARNING
NO_EDNS_SUPPORT                   | NOTICE
BAD_UNSUPPORTED_VER               | WARNING
NS_ERROR                          | WARNING

## Special procedural requirements	

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol and log a message reporting
the ignored result.

## Intercase dependencies

None


[RFC 6891]: https://tools.ietf.org/html/rfc6891
[RFC 6891, section 6.1.3]: https://tools.ietf.org/html/rfc6891#section-6.1.3
[Method4]: ../Methods.md#method-4-delegation-name-server-addresses
[Method5]: ../Methods.md#method-5-in-zone-addresses-records-of-name-servers
[NO_RESPONSE]: #outcomes
[NO_EDNS_SUPPORT]: #outcomes
[BAD_UNSUPPORTED_VER]: #outcomes
[NS_ERROR]: #outcomes

