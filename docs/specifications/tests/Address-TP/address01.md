## ADDRESS01: Name server address must be globally routable

### Test case identifier
**ADDRESS01** A name server address must be in the globally routable public
 address space.

### Objective

In order for the domain and its resources to be accessible, authoritative 
name servers must have addresses in the routable public addressing space.

IANA is responsible for global coordination of the IP addressing system.
Aside its address allocation activities, it maintains reserved address ranges
for special uses. These ranges can be categorized into three types : 
[Special purpose IPv4
addresses](http://www.iana.org/assignments/iana-ipv4-special-registry/iana-ipv4-special-registry.txt),
[Special purpose IPv6
addresses](http://www.iana.org/assignments/iana-ipv6-special-registry/iana-ipv6-special-registry.txt)
and [Multicast reserved
addresses](https://www.iana.org/assignments/multicast-addresses/multicast-addresses.txt).


### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Obtain the IP addresses of each name server of the domain checked using
   [Method5](../Methods.md)

2. Each IP address has to be checked against the blocks listed in the three tables below.
 
3. If any IP address matches one of the block, the test case fails.


| IPv4 Special purpose adresses |||
|---------------------|----------------------------|--------------|
| **Address Block**   | **Name**                   | **Reference**|
| 0.0.0.0/8          | "This host on this network" | RFC 1122     |
| 10.0.0.0/8, <br>192.168.0.0/16,<br>172.16.0.0/12 | Private-Use  | RFC 1918     |
| 100.64.0.0/10      | Shared Address Space        | RFC 6598     |
| 127.0.0.0/8        | Loopback                    | RFC 1122     |
| 169.254.0.0/16     | Link Local                  | RFC 3927     |
| 192.0.0.0/24       | IETF Protocol Assignments   | RFC 6890     |
| 192.0.0.0/29       | DS-Lite                     | RFC 6333     |
| 192.0.0.170/32,<br>192.0.0.171/32| NAT64/DNS64 Discovery        | RFC 7050     |
| 192.0.2.0/24,<br>198.51.100.0/24,<br>203.0.113.0/24             | Documentation               | RFC 5737     |
| 192.88.99.0/24     | 6to4 Relay Anycast          | RFC 3068     |
| 198.18.0.0/15      | Benchmarking                | RFC 2544     |
| 240.0.0.0/4        | Reserved                    | RFC 1112     |
| 255.255.255.255/32 | Limited Broadcast           | RFC 919      |

Table: IPv4 special purpose blocks


| IPv6 Special purpose adresses |||
|---------------------|----------------------------|--------------|
| **Address Block**   | **Name**                   | **Reference**|
|::1/128	      |Loopback Address	           | RFC 4291     |
|::/128	              |Unspecified Address	   | RFC 4291     | 
|::ffff:0:0/96        |IPv4-mapped Address	   | RFC 4291     |
|64:ff9b::/96         |IPv4-IPv6 Translation	   | RFC 6052     | 
|100::/64	      |Discard-Only Address Block  | RFC 6666     |
|2001::/23	      |IETF Protocol Assignments   | RFC 2928     | 
|2001::/32	      |TEREDO	                   | RFC 4380     |
|2001:2::/48          |Benchmarking	           | RFC 5180     |
|2001:db8::/32        |Documentation	           | RFC 3849     |
|2001:10::/28         |Deprecated (ORCHID)	   | RFC 4843     | 
|2002::/16	      |6to4 	                   | RFC 3056     |
|fc00::/7	      |Unique-Local 	           | RFC 4193     |
|fe80::/10	      |Linked-Scoped Unicast	   | RFC 4291     |
|::<ipv4-address>/96  |Deprecated (IPv4-compatible Address)| RFC 4291     | 
|5f00::/8 <br> 3ffe::/16 | unallocated (ex 6bone)  | RFC 3701     |
|::/0                 |Default route               | RFC 5156     |  

Table: IPv6 special purpose blocks


| Multicast adresses |||
|---------------------|----------------------------|--------------|
| **Address Block**      | **Name**                | **Reference**|
| 224.0.0.0/4        | IPv4 multicast addresses    | RFC 5771     |
| ff00::/8           | IPv6 multicast addresses    | RFC 4291     |

Table: Multicast blocks

### Outcome(s)

If one name server has one of its addresses matches a forbidden address block , the test fails.
If all the name server addresses are outside these forbidden blocks, the test case succeeds. 

### Special procedural requirements

None.

### Intercase dependencies

None.














