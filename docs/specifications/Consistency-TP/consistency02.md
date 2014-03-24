## CONSISTENCY02: The administrative contact must be consistent between authoritative name servers 

### Test case identifier

**CONSISTENCY02:** The administrative contact must be consistent between authoritative name servers

### Objective

All authoritative name servers must serve the same SOA record for the designated domain. [Technical reference to be provided]. As per section 3.3.13 of [RFC 1035]((http://tools.ietf.org/html/rfc1035),  the field "RNAME" in the SOA RDATA refers to the administrative contact.  The inconsistency in the administrative contact for the designated domain might result in operational failures being informed to different persons.

The objective of this test is to verify that the administrative contact is consistent between different authoritative name servers.

### Inputs

1. The domain name to be tested

### Ordered description of steps to be taken to execute the test case

1. Retrieve all the authoritative name servers for the fomain
2. The SOA record is queried from all the authoritative name servers for the domain. 
3. If the SOA administrative contact is not the same from all the answers received from step 2, then the test fails

### Outcome(s)
All authoritative name servers must have consistent administrative contact. If the test does not find any inconsistency, then the test succeeds

### Special procedural requirements	


### Intercase dependencies

None
