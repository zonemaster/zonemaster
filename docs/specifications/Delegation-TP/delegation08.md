## DELEGATION08:Test the existence of SOA record in the domain's zone

### Test case identifier

**DELEGATION08:** Test the existence of SOA record in the domain's zone 

### Objective

Section 6.1 of the [RFC 2182](http://tools.ietf.org/html/rfc2182) specifies that the SOA record is mandatory for every zone. 

This test is intended to verify the prescence of a SOA record in the domain's zone.

### Inputs

1. The label of the domain to be tested

### Ordered description of steps to be taken to execute the test case

1. Find the list of authoritative name servers for the domain
1.1 A recursive NS-record lookup for the domain name starting at the root domain should be done, and the steps of the process recorded <br/>
1.2 If the recursion reaches a name server that responds with a redirect directly to the requested domain, then the domain through which the name server was found is considered the parent domain <br/>
1.3 Send a query to the parent domain asking for the list of name server authoritative for the domain that is being tested <br/>
1.4 Record the list of name servers obtained from the authority section <br/>1.5 A NS query is made to all listed name servers obtained from step 1.4 for the domain <br/>
1.6 Record the list of name servers in the answer <br/>
1.7  Send a query to the domain asking for the list of authoritative name servers <br/>
1.8 Record the list of authoritative name servers in the answer <br/>
2. A SOA query is sent to all distinct name servers obtained as the result of step 1.4 and 1.8
3. If none of the name server failed to give an authoritative answer ("AA-bit" is set in the answer), the test fails

### Outcome(s)

If any of the name server queried responded with an authoritative answer for the query, then the test succeeds

### Special procedural requirements

None

### Intercase dependencies

None
