## CONNECTIVITY02: TCP connectivity

### Test case identifier

**CONNECTIVITY02:** TCP connectivity

### Objective

DNS queries are sent using TCP on port 53, as described in section 4.2.2 of
[RFC 1035](https://tools.ietf.org/html/rfc1035).

The objective for this test is that all the authoritative name servers for
the domain are accessible over TCP on port 53

### Inputs

The domain to be tested.

### Ordered description of steps to be taken to execute the test case

1. Obtains the IP addresses of the name servers from [Method4](../Methods.md)
   and [Method5](../Methods.md)
2. A SOA query is sent over TCP to distinct IP address of each name server
   found in step 1.
3. If all queries in step 2 receive a DNS answer (bogus response are not
   checked here) then the test case succeed.

### Outcome(s)

If there is any name server that fails to answer queries over port 53 using
TCP, this test case fails

### Special procedural requirements     

None

### Intercase dependencies

None
