## ADDRESS01: Name server address must be globally routable

### Test case identifier
**ADDRESS01** Name server address must be globally routable

### Objective

In order for the domain and its resources to be accessible, authoritative 
name servers must have addresses in the routable public addressing space.

IANA is responsible for global coordination of the IP addressing system.
Aside its address allocation activities, it maintains reserved address ranges
for special uses. These ranges can be categorized into three types : 
[Special purpose IPv4
addresses](https://www.iana.org/assignments/iana-ipv4-special-registry/iana-ipv4-special-registry.xml),
[Special purpose IPv6
addresses](https://www.iana.org/assignments/iana-ipv6-special-registry/iana-ipv6-special-registry.xml)
and [Multicast reserved
addresses](https://www.iana.org/assignments/multicast-addresses/multicast-addresses.xml).

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Obtain the IP addresses of each name server of the domain from the parent using
   [Method4](../Methods.md) and child using [Method5](../Methods.md)

2. If any IP address (IPv4 or IPv6) falls within any of the blocks in the below
   mentioned IANA links, the test case fails:
   * <http://www.iana.org/assignments/iana-ipv4-special-registry/iana-ipv4-special-registry.xhtml>
   * <http://www.iana.org/assignments/iana-ipv6-special-registry/iana-ipv6-special-registry.xhtml>

### Outcome(s)

If one name server has one of its addresses matches a forbidden address
block, the test fails. If all the name server addresses are outside these
forbidden blocks, the test case succeeds. 

### Special procedural requirements

The registries listed in bullet 2 above must be fetched prior to testing 

### Intercase dependencies

None.
