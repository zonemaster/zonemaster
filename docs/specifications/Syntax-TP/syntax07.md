## SYNTAX07: No illegal characters in the SOA MNAME field

### Test case identifier
**SYNTAX07** There must be no illegal characters in the SOA MNAME field

### Objective

The SOA MNAME field is a hostname. Hostnames are valid according to the
rules defined in [RFC 952](http://tools.ietf.org/html/rfc952),
in section 2.1 in [RFC 1123](http://tools.ietf.org/html/rfc1123#section-2.1),
section 11 in [RFC 2182](http://tools.ietf.org/html/rfc2181#section-11) and
section 2 and 5 in [RFC 3696](http://tools.ietf.org/html/rfc3696#section-2).
Newer RFCs may override some rules defined in earlier documents.

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Retrieve the SOA record from the zone being tested.
2. Get the MNAME from the SOA record.
3. Each label of the hostname of the test object is used as the input
   for the validation.
4. If any label in the hostname does not contain a-z or 0-9 this test case
   fails.
5. If any label of the hostname is longer than 63 characters, this test case
   fails.
6. If the hostname is longer than 255 characters including separators, this
   test case fails.
7. If the rightmost label (the TLD) contains only digits, this test case
   fails.
8. If there is a hyphen ('-') in position 3 and 4 of the label, and the prefix
   is not xn (used for internationalization), this test case fails.

### Outcome(s)

If any of the steps 4 to 8 in the ordered description of this test case fails,
the whole test case fails.

### Special procedural requirements

None.

### Intercase dependencies

This test case uses the same host name validator as test case [SYNTAX04](syntax04.md).
