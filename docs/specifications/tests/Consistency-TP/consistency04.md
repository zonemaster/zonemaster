# CONSISTENCY04: Name server NS consistency

## Test case identifier

**CONSISTENCY04**

## Objective

All authoritative name servers must serve the same NS record set
for the tested domain, child zone ([RFC 1034], section 4.2.2).
Any inconsistency of NS records described in [RFC 1035], 
section 3.3.11, might result in operational failures.

The objective of this test is to verify that the NS records are
consistent between all authoritative name servers of the child zone.

Two NS RR sets are considered to be equal if both sets have the 
same number of NS records, and for each NS record in one of the 
sets there is exactly one NS record with identical owner name, 
class, TTL and RDATA in the other NS set.

## Inputs

* The domain name to be tested ("Child Zone").

## Ordered description of steps to be taken to execute the test case

1. Obtain the set of name server IPs for the *Child Zone* using
   [Method4] and [Method5]. 

2. Create an NS query for the apex of the *Child Zone*.

3. Send the NS query to each of the retrieved name server IPs.

4. If a name server IP does not respond emit *[NO_RESPONSE]*.

5. If the response from a name server IP does not include an 
   NS RR set for the *Child Zone* with the AA flag set emit 
   *[NO_RESPONSE_NS_QUERY]*.

6. If all retreived NS RR sets are equal emit *[ONE_NS_SET]* 
   else emit *[MULTIPLE_NS_SET]*.


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
NO_RESPONSE_NS_QUERY          | WARNING
ONE_NS_SET                    | INFO
MULTIPLE_NS_SET               | NOTICE


## Special procedural requirements	

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
on the ignored result.


## Intercase dependencies

None


[RFC 1034]: https://tools.ietf.org/html/rfc1034

[RFC 1035]: https://tools.ietf.org/html/rfc1035

[Method4]:  ../Methods.md#method-4-obtain-glue-address-records-from-parent

[Method5]:  ../Methods.md#method-5-obtain-the-name-server-address-records-from-child

[NO_RESPONSE]: #outcomes

[NO_RESPONSE_NS_QUERY]: #outcomes

[ONE_NS_SET]: #outcomes

[MULTIPLE_NS_SET]: #outcomes
