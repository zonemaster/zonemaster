# List of Name Server tests

These are tests of the properties of a name server.

This document uses the terminology defined in the
[Master Test Plan](../Master%20Test%20Plan.md).

## Mapping from Requirements to Test Case

|Req| Description                                                              | Test Case |
|:--|:-------------------------------------------------------------------------|:----------|
|R42|check if server is really recursive                                       |[NAMESERVER01](nameserver01.md)|
|R43|nameserver doesn't allow recursion                                        |[NAMESERVER01](nameserver01.md)|
|R46|test if server is recursive                                               |[NAMESERVER01](nameserver01.md)|
|R72|Test of EDNS0 support                                                     |[NAMESERVER02](nameserver02.md)|
|R73|Test availability of zone transfer (AXFR)                                 |[NAMESERVER03](nameserver03.md)|
|R74|Answer from name server came from an IP address other than expected (wrong source IP)|[NAMESERVER04](nameserver04.md)|
