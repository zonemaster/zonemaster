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


### Outcome(s)

The engine should return FAIL for each zone configured. If it returns PASS for 
any of the the configured zone, then the engine does not capture completely lame
delegation.

### Special procedural requirements	

None

### Intercase dependencies

None
