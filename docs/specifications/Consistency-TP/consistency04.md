## CONSISTENCY04: The RDATA fields "REFRESH", "RETRY", "EXPIRE" and "MINIMUM"  must be consistent between authoritative name servers

### Test case identifier

**CONSISTENCY04:**  The RDATA fields "REFRESH", "RETRY", "EXPIRE" and "MINIMUM" must be consistent between authoritative name servers

### Objective
All authoritative name servers must serve the same SOA record for the designated domain. [Technical reference to be provided]. As per section 3.3.13 of [RFC 1035](http://tools.ietf.org/html/rfc1035),  the field "REFRESH" in the SOA RDATA refers to the 32 bit time interval before the zone should be refereshed. The field "RETRY" refers to the 32 bit interval before a failed refresh should be retried, the field "EXPIRE" refers to a 32 bit time value that specifies the upper limit on
the time interval that can elapse before the zone is no longer authoritative and the field "MINIMUM" is the unsigned 32 bit minimum TTL field that should be exported with any resource record from the domain's zone

The inconsistency in these different fields for the designated zone (*Got to Verify*) might result in operational inconsistencies.

### Inputs

1. The domain name to be tested

### Ordered description of steps to be taken to execute the test case

1. Retrieve all the authoritative name servers for the fomain
2. The SOA record is queried from all the authoritative name servers for the domain.
3. If the SOA values "REFRESH", "RETRY", "EXPIRE" and "MINIMUM" not the same from all the answers received from step 2, then the test fails

### Outcome(s)

All authoritative name servers must have consistent "REFRESH", "RETRY", "EXPIRE" and "MINIMUM"  SOA values. If the test does not find any inconsistency, then the test succeeds

### Special procedural requirements	

None

### Intercase dependencies

This test is done only when [CONSISTENCY01](./consistency01.md) succeeds
