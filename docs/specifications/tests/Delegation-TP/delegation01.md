## DELEGATION01: Minimum number of name servers   

### Test case identifier

**DELEGATION01:** Minimum number of name servers

### Objective

Section 4.1 of [RFC 1034](http://tools.ietf.org/html/rfc1034) specifies that
there must be at least minimum two name servers for a domain. This test is
done to verify this condition

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Obtain the complete set of name servers from parent using
   [Method2](../Methods.md) and the child using [Method3](../Methods.md).
2. If the total amount of name servers returned are less than two, the test
   case fails.
 
### Outcome(s)

If the total amount of name servers used for the domain are two or more,
then the test case succeeds .

### Special procedural requirements

None 

### Intercase dependencies

None
