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

1. Record the list of nameservers from the parent using [Method
2](../Methods.md) and the child using [Method3](../Methods.md)

2. Query the servers in step 1 for A and AAAA addresses.

3. Record the list of unique A and AAAA addresses in the answer section.

4. If the count of the A or AAAA addresses obtained in step 3 is more than '1', then this  test case fails with a warning.

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
