## DELEGATION02: Test the presence of a minimum two name servers (RFC 2182)

### Test case identifier
**DELEGATION02:** Test the presence of a minimum two name servers 

### Objective
There must be a minimum of two NS record listed in the delegation

### Inputs
The FQDN of the domain name to be tested

### Ordered description of steps to be taken to execute the test case
1. A name server query for the FQDN should be sent
2. If there are less than two DNS ANSWERS for the query then the test fails

### Outcome(s)
If the response contains atleast two name server record for delegated servers, then the test succeeds 

### Special procedural requirements

### Intercase dependencies
None
