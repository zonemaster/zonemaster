# List of Zone tests

These are tests of the zone content in DNS, such as SOA and
MX records.

This document uses the terminology defined in the
[Master Test Plan](../Master%20Test%20Plan.md).

## Mapping from Requirements to Test Case

|Req| Description                                                              | Test Case |
|:--|:-------------------------------------------------------------------------|:----------|
|R25|Fully qualified master nameserver in SOA                                  |[ZONE01](zone01.md)|
|R26|SOA 'refresh' at least 6 hours                                            |[ZONE02](zone02.md)|
|R27|SOA 'retry' lower than 'refresh'                                          |[ZONE03](zone03.md)|
|R28|SOA 'retry' at least 1 hour                                               |[ZONE04](zone04.md)|
|R29|SOA 'expire' at least 7 days                                              |[ZONE05](zone05.md)|
|R31|SOA 'minimum' less than 1 day                                             |[ZONE06](zone06.md)|
|R32|SOA master is not an alias                                                |[ZONE07](zone07.md)|
|R50|MX is not an alias                                                        |[ZONE08](zone08.md)|
|R47|MX record present                                                         |[ZONE09](zone09.md)|
|R52|MX can be resolved                                                        |[ZONE09](zone09.md)|

-------

Copyright (c) 2013, 2014, 2015, IIS (The Internet Infrastructure Foundation)  
Copyright (c) 2013, 2014, 2015, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <http://creativecommons.org/licenses/by/4.0/>.
