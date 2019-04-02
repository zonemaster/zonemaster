## DELEGATION05: NS RR does not point to CNAME alias

### Test case identifier

**DELEGATION05:** NS RR does not point to CNAME alias 

### Objective

[RFC 1912](https://tools.ietf.org/html/rfc1912) mentions that NS records
pointing to CNAME is forbidden. 

The objective of this test is to verify that name servers does not point to
a CNAME record.

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Obtain the complete set of name server address records from the parent using
   [Method4](../Methods.md) and the child using [Method5](../Methods.md).
2. All the uniquely obtained address records are queried for A and AAAA records.
3. If any of the name server queried responded with the resource record type
   CNAME, then this test case fails.

### Outcome(s)

If none of the response contains the resource record type CNAME then the
test succeeds.

### Special procedural requirements

None

### Intercase dependencies

None
