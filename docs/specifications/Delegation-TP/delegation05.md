## DELEGATION05: Test whether there is an authoritative ANSWER for the name server

### Test case identifier

**DELEGATION05:** Test whether there is an authoritative ANSWER for the name server 

### Objective

Subsection 6.1 of [RFC 2181](http://tools.ietf.org/html/rfc2181) specifies that the nameservers must answer authoritatively for the designated zone. Responses to queries to the name servers for the designated zone must have the "AA" bit set

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
2. All distinct name servers obtained as the result of step 1.4 and 1.8 are queried for the SOA record over TCP and UDP
3. If any of the name server fail to give an authoritative answer ("AA-bit" is set in the answer), the test fails

### Outcome(s)

If all the name servers answer with the AA-bit set, then the test succeeds

### Special procedural requirements

None

### Intercase dependencies

None
