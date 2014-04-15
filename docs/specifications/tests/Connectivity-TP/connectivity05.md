## CONNECTIVITY05: Check whether all the IP addresses of the child domain's authoritative name server is part of the same subnet


### Test case identifier

**CONNECTIVITY05:** Check whether all the IP addresses of the child domain's authoritative name server is part of the same subnet

### Objective
[RFC 2182](http://tools.ietf.org/html/rfc2182), section 3.1 clearly specifies that distinct authoritative name servers for a child domain should be placed in different topological and geographical locations. The objective is to minimise the likelihood of a single failure disabling all of them. 

The objective in this test is to check that more than one IP addresses of the domain's authoritative name servers does not belong to the same subnet

### Inputs

1. The IP addresses of the child domain's authoritative name servers

### Ordered description of steps to be taken to execute the test case

1. Find the list of all the name servers used by the domain. This list MUST contain all name servers from the parent delegation for the domain, and all name servers in the apex of the domain's zone itself
2. Find the IP addresses corresponding to the name servers in step1. In order to do that: <br/>
2.1. Collect all glue records from the parent for the domain <br/>
2.2. Collect all IP addresses of the name servers, authoritative for the domain from the domain's zone (i.e. the domain being tested) <br/>
2.3. Collect all the IP addresses used by out-of-bailwick name servers <br/>
3. Create a subnet list from each of the retrieved IP addresses obtained from step2, and define its range. For example, if it is IPv4 then the range is 28 and if it is IPv6, then the range is 64
4. Check the IP address in the input with the subnet list (obtained from step3)
5. If all distinct IP address falls in a single subnet range of the subnet list (obtained from step3), then the test fails  

### Outcome(s)

If there is a single IP address that has a subnet range which is different from the other IP addresses in the input, then the test succeeds

### Special procedural requirements

None
### Intercase dependencies

None
