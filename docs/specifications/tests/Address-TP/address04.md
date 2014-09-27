## ADDRESS04: IPv6 address not part of bogon prefix

### Test case identifier

**ADDRESS04:** IPv6 address not part of bogon prefix

### Objective

A bogon prefix is a route that should never appear in the Internet routing
table. A packet routed over the public Internet (not including over VPNs or
other tunnels) should never have a source address in a bogon range.

Bogons are reserved address defined in [RFC
1918](https://tools.ietf.org/html/rfc1918), [RFC
5735](https://tools.ietf.org/html/rfc5735) and [RFC
6598](https://tools.ietf.org/html/rfc6598) and are netblocks that have not
yet been allocated to a RIR by IANA.

The objective of this test case is to verify that the IPv6 addresses to
which the child domain resolves is not that is defined as 'bogon prefix'.

### Inputs

The domain to be tested.

### Ordered description of steps to be taken to execute the test case

1. Obtains the IPv6 addresss of the name servers from [Method4]
   (../Methods.md) and [Method5](../Methods.md)
2. If any of the addresses obtained from the name servers is part of a bogon
prefix [Match with Team-cymru IPv6 bogon prefixes as explained here :
   (https://www.team-cymru.org/Services/Bogons/dns.html)]

### Outcome(s)

If there is no match in the IPv6 bogon prefix blacklist for all the listed
name servers then the test case passes.

### Special procedural requirements

None

### Intercase dependencies

None
