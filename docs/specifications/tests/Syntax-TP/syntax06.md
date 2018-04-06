## SYNTAX06: No illegal characters in the SOA RNAME field

### Test case identifier
**SYNTAX06** There must be no illegal characters in the SOA RNAME field

### Objective

The SOA RNAME field is a mailbox address. The SOA RNAME field is defined
in section 3.3 of [RFC 1034](https://tools.ietf.org/rfc/rfc1034.txt) and
section 2.2 of [RFC 1912](https://tools.ietf.org/rfc/rfc1912.txt). The RNAME
field should follow the rules of an e-mail address also defined in section
3.4.1 of [RFC 2822](https://tools.ietf.org/html/rfc2822#section-3.4).

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Obtain a set of name server IP addresses using [Method4] and [Method5].
2. Create a SOA query for the zone.
3. Send the SOA query over UDP to each unique name server IP address.
4. Get the RNAME from the SOA record.
5. Convert the first non-escaped "." to an "@" in the RNAME.
6. De-escape the RNAME, converting a "\." to ".".
7. Verify the result from step 3 and 4 according to the Addr-spec
   specification in RFC 2822 section 3.4.1. If this verification fails,
   this test case failes.


### Outcome(s)

If there is any SOA/RNAME field that is invalid according to RFC 2822,
this test case fails.

### Special procedural requirements

None.

### Intercase dependencies

None.

-------
[Method4]: ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]: ../Methods.md#method-5-obtain-the-name-server-address-records-from-child

Copyright (c) 2013-2018, IIS (The Internet Foundation in Sweden)  
Copyright (c) 2013-2018, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <https://creativecommons.org/licenses/by/4.0/>.
