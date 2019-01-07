# NAMESERVER14: Test for unknown version with unknown OPTION-CODE

## Test case identifier

**NAMESERVER14** 

### Objective

This test case actually combines the test options in test cases
[NAMESERVER10](../nameserver10.md) and [NAMESERVER11](../nameserver11.md). 

### Inputs

"Child Zone" - The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Create an SOA query for the *Child Zone* with an OPT record with 
   EDNS version set to "1" and  with EDNS OPTION-CODE set to an
   unassigned value (see [IANA-DNSSYSTEM-PARAMETERS]) and
   with no other EDNS options or flags. 

2. Obtain the set of name server IP addresses using [Method4] and [Method5]
   ("Name Server IP").

3. For each name server in *Name Server IP* do:

	1. Send the SOA query to the name server and collect the response.
	2. If there is no DNS response, output *[NO_RESPONSE]* and go to
      	next server.
	3. Else, if the DNS response has the RCODE "FORMERR" then output
      	*[NO_EDNS_SUPPORT]*.
	4. Else, if the RCODE has "NOERROR", and has an "OPTION-CODE" and
	"Version Number" present in the response,  then output
	[UNKNOWN_OPTION_CODE_VERSION]. 
	5. Else, if the DNS response has the RCODE "NOERROR" and "Version
	number" present in the response then output [UNSUPPORTED_EDNS_VER]
	6. Else, if the DNS response has the RCODE "NOERROR" and "OPTION-CODE"
	present in the response then output [UNKNOWN_OPTION_CODE].
	7. Else, if the DNS response meet the following four criteria,
      	then just go to the next name server (no error):
		1. If the SOA is not obtained as response in the ANSWER section.
		2. It has the RCODE "BADVERS".
		3. The pseudo-section response has an OPT record with version set to 0.
		4. The option is not present in the response
	8. Else output *[NS_ERROR]*.
 
### Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

The outcome of this Test case is "pass" in all other cases.

Message                           | Default severity level (Output message)
:---------------------------------|:--------------------------------------------------
NO_RESPONSE                       | WARNING
NO_EDNS_SUPPORT                   | WARNING
NS_ERROR			  | WARNING     
UNKNOWN_OPTION_CODE               | WARNING
UNSUPPORTED_EDNS_VER      	  | WARNING
UNKNOWN_OPTION_CODE_VERSION       | WARNING

### Special procedural requirements

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol and log a message reporting
the ignored result.

### Intercase dependencies

None.

[IANA-DNSSYSTEM-PARAMETERS]:
https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-11
[Method4]: ../Methods.md#method-4-delegation-name-server-addresses
[Method5]: ../Methods.md#method-5-in-zone-addresses-records-of-name-servers
[NO_RESPONSE]: #outcomes
[NO_EDNS_SUPPORT]: #outcomes
[NS_ERROR]: #outcomes
[UNKNOWN_OPTION_CODE]: #outcomes
[UNSUPPORTED_EDNS_VER]: #outcomes
[UNKNOWN_OPTION_CODE_VERSION]: #outcomes
