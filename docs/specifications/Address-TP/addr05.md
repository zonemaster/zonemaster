## ADDR05: IPv6 loopback address is not forward to root name servers

### Test case identifier
**ADDR05** IPv6 loopback address is not forward to root name servers

### Objective

In order to prevent forwarding some queries to the root name servers, IPv6
loopback address should be properly managed : authoritative name servers should
either (a) not provide a response or (b) be authoritative for the zone 
0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa.

### Inputs

The list of the checked domain name servers.

### Ordered description of steps to be taken to execute the test case

1. SOA queries concerning the domain 
   0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa.
   must be sent to each authoritative name server.

2. If the domain is delegated at one name server, the test for this name server
	succeeds.

   The domain is considered delegated if the response to the SOA query has its
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
