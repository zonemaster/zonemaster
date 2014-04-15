## DELEGATION01: The domain must have a minimum of two authoritative name servers   

### Test case identifier

**DELEGATION01:** The domain must have a minimum of two authoritative name servers

### Objective

Section 4.1 of [RFC 1034](http://tools.ietf.org/html/rfc1034) specifies that
there must be at least minimum two name servers for a domain. This test is
done to verify this condition

### Inputs

The label of the domain name to be tested

### Ordered description of steps to be taken to execute the test case

1. Obtain the list of name servers from [Method2](../Methods.md) and
[Method3](../Methods.md)
2. if the result of step 1 is less than two, the test fails
 
### Outcome(s)

If the results of step 2.1 and step 3.2 contain two or more name servers,
then the test succeeds 

### Special procedural requirements

None 

### Intercase dependencies

None
