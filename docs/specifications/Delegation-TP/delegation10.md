## DELEGATION10:Test whether the ANSWER for SOA is authoritative

### Test case identifier
** DELEGATION10: ** Test whether the ANSWER for SOA is authoritative 

### Objective

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
