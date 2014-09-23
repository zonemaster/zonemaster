## CONFIGURATION03: Lame Delegation 

### Test case identifier

**CONFIGURATION03:** Lame delegation

### Objective 

Lame delegation errors happen when a name server that is registered in the DNS
system as authoritative for a zone does not provide authoritative answers for
the zone.


### Inputs

The domain to be tested.

### Ordered description of steps to be taken to execute the test case

1. Configure a zone with lame delegation features
2. Obtain the complete set of name servers (from the parent using
[Method2](../../tests/Methods.md) if exists and the child using [Method3]
(../../tests/Methods.md)).
3. Query the RRs in the zone with the unique set of name servers
obtained from step2.
4. For each RR in the zone tested, check whether the name server is able to provide an
authoritative answer ("AA-bit" is set in the answer)
5. If the query flag doesn't contain a "AA-bit" set in the answer, the test
returns with FAIL


### Outcome(s)

The engine should return FAIL for each zone configured. If it returns PASS for 
any of the the configured zone, then the engine does not capture completely lame
delegation.

### Special procedural requirements	

None

### Intercase dependencies

None
