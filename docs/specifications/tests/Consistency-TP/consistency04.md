## CONSISTENCY04: Name server NS consistency

### Test case identifier

**CONSISTENCY04:** Name server NS consistency

### Objective

All authoritative name servers must serve the same NS record set
(section 4.2.2) of [RFC 1034](https://tools.ietf.org/html/rfc1034)
for the tested domain. Any inconsistency of NS records descibed in
section 3.3.11 of [RFC 1035](https://tools.ietf.org/html/rfc1035)
might result in operational failures.

The objective of this test is to verify that the NS records are
consistent between all the authoritative name servers.

### Inputs

1. The domain name to be tested

### Ordered description of steps to be taken to execute the test case

1. Obtain the list of name servers for the domain name to be tested 
   from [Method2](../Methods.md) (delegation) and
   [Method3](../Methods.md) (in child zone).
2. Retrieve the IP addresses for the obtained name servers using
   [Method4](../Methods.md) (glue at parent) and [Method5](../Methods.md)
   (address record in child zone) if the name server name is in-zone.
3. Retrieve the IP addresses for the obtained name servers by doing
   a lookup on public Internet if the name server name is out-of-zone.
4. Retrieve the NS RR set from all retrieved name server IP address. 
5. If the NS RR set does not give the same answer from all the name
   servers, this test case fails.

### Outcome(s)

The outcome is PASS or FAIL.

### Special procedural requirements	

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
on the ignored result.

### Intercase dependencies

None

-------

Copyright (c) 2013, 2014, 2015, IIS (The Internet Infrastructure Foundation)  
Copyright (c) 2013, 2014, 2015, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <https://creativecommons.org/licenses/by/4.0/>.
