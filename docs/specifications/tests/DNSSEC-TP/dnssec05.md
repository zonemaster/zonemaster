# DNSSEC05: Check for invalid DNSKEY algorithms

## Test case identifier
**DNSSEC05**

## Objective

A domain name (zone) should only use DNSKEY algorithms that are specified 
by IANA to be used for a DNSKEY. A public domain name (zone) should not
use private algorithms. The IANA registry of [DNSSEC Algorithm Numbers]
specifies which algorithms to use.

The DNSKEY record is defined in [RFC 4034, section 2].

## Inputs

* The domain name to be tested ("Child Zone").

## Ordered description of steps to be taken to execute the test case

1. Create a DNSKEY query with DO flag set for the apex of the 
   *Child Zone*.

2. Retrieve all name server IP addresses for the
   *Child Zone* using [Method4] and [Method5].

3. Repeat the following steps for each name server IP address:

   1. Send the DNSKEY query over UDP.
   2. If no DNS response is returned, then emit *[NO_RESPONSE]*.
   3. If the DNS response does not contain an DNSKEY RRset,
      then emit *[NO_RESPONSE_DNSKEY]*.
   4. Extract the algorithm numbers from each DNSKEY record and
      compare the extracted algorithm number to the IANA
      [DNSSEC Algorithm Numbers] registry.
      1. If the algorithm is classified as "deprecated" (algorithm 
         1), emit *[ALGORITHM_DEPRECATED]*.
      2. If the algorithm is classified as "reserved" (algorithm 
         4, 9, 11, 123-251 or 255), emit *[ALGORITHM_RESERVED]*.
      3. If the algorithm is classified as "unassigned" (algorithm
         17-122), emit *[ALGORITHM_UNASSIGNED]*.
      4. If the algorithm is classified as "private algorithm"
         (algorithm 253 or 254), emit *[ALGORITHM_PRIVATE]*.
      5. If the algorithm is classified as "delete DS" (algorithm
         0), emit *[ALGORITHM_DELETE_DS]*.
      6. If the algorithm is classified as "indirect key" (algoritm
         252), emit *[ALGORITHM_INDIRECT_KEY]*.
      7. If the algorithm is not meant for zone signing (algorithm
         0-2, 4, 9, 11, 17-252 or 255), emit 
         *[ALGORITHM_NOT_ZONE_SIGN]*.
      8. If no message has been emitted for the DNSKEY, emit 
         *[ALGORITHM_OK]*.

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
NO_RESPONSE_DNSKEY            | WARNING
ALGORITHM_DEPRECATED          | WARNING
ALGORITHM_RESERVED            | ERROR
ALGORITHM_UNASSIGNED          | ERROR
ALGORITHM_PRIVATE             | WARNING
ALGORITHM_NOT_ZONE_SIGN       | WARNING
ALGORITHM_DELETE_DS           | WARNING
ALGORITHM_INDIRECT_KEY        | WARNING
ALGORITHM_OK                  | INFO


## Special procedural requirements

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
on the ignored result.

See the [DNSSEC README] document about DNSSEC algorithms.

The test case is only performed if some DNSKEY record is found in the
*Child Zone*.


## Intercase dependencies

None.


[Method4]: ../Methods.md#method-4-obtain-glue-address-records-from-parent

[Method5]: ../Methods.md#method-5-obtain-the-name-server-address-records-from-child

[DNSSEC Algorithm Numbers]: https://www.iana.org/assignments/dns-sec-alg-numbers/dns-sec-alg-numbers.xml

[RFC 4034, section 2]: https://tools.ietf.org/html/rfc4034#section-2

[DNSSEC README]: ./README.md

[NO_RESPONSE]: #outcomes

[NO_RESPONSE_DNSKEY]: #outcomes

[ALGORITHM_DEPRECATED]: #outcomes

[ALGORITHM_RESERVED]: #outcomes

[ALGORITHM_UNASSIGNED]: #outcomes

[ALGORITHM_PRIVATE]: #outcomes

[ALGORITHM_NOT_ZONE_SIGN]: #outcomes

[ALGORITHM_DELETE_DS]: #outcomes

[ALGORITHM_INDIRECT_KEY]: #outcomes

[ALGORITHM_OK]: #outcomes

