## DELEGATION07: This test is done to verify whether all glue name records
are present at the child

### Test case identifier

**DELEGATION07:** Test to verify whether all glue name records are present
at the child 

### Objective

If the list of name servers for a domain obtained from its parent are not
found in its its child zone, then it leads to an inconsistency.

* Have to refer to an RFC or another technical document *

### Inputs

1. The label of the domain name to be tested

### Ordered description of steps to be taken to execute the test case

1. Obtain the list of name servers from [Method2](../Methods.md) and
[Method3](../Methods.md)
3. If the set of NS names obtained from [Method2](../Methods.md) are 
not found in [Method3](../Methods.md) , then the test fails

### Outcome(s)

If the set of glue name records obtained are found in the list of name
servers obtained from the child also, then the test succeeds

### Special procedural requirements

None

### Intercase dependencies

None
