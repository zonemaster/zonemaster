## DELEGATION10:Test whether the ANSWER for SOA is authoritative

### Test case identifier
**DELEGATION10:** Test whether the ANSWER for SOA is authoritative 

### Objective
Section 6.1 of the [RFC 2182](http://tools.ietf.org/html/rfc2182) states that the name server record in the SOA is authoritative for all resource records in a zone that are not in another zone.

This test is inteded to verify whether the name server record in the SOA od the child domain's zone i authoritative for that zone.

### Inputs
1. The FQDN of the zone

### Ordered description of steps to be taken to execute the test case
1. An SOA query is sent using the provided FQDN of the zone
2. If there are no DNS ANSWERS for the query then the test fails

### Outcome(s)
If the response contains a single ANSWER for the query, then the test succeeds

### Special procedural requirements
None

### Intercase dependencies
None
