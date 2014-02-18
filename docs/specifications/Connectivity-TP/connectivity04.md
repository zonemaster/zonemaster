## CONNECTIVITY04: Each IP address of the domain's authoritative name server should be part of a different subnet

### Test case identifier

**CONNECTIVITY04:** Each IP addresses of the domain's authoritative name servershould be part of a different subnet

### Objective

[RFC 2182](http://tools.ietf.org/html/rfc2182), section 3.1 clearly specifies that distinct authoritative name servers for a domain should be placed in different topological and geographical locations. The goal is to minimise the likelihood of a single failure disabling all of them. 

The objective in this test is to check that more than one IP addresses of the domain's authoritative name servers does not belong to the same subnet

### Inputs

1. The domain name to be tested

### Ordered description of steps to be taken to execute the test case

1. Find the list of all the name servers used by the domain. This list MUST contain all name servers from the parent delegation for the domain, and all name servers in the apex of the domain's zone itself
2. Find the IP addresses corresponding to the name servers in step1. In order to do that: <br/>
2.1. Collect all glue records from the parent for the domain <br/>
2.2. Collect all IP addresses of the name servers, authoritative for the domain from the domain's zone (i.e. the domain being tested) <br/>
2.3. Collect all the IP addresses used by out-of-bailwick name servers <br/>
3. Create a subnet list from each of the retrieved IP addresses from step2, and define its range. For example, if it is IPv4 then the range is 28 and if it is IPv6, then the range is 64
4. Check the IP address in the input with the subnet list.
5. If a distinct IP address falls in the range of more than one subnet in the subnet list, then the test fails   

### Outcome(s)

If there is not a single IP address from the input which falls inside the range of more than one subnet, then the test succeeds

### Special procedural requirements

None

### Intercase dependencies

None
