## DELEGATION01: Test the presence of atleast one name server 

### Test case identifier
**DELEGATION01** Test the presence of atleast one name server 

### Objective
There must be atleast one NS record listed in the delegation

### Inputs
The FQDN of the domain name to be tested

### Ordered description of steps to be taken to execute the test case
1. A name server query for the FQDN should be sent
2. If there are no DNS ANSWERS for the query then the test fails

### Outcome(s)
If the response contains atleast one name server record for delegated servers, then the test succeeds 

### Special procedural requirements
If this test fails, it's impossible to continue and the whole testing process is aborted

### Intercase dependencies
None
