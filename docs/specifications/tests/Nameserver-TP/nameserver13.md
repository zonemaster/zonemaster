# nameserver13: Test for EDNS truncated response

### test case identifier

**Nameserver13**

### objective

EDNS is a mechanism to announce capabilities of a dns implementation,
and is now basically required by any new functionality in dns such as
dnssec ([rfc 6891]).

[RFC 6891, section 7] states that an OPT record is supposed to be included
in a truncated response, where-in in the request, an OPT pseudo-RR is present.

In this test case, we will query with DO bit set to '1' and forcing a
truncated response with setting buffer size to 512 in the query. We will also
make sure that the resolution is not retried using TCP.

### Inputs
"Child Zone" - The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Create a query for the *Child Zone* with DO bit set to '1', a buffer size
of 512 bytes and with the option for ignoring truncation of UDP responses.  

2. Obtain the set of name server IP addresses using [Method4] and [Method5]
   ("Name Server IP").

3. For each name server in *Name Server IP* do:
	1. Send the query to the name server and collect the response.
	2. If there is no DNS response, output *[NO_RESPONSE]* and go to
      next server.
	3. If the DNS response has the RCODE "FORMERR" then output
      *[NO_EDNS_SUPPORT]*.

4. Else, if the DNS response meet the following criteria,
      then just go to the next name server (no error):
	1. If the DNS response has the RCODE "NOERROR".
	2. If the pseudo-section response has an OPT record with version set to 0.

5. Else output *[NS_ERROR]*.
 
### Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

The outcome of this Test case is "pass" in all other cases.

Message                           | Default severity level (when message is outputed)
:---------------------------------|:--------------------------------------------------
NO_RESPONSE                       | WARNING
NO_EDNS_SUPPORT                   | NOTICE
NS_ERROR			  | WARNING     

### Special procedural requirements

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol and log a message reporting
the ignored result.

### Intercase dependencies

None.

[RFC 6891]: https://tools.ietf.org/html/rfc6891
[RFC 6891, section 7]: https://tools.ietf.org/html/rfc6891#section-7
[Method4]: ../Methods.md#method-4-delegation-name-server-addresses
[Method5]: ../Methods.md#method-5-in-zone-addresses-records-of-name-servers
[NO_RESPONSE]: #outcomes
[NO_EDNS_SUPPORT]: #outcomes
[NS_ERROR]: #outcomes

-------

Copyright (c) 2013, 2014, 2015, IIS (The Internet Infrastructure
Foundation) Copyright (c) 2013, 2014, 2015, AFNIC Creative Commons Attribution
4.0 International License

You should have received a copy of the license along with this work. If not,
see <https://creativecommons.org/licenses/by/4.0/>.
