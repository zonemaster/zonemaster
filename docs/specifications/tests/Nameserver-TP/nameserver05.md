# NAMESERVER05: Behaviour against AAAA query

## Test case identifier
**NAMESERVER05**

## Objective

Older implementations of authoritative name servers have shown different
misbehaviours trying to answer queries for AAAA records, as described in
[RFC 4074]. This test case is intended to find out if the name server
authoritative for the domain shows any of these behaviours.


## Inputs

* "Child Zone" - The domain name to be tested.


## Ordered description of steps to be taken to execute the test case

1. Create an A query for the apex of the *Child Zone*.

2. Create a AAAA query for the apex of the *Child Zone*.

3. Create an empty set "AAAA OK".

4. Retrieve all name server IP addresses for the
   *Child Zone* using [Method4] and [Method5] ("NS IP").

5. For each name server IP address in *NS IP* do:

   1. Send the A query over UDP to the name server IP.
   2. If no DNS response is returned, then output *[NO_RESPONSE]*.
   3. Else, if DNS response does not have RCODE NOERROR, then output 
      *[A_UNEXPECTED_RCODE]*.
   4. Else, do:
      1. Send the AAAA query over UDP to the name server IP.
      2. If no DNS response is returned, then output *[AAAA_QUERY_DROPPED]*.
      3. Else, if the RCODE of the response is not NOERROR, then output
         *[AAAA_UNEXPECTED_RCODE]*.
      4. Else, if the answer section contains an AAAA record with incorrect
         RDATA lenght (e.g. 4 instead of 16 octets), then output
         *[AAAA_BAD_RDATA]*.
      5. Else, add the name server IP to *AAAA OK*.

6. If *AAAA OK* is non-empty and no messages *[AAAA_QUERY_DROPPED]*,
   *[AAAA_UNEXPECTED_RCODE]* or *[AAAA_BAD_RDATA]* have been outputted for any
   name server IP, then output *[AAAA_WELL_PROCESSED]*.


## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

In other cases the outcome of this Test Case is "pass".

Message                       | Default severity level
:-----------------------------|:-----------------------------------
AAAA_BAD_RDATA                | ERROR
AAAA_QUERY_DROPPED            | ERROR
AAAA_UNEXPECTED_RCODE         | ERROR
AAAA_WELL_PROCESSED           | INFO
A_UNEXPECTED_RCODE            | WARNING
NO_RESPONSE                   | WARNING


## Special procedural requirements

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
on the ignored result.


## Intercase dependencies

None.


[AAAA_BAD_RDATA]:        #outcomes
[AAAA_QUERY_DROPPED]:    #outcomes
[AAAA_UNEXPECTED_RCODE]: #outcomes
[AAAA_WELL_PROCESSED]:   #outcomes
[A_UNEXPECTED_RCODE]:    #outcomes
[Method4]:               ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:               ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[NO_RESPONSE]:           #outcomes
[RFC 4074]:              https://tools.ietf.org/html/rfc4074




