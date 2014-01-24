## ZONE09: MX is not an alias

### Test case identifier
**ZONE09** MX is not an alias

### Objective

An MX type record for a domain must not be a CNAME, following the text
in section 10.3 of [RFC 2181](http://tools.ietf.org/html/rfc2181).

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
