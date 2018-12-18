# NAMSERVER13: Test for EDNS truncated response

## Test case identifier

**NAMESERVER13**

## Objective

EDNS is a mechanism to announce capabilities of a DNS implementation,
and is now basically required by any new functionality in DNS such as
DNSSEC ([RFC 6891]).

[RFC 6891, section 7] states that an OPT record must be included
in a truncated response, if the query includes an OPT pseudo record.

This Test Case will try to verify that if the response to a query with an OPT
record is truncated, then the response will contain an OPT record.

To trigger a truncated response, the OPT pseudo record 'DO' bit is set and the
buffer size is limited to 512 bytes. If the zone is not signed with DNSSEC, the
response will probably not be truncated anyway.

## Inputs

"Child Zone" - The domain name to be tested.

## Ordered description of steps to be taken to execute the test case

1. Create a DNSKEY query for the *Child Zone* that is signed with 'DO' bit
set to '1' and setting the buffer size to 512 bytes

2. Obtain the set of name server IP addresses using [Method4] and [Method5]
   ("Name Server IP").

3. For each name server in *Name Server IP* do:

	1. Send the query to the name server and collect the response.
	2. If there is no DNS response, output *[NO_RESPONSE]* and go to
      	next server.
	3. Else, if the DNS response has the RCODE "FORMERR" then output
      	*[NO_EDNS_SUPPORT]* and go to the next server. 
	4. Else, if the DNS response meet the following criteria output 
        *[MISSING_OPT_IN_TRUNCATED]*:
	        1. The DNS response is truncated (the "TC" flag is set).
	        2. The DNS response has no OPT record.
	5. Else, if the DNS response meet the following criteria,
      	then just go to the next name server (no error):
		1. The DNS response has the RCODE "NOERROR".
		2. The pseudo-section response has an OPT record with version set to 0.
	6. Else output *[NS_ERROR]*.
 
## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

The outcome of this Test case is "pass" in all other cases.

Message                           | Default severity level (when message is outputed)
:---------------------------------|:--------------------------------------------------
NO_RESPONSE                       | WARNING
NO_EDNS_SUPPORT                   | WARNING
NS_ERROR			  | WARNING     
MISSING_OPT_IN_TRUNCATED   	  | WARNING

## Special procedural requirements

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol and log a message reporting
the ignored result.

## Intercase dependencies

None.

[RFC 6891]: https://tools.ietf.org/html/rfc6891
[RFC 6891, section 7]: https://tools.ietf.org/html/rfc6891#section-7
[Method4]: ../Methods.md#method-4-delegation-name-server-addresses
[Method5]: ../Methods.md#method-5-in-zone-addresses-records-of-name-servers
[NO_RESPONSE]: #outcomes
[NO_EDNS_SUPPORT]: #outcomes
[NS_ERROR]: #outcomes
[MISSING_OPT_IN_TRUNCATED]: #outcomes

