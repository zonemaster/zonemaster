## CONNECTIVITY01: UDP connectivity

### Test case identifier

**CONNECTIVITY01:** UDP connectivity

### Objective

DNS queries are sent using UDP on port 53, as described in section 4.2.1 of
[RFC 1035](https://tools.ietf.org/html/rfc1035).

The objective for this test is that all the authoritative name servers for
the domain are accessible over UDP on port 53

### Inputs

The domain to be tested.

### Ordered description of steps to be taken to execute the test case

1. Obtains the IP address of the name servers from [Method4](../Methods.md)
   and [Method5](../Methods.md)
2. A SOA query is sent over UDP to distinct IP addresses of each name server
   found in step 1.
3. If all queries in step 2 receive a DNS answer (bogus responses are not
   checked here) then the test case succeed.

### Outcome(s)

If there is any name server that fails to answer queries over port 53 using
UDP, this test case fails

### Special procedural requirements	

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the result of any test using this transport protocol. Log a message reporting on the ignored result.

### Intercase dependencies

None

-------

Copyright (c) 2013, 2014, 2015, .SE (The Internet Infrastructure Foundation)  
Copyright (c) 2013, 2014, 2015, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <http://creativecommons.org/licenses/by/4.0/>.
