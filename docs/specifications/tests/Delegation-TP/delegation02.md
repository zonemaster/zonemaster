## DELEGATION02: Name servers must have distinct IP addresses

### Test case identifier

**DELEGATION02:** Name servers must have distinct IP addresses

### Objective

If the domain have several different name server names used, they can all
be using the same IP address. This may be due to a configuration error, or
a workaround to a certain policy restriction. This test case checks that
the name servers used does not resolve to reuse the same IP addresses.

Section 4.1 of [RFC 1034](http://tools.ietf.org/html/rfc1034) says at least
to name servers must be used for a delegation. 

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Obtain the complete set of name servers from the parent using
   [Method2](../Methods.md) and the child using [Method3](../Methods.md).
2. Obtains the IP addresss of the name servers from the parent using
   [Method4](../Methods.md) and the child using [Method5](../Methods.md),
   and do recursive lookups for the name servers that are out of bailiwick.
3. If any of the IP addresses resolved in step 2 are not unique, then this
   test case fails.


### Outcome(s)

If all the IP addresses used by the name servers for the domain are unique,
then the test succeeds.

### Special procedural requirements

None 

### Intercase dependencies

None
