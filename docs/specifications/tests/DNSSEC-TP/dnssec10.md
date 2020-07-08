# DNSSEC10: Zone contains NSEC or NSEC3 records

## Test case identifier
**DNSSEC10**

## Objective

When DNSSEC is enabled, NSEC or NSEC3 records provide a secure denial
of existence for records not present in the zone. This test case
verifies that correct NSEC or NSEC3 records with valid signatures are
returned for a query for an non-existent name.

Furthermore, it is verified that the name servers for the zone are
consistent about NSEC and NSEC3, i.e. either all servers should use
NSEC or all servers should use NSEC3. No server should use both.

The use of the NSEC RR type is described in
[RFC 4035][RFC 4035#section-3.1.3], section 3.1.3, and
the description of the NSEC RR itself is in
[RFC 4034][RFC 4034#section-4], section 4.

The description of the NSEC3 RR is in
[RFC 5155][RFC 5155#section-3], section 3, and its
use in the DNS response is described in
[RFC 5155][RFC 5155#section-7.2], section 7.2.

## Scope

It is assumed that *Child Zone* has been tested by [Basic04]. This test
case will set DEBUG level on messages for non-responsive name servers.

## Inputs

* "Child Zone" - The domain name to be tested.
* "Non-Existent Query Name" - A label that should never exist,
  "xx--test-test-test", put under apex of *Child Zone*,  e.g.
  "xx--test-test-test.example.com".

## Ordered description of steps to be taken to execute the test case

1. Create an A query with DO flag set for *Non-Existent Query Name*.

2. Create a DNSKEY query with DO flag set for *Child Zone*.

3. Retrieve all name server IP addresses for the
   *Child Zone* using [Method4] and [Method5] ("NS IP").

4. Create three empty sets, "NSEC-Zone", "NSEC3-Zone", and
   "No-DNSSEC-Zone".

5. For each name server IP address in *NS IP* do:

   1. Send the A query over UDP to the name server IP.
   2. If no DNS response is returned, then output *[NO_RESPONSE]*.
   3. Else, if the DNS response has RCODE NOERROR, then output
      *[TEST_ABORTED]*.
   4. Else, if the DNS response does not have RCODE NXDOMAIN, then
      output *[INVALID_RCODE]*.
   5. Else, if the authority section has both NSEC and NSEC3 records,
      output *[MIXED_NSEC_NSEC3]*.
   6. Else, if the authority section has neither NSEC nor NSEC3
      records, then add the name server IP to the
      *No-DNSSEC-Zone* set and output *[NO_NSEC_NSEC3]*.
   7. Else, if the authority section has one or more NSEC records
      but no NSEC3 records (one or more NSEC3 records but no NSEC
      records), then do:
      1. Add the name server IP to the *NSEC-Zone* set (*NSEC3-Zone*
         set).
      2. Retreive all NSEC (NSEC3) records from the response.
      3. If the NSEC (NSEC3) records do not "cover" the
         *Non-Existent Query Name*, then output *[NSEC_COVERS_NOT]*
         (*[NSEC3_COVERS_NOT]*).
      4. Retreive the RRSIG records for the retreived NSEC records
         (NSEC3 records), i.e. same owner name and NSEC (NSEC3) as
         type covered, if any.
      5. If any of the NSEC records (NSEC3 records) do not have
         a matching RRSIG record, then output *[NSEC_NOT_SIGNED]*
         (*[NSEC3_NOT_SIGNED]*).
      5. Send the DNSKEY query to the name server IP.
      6. Verify the RRSIG records by the relevant DNSKEY record.
      7. If one or more of the following criteria is met, output
         *[NSEC_SIG_VERIFY_ERROR]* (*[NSEC3_SIG_VERIFY_ERROR]*):
         * No DNSKEY records are returned.
         * There is one or more NSEC records (NSEC3 records) that
           has RRSIG for which the validity period starts after or
           ends before the time of test execution.
      8. Else, if the Zonemaster installation does not have support
         for the algorithm that created the RRSIG, then output
         *[DS10_ALGO_NOT_SUPPORTED_BY_ZM]* and print algorithm,
         DNSKEY key tag and name server IP.
      9. Else, if there is one or more NSEC records (NSEC3 records)
         that cannot be verified by retreived RRSIG and DNSKEY
         records output *[NSEC_SIG_VERIFY_ERROR]*
         (*[NSEC3_SIG_VERIFY_ERROR]*.

6. If *No-DNSSEC-Zone* is non-empty and at least one of *NSEC-Zone*
   and *NSEC3-Zone* is also non-empty, then output
   *[INCONSISTENT_DNSSEC]*.

7. Else, if *No-DNSSEC-Zone* is non-empty and both *NSEC-Zone* and
   *NSEC3-Zone* are empty, then output *[BROKEN_DNSSEC]*.

8. Else, if both *NSEC-Zone* and *NSEC3-Zone* are non-empty, then
   output *[INCONSISTENT_NSEC_NSEC3]*.

9. Else, if *NSEC-Zone* is non-empty and *[MIXED_NSEC_NSEC3]* has not
   been outputted, then output *[HAS_NSEC]*.

10. Else, if *NSEC3-Zone* is non-empty and *[MIXED_NSEC_NSEC3]* has not
    been outputted, then output *[HAS_NSEC3]*.


## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the [severity level] *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the [severity level] *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

In other cases the outcome of this Test Case is "pass".

Message                       | Default [severity level]
:-----------------------------|:-----------------------------------
BROKEN_DNSSEC                 | ERROR
DS10_ALGO_NOT_SUPPORTED_BY_ZM | NOTICE
HAS_NSEC                      | INFO
HAS_NSEC3                     | INFO
INCONSISTENT_DNSSEC           | ERROR
INCONSISTENT_NSEC_NSEC3       | ERROR
INVALID_RCODE                 | WARNING
MIXED_NSEC_NSEC3              | ERROR
NO_NSEC_NSEC3                 | ERROR
NO_RESPONSE                   | DEBUG
NSEC3_COVERS_NOT              | ERROR
NSEC3_NOT_SIGNED              | ERROR
NSEC3_SIG_VERIFY_ERROR        | ERROR
NSEC_COVERS_NOT               | ERROR
NSEC_NOT_SIGNED               | ERROR
NSEC_SIG_VERIFY_ERROR         | ERROR
TEST_ABORTED                  | NOTICE


## Special procedural requirements

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
on the ignored result.

See the [DNSSEC README] document about DNSSEC algorithms.

The test case is only performed if some DNSKEY record is found in the
*Child Zone*.


## Intercase dependencies

None.

[Basic04]:                 ../Basic-TP/basic04.md
[BROKEN_DNSSEC]:           #outcomes
[DNSSEC README]:           README.md
[DS10_ALGO_NOT_SUPPORTED_BY_ZM]: #outcomes
[HAS_NSEC3]:               #outcomes
[HAS_NSEC]:                #outcomes
[INCONSISTENT_DNSSEC]:     #outcomes
[INCONSISTENT_NSEC_NSEC3]: #outcomes
[INVALID_RCODE]:           #outcomes
[MIXED_NSEC_NSEC3]:        #outcomes
[Method4]:                 ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                 ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[NO_NSEC_NSEC3]:           #outcomes
[NO_RESPONSE]:             #outcomes
[NO_RESPONSE_DS]:          #outcomes
[NSEC3_COVERS_NOT]:        #outcomes
[NSEC3_NOT_SIGNED]:        #outcomes
[NSEC3_SIG_VERIFY_ERROR]:  #outcomes
[NSEC_COVERS_NOT]:         #outcomes
[NSEC_NOT_SIGNED]:         #outcomes
[NSEC_SIG_VERIFY_ERROR]:   #outcomes
[RFC 4034#section-4]:      https://tools.ietf.org/html/rfc4034#section-4
[RFC 4035#section-3.1.3]:  https://tools.ietf.org/html/rfc4035#section-3.1.3
[RFC 5155#section-3]:      https://tools.ietf.org/html/rfc5155#section-3
[RFC 5155#section-7.2]:    https://tools.ietf.org/html/rfc5155#section-7.2
[Severity Level]:          ../SeverityLevelDefinitions.md
[TEST_ABORTED]:            #outcomes
