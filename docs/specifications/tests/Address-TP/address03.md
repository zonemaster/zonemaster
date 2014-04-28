## ADDRESS03: Reverse DNS entry matches name server name

### Test case identifier
**ADDRESS03** Reverse DNS entry matches name server name

### Objective

Some anti-spam techniques use reverse DNS lookup to allow incoming traffic.
In order to prevent name servers to be blocked or blacklisted, DNS 
administrators should publish PTR records associated with the name server
addresses. 

Moreover, as mentioned in paragraph 2.1 of [RFC
1912](http://tools.ietf.org/html/rfc1912) PTR records must match name
server name. 

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Obtain the name server address records from child using
   [Method5](../Methods.md).
2. Retrieve the list of host names names as the result of
   outcomes in test case [ADDRESS02](address02.md).
3. Parse the list of domain name server addresses and their
   corresponding PTR records from step 2.
4. If an IP address has no matching PTR record, this test case fails.
5. If an IP address has one or more PTR records, then parse this 
   list of domain names.
6. If a domain name matches one of the domain name servers (list
   from step 2) and the IP address parsed at step 3 matches
   one of the addresses associated to the domain name in step 2, 
   then this IP address is considered good, continue and go to
   step 4. Otherwise, continue parsing PTR records attached to 
   the same IP address and go to step 5. If no more PTR records
   are left, the whole test case fails.

### Outcome(s)

Multiple addresses and multiple PTR records are allowed. The test 
succeeds if every name server address has a corresponding PTR 
record and this record matches the server name.
If one address doesn't match, the whole test case fails.

### Special procedural requirements

None.

### Intercase dependencies

Some of the input of this test comes as the result of test case
[ADDRESS02](address02.md).
