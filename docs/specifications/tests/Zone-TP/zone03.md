## ZONE03: SOA 'retry' lower than 'refresh'

### Test case identifier
**ZONE03** SOA 'retry' lower than 'refresh'

### Objective

The SOA retry value is the number of seconds that describes
minimum time elapsed since a failed zone refresh from the primary
name server. The SOA refresh value is described
in section 3.3.13 in [RFC 1035](https://tools.ietf.org/html/rfc1035),
and clarified in section 2.2 of
[RFC 1912](https://tools.ietf.org/html/rfc1912).

> It's typically some fraction of the refresh interval.

Setting the retry value low will increase the DNS traffic between
the servers, and also increase the load on the master name server.

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Retrieve the SOA record from a delegated name server for the domain.
2. If the answer from step 1 is not authoritative, iterate step 1 until there is an authoritative answer.
3. Retrieve the retry value from the SOA record.
4. If the retry value is higher than or equal to the refresh value,
   this test case fails.

### Outcome(s)

If the SOA retry value is higher than or equal to the refresh value,
this test case fails.

### Special procedural requirements

None.

### Intercase dependencies

None.

-------

Copyright (c) 2013, 2014, 2015, IIS (The Internet Infrastructure Foundation)  
Copyright (c) 2013, 2014, 2015, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <https://creativecommons.org/licenses/by/4.0/>.
