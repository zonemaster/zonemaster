## ADDRESS03: Reverse DNS entry matches name server name

### Test case identifier
**ADDRESS03** Reverse DNS entry matches name server name

### Objective

Some anti-spam techniques use reverse DNS lookup to allow incoming traffic.
In order to prevent name servers to be blocked or blacklisted, DNS 
administrators should publish PTR records associated with the name server
addresses. 

Moreover, as mentioned in paragraph 2.1 of [RFC
1912](http://tools.ietf.org/html/rfc1912) when a PTR record exists, it must match the host
name.

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Obtain the name servers list using [Method3](../Methods.md).

2. For each name server found in step 1, obtain the name server address 
   records from child using [Method5](../Methods.md). 
   These IP addresses can be associated to the name servers through a hash 
   table where each address is a key and the name server it's unique value.
   Let's call this hash table HASH1.

3. Obtain the reverse DNS entries associated to name servers names as described
   in test case [ADDRESS02](address02.md). Let's call its outcome HASH2 which
   consists of IP adresses as keys and hostnames as values. As multiple PTR
   records are allowed, an IP address can have several corresponding hostnames.

4. Compare HASH2 to HASH1. 

   Parse the address list of HASH1. 

   For an address (a) of HASH1, take the corresponding hostname (h) in HASH1. 
   If this hostname (h) is present in the hostnames list associated to this
   address (a) in HASH2, then the test succeeds for address (a).

   If the hostname (h) does not match any hostnames associated to address (a)
   in HASH2, then the test fails for address (a).

   If the test fails for one IP address, the whole test case fails.   
   

### Outcome(s)

Multiple addresses and multiple PTR records are allowed. The test 
succeeds if every name server address has one or more PTR records
and one of these records matches the server name.
If one address doesn't match, the whole test case fails.

### Special procedural requirements

None.

### Intercase dependencies

Some of the input of this test comes as the result of test case
[ADDRESS02](address02.md). [ADDRESS02](address02.md) must succeed
prior to proceed with this test case [ADDRESS03](address03.md).
