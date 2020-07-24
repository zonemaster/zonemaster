# BASIC04: Test of basic nameserver and zone functionality

## Test case identifier
**BASIC04**

## Objective

Many test cases will query the name servers in the delegation or the
name servers appointed by the NS records in the zone for the NS or SOA
record or both. Reporting problem is crucial, but instead of letting
several test cases report the same problems found, most test cases
assume that this test case has been run. Only this test case will
report problems found in the following areas:

* Name Server not responding to a query without EDNS over UDP.
* Name Server responding to TCP but not UDP.
* Name Server not including SOA record of *Child Zone* in the answer
  section in the response on a SOA query for *Child Zone*.
* Name Server not including NS record of *Child Zone* in the answer
  section in the response on an NS query for *Child Zone*.
* Name Server not setting the AA flag in a response with SOA or NS in
  answer section.
* Name Server responding with unexpected RCODE (any except "NOERROR")
  on query for SOA or NS for *Child Zone*.


## Inputs

* "Child Zone" - The domain name to be tested.


## Ordered description of steps to be taken to execute the test case

1. Create a SOA query for the *Child Zone* without any OPT record (no EDNS).

2. Create a NS query for the *Child Zone* without any OPT record (no EDNS).

3. Obtain the set of name server IP addresses using [Method4] and [Method5]
   ("Name Server IP").

4. For each name server in *Name Server IP* do:

   1. Send the SOA query over UDP and the NS query over UDP to the name server
      and collect the responses.
   2. If there is no DNS response on neither query (UDP), then:
      1. Send the SOA query over TCP to the name server and collect the
         response.
      2. If there is no DNS response on the TCP query, then output
         *[B04_NO_RESPONSE]* and go to next server.
      3. Else (there is a DNS response over TCP), then output 
         *[B04_RESPONSE_TCP_NOT_UDP]* and go to next server.
   3. Else:
      1. Process the response on the SOA query (UDP):
         1. If there is no response, then output *[B04_NO_RESPONSE_SOA_QUERY]*.
         2. Else, if the RCODE is not "NOERROR" then output
            *[B04_UNEXPECTED_RCODE_SOA_QUERY]*.
         3. Else, if there is no SOA record in the answer section, then
            output *[B04_MISSING_SOA_RECORD]*.
         4. Else, if the SOA record has owner name other than *Child Zone*
            then output *[B04_WRONG_SOA_RECORD]*.
         5. Else, AA flag is unset, then output *[B04_SOA_RECORD_NOT_AA]*.
      2. Process the response on the NS query (UDP):
         1. If there is no response, then output *[B04_NO_RESPONSE_NS_QUERY]*.
         2. Else, if the RCODE is not "NOERROR" then output
            *[B04_UNEXPECTED_RCODE_NS_QUERY]*.
         3. Else, if there is no NS record in the answer section, then
            output *[B04_MISSING_NS_RECORD]*.
         4. Else, if the NS record has owner name other than *Child Zone*
            then output *[B04_WRONG_NS_RECORD]*.
         5. Else, AA flag is unset, then output *[B04_NS_RECORD_NOT_AA]*.

## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

The outcome of this Test case is "pass" in all other cases.

Message                           | Default severity level of message
:---------------------------------|:-----------------------------------
B04_MISSING_NS_RECORD             | WARNING
B04_MISSING_SOA_RECORD            | WARNING
B04_NO_RESPONSE                   | WARNING
B04_NO_RESPONSE_NS_QUERY          | WARNING
B04_NO_RESPONSE_SOA_QUERY         | WARNING
B04_NS_RECORD_NOT_AA              | WARNING
B04_RESPONSE_TCP_NOT_UDP          | WARNING
B04_SOA_RECORD_NOT_AA             | WARNING
B04_UNEXPECTED_RCODE_NS_QUERY     | WARNING
B04_UNEXPECTED_RCODE_SOA_QUERY    | WARNING
B04_WRONG_NS_RECORD               | WARNING
B04_WRONG_SOA_RECORD              | WARNING

## Special procedural requirements	

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol and log a message reporting
the ignored result.

This test case is run before [Basic02].

## Intercase dependencies

None.

[B04_MISSING_NS_RECORD]:          #outcomes
[B04_MISSING_SOA_RECORD]:         #outcomes
[B04_NO_RESPONSE]:                #outcomes
[B04_NO_RESPONSE_NS_QUERY]:       #outcomes
[B04_NO_RESPONSE_SOA_QUERY]:      #outcomes
[B04_NS_RECORD_NOT_AA]:           #outcomes
[B04_RESPONSE_TCP_NOT_UDP]:       #outcomes
[B04_SOA_RECORD_NOT_AA]:          #outcomes
[B04_UNEXPECTED_RCODE_NS_QUERY]:  #outcomes
[B04_UNEXPECTED_RCODE_SOA_QUERY]: #outcomes
[B04_WRONG_NS_RECORD]:            #outcomes
[B04_WRONG_SOA_RECORD]:           #outcomes
[Basic02]:                        basic02.md
[Method4]:                        ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                        ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
