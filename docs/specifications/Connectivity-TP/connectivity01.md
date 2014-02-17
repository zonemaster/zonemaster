## CONNECTIVITY01: The domain must answer DNS queries over UDP on port 53

### Test case identifier

**CONNECTIVITY01:**  The domain must answer DNS queries over UDP on port 53

### Objective

DNS queries are sent using UDP on port 53, as described in section 4.2.1 of [RFC 1035](http://tools.ietf.org/html/rfc1035).

The objective for this test is that all the authoritative name servers for the domain are accessible over UDP on port 53

### Inputs

1. The domain name to be tested

### Ordered description of steps to be taken to execute the test case

1. Find the list of all the name servers used by the domain. This list MUST contain all name servers from the parent delegation for the domain, and all name servers in the apex of the domain's zone itself
2. Find the IP addresses corresponding to the name servers in step1. In order to do that: <br/>
2.1. Collect all glue records from the parent for the domain <br/>
2.2. Collect all IP addresses of the name servers, authoritative for the domain from the domain's zone (i.e. the domain being tested)
2.3. Collect all the IP addresses used by out-of-bailwick name servers
3. A SOA query is sent over UDP to distinct IP address of each name server found in step2
4. If all queries in step 3 receive a NOERROR response (bogus response are not checked here) then the test case succeed.

### Outcome(s)

If there is any name server that fails to answer queries over port 53 using UDP, this test case fails

### Special procedural requirements	

None

### Intercase dependencies

None
