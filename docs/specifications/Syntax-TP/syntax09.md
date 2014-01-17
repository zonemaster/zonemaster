## SYNTAX09: The SOA serial number field should be in the YYYYMMDDnn format

### Test case identifier
**SYNTAX01** The SOA serial number field should be in the YYYYMMDDnn format

### Objective

The recommended format for the serial number is YYYYMMDDnn, which is year, month
and date with a two digit serial number. This is documented in section 2.2 of
[RFC 1912](http://www.ietf.org/rfc/rfc1912.txt).

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. The domain name of the test object is used as the input for the validation.
2. Look up the SOA record and extract the Serial number field.
3. If the first digits of the serial number are larger than 1900, the test case
   passes.
4. If the digits in position 5 and 6 are larger or equal than 01 and less or equal
   than 12, the test case passes.
5. If the digits in position 7 and 8 are larger or equal than 01 and less or equal
   than 31, the test case passes.
6. If any of the above expressions fail, this test case fails.

### Outcome(s)

If the SOA Serial number format is not of the recommended format YYYYMMDDnn,
this test case fails.

### Special procedural requirements

None.

### Intercase dependencies

None.
