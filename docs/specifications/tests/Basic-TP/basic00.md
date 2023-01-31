## BASIC00: Domain name must be valid

### Test case identifier
**BASIC00** Domain name must be valid

### Objective

In order to begin testing the domain name from the input must be a valid
domain name. The domain name must either be

1. a valid IDN name (Internationalized Domain Name) ([RFC 5890](https://tools.ietf.org/html/rfc5890#page-13),
section 2.3.2.3), or
2. a valid ASCII domain.

The ASCII domain name is valid if it follows the rules defined in section 2.1
of [RFC 1123](https://tools.ietf.org/html/rfc1123#section-2.1), i.e. only
consists of the ASCII characters "a-z", "A-Z", "0-9", "." and "-" with the
extension of the "_" character, standardized for SRV records
([RFC 2782](https://tools.ietf.org/html/rfc2782)). The "." character is
the delimiter between labels, and a label must not start or end with a
"-" character. There are also length limitations of the domain names and
its labels (specified below).

A valid IDN name with non-ASCII code points can always be converted
to a valid ASCII domain meeting the requirement above.

The objective of this test is to see if it is possible to have the domain name
mapped into a DNS packet in order to proceed with further testing.


### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. If the input domain name starts with a "." character or has two or more consecutive
"." characters the test case fails.
2. Remove any trailing "." character from the input domain name.
3. If the domain name contains non-ASCII characters, try to convert
it to an ASCII domain, without a trailing "." character, with the IDN rules (see above).
If the conversion fails, then this test case fails.
4. If the domain name does not meet the requirement of permissible characters of
an ASCII domain above, this test case fails.
5. If the total length of the input is more than 253 octets, this test
   case fails.
6. Separate the input by the dividing it into labels separated by the "."
   character.
7. If any of the labels from step 6 has more than 63 octets, this test case fails.


### Outcome(s)

The outcome is PASS or FAIL.

### Special procedural requirements

If this test fails, it's impossible to continue and the whole testing process
is aborted.

### Intercase dependencies

None.
