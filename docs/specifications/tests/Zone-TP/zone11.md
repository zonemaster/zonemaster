# ZONE11: Verify SOA MNAME


## Test case identifier
**ZONE11**


## Objective

The SOA MNAME record must be a fully qualified master nameserver. 
 
The purpose of this test is to test:
    - that the server responds to DNS queries.
    - that the server is authoritative to the zone.
    - that the MNAME is not the zone name.
    - that the SOA serial is identical to the NS name servers.

## Scope

## Inputs

The domain name to be tested.

## Ordered description of steps to be taken to execute the test case

1. Retrieve the SOA record from a delegated name server for the domain, 
   and store the MNAME and its associated SERIAL.
   1. If there is no MNAME record, then output *MNAME_RECORD_DOES_NOT_EXIST*. 
   2. Else, if there is no SERIAL record, then output *SERIAL_RECORD_DOES_NOT_EXIST*.
   3. Else, if the MNAME is the same as the zone tested, then output *MNAME_IS_ZONE_NAME*.
   4. Else, do: 
      1. Send a SOA query to the name server in the MNAME.
         1. If the SOA response has the rcode "NOERROR" then:
            1. If the SOA response is not authoritative for the zone tested, then output *MNAME_NOT_AUTHORITATIVE*.
         2. Else, output *MNAME_NO_RESPONSE*.
      2. Obtain the set of IP addresses of name servers for the zone tested using [Method5] ("NS IP").
      3. For each name server in "NS IP", send a SOA query to the name server and collect the response.
         1. If there is a response, compare the SOA serial of that name server to the one in the MNAME.
            1. If they match, go to the next name server.
            2. Else, output *MNAME_NOT_MASTER*.
         2. Else, output *MNAME_NO_RESPONSE* 
      4. If the SOA MNAME field is not part of the NS set for the zone, then output *MNAME_NOT_IN_GLUE*.
      5. If no output message were sent, then output *MNAME_IS_MASTER*
2. Else, output *[NO_RESPONSE_SOA_QUERY]*.

## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

In other cases the outcome of this Test Case is "pass".

Message                       | Default severity level
:-----------------------------|:-----------------------------------
NO_RESPONSE_SOA_QUERY         | DEBUG
MNAME_RECORD_DOES_NOT_EXIST   | WARNING
SERIAL_RECORD_DOES_NOT_EXIST  | WARNING
MNAME_IS_ZONE_NAME            | WARNING
MNAME_NOT_AUTHORITATIVE       | WARNING
MNAME_NO_RESPONSE             | NOTICE
MNAME_NOT_IN_GLUE             | NOTICE
MNAME_NOT_MASTER              | WARNING
MNAME_IS_MASTER               | INFO

## Special procedural requirements

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
on the ignored result.

## Intercase dependencies

None

## Terminology

[NO_RESPONSE_SOA_QUERY]:        #outcomes
[MNAME_RECORD_DOES_NOT_EXIST]:  #outcomes
[SERIAL_RECORD_DOES_NOT_EXIST]: #outcomes
[MNAME_IS_ZONE_NAME]:           #outcomes
[MNAME_NOT_AUTHORITATIVE]:      #outcomes
[MNAME_NO_RESPONSE]:            #outcomes
[MNAME_NOT_MASTER]:             #outcomes
[MNAME_IS_MASTER]:              #outcomes
[Method5]:                      ../Methods.md#method-5-obtain-the-name-server-address-records-from-child