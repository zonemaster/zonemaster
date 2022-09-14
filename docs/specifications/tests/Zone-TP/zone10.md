# ZONE10: No multiple SOA records


## Test case identifier
**ZONE10**


## Objective

The SOA record is crucial for the DNS zone and "exactly one SOA RR should
be present at the top of the zone" ([RFC 1035][RFC 1035#5.2], section 5.2).
This test case will verify that the zone of the domain to be tested return
exactly one SOA record.


## Scope

It is assumed that *Child Zone* is also tested by [Connectivity01]. This test
case will set DEBUG level on messages for non-responsive name servers.


## Inputs

* "Child Zone" - The domain name to be tested.


## Ordered description of steps to be taken to execute the test case

1. Obtain the set of name server IP addresses using [Method4] and [Method5]
   ("NS IP").

2. Create a SOA query for the apex of the *Child Zone* with RD flag unset.

3. For each name server in *NS IP* do:
   1. Send the SOA query over UDP to the name server.
   2. If the name server does not respond with a DNS response, then
      output *[NO_RESPONSE]*.
   3. Else, if the DNS response does not include a SOA record in the
      answer section, then output *[NO_SOA_IN_RESPONSE]*.
   4. Else, if the SOA record or records in the answer section do not
      have *Child Zone* as owner name, then output *[WRONG_SOA]*.
   5. Else, if the DNS response includes multiple SOA records in the
      answer section, then output *[MULTIPLE_SOA]*.

4. If no message is outputted for any server, then output *[ONE_SOA]*.


## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

In other cases the outcome of this Test Case is "pass".

Message                       | Default severity level
:-----------------------------|:-----------------------------------
MULTIPLE_SOA                  | ERROR
NO_RESPONSE                   | DEBUG
NO_SOA_IN_RESPONSE            | DEBUG
ONE_SOA                       | INFO
WRONG_SOA                     | DEBUG


## Special procedural requirements

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
on the ignored result.


## Intercase dependencies

None.


## Terminology

When the term "using Method" is used, names and IP addresses are fetched
using the defined [Methods].

The term "send" (to an IP address) is used when a DNS query is sent to
a specific name server.


[Connectivity01]:            ../Connectivity-TP/connectivity01.md
[MULTIPLE_SOA]:              #outcomes
[Method4]:                   ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                   ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[Methods]:                   ../Methods.md
[NO_RESPONSE]:               #outcomes
[NO_SOA_IN_RESPONSE]:        #outcomes
[ONE_SOA]:                   #outcomes
[RFC 1035#5.2]:              https://tools.ietf.org/html/rfc1035#section-5.2
[WRONG_SOA]:                 #outcomes
[terminology]:               #terminology

