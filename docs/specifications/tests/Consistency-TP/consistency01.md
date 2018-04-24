# CONSISTENCY01: SOA serial number consistency

## Test case identifier

**CONSISTENCY01**

## Objective

For the data served by the authoritative name servers for a designated zone
to be consistent, all authoritative name servers must serve the same SOA
record for the designated zone.   

If the serial number (explained in 3.3.13. of [RFC 1035]), 
which is part of the SOA record, is not consistent between authoritative servers, 
there is a possibility that the data served is inconsistent. The reasons for this 
inconsistency may be different - such as misconfiguration, or as a result of slow 
propagation to the secondary name servers.

The objective of this test is to verify that the serial number is consistent
between different authoritative name servers.

For reference purposes : [RFC 1982]
explains the serial number arithmetic, and section 4.3.5 of 
[RFC 1034] explains the importance of
serial number consistency.

## Inputs

* The domain name to be tested ("child zone")
* Accepted SOA serial difference, default 0 ("accepted serial difference")

## Ordered description of steps to be taken to execute the test case

 1. Obtain the list of name server IPs for the *child zone* from [Method4] 
    and [Method5].
 2. Create an SOA query for *child zone* apex and send it to all name 
    server IPs.
 3. Retrieve the SOA RR from the responses from all name server IPs.
 4. If a name server does not respond, emit *[NO_RESPONSE]*.
 5. If a name server does not include a SOA record in the response,
    emit *[NO_RESPONSE_SOA_QUERY]*.
 6. If all serial numbers are identical, emit *[ONE_SOA_SERIAL]* and stop
    processing these steps.
 7. If at least two serial numbers are different:
    1. Order the serial number values from smallest to largest following
       the arithmetic for serial number.
       If there is not a single, uniquely defined order of the serial 
       numbers, emit *[SOA_SERIAL_VARIATION]* and *[MULTIPLE_SOA_SERIALS]*, 
       and end processing these steps.
    2. If the difference between the first and the last serial number
       is larger than *accepted serial difference*, using arithemtic
       for serial number, emit *[SOA_SERIAL_VARIATION]* and 
       *[MULTIPLE_SOA_SERIALS]*, and end processing these steps.
    3. Emit *[MULTIPLE_SOA_SERIALS_OK]*.


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
ONE_SOA_SERIAL                | INFO
MULTIPLE_SOA_SERIALS          | WARNING
MULTIPLE_SOA_SERIALS_OK       | NOTICE
SOA_SERIAL                    | INFO
SOA_SERIAL_VARIATION          | NOTICE


## Special procedural requirements	

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
on the ignored result.

A manual inspection of the SOA serial may be needed to determine if the zone
updates work properly or not, and if the serial values are within a
reasonable range, then the test is OK.

When comparing SOA serial it must be done using the aritmetic defined in
[RFC 1982].


## Intercase dependencies

None

[RFC 1034]: https://tools.ietf.org/html/rfc1035

[RFC 1035]: https://tools.ietf.org/html/rfc1035

[RFC 1982]: https://tools.ietf.org/html/rfc1982 

[Method4]: ../Methods.md#method-4-obtain-glue-address-records-from-parent

[Method5]: ../Methods.md#method-5-obtain-the-name-server-address-records-from-child

[NO_RESPONSE]: #outcomes
[NO_RESPONSE_SOA_QUERY]: #outcomes
[ONE_SOA_SERIAL]: #outcomes
[MULTIPLE_SOA_SERIALS]: #outcomes
[MULTIPLE_SOA_SERIALS_OK]: #outcomes
[SOA_SERIAL]: #outcomes
[SOA_SERIAL_VARIATION]: #outcomes

