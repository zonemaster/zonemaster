## ADDRESS04: IPv4 loopback address is not forward to root name servers

### Test case identifier
**ADDRESS04** IPv4 loopback address is not forward to root name servers

### Objective

In order to prevent forwarding some queries to the root name servers, IPv4
loopback address should be properly managed : authoritative name servers should
either (a) not provide a response or (b) be authoritative for one of the zones 
"127.in-addr.arpa", "0.127.in-addr.arpa" or "0.0.127.in-addr.arpa".

Section 4.1 of RFC 1912 (https://tools.ietf.org/rfc/rfc1912.txt) lists special
case zones. 

### Inputs

The list of the checked domain name servers.

### Ordered description of steps to be taken to execute the test case

1. SOA queries concerning the domains "127.in-addr.arpa",
   "0.127.in-addr.arpa" and "0.0.127.in-addr.arpa" must be sent 
   to each authoritative name server, in this order of domains.

2. If one of the domain listed at step 1, is delegated at one name server
   it is unnecessary to proceed with the remaining domains and the test at
   this name server succeeds. 

   If none of these domains is delegated at a name server, the name server 
   must not provide an answer nor forward to the root name servers for each 
   of the domains listed at step 1. In this case, the test succeeds at this name
   server. Otherwise, the test fails for this name server.

   A domain is considered delegated if the response to the SOA query has its
   authoritative answer flag set and the answer section contains an SOA record
   for the domain.

   In the case where a domain is not delegated at a name server, this latter
   must reply with a RCODE Refused or ServFail and the authority section
   must be empty.

3. If the test succeeds for each name server, the whole test case succeeds.
   Otherwise, it fails.

### Outcome(s)

None.

### Special procedural requirements

None.

### Intercase dependencies

None.
