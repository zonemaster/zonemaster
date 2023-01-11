# CONSISTENCY03: SOA timers consistency

## Test case identifier

**CONSISTENCY03**

## Objective

All SOA record timer fields must be consistent across all authoritative 
name servers. An inconsistency in these fields might result in operational 
inconsistencies for the designated zone.

There are other test cases that provide consistency tests for the other
SOA fields:

* [CONSISTENCY01] (SOA Serial)
* [CONSISTENCY02] (RNAME)
* [CONSISTENCY06] (MNAME)

## Scope

It is assumed that *Child Zone* is also tested by [Connectivity01]. This test
case will set DEBUG level on messages for non-responsive name servers.

## Inputs

* The domain name to be tested ("Child Zone").

## Ordered description of steps to be taken to execute the test case

 1. Create an SOA query for *Child Zone* apex.

 2. Obtain the list of name server IPs for the *Child Zone* from [Method4] 
    and [Method5].

 3. Send the SOA query to all name server IPs.

 4. If a name server does not respond, emit *[NO_RESPONSE]*.

 5. If a name server responds but no SOA record is included in the 
    response, emit *[NO_RESPONSE_SOA_QUERY]*.

 6. Retrieve the SOA RR from the responses from all name server IPs.

 7. Emit *[ONE_SOA_TIME_PARAMETER_SET]* if at least one SOA record has 
    been retrieved and all SOA records have:
    1. the same REFRESH value, 
    2. the same RETRY value, 
    3. the same EXPIRE value, and 
    4. the same MINIMUM value.

 8. Emit *[MULTIPLE_SOA_TIME_PARAMETER_SET]* if any two SOA
    records had different values in previous step.

## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

In other cases the outcome of this Test Case is "pass".

Message                          | Default severity level (if message is emitted)
:--------------------------------|:-----------------------------------
NO_RESPONSE                      | DEBUG
NO_RESPONSE_SOA_QUERY            | DEBUG
ONE_SOA_TIME_PARAMETER_SET       | INFO
MULTIPLE_SOA_TIME_PARAMETER_SET  | NOTICE


## Special procedural requirements	

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
on the ignored result.

## Intercase dependencies

None.


[Connectivity01]:                    ../Connectivity-TP/connectivity01.md
[CONSISTENCY01]:                     consistency01.md
[CONSISTENCY02]:                     consistency02.md
[CONSISTENCY06]:                     consistency06.md
[MULTIPLE_SOA_TIME_PARAMETER_SET]:   #outcomes
[Method4]:                           ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                           ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[NO_RESPONSE]:                       #outcomes
[NO_RESPONSE_SOA_QUERY]:             #outcomes
[ONE_SOA_TIME_PARAMETER_SET]:        #outcomes

