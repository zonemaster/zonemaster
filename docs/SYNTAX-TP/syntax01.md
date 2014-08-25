## SYNTAX01: Label length

### Test case identifier

**SYNTAX01:** Label length

### Objective
In DNS, domain names are expressed in terms of a sequence of labels. Section 
2.3.1 of [RFC 1035](https://tools.ietf.org/html/rfc1035) mentions that the 
label must be 63 characters or less.

The objective for this test is verify whether the engine conforms to the
specification described in the previous paragraph.

### Inputs

The domain to be tested.

### Ordered description of steps to be taken to execute the test case

1. Configure a live zone, wherein one of the label length of the domain is 1
2. A standard query for the domain is made
3. If the query don’t receive an appropriate response the test returns with
FAIL
4. Modify the label length of the domain from 1 to 63
5. A standard query for the domain is made
6. If the query don’t receive an appropriate response the test returns with
FAIL 
7. Modify the label length of the domain from 63 to 64
8. A standard query for the domain is made
9. If the query don't receive Error response, the test returns with FAIL 

### Outcome(s)

The engine should capture the label length functionality as specified in
RFC 1035 and return PASS and if not, returns FAIL

### Special procedural requirements	

None

### Intercase dependencies

None
