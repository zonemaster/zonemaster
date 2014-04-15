## CONNECTIVITY01: The domain must answer DNS queries over UDP on port 53

### Test case identifier

**CONNECTIVITY01:**  The domain must answer DNS queries over UDP on port 53

### Objective

DNS queries are sent using UDP on port 53, as described in section 4.2.1 of
[RFC 1035](http://tools.ietf.org/html/rfc1035).

The objective for this test is that all the authoritative name servers for
the domain are accessible over UDP on port 53

### Inputs

1. The domain name to be tested

### Ordered description of steps to be taken to execute the test case

1. Obtain the list of name servers from [Method2](../Methods.md) and
[Method3](../Methods.md).
2. Obtains the IP addresss of the name servers from [Method4](../Methods.md)
and [Method5](../Methods.md)
3. A SOA query is sent over UDP to distinct IP address of each name server
found in step2
4. If all queries in step 3 receive a DNS answer (bogus response are not
checked here) then the test case succeed.

### Outcome(s)

If there is any name server that fails to answer queries over port 53 using
UDP, this test case fails

### Special procedural requirements	

None

### Intercase dependencies

None
