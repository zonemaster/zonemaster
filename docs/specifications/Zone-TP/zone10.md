## ZONE10: MX record present

### Test case identifier
**ZONE10** MX record present

### Objective

It is strongly recommended in section 7 of
[RFC 2142](http://tools.ietf.org/html/rfc2142)
that all domains should have a mailbox named hostmaster@domain.

> For simplicity and regularity, it is strongly recommended that the
> well known mailbox name HOSTMASTER always be used
> <HOSTMASTER@domain>.

It is therefore necessary for any domain to publish an MX record.

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Query the MX record for the domain name.
3. If there is an MX record in the answer, this test case succeeds.

### Outcome(s)

If there is no target host (MX record) to deliver e-mail for the domain
name, this test case fails.

### Special procedural requirements

None.

### Intercase dependencies

None.
