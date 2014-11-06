## RESTRICTION02: Domain name length

### Test case identifier

**RESTRICTION02:** Domain name length

### Objective
Section 3.1 of [RFC 1035](https://tools.ietf.org/html/rfc1035) mentions that the
the total length of a domain name (i.e., label octets and label length octets) 
is restricted to 255 octets or less.

The objective for this test is verify whether the engine conforms to the
specification described in the previous paragraph

### Results
Since it is not possible to fit in more than 255 octets in a DNS 
packet, this test is not run.
