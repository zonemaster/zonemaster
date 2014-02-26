## DELEGATION10:Test whether the SOA serial number of the domain's zone is set to zero

### Test case identifier

**DELEGATION10:** Test whether the SOA serial number of the domain's zone is set to zero 

### Objective

Section 7 of the [RFC 1982](http://tools.ietf.org/html/rfc1982) states that the the serial number is a non negative integer with values taken from the range [0 .. 4294967295].  That is, a 32 bit unsigned integer.

But it cautions against setting this value to zero mentioning the following :

"Caution should also be exercised before causing the serial number to be set to the value zero.  While this value is not in any way special in serial number arithmetic, or to the DNS SOA serial number, many DNS implementations have incorrectly treated zero as a special case, with special properties, and unusual behaviour may be expected if zero is used as a DNS SOA serial number.

This test is inteded to verify that serial value in the domain's zone is not set to zero

### Inputs

1. The label of the domain to be tested

### Ordered description of steps to be taken to execute the test case

1. An SOA query is sent using the hostname of the domain
2. If serial value in the answer section of the response is zero, then the test fails

### Outcome(s)
If the response contains a serial number value greater than 0, then the test succeeds

### Special procedural requirements

None

### Intercase dependencies

None
