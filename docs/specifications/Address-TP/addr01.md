## ADDR01: Name server address must not be in private network

### Test case identifier
**ADDR01** A name server address must not be in private network

### Objective

In order for the domain and its resources to be accessible, authoritative 
name servers must have addrresses in the public addressing space.

In section 3. of RFC 1918 (https://tools.ietf.org/rfc/rfc1918.txt), the
private address space is defined.

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Find the IP addresses of each name server of the domain checked. 
   Use the method described in [Master Test Plan](../Master Test Plan.md) 
   paragraph "Get the IP address records from the child zone".

2. Each IPv4 address has to be checked against the three
   blocks allocated to private networks : 10.0.0.0/8, 172.16.0.0/12 and
   192.168.0.0/16.

3. If any address matches one of the private blocks, the test case
   fails.

### Outcome(s)

If one name server address is part of a private network, the test fails.
If all the name server addresses are in the public addressing space, the
test succeeds.

### Special procedural requirements

None.

### Intercase dependencies

None.
