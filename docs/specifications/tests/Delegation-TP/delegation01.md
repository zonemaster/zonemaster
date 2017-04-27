## DELEGATION01: Minimum number of name servers   

### Test case identifier

**DELEGATION01:** Minimum number of name servers

### Objective

Section 4.1 of [RFC 1034](http://tools.ietf.org/html/rfc1034) specifies that
there must be at least minimum two name servers for a domain. This test is
done to verify this condition

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Obtain the complete set of name servers from parent using
   [Method2](../Methods.md).
2. If the number of name servers (distinct NS records) returned in previous step is less than two, the
   record as an error.
3. Obtain the complete set of name servers from the child 
   using [Method3](../Methods.md).
4. If the number of name servers (distinct NS records) returned in the previous step is less than two, the
   record as an error.
5. If an error was recorded in step 2 or step 4, then the test case fails.
 
### Outcome(s)

If the total amount of name servers used for the domain are two or more,
then the test case succeeds.

### Special procedural requirements

None 

### Intercase dependencies

None

-------

Copyright (c) 2013-2017, IIS (The Internet Foundation in Sweden )  
Copyright (c) 2013-2017, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <http://creativecommons.org/licenses/by/4.0/>.
