## NAMESERVER06: NS can be resolved

### Test case identifier
**NAMESERVER06** NS can be resolved

### Objective

All name servers names listed for a delegation must be resolvable in DNS.
If they are not resolvable using DNS this is a sign of misconfiguration,
and raises the risk of unreachability for the domain. It could also lower
the performance for any resolver trying to resolve the name.

The objective of this test is to resolve the domain using all the listed
name servers used in the delegation. More information about resolver
behavior is in section 7 of [RFC 1035](https://tools.ietf.org/html/rfc1035).

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Obtain the list of name servers for the domain using [Method 2]
   (../Methods.md#method-2-obtain-name-servers-from-parent) and [Method 3]
   (../Methods.md#method-3-obtain-name-servers-from-child).
2. Use [Method 4]
   (../Methods.md#method-4-obtain-glue-address-records-from-parent) and
   [Method 5]
   (../Methods.md#method-5-obtain-the-name-server-address-records-from-child)
   to resolve all the name server names obtained in step 1.
3. If any name does not resolve to either an A RR or AAAA RR, this test
   case fails.

### Outcome(s)

If any of the name server names fails to resolve to an IP address, this
test case fails.

### Special procedural requirements

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of
the result of any test using this transport protocol. Log a message
reporting on the ignored result.

### Intercase dependencies

None.
