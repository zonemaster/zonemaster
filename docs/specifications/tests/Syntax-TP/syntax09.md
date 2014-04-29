## SYNTAX09: The SOA serial number field should be in the YYYYMMDDnn format

### Test case identifier
**SYNTAX09** The SOA serial number field should be in the YYYYMMDDnn format

### Objective

The recommended format for the serial number is YYYYMMDDnn, which is year, month
and date with a two digit serial number. This is documented in section 2.2 of
[RFC 1912](http://tools.ietf.org/rfc/rfc1912.txt).
[RFC 3339](http://tools.ietf.org/html/rfc3339#section-5) describes the use of
date and time formats in Internet protocols, and its use of ISO 8601.

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. The domain name of the test object is used as the input for the validation.
2. Look up the SOA record and extract the Serial number field.
3. If the serial number is not exactly ten digits long, the test case fails.
4. The first eight digits of the serial number must form a valid ISO 8601
   calendar date. If they do not, the test fails.

### Outcome(s)

If the SOA Serial number format is not of the recommended format YYYYMMDDnn,
this test case fails.

### Special procedural requirements

None.

### Intercase dependencies

None.
