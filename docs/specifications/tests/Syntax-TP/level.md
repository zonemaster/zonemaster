# List of Syntax tests

These are tests of the syntax of different labels in DNS, such as domain
names and host names.

This document uses the terminology defined in the
[Master Test Plan](../Master%20Test%20Plan.md).

## Mapping from Requirements to Test Case

|Req| Description                                                              | Test Case |
|:--|:-------------------------------------------------------------------------|:----------|
|R05|There must be no illegal symbols in the domain name                       |[SYNTAX01](syntax01.md)|
|R06|There must be no dash ('-') at the start or befinning of the domain name  |[SYNTAX02](syntax02.md)|
|R07|There must be no double dash ('--') in position 3 and 4 of the domain name|[SYNTAX03](syntax03.md)|
|R17|The NS name must have a valid domain/hostname                             |[SYNTAX04](syntax04.md)|
|R22|There must be no misused '@' character in the SOA RNAME field             |[SYNTAX05](syntax05.md)|
|R23|There must be no illegal characters in the SOA RNAME field                |[SYNTAX06](syntax06.md)|
|R24|There must be no illegal characters in the SOA MNAME field                |[SYNTAX07](syntax07.md)|
|R49|The MX name must have a valid domain/hostname                             |[SYNTAX08](syntax08.md)|

-------

Copyright (c) 2013, 2014, 2015, .SE (The Internet Infrastructure Foundation)  
Copyright (c) 2013, 2014, 2015, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <http://creativecommons.org/licenses/by/4.0/>.
