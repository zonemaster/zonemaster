## DELEGATION09: This test is done to verify that the NS records for the domain are same at the parent as well as at the child

### Test case identifier

**DELEGATION09:** Test to verify whether there is any mismatch between child
and parent NS records for a domain

### Objective

If the list of name servers for a domain obtained from its parent and from
its child zone does not match, then it leads to an inconsistency.

* Have to refer to an RFC or another technical document *

### Inputs

1. The label of the domain name to be tested

### Ordered description of steps to be taken to execute the test case

1. Obtain the list of name servers from [Method2](../Methods.md) and
[Method3](../Methods.md)
3. If the set of NS names on in [Method2](../Methods.md) and
[Method3](../Methods.md) are disjoint, then the test fails

### Outcome(s)

If the set of NS names on the parent side and the set of NS names on the
child side match, then the test succeeds

### Special procedural requirements

None

### Intercase dependencies

None
