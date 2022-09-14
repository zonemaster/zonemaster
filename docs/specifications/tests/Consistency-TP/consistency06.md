# CONSISTENCY06: SOA MNAME consistency

## Test case identifier

**CONSISTENCY06**

## Objective

All authoritative name servers must serve the same SOA record (section
4.2.1) of [RFC 1034] for the tested domain. As per section 3.3.13 of 
[RFC 1035] the MNAME field in the SOA RDATA refers to the name of 
"the name server that was the original or primary source of data 
for this zone". Inconsistency in MNAME of the domain might result in 
operational failures for applications that uses MNAME.

## Scope

It is assumed that *Child Zone* is also tested by [Connectivity01]. This test
case will set DEBUG level on messages for non-responsive name servers.

## Inputs

* "Child Zone" - The domain name to be tested.

## Ordered description of steps to be taken to execute the test case

 1. Obtain the set of name server IPs for the *Child Zone* from [Method4] 
    and [Method5] ("Name Server IP").

 2. Create an SOA query for *Child Zone* apex.

 3. For each name server in *Name Server IP* do:

    1. Send the query to name server.
    2. If the name server does not respond with a DNS response, 
       emit *[NO_RESPONSE]* for that name server and go to next server.
    3. If the DNS response does not include a SOA record in the answer 
       section then emit *[NO_RESPONSE_SOA_QUERY]* for that server and go 
       to next server.
    4. Retrieve the MNAME field from the SOA RR from the DNS response
       and save that to compare it with the MNAME from the other name
       servers.

 4. Compare the MNAME fields retreived from all name servers.

 5. If at least one name server has responded with a SOA record and the 
    MNAME is identical in all SOA records retrieved, emit *[ONE_SOA_MNAME]*.

 6. If MNAME is not identical in all SOA records retrieved, emit 
    *[MULTIPLE_SOA_MNAMES]*.

## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

In other cases the outcome of this Test Case is "pass".

Message                       | Default severity level (if message is emitted)
:-----------------------------|:-----------------------------------
NO_RESPONSE                   | DEBUG
NO_RESPONSE_SOA_QUERY         | DEBUG
ONE_SOA_MNAME                 | INFO
MULTIPLE_SOA_MNAMES           | NOTICE


## Special procedural requirements	

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
on the ignored result.

## Intercase dependencies

None


[Connectivity01]:           ../Connectivity-TP/connectivity01.md
[MULTIPLE_SOA_MNAMES]:      #outcomes
[Method4]:                  ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                  ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[NO_RESPONSE]:              #outcomes
[NO_RESPONSE_SOA_QUERY]:    #outcomes
[ONE_SOA_MNAME]:            #outcomes
[RFC 1034]:                 https://tools.ietf.org/html/rfc1035
[RFC 1035]:                 https://tools.ietf.org/html/rfc1035

