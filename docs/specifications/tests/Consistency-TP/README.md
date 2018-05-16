# List of Consistency tests

This document uses the terminology defined in the [Master Test Plan](../MasterTestPlan.md).

## Mapping from Requirements to Test Case

|Req| Description                                                  | Test Case                       |
|:--|:-------------------------------------------------------------|:--------------------------------|
|R33|SOA serial number consistency                                 |[CONSISTENCY01](consistency01.md)|
|R34|RNAME consistency                                             |[CONSISTENCY02](consistency02.md)|
|R36|Coherence of SOA with primary nameserver                      |[CONSISTENCY03](consistency03.md)|
|R70|Coherence of all other SOA-fields where SOA Serial is the same|[CONSISTENCY03](consistency03.md)|
|R78|All authoritative nameservers reply with same set             |[CONSISTENCY04](consistency04.md)|
|R83|Consistency between glue and authoritative data               |[CONSISTENCY05](consistency05.md)|

-------

Copyright (c) 2013, 2014, 2015, IIS (The Internet Infrastructure Foundation)  
Copyright (c) 2013, 2014, 2015, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <https://creativecommons.org/licenses/by/4.0/>.
