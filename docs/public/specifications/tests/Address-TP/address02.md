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

Best curent practices dictates that imternet reachable hosts should have a
reverse DNS entry, as various services on the Internet, for instance spam 
filters, may consider this when determining the trustworthiness of the host.
Se [RFC1912] section 2.1 and [RFC1033] page 11 for additional information.

### Scope

This test checks for the existence of PTR records for the corresponding reverse
domains of the name servers IP address 

### Inputs

The domain name to be tested.

### Summary

Message Tag                   | Level    | Arguments | Message ID for message tag
:---------------------------- |:---------|:----------|:--------------------------
A02_PTR_PRESENT               | INFO     |           | PTR present for all nameservers
A02_PTR_MISSING               | NOTICE   | ns_list   | PTR missing for "{ns_list}"


The value in the Level column is the default severity level of the message. The
severity level can be changed in the [Zonemaster-Engine profile]. Also see the
[Severity Level Definitions] document.


The argument names in the Arguments column lists the arguments used in the
message. The argument names are defined in the [argument list].


### Test procedure 

1. Create the empty set: Name server name and IP address ("Name Server IP").

2. Obtain the glue address records of each name server for the domain from the
   parent using the method [Get-Del-NS-Names-and-IPs] and add them to the 
   *Name Server IP* set. 

3. Obtain the IP addresses of each name server for the domain using the method 
   [Get-Zone-NS-Names-and-IPs] and add any non-duplicate results to 
   *Name Server IP* set. 

4. Create the following empty set: IP address ("PTR Missing")

5. For each name server in *Name Server IP* do:
   1. Make a recursive PTR query.
   2. If the response fails to match the following criteria, add the IP address
      to the *PTR Missing* set.
        - RCODE must be NOERROR
        - answer section must contain at least one PTR record
  
6. If the set *PTR Missing* is empty, then putput *[A02_PTR_PRESENT]*

7. Else, output *[A02_PTR_MISSING]*


### Outcome(s)

The outcome of the test is "pass" if the set *PTR missing* is empty. If not,
the outcome is "notice"

### Special procedural requirements

None.

### Intercase dependencies

None.

[RFC1912]:                          https://www.rfc-editor.org/rfc/rfc1912
[RFC1033]:                          https://www.rfc-editor.org/rfc/rfc1033
[Argument list]:                    ../ArgumentsForTestCaseMessages.md
[Severity Level Definitions]:       ../SeverityLevelDefinitions.md
[Zonemaster-Engine profile]:        ../../../configuration/profiles.md
[Get-Del-NS-Names-and-IPs]:         ../MethodsV2.md#method-get-delegation-ns-names-and-ip-addresses
[Get-Zone-NS-Names-and-IPs]:        ../MethodsV2.md#method-get-zone-ns-names-and-ip-addresses
[A02_PTR_PRESENT]:                  #Summary
[A02_PTR_MISSING]:                  #Summary
