# DNSSEC14: Check for valid RSA DNSKEY key size

## Test case identifier
**DNSSEC14**

## Objective

The DNSKEYs based on RSA have different minimum and maximum key sizes,
which must be followed. This test case will validate the keys size of 
such keys. RSA based algorithms that are deprecated or else not suitable 
for DNSKEY ([RFC 8624] and [IANA registry]) are just ignored. See test 
case [DNSSEC05] for test of algorithm.

The table 1 below specify the maximum and minimum key size, 
respectively. Algorithm number can be found in [IANA registry].

Table 1: Minimum and maximum RSA key sizes in bits

Algorithm | Min size  | Max size | Reference
:---------|:----------|:---------|:----------------
5         | 512       | 4096     | [RFC 3110]
7         | 512       | 4096     | [RFC 5155]
8         | 512       | 4096     | [RFC 5702]
10        | 1024      | 4096     | [RFC 5702]

It is also recommended that an RSA based algorithm has a key length 
of at least 2048 bit as stated in [NIST SP 800-57 Part 1 Rev. 4],
table 2 on page 53 in section 5.6.1 and table 4 on page 55 in 
section 5.6.2.

This test case verifies that RSA DNSKEYs follows the stated key lengths
from the RFCs and also the NIST recommended shortest key length.

## Scope

It is assumed that *Child Zone* is also tested by [Connectivity01]. This test
case will set DEBUG level on messages for non-responsive name servers.

## Inputs

* "Child Zone" - The domain name to be tested. 
* "Key Size Table" - The table above. 

## Ordered description of steps to be taken to execute the test case

1. Create a DNSKEY query with DO flag set for the apex of the
   *Child Zone*.

2. Retrieve all name server IP addresses for the
   *Child Zone* using [Method4] and [Method5] ("NS IP").

3. Create an empty set "DNSKEY RRs".

4. For each name server IP address in *NS IP* do:

   1. Send the DNSKEY query over UDP.
   2. If no DNS response is returned, then output *[NO_RESPONSE]*.
   3. Else, if the DNS response does not contain an DNSKEY RRset,
      then output *[NO_RESPONSE_DNSKEY]*.
   4. Else, retrieve the DNSKEY RRs and add them to *DNSKEY RRs*.

5. For each DNSKEY from the *DNSKEY RRs* do:
   1. If the algorithm of the DNSKEY is not listed in *Key Size 
      Table*, go to next DNSKEY.
   2. Else, if the algorithm is listed in *Key Size Table* and the
      key size is smaller than specified, then output 
      *[DNSKEY_TOO_SMALL_FOR_ALGO]*.
   3. Else, if the algorithm is listed in *Key Size Table* and the
      key size is smaller than 2048 bits, then output
      *[DNSKEY_SMALLER_THAN_REC]*.
   3. Else, if the algorithm is listed in *Key Size Table* and the
      key size is larger than specified, then output 
      *[DNSKEY_TOO_LARGE_FOR_ALGO]*.

6. If *DNSKEY RRs* is non-empty and no messages, except for any
   *[NO_RESPONSE]*, has been outputted, then output 
   *[KEY_SIZE_OK]*.      


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
DNSKEY_SMALLER_THAN_REC       | WARNING
DNSKEY_TOO_SMALL_FOR_ALGO     | ERROR
DNSKEY_TOO_LARGE_FOR_ALGO     | ERROR
KEY_SIZE_OK                   | INFO


## Special procedural requirements

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
on the ignored result.

See the [DNSSEC README] document about DNSSEC algorithms.

The test case is only performed if some DNSKEY record is found in the
*Child Zone*.


## Intercase dependencies

None.

[Connectivity01]:                                        ../Connectivity-TP/connectivity01.md
[DNSKEY_SMALLER_THAN_REC]:                               #outcomes
[DNSKEY_TOO_LARGE_FOR_ALGO]:                             #outcomes
[DNSKEY_TOO_SMALL_FOR_ALGO]:                             #outcomes
[DNSSEC README]:                                         ./README.md
[DNSSEC05]:                                              ./dnssec05.md
[IANA registry]:                                         https://www.iana.org/assignments/dns-sec-alg-numbers/dns-sec-alg-numbers.xml
[KEY_SIZE_OK]:                                           #outcomes
[Method4]:                                               ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                                               ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[NIST SP 800-57 Part 1 Rev. 4]:                          https://csrc.nist.gov/publications/detail/sp/800-57-part-1/rev-4/archive/2016-01-28
[NO_RESPONSE]:                                           #outcomes
[NO_RESPONSE_DNSKEY]:                                    #outcomes
[RFC 3110]:                                              https://datatracker.ietf.org/doc/html/rfc3110
[RFC 5155]:                                              https://datatracker.ietf.org/doc/html/rfc5155
[RFC 5702]:                                              https://datatracker.ietf.org/doc/html/rfc5702#section-2
[RFC 8624]:                                              https://www.rfc-editor.org/rfc/rfc8624.html#section-3.1
[Recommendation for key Management, part 1, revision 4]: https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-57pt1r4.pdf

