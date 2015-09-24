## SYNTAX08: MX name must have a valid hostname

### Test case identifier
**SYNTAX08** The MX record name must be a valid hostname

### Objective

The MX record names used for delivering mail for a domain name address
must be valid hostnames according to the rules defined in
[RFC 952](http://tools.ietf.org/html/rfc952),
in section 2.1 in [RFC 1123](http://tools.ietf.org/html/rfc1123#section-2.1),
section 11 in [RFC 2182](http://tools.ietf.org/html/rfc2181#section-11) and
section 2 and 5 in [RFC 3696](http://tools.ietf.org/html/rfc3696#section-2).
Newer RFCs may override some rules defined in earlier documents. The MX
records use of "Domain Names" is described in section 2.3.5  of
[RFC 5321](http://tools.ietf.org/html/rfc5321#section-2.3.5).

### Inputs

The hostnames to be tested. The hostnames comes from looking up the MX record
for the domain being tested.

### Ordered description of steps to be taken to execute the test case

1. Query for the MX record of the domain name.
2. For each hostname of the MX records found:
3. If any label in the hostname does not contain a-z or 0-9 this test case
   fails.
4. If any label of the hostname is longer than 63 characters, this test case
   fails.
5. If the hostname is longer than 255 characters including separators, this
   test case fails.
6. If the rightmost label (the TLD) contains only digits, this test case
   fails.
7. If there is a hyphen ('-') in position 3 and 4 of the label, and the prefix
   is not xn (used for internationalization), this test case fails.

### Outcome(s)

If any of the steps 3 to 7 in the ordered description of this test case fails,
the whole test case fails.

### Special procedural requirements

None.

### Intercase dependencies

None.

-------

Copyright (c) 2013, 2014, 2015, IIS (The Internet Infrastructure Foundation)  
Copyright (c) 2013, 2014, 2015, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <http://creativecommons.org/licenses/by/4.0/>.
