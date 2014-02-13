## CONNECTIVITY01: The domain must answer DNS queries over UDP on port 53

### Test case identifier
**CONNECTIVITY01:**  The domain must answer DNS queries over UDP on port 53

### Objective

DNS queries are sent using UDP on port 53, as described in section 4.2.1 of [RFC 1035](http://tools.ietf.org/html/rfc1035).

The objective for this test is that all the authoritative nameservers for the domain are accessible over UDP on port 53

### Inputs

1. The domain name to be tested

### Ordered description of steps to be taken to execute the test case

1. Find the list of all the nameservers used by the domain. This list MUST contain all nameservers from the parent delegation for the domain, and all nameservers in the apex of the domain's zone itself
2. Find the IP addresses corresponding to the nameservers in step1. In order to do that:
2.1. Collect all glue records from the parent for the domain
2.2. Collect all glue records from the child domain (i.e. the domain being tested)
2.3. Collect all the IP addresses used by out-of-bailwick nameservers
3. A SOA query is sent to each IP address of each nameserver found in step2
4. If no answer is received from any query in step3, the test case fails

### Outcome(s)

If there is any nameserver that fails to answer queries over port 53 using UDP, this test case fails

### Special procedural requirements	

None

### Intercase dependencies

None
