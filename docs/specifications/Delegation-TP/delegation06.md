## DELEGATION06: Test that the NS record is not pointing to a CNAME alias

### Test case identifier

**DELEGATION06:** Test that the NS record is not pointing to a CNAME alias 

### Objective

[RFC 1912](http://tools.ietf.org/html/rfc1912) mentions that NS records pointing to CNAME is forbidden. 

The objective of this test is to verify that name servers does not point to a CNAME record

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
2. All distinct name servers obtained as the result of step 1.4 and 1.8 are queried for A and AAAA records
3. If any of the name server queried responded with the resource record type CNAME, then the test fails

### Outcome(s)

If none of the response contains the resource record type CNAME then the test succeeds

### Special procedural requirements

None

### Intercase dependencies

None
