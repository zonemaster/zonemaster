## DELEGATION09: This test is done to verify that the NS records for the domain are same at the parent as well as at the child

### Test case identifier

**DELEGATION09:** Test to verify whether there is any mismatch between child and parent NS records for a domain

### Objective

If the list of name servers for a domain obtained from its parent and from its child zone does not match, then it leads to an inconsistency.

* Have to refer to an RFC or another technical document *

### Inputs

1. The label of the domain name to be tested

### Ordered description of steps to be taken to execute the test case

1. Find the list of authoritative name servers for the domain from the parent domain
1.1 A recursive NS-record lookup for the domain name starting at the root domain should be done, and the steps of the process recorded <br/>
1.2 If the recursion reaches a name server that responds with a redirect directly to the requested domain, then the domain through which the name server was found is considered the parent domain <br/>
1.3 Send a query to the parent domain asking for the list of name server authoritative for the domain that is being tested <br/>
1.4 Record the list of name servers obtained from the authority section <br/>1.5 A NS query is made to all listed name servers obtained from step 1.4 for the domain <br/>
1.6 Record the list of name servers in the answer <br/>
2. Find the list of authoritative name servers for the domain from the domain's zone <br/>
2.1 Send a query to the domain asking for the list of authoritative name servers<br/>
2.2 Record the list of authoritative name servers in the answer <br/>
3. If the set of NS names on the parent side and the set of NS names on the child side are disjoint, then the test fails

### Outcome(s)

If the set of NS names on the parent side and the set of NS names on the child side match, then the test succeeds

### Special procedural requirements

None

### Intercase dependencies

None
