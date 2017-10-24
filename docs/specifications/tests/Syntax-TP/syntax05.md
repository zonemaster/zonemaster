## SYNTAX05: Misuse of '@' character in the SOA RNAME field

### Test case identifier
**SYNTAX05** There must be no misused '@' character in the SOA RNAME field

### Objective

The SOA RNAME field does not allow the '@' characters to be used for
describing a mailbox. The first dot ('.') is thus translated into the
'@' character. This is a common mistake. The rules are defined in
[RFC 1035](https://tools.ietf.org/rfc/rfc1035.txt).

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Retrieve the SOA record from the zone being tested.
2. If there is any '@' character in the RNAME field, this test case fails.

### Outcome(s)

If there is any '@' character in the RNAME field, this test case fails.

### Special procedural requirements

None.

### Intercase dependencies

The de-escaped output from this test is used by [SYNTAX08](syntax08.md).

-------

Copyright (c) 2013, 2014, 2015, IIS (The Internet Infrastructure Foundation)  
Copyright (c) 2013, 2014, 2015, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <https://creativecommons.org/licenses/by/4.0/>.
