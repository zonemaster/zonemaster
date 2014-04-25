## DELEGATION05: Test that the NS record is not pointing to a CNAME alias

### Test case identifier

**DELEGATION05:** Test that the NS record is not pointing to a CNAME alias 

### Objective

[RFC 1912](http://tools.ietf.org/html/rfc1912) mentions that NS records
pointing to CNAME is forbidden. 

The objective of this test is to verify that name servers does not point to
a CNAME record

### Inputs

1. The label of the domain name to be tested

### Ordered description of steps to be taken to execute the test case

1. Obtain the list of name servers from [Method2](../Methods.md) and
[Method3](../Methods.md)
2. All name servers obtained as the result of step 1 are queried for A and
AAAA records
3. If any of the name server queried responded with the resource record type
CNAME, then the test fails

### Outcome(s)

If none of the response contains the resource record type CNAME then the test succeeds

### Special procedural requirements

None

### Intercase dependencies

None
