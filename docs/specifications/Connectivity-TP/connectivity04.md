## CONNECTIVITY04: Each IP address of the domain's authoritative name server
should be part of a different subnet

### Test case identifier

**CONNECTIVITY04:** Each IP addresses of the domain's authoritative name
servershould be part of a different subnet

### Objective

[RFC 2182](http://tools.ietf.org/html/rfc2182), section 3.1 clearly
specifies that distinct authoritative name servers for a domain should be
placed in different topological and geographical locations. The goal is to
minimise the likelihood of a single failure disabling all of them. 

The objective in this test is to check that more than one IP addresses of
the domain's authoritative name servers does not belong to the same subnet

### Inputs

1. The domain name to be tested

### Ordered description of steps to be taken to execute the test case

1. Obtain the list of name servers from [Method2](../Methods.md) and
[Method3](../Methods.md)
2. Obtains the IP addresss of the name servers from [Method4](../Methods.md)
and [Method5](../Methods.md)
3. Create a subnet list from the retrieved IP addresses in step 2 and define
its range. 
3.a if IPv4, then the range is 28
3.b if IPv6, then the range is 64 
3.c Record the subnet list (ToDo : Add the formula)
4. Check the IP address from step2 with the subnet list (obtained from step3)
5. If a single IP address falls in the range of more than one subnet in the
subnet list (obtained from step3), then the test fails   

### Outcome(s)

If there is not a single IP address from the input which falls inside the
range of more than one subnet, then the test succeeds

### Special procedural requirements

None

### Intercase dependencies

None
