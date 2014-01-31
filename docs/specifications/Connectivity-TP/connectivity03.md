## CONNECTIVITY03: The IP addresses of the authoritative name servers of the child domain should not be part of a bogon prefix

### Test case identifier
**CONNECTIVITY03:** The IP addresses of the authoritative name servers of the child domain should not be part of a bogon prefix


### Objective
A bogon prefix is a route that should never appear in the Internet routing table. A packet routed over the public Internet (not including over VPNs or other tunnels) should never have a source address in a bogon range.

Bogons are reserved address defined in [RFC 1918](http://tools.ietf.org/html/rfc1918), [RFC 5735](http://tools.ietf.org/html/rfc5735) and [RFC 6598](http://tools.ietf.org/html/rfc6598) and are netblocks that have not yet been allocated to a RIR by IANA.

The objective of this test is to verify that the IP addresses to which the child domain resolves is not that is defined as 'bogon prefix'


### Inputs
1. The IP addresses (IPv4 and IPv6) of the listed authoritative name servers of the child domain

### Ordered description of steps to be taken to execute the test case
1. Each of the retrieved IP addresses are run against the bogon black list
2. If there is a match then the test fails

### Outcome(s)
If there is no match in the bogon prefix blacklist for all the listed name servers then the test succeeds

### Special procedural requirements

### Intercase dependencies
None
