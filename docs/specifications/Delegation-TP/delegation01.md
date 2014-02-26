## DELEGATION01: The domain must have a minimum of two authoritative name servers   

### Test case identifier

**DELEGATION01:** The domain must have a minimum of two authoritative name servers

### Objective

[RFC 2182](http://tools.ietf.org/html/rfc2182) specifies that there must be at least minimum two name servers for a domain. This test is done to verify this condition

### Inputs

The label of the domain name to be tested

### Ordered description of steps to be taken to execute the test case

1. Get the name servers authoritative for the domain from its parent <br/>
1.1 A recursive NS-record lookup for the domain name starting at the root domain should be done, and the steps of the process recorded
1.2 If the recursion reaches a name server that responds with a redirect directly to the requested domain, then the domain through which the name server was found is considered the parent domain <br/>
1.3 Send a query to the parent domain asking for the list of name server authoritative for the domain that is being tested <br/>
1.4 Record the list of name servers obtained from the authority section <br/>
2. A NS query is made to all listed name servers obtained from step 1.4 for the domain <br/>
2.1 Record the list of name servers in the answer <br/>
3. Get the name servers authoritative from the domain's zone <br/>
3.1 Send a query to the domain asking for the list of authoritative name servers<br/>
3.2 Record the list of authoritative name servers in the answer <br/>

4. if the results of step 2.1 or step 3.2 are less than two, the test fails
 
### Outcome(s)

If the results of step 2.1 and step 3.2 contain two or more name servers, then the test succeeds 

### Special procedural requirements

None 

### Intercase dependencies

None
