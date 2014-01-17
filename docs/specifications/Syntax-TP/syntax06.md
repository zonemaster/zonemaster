## SYNTAX06: No illegal characters in the SOA RNAME field

### Test case identifier
**SYNTAX06** There must be no illegal characters in the SOA RNAME field

### Objective

The SOA RNAME field is a mailbox address. The RNAME field is defined
in section 3.3 of [RFC 1034](http://www.ietf.org/rfc/rfc1034.txt) and
section 2.2 of [RFC 1912](http://www.ietf.org/rfc/rfc1912.txt). The RNAME
field should follow the rules of an e-mail address also defined in section
3.4.1 of [RFC 2822](http://tools.ietf.org/html/rfc2822#section-3.4).

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Retrieve the SOA record from the zone being tested.
2. Get the RNAME from the SOA record.
3. De-escape the RNAME, converting a "\." to ".".
4. Convert the first "." to an "@".
5. Verify the result from step 3 and 4 according to the Addr-spec
   specification in RFC 2822 section 3.4.1. If this verification fails,
   this test case failes.

### Outcome(s)

If the RNAME field does not validate according to the RFC 2822 specification,
this test case fails.

### Special procedural requirements

None.

### Intercase dependencies

None.
