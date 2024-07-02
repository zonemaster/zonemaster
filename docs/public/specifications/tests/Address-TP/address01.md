## ADDRESS01: Name server address must be globally routable

### Test case identifier
**ADDRESS01** 

## Table of contents

* [Objective](#Objective)
* [Scope](#Scope)
* [Inputs](#Inputs)
* [Summary](#Summary)
* [Test procedure](#Test-procedure)
* [Outcome(s)](#Outcomes)
* [Intercase dependencies](#Intercase-dependencies)


### Objective

In order for the domain and its resources to be accessible, authoritative 
name servers must have addresses in the routable public addressing space.

IANA is responsible for global coordination of the IP addressing system.
Aside its address allocation activities, it maintains reserved address ranges
for special uses. These ranges can be categorized into three types:

* [Special purpose IPv4
addresses](https://www.iana.org/assignments/iana-ipv4-special-registry/iana-ipv4-special-registry.xml)
* [Special purpose IPv6
addresses](https://www.iana.org/assignments/iana-ipv6-special-registry/iana-ipv6-special-registry.xml)
* [Multicast reserved
addresses](https://www.iana.org/assignments/multicast-addresses/multicast-addresses.xml).

### Scope

IP addresses from authoritative name servers are matched against IANAS list of public routable address ranges.

### Inputs

* The domain name to be tested.

### Summary

Message Tag          | Level    | Arguments     | Message ID for message tag
:--------------------|:---------|:--------------|:--------------------------
A01_IP_ADDRESSES_GLOBALLY_REACHABLE | INFO     |ns_list | IP addresses in "{ns_list}" listed as globally reachable.
A01_NO_GLOBALLY_REACHABLE_IP_ADDRESSES | CRITICAL     |ns_list | None of the IP addresses in "{ns_list}" listed as globally reachable.
A01_IP_ADDRESS_NOT_GLOBALLY_REACHABLE| ERROR     |ns | IP adress for "{ns}" not listed as globally reachable..
A01_PRIVATE_IP_ADDRESS| ERROR     |ns | IP adress for "{ns}" part of RFC1918 private address ranges.


The value in the Level column is the default severity level of the message. The
severity level can be changed in the [Zonemaster-Engine profile]. Also see the
[Severity Level Definitions] document.

The argument names in the Arguments column lists the arguments used in the
message. The argument names are defined in the [argument list].

### Test procedure 

1. Obtain the IP addresses of each name server of the domain from the parent using
   [Method4](../Methods.md) and child using [Method5](../Methods.md)

2. If any IP address (IPv4 or IPv6) is *not* indicated to be "Globally Reachable" in the IANA 
   documentation linked above, the test case fails.

### Outcome(s)

If one name server has one of its addresses matches a forbidden address
block, the test fails. If all the name server addresses are outside these
forbidden blocks, the test case succeeds. 

### Special procedural requirements

The registries listed in the [Objective](#Objective) section above must be fetched prior to testing.

### Intercase dependencies

None.
