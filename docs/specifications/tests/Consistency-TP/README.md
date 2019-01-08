# List of Consistency tests

This document uses the terminology defined in the [Master Test Plan](../MasterTestPlan.md).

## Mapping from Requirements to Test Case

|Req| Description                                                  | Test Case                       |
|:--|:-------------------------------------------------------------|:--------------------------------|
|R33|SOA serial number consistency                                 |[CONSISTENCY01](consistency01.md)|
|R34|RNAME consistency                                             |[CONSISTENCY02](consistency02.md)|
|R36|Coherence of SOA with primary nameserver  (SOA timers)        |[CONSISTENCY03](consistency03.md)|
|R70|Coherence of all other SOA-fields where SOA Serial is the same|[CONSISTENCY03](consistency03.md)|
|R78|All authoritative nameservers reply with same set             |[CONSISTENCY04](consistency04.md)|
|R83|Consistency between glue and authoritative data               |[CONSISTENCY05](consistency05.md)|
|R89|Coherence of SOA with primary nameserver (SOA MNAME)          |[CONSISTENCY06](consistency06.md)|
