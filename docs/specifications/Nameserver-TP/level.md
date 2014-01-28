# List of Name Server tests

These are tests of the properties of a name server.

This document uses the terminology defined in the
[Master Test Plan](../Master%20Test%20Plan.md).

## Mapping from Requirements to Test Case

|Req| Description                                                              | Test Case |
|:--|:-------------------------------------------------------------------------|:----------|
|R42|check if server is really recursive                                       |[NS01](ns01.md)|
|R43|nameserver doesn't allow recursion                                        |[NS01](ns01.md)|
|R46|test if server is recursive                                               |[NS01](ns01.md)|
|R72|Test of EDNS0 support                                                     |[NS02](ns02.md)|
|R73|Test availability of zone transfer (AXFR)                                 |[NS03](ns03.md)|
|R74|Answer from name server came from an IP address other than expected (wrong source IP)|[NS04](ns04.md)|
