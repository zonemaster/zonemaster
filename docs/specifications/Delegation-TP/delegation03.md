## DELEGATION02:The child domain must have a minimum of two name server records listed in its delegation

### Test case identifier
**DELEGATION02:** The child domain must have a minimum of two name server records listed in its delegation 

### Objective
[RFC 2182](http://tools.ietf.org/html/rfc2182) specifies that there must be atleast minimum two name servers for a domain, one which is primary and the others acting as secondary. This test is done to verify the existence of a minimum of two NS record listed in the delegation


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
