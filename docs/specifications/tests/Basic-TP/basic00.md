## BASIC00: Domain name must be valid

### Test case identifier
**BASIC00** Domain name must be valid

### Objective

In order to begin testing the domain name from the input must be a valid
domain name. The domain name must either be a 

1. a valid IDN name (Internationalized Domain Name) ([RFC 5890](https://tools.ietf.org/html/rfc5890#page-13), 
section 2.3.2.3), or
2. a valid ASCII domain.

The ASCII domain name is valid if follows the rules defined in section 2.1
of [RFC 1123](https://tools.ietf.org/html/rfc1123#section-2.1), i.e. only
consists of the ASCII characters "a-z", "A-Z", "0-9", "." and "-" with the
extension of "_", standardized for SRV records 
([RFC 2782](https://tools.ietf.org/html/rfc2782)).

A valid IDN name with non-ASCII code points can always be converted 
to a valid ASCII domain meeting the requirement above.

The objective of this test is to see if it is possible to have the domain name
mapped into a DNS packet in order to proceed with further testing.


### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. If the domain name has more than one tailing dot, the test case
fails.
2. Remove any trailing dot from the input domain name.
3. If the domain name contains non-ASCII characters, try to convert
it to an ASCII domain with the IDN rules. If the conversion fails,
then this test case fails.
4. If the domain name does not meet the requirement of an ASCII domain
above, then this test case fails.
5. If the total length of the input is more than 253 octets, this test
   case fails.
6. Separate the input by the dividing it into labels separated by the "."
   character.
7. If any of the labels from step 3 is more than 63 octets, this test case fails.
8. If any of the labels from step 3 is zero octets in length, this test
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

Copyright (c) 2013-2016, IIS (The Internet Foundation In Sweden)  
Copyright (c) 2013-2016, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <http://creativecommons.org/licenses/by/4.0/>.
