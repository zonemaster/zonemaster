## BASIC02: The child domain must have at least one working nameserver

### Test case identifier
**BASIC02** The child domain must have at least one working nameserver

### Objective

In order for the domain to work, it must have at least one nameserver that can answer queries about the domain. 

### Inputs

A list of nameserver names taken from the parent domain, and the IP addresses corresponding to those names. The addresses should come from glue address records for in-bailiwick nameserver names, and from separate recursive queries for out-of-bailiwick nameserver names. 

### Ordered description of steps to be taken to execute the test case

An NS query for the child domain should be sent to each address. If there are no DNS answers
from any of the name servers, this test case fails.

### Outcome(s)

If at least one recorded response is a well-formed DNS response holding one or more NS records for the child domain, this test succeeds.

### Special procedural requirements

If this test fails, it's impossible to continue and the whole testing process (except for the BASIC03 test) is aborted.

### Intercase dependencies

None.
