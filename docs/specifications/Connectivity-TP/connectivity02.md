## CONNECTIVITY02: The child domain must accessible over TCPP on port 53

### Test case identifier
**CONNECTIVITY02:**  The child domain must accessible over TCPP on port 53

### Objective
The child domain must also answer DNS queries on TCP

### Inputs
1. The FQDN of the child domain's authoritative name servers

### Ordered description of steps to be taken to execute the test case
1. A SOA query is sent over TCP to all authoritative name servers of the child domain
2. If the FQDN has a single address, then the test fails if a query destined to that addresses does not provide an answer within a particular time period (Should we set a threshhold time for TCP?)
3. If the FQDN has multiple addresses, then the test  fails if none of those addresses provide an answer within the specified threshhold time


### Outcome(s)
If there is a response from all the listed name servers within the threshhold period, then the test succeeds
### Special procedural requirements

### Intercase dependencies
None
