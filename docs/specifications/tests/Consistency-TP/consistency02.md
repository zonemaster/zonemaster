# CONSISTENCY02: SOA RNAME consistency

## Test case identifier

**CONSISTENCY02**

## Objective

All authoritative name servers must serve the same SOA record (section
4.2.1) of [RFC 1034] for the
tested domain. As per section 3.3.13 of [RFC 1035]
the RNAME field in the SOA RDATA refers to the administrative contact. The inconsistency in
the administrative contact for the a domain might result in operational
failures being informed to different persons.

The objective of this test is to verify that the administrative contact is
consistent between different authoritative name servers.

## Inputs

* The domain name to be tested ("child zone")

## Ordered description of steps to be taken to execute the test case

 1. Obtain the list of name server IPs for the *child zone* from [Method4] 
    and [Method5].
 2. Create an SOA query for *child zone* apex and send it to all name 
    server IPs.
 3. Retrieve the SOA RR from the responses from all name server IPs.
 4. If a name server does not respond, emit *[NO_RESPONSE]*.
 5. If a name server responds but does not include a SOA record 
    in the response, emit *[NO_RESPONSE_SOA_QUERY]*.
 6. If at least one SOA record has been retrieved and RNAME is 
    identical in all SOA records emit *[ONE_SOA_RNAME]*.
 7. If RNAME is not identical in all SOA records emit 
    *[MULTIPLE_SOA_RNAMES]*.

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
NO_RESPONSE_SOA_QUERY         | DEBUG
ONE_SOA_RNAME                 | INFO
MULTIPLE_SOA_RNAMES           | NOTICE


## Special procedural requirements	

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
on the ignored result.

## Intercase dependencies

None


[RFC 1034]: https://tools.ietf.org/html/rfc1035

[RFC 1035]: https://tools.ietf.org/html/rfc1035

[RFC 1982]: https://tools.ietf.org/html/rfc1982 

[Method4]: ../Methods.md#method-4-obtain-glue-address-records-from-parent

[Method5]: ../Methods.md#method-5-obtain-the-name-server-address-records-from-child

[NO_RESPONSE]: #outcomes
[NO_RESPONSE_SOA_QUERY]: #outcomes
[ONE_SOA_RNAME]: #outcomes
[MULTIPLE_SOA_RNAMES]: #outcomes

