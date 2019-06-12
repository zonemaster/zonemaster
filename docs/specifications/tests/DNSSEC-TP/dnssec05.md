# DNSSEC05: Check for invalid DNSKEY algorithms

## Test case identifier
**DNSSEC05**

## Objective

A domain name (zone) should only use DNSKEY algorithms that are specified
by [RFC 8624], section 3.1 and the [IANA registry] of *DNSSEC Algorithm
Numbers* to be used for DNSSEC signing. A public domain name (zone) should not use
private algorithms.

If [RFC 8624] and [IANA registry] disagree on the same algorithm, the
RFC takes precedence until the registry has a been updated with a
reference to the RFC.

## Inputs

* The domain name to be tested ("Child Zone").
* The status of all algorithms from [RFC 8624] and [IANA registry]
  ("Algorithm Status").

## Ordered description of steps to be taken to execute the test case

1. Create a DNSKEY query with DO flag set for the apex of the
   *Child Zone*.

2. Retrieve all name server IP addresses for the
   *Child Zone* using [Method4] and [Method5].

3. Repeat the following steps for each name server IP address:

   1. Send the DNSKEY query over UDP.
   2. If no DNS response is returned, then output *[NO_RESPONSE]*.
   3. Else if the DNS response does not contain an DNSKEY RRset,
      then output *[NO_RESPONSE_DNSKEY]*.
   4. Else extract the algorithm numbers from each DNSKEY record and
      compare the algorithm number to *Algorithm Status*.
      1. If the algorithm is deprecated (algorithm 1, 3, 6 or 12)
         output *[ALGORITHM_DEPRECATED]*.
      2. If the algorithm is reserved (algorithm
         4, 9, 11, 123-252 or 255), output *[ALGORITHM_RESERVED]*.
      3. If the algorithm is unassigned (algorithm
         17-122), output *[ALGORITHM_UNASSIGNED]*.
      4. If the algorithm is private algorithm
         (algorithm 253-254), output *[ALGORITHM_PRIVATE]*.
      5. If the algorithm is not meant for zone signing (algorithm
         0-2), output *[ALGORITHM_NOT_ZONE_SIGN]*.
      6. If the algorithm is not rekommended for zone signing (algorithm
         5, 7 or 10), output *[ALGORITHM_NOT_RECOMMENDED]*.
      7. If no message has been outputted for the DNSKEY, output 
         *[ALGORITHM_OK]*.

## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

In other cases the outcome of this Test Case is "pass".

Message                       | Default severity level
:-----------------------------|:-----------------------------------
NO_RESPONSE                   | WARNING
NO_RESPONSE_DNSKEY            | WARNING
ALGORITHM_DEPRECATED          | ERROR
ALGORITHM_RESERVED            | ERROR
ALGORITHM_UNASSIGNED          | ERROR
ALGORITHM_NOT_RECOMMENDED     | WARNING
ALGORITHM_PRIVATE             | ERROR
ALGORITHM_NOT_ZONE_SIGN       | ERROR
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

[RFC 8624]: https://www.rfc-editor.org/rfc/rfc8624.html#section-3.1
[IANA registry]: https://www.iana.org/assignments/dns-sec-alg-numbers/dns-sec-alg-numbers.xml

[Method4]: ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]: ../Methods.md#method-5-obtain-the-name-server-address-records-from-child

[DNSSEC README]: ./README.md
[NO_RESPONSE]: #outcomes
[NO_RESPONSE_DNSKEY]: #outcomes
[ALGORITHM_DEPRECATED]: #outcomes
[ALGORITHM_RESERVED]: #outcomes
[ALGORITHM_UNASSIGNED]: #outcomes
[ALGORITHM_NOT_RECOMMENDED]: #outcomes
[ALGORITHM_PRIVATE]: #outcomes
[ALGORITHM_NOT_ZONE_SIGN]: #outcomes
[ALGORITHM_OK]: #outcomes

