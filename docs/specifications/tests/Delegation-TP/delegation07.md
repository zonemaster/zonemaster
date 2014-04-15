## DELEGATION07: Test that the authoritative name servers for the domain be accessible over Internet

### Test case identifier

**DELEGATION07:** Test that the authoritative name servers for the domain be accessible over Internet

### Objective

The name server must answer DNS queries over both the UDP and TCP over port 53

This test case fulfils the requirements 2.3.1 in the "Technical requirements for authoritative name servers" document 

### Inputs

1. The label of the domain name to be tested

### Ordered description of steps to be taken to execute the test case

1. Find the list of authoritative name servers for the domain
1.1 A recursive NS-record lookup for the domain name starting at the root domain should be done, and the steps of the process recorded <br/>
1.2 If the recursion reaches a name server that responds with a redirect directly to the requested domain, then the domain through which the name server was found is considered the parent domain <br/>
1.3 Send a query to the parent domain asking for the list of name server authoritative for the domain that is being tested <br/>
1.4 Record the list of name servers obtained from the authority section <br/>1.5 A NS query is made to all listed name servers obtained from step 1.4 for the domain <br/>
1.6 Record the list of name servers in the answer <br/>
1.7  Send a query to the domain asking for the list of authoritative name servers <br/>
1.8 Record the list of authoritative name servers in the answer <br/>
2. A SOA query is sent over UDP and TCP to all distinct name servers obtained as the result of step 1.4 and 1.8 
3. If any of the name server fail to give an authoritative answer ("AA-bit" is set in the answer), the test fails 

### Outcome(s)

If any query is failing to get an answer, then the test case fails

### Special procedural requirements

None

### Intercase dependencies

None
