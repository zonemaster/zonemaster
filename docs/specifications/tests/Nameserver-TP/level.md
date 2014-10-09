# List of Name Server tests

These are tests of the properties of a name server.

These documents use the terminology defined in the
[Master Test Plan](../Master%20Test%20Plan.md).

## Mapping from Requirements to Test Case

|Req| Description                              | Test Case                     |
|:--|:-----------------------------------------|:------------------------------|
|R42|A name server should not be a recursor    |[NAMESERVER01](nameserver01.md)|
|R43|nameserver doesn't allow recursion        |[NAMESERVER01](nameserver01.md)|
|R46|test if server is recursive               |[NAMESERVER01](nameserver01.md)|
|R72|Test of EDNS0 support                     |[NAMESERVER02](nameserver02.md)|
|R73|Test availability of zone transfer (AXFR) |[NAMESERVER03](nameserver03.md)|
|R74|Same source address                       |[NAMESERVER04](nameserver04.md)|
|R53|behaviour against AAAA query              |[NAMESERVER05](nameserver05.md)|
|R19|NS can be resolved                        |[NAMESERVER06](nameserver06.md)|
