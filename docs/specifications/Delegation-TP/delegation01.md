## DELEGATION01: The domain must have a minimum of two authoritative name servers   

### Test case identifier

**DELEGATION01:** The domain must have a minimum of two authoritative name servers

### Objective

[RFC 2182](http://tools.ietf.org/html/rfc2182) specifies that there must be at least minimum two name servers for a domain. This test is done to verify this condition

### Inputs

The label of the domain name to be tested

### Ordered description of steps to be taken to execute the test case

1. Get the name servers authoritative for the domain from its parent
1.1 

2. Get the name servers authoritative from the domain's zone


 
1. A name server query for the domain should be sent
2. If there are no DNS ANSWERS for the query then the test fails

### Outcome(s)

If the response contains atleast one name server record for delegated servers, then the test succeeds 

### Special procedural requirements

None 

### Intercase dependencies

None
