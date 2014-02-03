## DELEGATION07: Test that the NS record is not pointing to a CNAME alias

### Test case identifier
**DELEGATION07:** Test that the NS record is not pointing to a CNAME alias 

### Objective
[RFC 1912](http://tools.ietf.org/html/rfc1912) mentions that NS records pointing to CNAME is forbidden. 

The objective of this test is to verify that name servers does not point to a CNAME record

### Inputs
1. FQDN of the authoritative name servers

### Ordered description of steps to be taken to execute the test case
1. For each name server, the authority and answer section is queried
2. If any of the response contains the resource record type CNAME, then the test fails

### Outcome(s)
If none of the response contains the resource record type CNAME then the test succeeds

### Special procedural requirements
None

### Intercase dependencies
None
