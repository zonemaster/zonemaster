## DELEGATION03: Verify that the nameservers delegated has distinct IP addresses 

### Test case identifier
**DELEGATION03** Verify that the nameservers delegated has distinct IP addresses 

### Objective
The name server hosts must not resolve to the same IP address

### Inputs
The name server's FQDN and corresponding IP address

### Ordered description of steps to be taken to execute the test case
1. Get the list of name servers delegated with the correspodning IP address
2. If the list of IP address obtained is not unique, then the test fails

### Outcome(s)
If all the IP addresses obtained for the delegated name servers are unique, then the test succeeds 

### Special procedural requirements

### Intercase dependencies
None
