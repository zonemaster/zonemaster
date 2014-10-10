## CONSISTENCY04: Name server NS consistency

### Test case identifier

**CONSISTENCY04:** Name server NS consistency

### Objective

All authoritative name servers must serve the same NS record set
(section 4.2.2) of [RFC 1034](https://tools.ietf.org/html/rfc1034)
for the tested domain. Any inconsistency of NS records descibed in
section 3.3.11 of [RFC 1035](https://tools.ietf.org/html/rfc1035)
might result in operational failures.

The objective of this test is to verify that the NS records are
consistent between all the authoritative name servers.

### Inputs

1. The domain name to be tested

### Ordered description of steps to be taken to execute the test case

1. Obtain the list of name servers from [Method4](../Methods.md) and
   [Method5](../Methods.md).
2. Retrieve the NS RR set from all the name servers. 
3. If the NS RR set is not give the same answer from all the name
   servers, this test case fails.

### Outcome(s)

If not all the designated authoritative name servers answer with the
same NS RR set, this test case fails.

### Special procedural requirements	

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
on the ignored result.

### Intercase dependencies

None
