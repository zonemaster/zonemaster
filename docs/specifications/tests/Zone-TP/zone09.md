## ZONE09: MX record present

### Test case identifier
**ZONE09** MX record present

### Objective

It is strongly recommended in section 7 of
[RFC 2142](https://tools.ietf.org/html/rfc2142)
that all domains should have a mailbox named hostmaster@domain.

> For simplicity and regularity, it is strongly recommended that the
> well known mailbox name HOSTMASTER always be used
> <HOSTMASTER@domain>.

It is therefore necessary for any domain to publish an MX record.
However, SMTP can make a delivery without the MX, using the A or
AAAA record as specified in section 5.1 of
[RFC 5321](https://tools.ietf.org/html/rfc5321#section-5.1).

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Query the MX record from a delegated name server for the domain.
2. If the answer from step 1 is not authoritative, iterate step 1 until there is an authoritative answer.
3. If there are MX records present in the answer, this part of the test
   case succeeds.
4. If there are no MX records present in the answer from the MX query,
   query for the A and AAAA records for the domain.
5. If there is any A och AAAA record in the answers from the queries in
   step 4, this test case succeeds.

### Outcome(s)

If there is no target host (MX, A or AAAA record) to deliver e-mail for the
domain name, this test case fails.

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
