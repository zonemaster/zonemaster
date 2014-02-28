## DELEGATION02: Verify that the nameservers delegated has distinct IP addresses

### Test case identifier

**DELEGATION02:** Verify that the nameservers delegated has distinct IP addresses

### Objective

Even though none of the RFC seems to explicitly state, but it is clear that distinct name server records for a domain must not resolve to the same IP address for resilience

### Inputs

The label of the domain name to be tested

### Ordered description of steps to be taken to execute the test case

1. Find the list of authoritative name servers for the domain <br/>
1.1 Get the name servers authoritative for the domain from its parent <br/>
1.1.1 A recursive NS-record lookup for the domain name starting at the root domain should be done, and the steps of the process recorded <br/>
1.1.2 If the recursion reaches a name server that responds with a redirect directly to the requested domain, then the domain through which the name server was found is considered the parent domain <br/>
1.1.3 Send a query to the parent domain asking for the list of name server authoritative for the domain that is being tested <br/>
1.1.4 Record the list of name servers obtained from the authority section <br/>
1.1.5 A NS query is made to all listed name servers obtained from step 1.1.4 for the domain <br/>
1.1.6 Record the list of name servers in the answer <br/>
1.2 Get the name servers authoritative from the domain's zone <br/>
1.2.1 Send a query to the domain asking for the list of authoritative name servers<br/>
1.2.3 Record the list of authoritative name servers in the answer <br/>
2. Find the IP addresses corresponding to the list of name servers obtained in step1. In order to do that: <br/>
2.1 send an A query to all distinct name servers obtained in step 1.1.6 and 1.2.3<br/>
2.2 Record the list of IPv4 addreses in the answer section<br/>
2.3 send an AAAA query to all distinct name servers obtained in step 1.1.6 and 1.2.3 <br/>
2.4 Record the list of IPv6 addresses in the answer section <br/>
3. If the list of IP address obtained in step2.2 and step2.4 are not unique, then the test fails


### Outcome(s)

If all the IP addresses obtained are unique, then the test succeeds

### Special procedural requirements

None 

### Intercase dependencies

None
