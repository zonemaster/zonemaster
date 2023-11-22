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

The table of algorithms below is copied from [IANA registry]. Only the first
three columns are copied. The complete table is available at [IANA registry].
In the table below, however, mnemonic is defined when undefined in the IANA table.

Algorithm no | Algorithm (or description)    | Mnemonic          | Note
:------------|:------------------------------|:------------------|:----
0            | Delete DS                     | DELETE            |
1            | RSA/MD5                       | RSAMD5            |
2            | Diffie-Hellman                | DH                |
3            | DSA/SHA1                      | DSA               |
4            | Reserved                      | RESERVED          | (1)
5            | RSA/SHA-1                     | RSASHA1           |
6            | DSA-NSEC3-SHA1                | DSA-NSEC3-SHA1    |
7            | RSASHA1-NSEC3-SHA1            | RSASHA1-NSEC3-SHA1|
8            | RSA/SHA-256                   | RSASHA256         |
9            | Reserved                      | RESERVED          | (1)
10           | RSA/SHA-512                   | RSASHA512         |
11           | Reserved                      | RESERVED          | (1)
12           | GOST R 34.10-2001             | ECC-GOST          |
13           | ECDSA Curve P-256 with SHA-256| ECDSAP256SHA256   |
14           | ECDSA Curve P-384 with SHA-384| ECDSAP384SHA384   |
15           | Ed25519                       | ED25519           |
16           | Ed448                         | ED448             |
17-122       | Unassigned                    | UNASSIGNED        | (1)
123-251      | Reserved                      | RESERVED          | (1)
252          | Reserved for Indirect Keys    | INDIRECT          |
253          | private algorithm             | PRIVATEDNS        |
254          | private algorithm OID         | PRIVATEOID        |
255          | Reserved                      | RESERVED          | (1)

(1) Mnemonic defined for Zonemaster usage when undefined in the IANA table.


## Scope

It is assumed that *Child Zone* is also tested by [Connectivity01]. This test
case will set DEBUG level on messages for non-responsive name servers.

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
         4, 9, 11, 123-251 or 255), output *[ALGORITHM_RESERVED]*.
      3. If the algorithm is unassigned (algorithm
         17-122), output *[ALGORITHM_UNASSIGNED]*.
      4. If the algorithm is private algorithm
         (algorithm 253-254), output *[ALGORITHM_PRIVATE]*.
      5. If the algorithm is not meant for zone signing (algorithm
         0, 2 or 252), output *[ALGORITHM_NOT_ZONE_SIGN]*.
      6. If the algorithm is not rekommended for zone signing (algorithm
         5, 7 or 10), output *[ALGORITHM_NOT_RECOMMENDED]*.
      7. If no message has been outputted for the DNSKEY (i.e. algorithm
         8, 13, 14, 15 or 16), output *[ALGORITHM_OK]*.

## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

In other cases the outcome of this Test Case is "pass".

Message                       | Default severity level
:-----------------------------|:-----------------------------------
NO_RESPONSE                   | DEBUG
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

[Connectivity01]:        ../Connectivity-TP/connectivity01.md
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

