# NAMESERVER01: A name server should not be a recursor

## Test case identifier
**NAMESERVER01**

## Objective

To ensure consistency in DNS, an authoritative name server should not be
configured to do recursive lookups. Also, open recursive resolvers are
considered bad internet practice due to their capability of assisting in
large scale DDoS attacks. The introduction to [RFC 5358]
elaborates on mixing recursor and
authoritative functionality, and the issue is further elaborated by
[D.J. Bernstein].

Section 2.5 of [RFC 2870] have very
specific requirement on disabling recursion functionality on root name
servers.

## Inputs

* The domain name to be tested ("Child Zone").

## Ordered description of steps to be taken to execute the test case

1. Create A queries for the following domain names, or other almost 
   certainly nonexistent name under different TLDs, with the RD flag
   set (the names are chosen to violate the IDNA 2008 standard):
   1. xn--nameservertest.iis.se
   2. xn--nameservertest.icann.org
   3. xn--nameservertest.ripe.net

2. Retrieve all address records for all the name servers using 
   [Method4] and [Method5].

3. Repeat the following steps for each retrieved name server IP.

3. Send the three A queries over UDP.

4. If the name server does not respond with a to a query with a DNS
   response, then emit *[NO_RESPONSE]*.

5. If the name server sends a response with the RA flag set, then 
   emit *[IS_A_RECURSOR]*.

6. If the server responds with the RCODE NXDOMAIN in all DNS 
   responses then emit *[IS_A_RECURSOR]*.

7. If no message has been emitted for the server, then emit 
   *[NO_RECURSOR]*.

## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

In other cases the outcome of this Test Case is "pass".

Message                       | Default severity level (if message is emitted)
:-----------------------------|:-----------------------------------
NO_RESPONSE                   | WARNING
IS_A_RECURSOR                 | ERROR
NO_RECURSOR                   | INFO

## Special procedural requirements

None.

## Intercase dependencies

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
on the ignored result.


[RFC 5358]: https://tools.ietf.org/html/rfc5358

[D.J. Bernstein]: http://cr.yp.to/djbdns/separation.html

[RFC 2870]: https://tools.ietf.org/html/rfc2870

[Method4]: #method-4-delegation-name-server-addresses

[Method5]: #method-5-in-zone-addresses-records-of-name-servers

[NO_RESPONSE]: #outcomes

[IS_A_RECURSOR]: #outcomes

[NO_RECURSOR]: #outcomes

