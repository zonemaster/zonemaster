# NAMESERVER12: Test for unknown EDNS flags

## Test case identifier

**NAMESERVER12** 

## Objective

EDNS is a mechanism to announce capabilities of a dns implementation,
and is now basically required by any new functionality in dns such as
DNSSEC ([RFC 6891]).

[RFC 6891, section 6.1.4] states that "Z" flag set to zero by senders and ignored by
receiver.

In this test case, we will query with an unknown EDNS flag
and expect that "Z" bits to be clear in the response.

## Inputs

"Child Zone" - The domain name to be tested.

## Ordered description of steps to be taken to execute the test case

1. Create a SOA query for the *Child Zone* with an OPT record with 
   EDNS flag "Z" bit set to anything other than "0" and no other EDNS options or flags.

2. Obtain the set of name server IP addresses using [Method4] and [Method5]
   ("Name Server IP").

3. For each name server in *Name Server IP* do:
	1. Send the SOA query to the name server and collect the response.
	2. If there is no DNS response, output *[NO_RESPONSE]* and go to
      	next server.
	3. Else, if the DNS response has the RCODE "FORMERR" then output
      	*[NO_EDNS_SUPPORT]*.
	4. Else, if the pseudo-section has an OPT record with flags being set to
	some value, then output [Z_FLAGS_NOTCLEAR]. 
	5. Else, if the DNS response meet the following four criteria,
      	then just go to the next name server (no error):
		1. The SOA is obtained as response in the ANSWER section.
		2. If the DNS response has the RCODE "NOERROR".
		3. The pseudo-section response has an OPT record with version set to 0.
		4. The "Z" bits are clear in the response

4. Else output *[NS_ERROR]*.
 
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
Z_FLAGS_NOTCLEAR          	  | WARNING

## Special procedural requirements

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol and log a message reporting
the ignored result.

## Intercase dependencies

None.

[RFC 6891]: https://tools.ietf.org/html/rfc6891
[RFC 6891, section 6.1.4]: https://tools.ietf.org/html/rfc6891#section-6.1.2
[Method4]: ../Methods.md#method-4-delegation-name-server-addresses
[Method5]: ../Methods.md#method-5-in-zone-addresses-records-of-name-servers
[NO_RESPONSE]: #outcomes
[NO_EDNS_SUPPORT]: #outcomes
[Z_FLAGS_NOTCLEAR]: #outcomes
[NS_ERROR]: #outcomes
