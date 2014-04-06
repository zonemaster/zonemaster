## DELEGATION08:Test the existence of SOA record in the domain's zone

### Test case identifier

**DELEGATION08:** Test the existence of SOA record in the domain's zone 

### Objective

Section 6.1 of the [RFC 2182](http://tools.ietf.org/html/rfc2182) specifies
that the SOA record is mandatory for every zone. 

This test is intended to verify the prescence of a SOA record in the
domain's zone.

### Inputs

1. The label of the domain to be tested

### Ordered description of steps to be taken to execute the test case

1. Obtain the list of name servers from [Method2](../Methods.md) and
[Method3](../Methods.md)
2. Apply [Method6](../Methods.md) to all the authoritative name servers for
the domain.
3. If there is no result from step2, the test fails

### Outcome(s)

If there is a single answer in step 2, then the test succeeds

### Special procedural requirements

None

### Intercase dependencies

None
