## ZONE11: MX authoritative answer

### Test case identifier
**ZONE11** MX authoritative answer

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
3. If there is an MX record in the answer, and the answer is authoritative
   (the AD bit is set), this test case succeeds.

### Outcome(s)

If the answer for the MX query to the domain have the AD bit set, this
test case succeeds.

### Special procedural requirements

None.

### Intercase dependencies

None.
