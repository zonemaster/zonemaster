## BASIC02: The domain must have at least one working name server

### Test case identifier
**BASIC02** The domain must have at least one working name server

### Objective

In order for the domain to work, it must have at least one name server that
can answer queries about the domain. 

### Inputs

1. A list of name server names taken from the parent domain
2. and the IP addresses corresponding to those names.

The addresses should come from glue name address records for in-bailiwick
name server names and from separate recursive queries for out-of-bailiwick
name server names.

### Ordered description of steps to be taken to execute the test case

1. An NS query for the child domain should be sent to each address.
2. If there are no DNS valid DNS packets containing the NS answer from any
   of the name servers, this test case fails.

### Outcome(s)

If at least one recorded response is a DNS response holding one or more NS
records for the child domain, this test succeeds.

### Special procedural requirements

If this test fails, it's impossible to continue and the whole testing
process (except for the BASIC03 test) is aborted.

### Intercase dependencies

None.
