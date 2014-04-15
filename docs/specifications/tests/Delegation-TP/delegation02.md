## DELEGATION02: Verify that the nameservers delegated has distinct IP addresses

### Test case identifier

**DELEGATION02:** Verify that the nameservers delegated has distinct IP addresses

### Objective

Even though none of the RFC seems to explicitly state, but it is clear that
distinct name server records for a domain must not resolve to the same IP
address for resilience

### Inputs

The label of the domain name to be tested

### Ordered description of steps to be taken to execute the test case

1. Obtain the list of name servers from [Method2](../Methods.md) and
[Method3](../Methods.md)
2. Obtains the IP addresss of the name servers from [Method4](../Methods.md)
and [Method5](../Methods.md)
3. If the list of IP address obtained in step2 are not unique, then the test fails


### Outcome(s)

If all the IP addresses obtained are unique, then the test succeeds

### Special procedural requirements

None 

### Intercase dependencies

None
