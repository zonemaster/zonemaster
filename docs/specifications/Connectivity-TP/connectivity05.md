## CONNECTIVITY05: Check whether all the IP addresses of the child domain's authoritative nameserver belong to same subnet


### Test case identifier
**CONNECTIVITY05:** Check whether all the IP addresses of the child domain's authoritative nameserver belong to same subnet

### Objective
[RFC 2182](http://tools.ietf.org/html/rfc2182), section 3.1 clearly specifies that distinct authoritative name servers for a child domain should be placed in different topological and geographical locations. The objective is to minimise the likelihood of a single failure disabling all of them. 

The objective in this test is to avoid more than one IP addresses of the authoritative name servers of the child domain belonging to the same subnet

### Inputs
1. The IP addresses of the child domain's authoritative name servers

### Ordered description of steps to be taken to execute the test case
1. Create a subnet list from each of the retrieved IP addresses, and define its range. For example if it is IPv4, then the range is 28 and if it is IPv6, then the range is 64
2. Check the IP address in the input with the subnet list.
3. If all distinct IP address falls in a single subnet range in the subnet list, then the test fails   

### Outcome(s)
If there is a single IP address that has a subnet range which is different from the other IP addresses in the input, then the test succeeds

### Special procedural requirements

### Intercase dependencies
None
