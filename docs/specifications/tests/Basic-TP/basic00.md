## BASIC00: Domain name must be valid

### Test case identifier
**BASIC00** Domain name must be valid

### Objective

In order to begin testing the domain name from the input must be a valid
domain name. The domain name must follow the rules defined in section 2.3.1
of [RFC 1123](https://tools.ietf.org/html/rfc1123#section-2.1). The
objective of this test is to see if it is possible to have the domain name
mapped into a DNS packet in order to proceed with further testing.

### Inputs

The label of the domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Remove any trailing dot from the input domain name.
2. If the total length of the input is more than 253 octets, this test
   case fails.
3. Separate the input by the dividing it into labels separated by the "."
   character.
4. If any of the labels from step 3 is more than 63 octets, this test
   case fails.
5. If any of the labels from step 3 is zero octets in length, this test
   case fails.

### Outcome(s)

If the total length of the input is more than 253 octets or any label is
longer than 63 octets, this test case fails.

### Special procedural requirements

If this test fails, it's impossible to continue and the whole testing process
is aborted.

### Intercase dependencies

None.

-------

Copyright (c) 2013, 2014, 2015, .SE (The Internet Infrastructure Foundation)  
Copyright (c) 2013, 2014, 2015, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <http://creativecommons.org/licenses/by/4.0/>.
