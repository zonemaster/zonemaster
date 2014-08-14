## SYNTAX02: Domain name length

### Test case identifier

**SYNTAX02:** Domain name length

### Objective
Section 3.1 of [RFC 1035](https://tools.ietf.org/html/rfc1035) mentions that the
the total length of a domain name (i.e., label octets and label length octets) 
is restricted to 255 octets or less.

The objective for this test is verify whether the engine conforms to the
specification described in the previous paragraph

### Inputs

The domain to be tested.

### Ordered description of steps to be taken to execute the test case

1. Configure a live zone, wherein the length of the domain is 255 octets
2. A standard query for the domain is made
3. If the query don’t receive an appropriate response the test returns with
FAIL
4. Modify the length of the domain from 255 to 256 by increasing one of the
label length
5. A standard query for the domain is made
6. If the query don't receive Error response, the test returns with FAIL 

### Outcome(s)

The engine should capture the label length functionality as specified in
RFC 1035 and return PASS and if not, returns FAIL

### Special procedural requirements	

None

### Intercase dependencies

None
