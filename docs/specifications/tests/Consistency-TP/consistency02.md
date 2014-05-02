## CONSISTENCY02: RNAME consistency

### Test case identifier

**CONSISTENCY02:** RNAME consistency

### Objective

All authoritative name servers must serve the same SOA record (section
4.2.1 of [RFC 1034](https://tools.ietf.org/html/rfc1034) for the
tested domain. As per section 3.3.13 of [RFC 1035](https://tools.ietf.org/html/rfc1035),
the RNAME field in the SOA RDATA refers to the administrative contact. The inconsistency in
the administrative contact for the a domain might result in operational
failures being informed to different persons.

The objective of this test is to verify that the administrative contact is
consistent between different authoritative name servers.

### Inputs

1. The domain name to be tested

### Ordered description of steps to be taken to execute the test case

1. Obtain the list of name servers from [Method2](../Methods.md) and
   [Method3](../Methods.md).
2. Retrieve the SOA RR from all the name servers. 
3. If the SOA RNAME field is not the same from all the answers
   received from step 2, then the test case fails.

### Outcome(s)
All authoritative name servers must have consistent RNAME field.
If the test does not find any inconsistency, then the test succeeds.

### Special procedural requirements	

None

### Intercase dependencies

None
