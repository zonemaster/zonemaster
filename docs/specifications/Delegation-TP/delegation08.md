## DELEGATION08: Test whether the nameserver can be resolved

### Test case identifier
**DELEGATION08:** Test whether the nameserver can be resolved 

### Objective
The name server must answer DNS queries on both the UDP and TCP protocols over port 53

### Inputs
1. The FQDN of the authoritative name server

### Ordered description of steps to be taken to execute the test case
1. A query is sent to find whether the FQDN is resolved to an IPv4 or IPv6 address
2. If there are no ANSWERS for the query, then the test fails


### Outcome(s)
If the response contains a a minimum of one ANSWER , then the test succeeds

### Special procedural requirements
None

### Intercase dependencies
None
