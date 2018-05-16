## DELEGATION02: Name servers must have distinct IP addresses

### Test case identifier

**DELEGATION02:** Name servers must have distinct IP addresses

### Objective

If the domain have several different name server names used, they can all
be using the same IP address. This may be due to a configuration error, or
a workaround to a certain policy restriction. This test case checks that
the name servers used does not resolve to reuse the same IP addresses.

Section 4.1 of [RFC 1034](https://tools.ietf.org/html/rfc1034) says at least
to name servers must be used for a delegation.

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Obtain the IP addresss of the name servers from the parent using [Method
4](../Methods.md#method-4-obtain-glue-address-records-from-parent) and the child using
   [Method 5](../Methods.md#method-5-obtain-the-name-server-address-records-from-child).
2. If any of the IP addresses resolved in step 1 is not unique, then this
   test case fails.

### Outcome(s)

If all the IP addresses used by the name servers for the domain are unique,
then the test succeeds.

### Special procedural requirements

None 

### Intercase dependencies

None

-------

Copyright (c) 2013, 2014, 2015, IIS (The Internet Infrastructure Foundation)  
Copyright (c) 2013, 2014, 2015, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <https://creativecommons.org/licenses/by/4.0/>.
