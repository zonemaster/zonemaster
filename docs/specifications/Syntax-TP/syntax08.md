## SYNTAX08: MX name must have a valid hostname

### Test case identifier
**SYNTAX08** The MX record name must be a valid hostname

### Objective

The MX record names used for delivering name to the SOA RNAME mail address
must be valid hostnames according to the rules defined in
[RFC 952](http://tools.ietf.org/html/rfc952),
in section 2.1 in [RFC 1123](http://tools.ietf.org/html/rfc1123#section-2.1),
section 11 in [RFC 2182](http://tools.ietf.org/html/rfc2181#section-11) and
section 2 and 5 in [RFC 3696](http://tools.ietf.org/html/rfc3696#section-2).
Newer RFCs may override some rules defined in earlier documents. The MX
records use of "Domain Names" is described in section 2.3.5  of
[RFC 5321](http://tools.ietf.org/html/rfc5321#section-2.3.5).

### Inputs

The hostnames to be tested. The hostnames comes from looking up the RNAME
in the SOA record for the domain being tested. The domain in the mail address
from the RNAME record contains the MX records with hosts that is going to be
tested.

### Ordered description of steps to be taken to execute the test case

1. Retrieve the SOA record from the zone being tested.
2. Get the RNAME from the SOA record.
3. De-escape the RNAME, converting a "\." to ".".
4. Convert the first "." to an "@".
5. Query for the MX record for the domain name part of the e-mail address of
   result of step 4.
6. For each hostname in the MX record found in step 5:
7. Each label of the hostname from the MX records are used as the input
   for the validation.
8. If any label in the hostname does not contain a-z or 0-9 this test case
   fails.
9. If any label of the hostname is longer than 63 characters, this test case
   fails.
10. If the hostname is longer than 255 characters including separators, this
   test case fails.
11. If the rightmost label (the TLD) contains only digits, this test case
   fails.
12. If there is a hyphen ('-') in position 3 and 4 of the label, and the prefix
   is not xn (used for internationalization), this test case fails.

### Outcome(s)

If any of the steps 5 to 12 in the ordered description of this test case fails,
the whole test case fails.

### Special procedural requirements

None.

### Intercase dependencies

None.
