# List of basic DNS tests

This document uses the terminology defined in the [Master Test Plan](../Master%20Test%20Plan.md).

## Mapping from Requirements to Test Case

|Req| Description                                                          | Test Case |
|:--|:---------------------------------------------------------------------|:----------|
|R33|Coherence of serial number with primary nameserver|[CONSISTENCY1](./consistency01.md)|
|R34|Coherence of administrative contact with primary nameserver|[CONSISTENCY02](./consistency02.md)|
|R35|Coherence of master with primary nameserver|[CONSISTENCY03](./consistency03.md)|
|R36|Coherence of SOA with primary nameserver|[CONSISTENCY04](./consistency04.md)|
|R45|Correctness of given nameserver list|[DELEGATION09](../Delegation-TP/delegation09.md)|
|R70|Coherence of all other SOA-fields where SOA Serial is the same|[CONSISTENCY04](./consistency04.md)|
