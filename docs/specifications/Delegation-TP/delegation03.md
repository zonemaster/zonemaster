## DELEGATION03: Verify that the nameservers delegated has distinct IP addresses 

### Test case identifier
**DELEGATION03:** Verify that the nameservers delegated has distinct IP addresses 

### Objective
Even though none of the RFC seems to explicitly state, but it is clear that the name server records for a child domain must not resolve to the same IP address

### Inputs
The name server's FQDN 

### Ordered description of steps to be taken to execute the test case
1. Get the list of name servers delegated with the corresponding IP address
2. If the list of IP address obtained is not unique, then the test fails

### Outcome(s)
If all the IP addresses obtained for the delegated name servers are unique, then the test succeeds 

### Special procedural requirements

### Intercase dependencies
None
