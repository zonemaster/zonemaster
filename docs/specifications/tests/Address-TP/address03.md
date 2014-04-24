## ADDRESS03: Reverse DNS entry matches name server name

### Test case identifier
**ADDRESS03** Reverse DNS entry matches name server name

### Objective

Some anti-spam techniques use reverse DNS lookup to allow incoming traffic.
In order to prevent name servers to be blocked or blacklisted, DNS 
administrators should publish PTR records associated to name servers'
addresses. 

Moreover, as mentionned in paragraph 2.1 of [RFC
1912](http://tools.ietf.org/html/rfc1912) PTR records must match name server's name. 

### Inputs

a. The domain name to be tested.

b. the list of the domain name servers and their corresponding 
   addresses as retrieved by [Method5](../Methods.md).

c. The list of domain names retrieved upon reverse DNS queries 
   regarding the domain name servers'addresses (see paragraph 
   "Outcomes" of test case [ADDRESS02](address02.md)


### Ordered description of steps to be taken to execute the test case

1. Parse the list of domain name server's addresses and their 
   corresponding PTR records (list c of the inputs).

2. If an IP address has no matching PTR record, the whole test 
   case fails.

3. If an IP address has one or more PTR records, then parse this 
   list of domain names.

3a. If a domain name matches one of the domain name servers (list
    b of the inputs) and the IP address parsed at step 1 matches
	one of the addresses associated to the domain name in list c, 
	then this IP address is considered good, continue and go to
	step 2. Otherwise, continue parsing PTR records attached to 
	the same IP address and go to step 3. If no more PTR records
	are left, the whole test case fails.

   

### Outcome(s)

Multiple addresses and multiple PTR records are allowed. The test 
succeeds if every name server address has a corresponding PTR 
record and this record matches the server name.
If one address doesn't match, the whole test case fails.


### Special procedural requirements

None.

### Intercase dependencies

The input of this test comes from the outcomes of test case
[ADDRESS02](address02.md).
