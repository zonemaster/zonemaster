## CONNECTIVITY01: The domain must be accessible over UDP on port 53

### Test case identifier
**CONNECTIVITY01:**  The domain must be accessible over UDP on port 53

### Objective

The objective for this test is that all the authoritative nameservers for the domain and its associated IP addresses are accessible over UDP on port 53

### Inputs

1. The domain name to be tested

### Ordered description of steps to be taken to execute the test case

1. Retrieve the list of authoritative nameservers names for the domain (Do we obtain the list from the resolver, parent or the child domain or manually for undelegated domains?)
2. And the IP addresses corresponding to those names. The IP addresses should (or MAY?) come from glue address records for in-bailiwick nameserver names and from separate recursive queries for out-of-bailiwick nameserver names.
3. A SOA query is sent over UDP to all the retrieved nameservers
4. If the nameserver has a single address, then the test fails if a query destined to that addresses does not provide an answer within a particular time period (the threshhold time should be decided)
5. If the nameserver is associated with multiple addresses, then the test  fails if any one of those addresses does not provide an answer within the specified threshhold time


### Outcome(s)

If there is a response from the retrieved nameservers and its associated IP addresses within the threshhold period, then the test succeeds

### Special procedural requirements

### Intercase dependencies
None
