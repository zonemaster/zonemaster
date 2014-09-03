## SYNTAX03: Character set restriction for label

### Test case identifier

**SYNTAX03:** Character set restriction for label

### Objective

Even though section 11 of [RFC 2181](https://tools.ietf.org/html/rfc2181) mentions 
that any binary string could be part of a label, many of the registries will
not permit special symbols in the label. This is an habit purused by the
registried based on section 2.1 of the the [RFC 1123](https://tools.ietf.org/html/rfc1123),
i.e. following the LDH (Letters, Digits and Hyphen) format. Even for the
IDNs [RFC 5892](https://tools.ietf.org/html/rfc5892) limits to the LDH
format.  

The objective for this test is verify whether the engine identifies the
domain names which is not in the LDH format. 

### Inputs

The domain to be tested.

### Ordered description of steps to be taken to execute the test case

1. Configure a live zone, wherein the label for the domain has characters
other than LDH
2. A standard query for the domain is made
3. If the query don't receive Error response, the test returns with FAIL 

### Outcome(s)

The engine should capture the LDH limitation and return PASS and if not, 
returns FAIL

### Special procedural requirements	

A FAIL for this test does not automatically indicate there is a procedural
failure

### Intercase dependencies

None
