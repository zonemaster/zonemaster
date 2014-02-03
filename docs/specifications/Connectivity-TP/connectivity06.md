## CONNECTIVITY06: Check whether all the IP addresses of the child domain's authoritative nameserver belong to same AS


### Test case identifier
**CONNECTIVITY06:** Check whether all the IP addresses of the child domain's authoritative nameserver belong to same AS

### Objective
[RFC 2182](http://tools.ietf.org/html/rfc2182), section 3.1 clearly specifies that distinct authoritative name servers for a child domain should be placed in different topological and geographical locations. The objective is to minimise the likelihood of a single failure disabling all of them. 

The objective in this test is to avoid more than one IP addresses of the authoritative name servers of the child domain belonging to the same subnet

### Inputs
1. The IP addresses of the child domain's authoritative name servers

### Ordered description of steps to be taken to execute the test case
1. Retrieve the AS (name) for each IP address in the input 
2. If all the retrieved AS are same, then the test fails

### Outcome(s)
If there is a AS which is different from the other retrieved AS, then the test succeeds

### Special procedural requirements

### Intercase dependencies
None
