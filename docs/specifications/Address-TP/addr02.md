## ADDR02: Reverse DNS entry exists for nameserver IP address

### Test case identifier
**ADDR02** Reverse DNS entry should exist for nameserver IP address

### Objective

Some anti-spam techniques use reverse DNS lookup to allow incoming traffic.
In order to prevent name servers to be blocked or black listed, DNS 
administrators should publish PTR records associated to name servers'
addresses.

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Find the IP addresses of each name server of the domain checked.
   Use the method described in [Master Test Plan](../Master Test Plan.md)
   paragraph "Get the IP address records from the child zone".

2. For each IP address, a recursive PTR query must be generated.

3. If any answer of the queries made in step 2 contains an RCODE other than
   NoError, this test case fails.

### Outcome(s)

A list of domain names. These are the results of the PTR queries generated.

### Special procedural requirements

Even though it is recommended to publish reverse DNS entries for nameservers
IP addresses, this test should not be blocking for the rest of the test cases
and should only issue a warning rather than an error.

### Intercase dependencies

The outcomes of this test is used as the input of ADDR03 test case.
