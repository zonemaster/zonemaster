# List of Name Server tests

These are tests of the properties of a name server.

These documents use the terminology defined in the
[Master Test Plan](../MasterTestPlan.md).

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
|R81|Test upward referral                      |[NAMESERVER07](nameserver07.md)|
|R82|Test QNAME case insensitivity             |[NAMESERVER08](nameserver08.md)|
|R80|Test QNAME case sensitivity               |[NAMESERVER09](nameserver09.md)|

-------

Copyright (c) 2013, 2014, 2015, IIS (The Internet Infrastructure Foundation)  
Copyright (c) 2013, 2014, 2015, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <https://creativecommons.org/licenses/by/4.0/>.
