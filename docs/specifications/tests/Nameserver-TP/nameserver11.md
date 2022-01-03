# NAMESERVER11: Test for unknown EDNS OPTION-CODE

## Test case identifier
**NAMESERVER11** 

## Objective

EDNS is a mechanism to announce capabilities of a DNS implementation,
and is now basically required by any new functionality in DNS such as
DNSSEC ([RFC 6891]).

[RFC 6891, section 6.1.2] states that any OPTION-CODE values not understood by a
responder or requestor MUST be ignored. Unknown OPTION-CODE values must be
processed as though the OPTION-CODE was not even there.

In this test case, we will query with an unknown EDNS OPTION-CODE and expect
that the OPTION-CODE is not present in the response for the query.

## Scope

It is assumed that *Child Zone* has been tested by [Basic04]. This test
case will set DEBUG level on messages for non-responsive name servers.

## Inputs

"Child Zone" - The domain name to be tested.

## Ordered description of steps to be taken to execute the test case

1. Create a first SOA query for the *Child Zone* with an OPT record with 
   EDNS version set to "0" and with EDNS(0) option of payload size ("bufsize")
   set to 512 and "DO" bit unset.

2. Create a second SOA query for the *Child Zone* with an OPT record with 
   EDNS OPTION-CODE set to anything other than it is already assigned as in the
[IANA-DNSSYSTEM-PARAMETERS] and no other EDNS options or flags.

3. Create a third SOA query for the *Child Zone* without any OPT record.

4. Obtain the set of name server IP addresses using [Method4] and [Method5]
   ("Name Server IP").

5. For each name server in *Name Server IP* do:

	1. Send the SOA query **with** OPT record **without** EDNS OPTION-CODE to the name server and collect the response.
   2. If there is no DNS response, then:
      1. Send the SOA query **without** OPT record to the name server and 
         collect the response.
      2. If there is no DNS response, then output *[NO_RESPONSE]* and 
         go to next server.
      3. Else (there is a DNS response), then output 
         *[BREAKS_ON_EDNS]* and go to next server.
   3. Else, if the DNS response meet the following two criteria,
      then output *[NO_EDNS_SUPPORT]*:
      1. It has the RCODE "FORMERR" 
      2. It has no OPT record.
   4. Else, if the DNS response meet the following criteria:
      1. It has the RCODE "NOERROR".
      2. The answer section contains the SOA record for *Child Zone*.
      3. It has OPT record with EDNS version 0.
      Then, send the SOA query **with** OPT record **with** EDNS OPTION-CODE to the name server and collect the response.
      	1. If there is an "OPTION-CODE" present in the response, then
				output *[UNKNOWN_OPTION_CODE]*.
			2. Else, if the DNS response meet the following four criteria,
      	then just go to the next name server (no error):
				1. The SOA is obtained as response in the ANSWER section.
				2. If the DNS response has the RCODE "NOERROR".
				3. The pseudo-section response has an OPT record with version set to 0.
				4. There is no "OPTION-CODE" present in the response.
			3. Else output *[NS_ERROR]*.
	5. Else, if the DNS response meet the following criteria,
      then output *[EDNS_RESPONSE_WITHOUT_EDNS]* and go to next server.
      1. It has the RCODE "NOERROR".
      2. It has no OPT record.
   6. Else, if the DNS response meet the following criteria,
      then output *[EDNS_VERSION_ERROR]* and go to next server.
      1. It has the RCODE "NOERROR".
      2. It has OPT record with EDNS version other than 0.
   7. Else output *[NS_ERROR]* (i.e. other erroneous or unexpected 
      response).
 
## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

The outcome of this Test case is "pass" in all other cases.

Message                           | Default severity level (when message is outputed)
:---------------------------------|:--------------------------------------------------
NO_RESPONSE                       | DEBUG
NO_EDNS_SUPPORT                   | WARNING
NS_ERROR                          | WARNING
UNKNOWN_OPTION_CODE               | WARNING

## Special procedural requirements

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol and log a message reporting
the ignored result.

## Intercase dependencies

None.



[Basic04]:               ../Basic-TP/basic04.md
[IANA-DNSSYSTEM-PARAMETERS]: https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-11
[Method4]: ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]: ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[NO_EDNS_SUPPORT]: #outcomes
[NO_RESPONSE]: #outcomes
[NS_ERROR]: #outcomes
[RFC 6891, section 6.1.2]: https://tools.ietf.org/html/rfc6891#section-6.1.2
[RFC 6891]: https://tools.ietf.org/html/rfc6891
[UNKNOWN_OPTION_CODE]: #outcomes
