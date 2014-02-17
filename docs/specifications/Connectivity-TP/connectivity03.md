## CONNECTIVITY03: The IPv6 addresses of the authoritative name servers of the domain should not be part of a bogon prefix

### Test case identifier

**CONNECTIVITY03:** The IPv6 addresses of the authoritative name servers of the domain should not be part of a bogon prefix


### Objective

A bogon prefix is a route that should never appear in the Internet routing table. A packet routed over the public Internet (not including over VPNs or other tunnels) should never have a source address in a bogon range.

Bogons are reserved address defined in [RFC 1918](http://tools.ietf.org/html/rfc1918), [RFC 5735](http://tools.ietf.org/html/rfc5735) and [RFC 6598](http://tools.ietf.org/html/rfc6598) and are netblocks that have not yet been allocated to a RIR by IANA.

The objective of this test is to verify that the IPv6 addresses to which the child domain resolves is not that is defined as 'bogon prefix'


### Inputs

1. The domain to be tested

### Ordered description of steps to be taken to execute the test case

1. Find the list of all the name servers used by the domain. This list MUST contain all name servers from the parent delegation for the domain, and all name servers in the apex of the domain's zone itself
2. Find the IPv6 addresses corresponding to the name servers in step1. In order to do that: <br/>
2.1. Collect all IPv6 glue records from the parent for the domain <br/>
2.2. Collect all IPv6 addresses of the name servers, authoritative for the domain from the domain's zone (i.e. the domain being tested) <br/>
2.3. Collect all the IPv6 addresses used by out-of-bailwick name servers <br/>
3. The obtained IPv6 addresses are run against IPv6 bogon lists
4. If there is a match then the test fails

### Outcome(s)

If there is no match in the IPv6 bogon prefix blacklist for all the listed name servers then the test succeeds

### Special procedural requirements

None

### Intercase dependencies

None
