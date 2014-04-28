# List of basic DNS tests

This document uses the terminology defined in the [Master Test Plan](../Master%20Test%20Plan.md).

## Mapping from Requirements to Test Case

|Req| Description                                                  | Test Case                       |
|:--|:-------------------------------------------------------------|:--------------------------------|
|R33|Serial number consistency                                     |[CONSISTENCY01](consistency01.md)|
|R34|RNAME consistency                                             |[CONSISTENCY02](consistency02.md)|
|R36|Coherence of SOA with primary nameserver                      |[CONSISTENCY03](consistency03.md)|
|R45|Correctness of given nameserver list                          |[DELEGATION09](../Delegation-TP/delegation09.md)|
|R70|Coherence of all other SOA-fields where SOA Serial is the same|[CONSISTENCY03](consistency03.md)|
