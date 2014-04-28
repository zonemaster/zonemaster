## DELEGATION06: Existence of SOA

### Test case identifier

**DELEGATION06:** Existence of SOA

### Objective

Section 6.1 of the [RFC 2182](http://tools.ietf.org/html/rfc2182) specifies
that the SOA record is mandatory for every zone. 

This test is intended to verify the prescence of a SOA record for the
domain.

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Obtain the complete set of name servers from the parent using
   [Method2](../Methods.md) and the child using [Method3](../Methods.md).
2. Query for the SOA record.
3. If there is an answer with NOERROR and there is no content in the
   answer section, this test case fails.

### Outcome(s)

If there is a SOA record present for the domain this test case succeeds.

### Special procedural requirements

None

### Intercase dependencies

None
