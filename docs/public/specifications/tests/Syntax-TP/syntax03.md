## SYNTAX03: There must be no double hyphen ('--') in position 3 and 4 of the domain name

### Test case identifier
**SYNTAX02** No double hyphen ('--') in position 3 and 4 of the domain name

### Objective

There must be no double hyphen ('--') in position 3 and 4 of the domain name,
unless the domain name has the prefix 'xn--' which is used for
internationalization.
See section 5 of [RFC 3696](https://datatracker.ietf.org/doc/html/rfc3696#section-5),
"Implications of internationalization".


### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Each label of the domain name of the test object is used as the input
   for the validation.
2. If any label in the domain name contains hyphens ('-') in position 3 and 4,
   go to next step.
3. Unless the prefix is 'xn', this test case fails.

### Outcome(s)

If any label in the domain name has a hyphen in position 3 and 4 of the label
and the prefix is not 'xn', this test case fails.

### Special procedural requirements

None.

### Intercase dependencies

None.
