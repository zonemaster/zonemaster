## CONSISTENCY05: Consistency between glue and authoritative data

### Test case identifier

**CONSISTENCY05:** Consistency between glue and authoritative data

### Objective

For name servers that have IP addresses listed as glue, the IP addresses must
match the authoritative A and AAAA records for that host. This is an IANA
requirement (https://www.iana.org/help/nameserver-requirements).

The objective of this test is to verify that the glue records are
consistent between glue and authoritative date.

### Inputs

1. The domain name to be tested

### Ordered description of steps to be taken to execute the test case

1. Obtain the list of address records from [Method4](../Methods.md) and
   [Method5](../Methods.md).
2. If the set of address records are not consistent between the glue address
   records and the name server address records from the child, this test case fails.

### Outcome(s)

If there is no consistency between the glue and the name server address records
from the child, this test case fails.

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
