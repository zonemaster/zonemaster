## CONSISTENCY03: SOA parameters consistency

### Test case identifier

**CONSISTENCY03:** SOA parameters consistency

### Objective

All SOA record fields except SERIAL, RNAME and MNAME must be consistent
across all authoritative name servers.

The inconsistency in these different fields for the designated zone (*Got to
Verify*) might result in operational inconsistencies.

There are other test cases that provide consistency tests for other
SOA fields.


### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

 1. Obtain a set of name server IP addresses using [Method4] and
    [Method5].
 2. Send a SOA query for the zone over UDP to each unique name server
    IP address.
 3. Verify that a response is received for each SOA query.
 4. Collect all SOA records from the answer section of all responses.
 5. Verify that all SOA records have the same REFRESH value.
 6. Verify that all SOA records have the same RETRY value.
 7. Verify that all SOA records have the same EXPIRE value.
 8. Verify that all SOA records have the same MINIMUM value.


### Outcome(s)

All authoritative name servers must have consistent REFRESH, RETRY,
EXPIRE and MINIMUM fields.
If the test does not find any inconsistency, then the test succeeds.

### Special procedural requirements	

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
on the ignored result.

### Intercase dependencies

-------

[Method4]: ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]: ../Methods.md#method-5-obtain-the-name-server-address-records-from-child

Copyright (c) 2013, 2014, 2015, IIS (The Internet Infrastructure Foundation)  
Copyright (c) 2013, 2014, 2015, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <https://creativecommons.org/licenses/by/4.0/>.
