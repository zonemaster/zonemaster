# List of Address tests

These tests focuses on the Address specific test cases of the DNS tests.

This document uses the terminology defined in the
[Master Test Plan](../Master%20Test%20Plan.md).

## Mapping from Requirements to Test Case

|Req| Description                                                              | Test Case         |
|:--|:-------------------------------------------------------------------------|:------------------|
|R03| Nameserver address must not be in  private network                       |[ADDR01](addr01.md)|
|R40| Reverse DNS entry exists for nameserver IP address                       |[ADDR02](addr02.md)|
|R41| Reverse DNS entry matches nameserver name                                |[ADDR03](addr03.md)|
|X37| IPv4 loopback address is not forward to root name servers                |[ADDR04](addr04.md)|
|X38| IPv6 loopback address is not forward to root name servers                |[ADDR05](addr05.md)|



## Comments

ZoneCheck has two test cases about loopback addresses : it checks if (a) these
adresses are delegated at the domain name servers (requirement R37) and (b) 
they are resolvable (requirements R38).

The reason behind that was not to forward loopback address queries to root name
servers and to comply with RFC 1912 (section 4.1)

R37 and R38 have been replaced here by two different requirements : one for the
IPv4 loopback address and the other for the IPv6 loopback address. The
requirement here is either a name server is authoritative for these addresses
or it refuses requests about these addresses.

Moreover and for legacy reasons, for IPv4 loopback addresses we have chosen to
check, in the case where a name server is not authoritative for the zone 
127.in-addr.arpa, if it is authoritative for 0.127.in-addr.arpa or 
0.0.127.in-addr.arpa. 

