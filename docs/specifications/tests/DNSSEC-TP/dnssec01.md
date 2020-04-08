# DNSSEC01: Legal values for the DS hash digest algorithm

## Test case identifier
**DNSSEC01**

## Objective

The list of allowed Digest Algorithms in a DS record published by
the parent is specified by [RFC 8624], section 3.3, and is published
in the [IANA registry] of *DS RR Type Digest Algoritms*. No DS
Digest Algorithm values, other than those specified in the RFC and
allocated by IANA, should be used in public DNS.

If [RFC 8624] and the [IANA registry] disagree on the same DS digest
algorithm, the RFC takes precedence until the registry has a been
updated with a reference to the RFC.

At the time of writing (2020-04-08), algorithm 1 (SHA-1) is still
in wide use even though it is no longer considered to be secure
([Wikipedia]).

The table of algorithms below is for reference only and is copied from [IANA
registry]. It is here to make it easier to read the steps when symbolic
names are given. This is only an excerpt from the table. The full table is
available at [IANA registry].

Algorithm number | Algorithm (or description)
:----------------|:-----------------------------------
0                | (Reserved)
1                | SHA-1
2                | SHA-256
3                | GOST R 34.11-94
4                | SHA-384
5-255            | (Unassigned)

## Inputs

* "Child Zone" - The domain name to be tested.
* "Algorithm Status" - The status of all DS digest algorithms from
  [RFC 8624] and the [IANA registry].
* "Test Type" - The test type with value "undelegated" or "normal".

* "Undelegated DS" - The DS record or records submitted
  (only if *Test Type* is undelegated).

## Ordered description of steps to be taken to execute the test case

1. If the *Test Type* is "undelegated, then:

   1. For each *Undelegated DS* do:
      1. Compare the DS algorithm value with *Algorithm Status*.
      2. If the algortithm value is 0 then output
         *[DS_ALGORITHM_NOT_DS]*.
      3. If algortithm value is 1 then output
         *[DS_ALGO_SHA1_DEPRECATED]*.
      4. If algortithm value is 3 then output
         *[DS_ALGORITHM_DEPRECATED]*.
      5. If algortithm value is 5-255 then output
         *[DS_ALGORITHM_RESERVED]*.
      6. If no message has been outputted for the DS, then
         output *[DS_ALGORITHM_OK]*.
   2. If *Undelegated DS* has at least one DS but none with
      algorithm value 2 output *[DS_ALGORITHM_MISSING]*.
   3. End the steps.

2. Create a DS query with DO flag set for the name of the
   *Child Zone* (*Test Type* is "normal").

3. Retrieve all name server IP addresses for the parent zone of
   *Child Zone* using [Method1] ("Parent NS IP").

4. For each IP address in *Parent NS IP* do:
   1. Send the DS query over UDP and collect the response.
   2. If there is no DNS response, then output *[NO_RESPONSE_DS]*.
   3. Else, if the RCODE is not NOERROR, then output
      *[UNEXPECTED_RESPONSE_DS]*.
   4. Else, go to next IP address if there is no DS in the
      response.
   5. Else, extract all DS records from the DNS response
      ("DS Records").
   6. For each DS in *DS Records*, do:
      1. Compare the DS algorithm value with *Algorithm Status*.
      2. If the algortithm value is 0 then output
         *[DS_ALGORITHM_NOT_DS]*.
      3. If algortithm value is 1 then output
         *[DS_ALGO_SHA1_DEPRECATED]*.
      4. If algortithm value is 3 then output
         *[DS_ALGORITHM_DEPRECATED]*.
      5. If algortithm value is 5-255 then output
         output *[DS_ALGORITHM_RESERVED]*.
      6. If no message has been outputted for the DS, then
         output *[DS_ALGORITHM_OK]*.
   7. If there was no DS with algorithm value 2 output
      *[DS_ALGORITHM_MISSING]*.


## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

In other cases the outcome of this Test Case is "pass".

Message                       | Default severity level
:-----------------------------|:-----------------------------------
DS_ALGORITHM_DEPRECATED       | ERROR
DS_ALGORITHM_MISSING          | NOTICE
DS_ALGORITHM_NOT_DS           | ERROR
DS_ALGORITHM_OK               | INFO
DS_ALGORITHM_RESERVED         | ERROR
DS_ALGO_SHA1_DEPRECATED       | WARNING
NO_RESPONSE_DS                | WARNING
UNEXPECTED_RESPONSE_DS        | WARNING

## Special procedural requirements

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
on the ignored result.

See the [DNSSEC README] document about DNSSEC algorithms.

Test case is only performed if DS records are found.

## Intercase dependencies

None.

[DNSSEC README]:               ./README.md
[DS_ALGORITHM_DEPRECATED]:     #outcomes
[DS_ALGORITHM_MISSING]:        #outcomes
[DS_ALGORITHM_NOT_DS]:         #outcomes
[DS_ALGORITHM_OK]:             #outcomes
[DS_ALGORITHM_RESERVED]:       #outcomes
[DS_ALGO_SHA1_DEPRECATED]:     #outcomes
[IANA registry]:               https://www.iana.org/assignments/ds-rr-types/ds-rr-types.xml
[Method1]:                     ../Methods.md#method-1-obtain-the-parent-domain
[NO_RESPONSE_DS]:              #outcomes
[RFC 8624]:                    https://tools.ietf.org/html/rfc8624#section-3.3
[UNEXPECTED_RESPONSE_DS]:      #outcomes
[Wikipedia]:                   https://en.wikipedia.org/wiki/SHA-1
