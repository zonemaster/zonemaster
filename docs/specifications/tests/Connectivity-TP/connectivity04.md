## CONNECTIVITY04: AS Diversity

### Test case identifier

**CONNECTIVITY04:** AS Diversity

### Objective

[RFC 2182](http://tools.ietf.org/html/rfc2182), section 3.1
clearly specifies that distinct authoritative name servers for a child
domain should be placed in different topological and geographical locations.
The objective is to minimise the likelihood of a single failure disabling
all of them. 

The objective in this test is to check that all IP addresses of the domain's
authoritative name servers does not belong to the same AS.

[missing references to AS numbers, RFC 1930?]

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Obtain the list of name servers from [Method2](../Methods.md) and
   [Method3](../Methods.md).
2. Obtains the IP addresss of the name servers from [Method4](../Methods.md)
   and [Method5](../Methods.md).
3. Obtain the AS (name) list for each IP address obtained from step2 using
   "asn.routeviews.org".
4. If all the retrieved AS (obtained from step3) are same, then the test
   fails.

### Outcome(s)

If there is a AS which is different from the other retrieved AS, then the
test succeeds.

### Special procedural requirements

None

### Intercase dependencies

None
