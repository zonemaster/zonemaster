## ADDRESS02: Reverse DNS entry exists for name server IP address

### Test case identifier
**ADDRESS02** Reverse DNS entry should exist for name server IP address

## Table of contents

* [Objective](#objective)
* [Scope](#scope)
* [Inputs](#inputs)
* [Summary](#summary)
* [Test procedure](#test-procedure)
* [Outcome(s)](#outcomes)
* [Special procedural requirements](#special-procedural-requirements)
* [Intercase dependencies](#intercase-dependencies)

### Objective

Some anti-spam techniques use reverse DNS lookup to allow incoming traffic.
In order to prevent name servers to be blocked or blacklisted, DNS 
administrators should publish PTR records associated to name server
addresses.

TODO: Technical reference to be found

### Scope

This test checks for the existence of PTR records for the corresponding reverse
domains of the name servers IP address 

### Inputs

The domain name to be tested.

### Summary

Message Tag                       | Level    | Arguments | Message ID for message tag
:-------------------------------- |:---------|:----------|:--------------------------
A02_PTR_RECORDS_PRESENT           | INFO     |           | All name servers have PTR records
A02_PTR_RECORD_MISSING            | WARNING  | ns_list   | IP address is missing PTR "{ns_list}"

### Test procedure 

1. Create the empty set: Name server name and IP address ("Name Server IP").

2. Obtain the glue address records of each name server for the domain from the
   parent using the method [Get-Del-NS-Names-and-IPs] and add them to the 
   *Name Server IP* set. 

3. Obtain the IP addresses of each name server for the domain using the method 
   [Get-Zone-NS-Names-and-IPs] and add any non-duplicate results to 
   *Name Server IP* set. 

4. Create the following empty sets: 
   * IP address and PTR ("PTR Records")
   * IP address ("PTR Missing")

5. For each name server in *Name Server IP* do:
   1. Make a recursive PTR query.
   2. If the response RCODE is NOERROR, add the IP address and RDATA to the *PTR Records* set.
   3. Else, add the IP address to the *PTR Missing* set.

6. If the set *PTR Missing* is empty, then putput *[A02_PTR_RECORDS_PRESENT]™

7. Else, output *[A02_PTR_RECORD_MISSING]*


### Outcome(s)

If the test case succeeds, its result is a list of addresses with corresponding
hostnames which are the result of the PTR queries performed.
The result could be represented as a hash table where the keys are the IP
addresses and the values their corresponding hostnames.

### Special procedural requirements

None.

### Intercase dependencies

The outcomes of this test is used as the input of [ADDRESS03](address03.md) test case.


[Get-Del-NS-Names-and-IPs]:         ../MethodsV2.md#method-get-delegation-ns-names-and-ip-addresses
[Get-Zone-NS-Names-and-IPs]:        ../MethodsV2.md#method-get-zone-ns-names-and-ip-addresses
[ADDRESS03]:                        ./address03.md
