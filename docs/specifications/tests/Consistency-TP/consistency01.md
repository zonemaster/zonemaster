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

* "Child Zone" - The domain name to be tested 
* "Accepted Serial Difference" - Accepted difference between SOA serial
  values from SOA records of different name servers for *Child Zone*. 
  Default value is 0, i.e. no difference.

## Ordered description of steps to be taken to execute the test case

1. Obtain the list of name server IPs for the *Child Zone* from [Method4] 
    and [Method5] ("Name Server IP").

2. Create an SOA query for *Child Zone* name (the top of the zone).

3. Create an empty set of pair of retrieved SOA serials and name server
   name and IP ("SOA Serial Set"). 

3. For each name server in *Name Server IP* do:
    
    1. Send the SOA query to the name server.

    2. If the name server does not respond with a DNS response, then 
       output *[NO_RESPONSE]*.

    3. Or, if the name server returns a DNS response, but no SOA 
       record is included, then output *[NO_RESPONSE_SOA_QUERY]*.

    4. Or, retrieve the SOA SERIAL from the response and add it to
       *SOA Serial Set* (unless it is already there) and update the set
       with the name server name and IP.

4. If *SOA Serial Set* has exactly one SOA serial value, then output 
   *[ONE_SOA_SERIAL]*.

5. Or, if *SOA Serial Set* has at least two SOA serials values, then do:
    1. Order the serial number values from *SOA Serial Set* from smallest 
       to largest following the arithmetic for serial number, if possible.
    2. If there is not a single, uniquely defined order of the serial 
       numbers, then output *[SOA_SERIAL_VARIATION]* and 
       *[MULTIPLE_SOA_SERIALS]*.
    3. Or, if the difference between the first and the last serial number
       is larger than *Accepted Serial Difference*, using arithmetic
       for serial number, then output *[SOA_SERIAL_VARIATION]* and 
       *[MULTIPLE_SOA_SERIALS]*.
    4. Or, if the difference between the first and the last serial number
       is not larger than *Accepted Serial Difference*, using arithmetic
       for serial number, output *[MULTIPLE_SOA_SERIALS_OK]*.

6. For each SOA serial value in *SOA Serial Set*, output *[SOA_SERIAL]* 
   with the serial number and a semicolon separated list of name server 
   names and IP address pairs (name/IP).
    

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

When comparing SOA serial it must be done using the arithmetic defined in
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

