## ZONE08: MX is not an alias

### Test case identifier
**ZONE08** MX is not an alias

### Objective

An MX type record for a domain must not resolve to a CNAME, following
the text in section 10.3 of [RFC 2181](http://tools.ietf.org/html/rfc2181)
and section 2.3.5 in
[RFC 5321](http://tools.ietf.org/html/rfc5321#section-2.3.5).

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Query the MX record for the domain name.
2. If the MX answer is a CNAME, this test case fails.

### Outcome(s)

If the MX record for the domain is pointing to a CNAME, this test case
fails.

### Special procedural requirements

None.

### Intercase dependencies

None.
