## BEHAVIOR02: NODATA returned in response in the event of querying a 
domain name that exists but no relevant answers in the answer section

### Test case identifier

**BEHAVIOR02:** NODATA returned in response in the event of querying a 
domain name that exist but no relevant answers in the answer section

### Objective 
Section 1 of [RFC 2308](https://tools.ietf.org/html/rfc2308) mentions that
"NODATA" is a pseudo RCODE. "NODATA" indicates that there are RRs for the requested
domain name, but none of them match the record type queried.

"NODATA" is indicated by an answer with RCODE set to "NOERROR" (defined in RFC
[RFC 1035](https://tools.ietf.org/html/rfc1035)) and no relevant answers in the
answer section.

This test is to verify whether the engine responds with NODATA when
querying a domain name that exists, but the queried record type does not exist.

### Inputs

The domain to be tested. The domain should be already delegated in the DNS, but
the queried record type should not exist.

### Ordered description of steps to be taken to execute the test case

1. A standard query for the domain is made, querying for the record type that
does not exist in the zone
2. The response should contain an RCODE NOERROR 
3. The response should contain an AUTHORITY section but no ANSWER section
4. If the response contains data contrary to steps 2 and 3, the test returns with FAIL

### Outcome(s)

If the test does not return FAIL, then the engine does not capture correctly
NODATA scenario

### Special procedural requirements	

None

### Intercase dependencies

None
