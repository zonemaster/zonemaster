# DNSSEC10: Zone contains NSEC or NSEC3 records


## Test case identifier
**DNSSEC10**


## Table of contents

* [Objective](#Objective)
* [Scope](#Scope)
* [Inputs](#Inputs)
* [Summary](#Summary)
* [Test procedure](#Test-procedure)
* [Outcome(s)](#Outcomes)
* [Special procedural requirements](#Special-procedural-requirements)
* [Intercase dependencies](#Intercase-dependencies)
* [Terminology](#terminology)


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

It is assumed that *Child Zone* is tested by [Basic04]. Isues covered by
[Basic04] (basic name server issues) will no result in messagess from this test
case.

This test case is only relevant if the zone has been DNSSEC signed.


## Inputs

* "Child Zone" - The domain name to be tested.
* "Non-Existent Query Name" - A label that should never exist, e.g.
  "xx--zpeqz4v66tckbqkyw35k--xx", which is created by the following steps, is
  added as a subdomain to *Child_Zone* to create the query name, e.g.
  "xx--zpeqz4v66tckbqkyw35k--xx.exemple.com".
  * Use the string "xx--" as a prefix for the label.
  * As middle part of the label, create a random string of 20 characters from
    the set "a-z0-9".
  * Use the string "--xx" as a suffix for the label.


## Summary

* If no DNSKEY records are found, then further inverstigation will not be done
  and no messages will be outputted.

Message Tag outputted              | Level   | Arguments  | Description of when message tag is outputted
:----------------------------------|:--------|:-----------|:--------------------------------------------
DS10_ALGO_NOT_SUPPORTED_BY_ZM      | NOTICE  | ns_ip_list, algo_mnemo, algo_num, keytag | This installation of Zonemaster does not support the DNSKEY algorithm.
DS10_HAS_NSEC                      | INFO    |            | Consistent NSEC returned from servers.
DS10_HAS_NSEC3                     | INFO    |            | Consistent NSEC3 returned from servers.
DS10_INCONSISTENT_NSEC_NSEC3       | ERROR   |2 ns_ip_list| Some servers return NSEC, others return NSEC3.
DS10_MISSING_NSEC_NSEC3            | ERROR   | ns_ip_list | Missing expected NSEC or NSEC3 in a signed zone.
DS10_MIXED_NSEC_NSEC3              | ERROR   | ns_ip_list | Both NSEC and NSEC3 are returned from the same server.
DS10_NAME_NOT_COVERED_BY_NSEC      | ERROR   | ns_ip_list | The non-existent name is not correctly covered by the NSEC records.
DS10_NAME_NOT_COVERED_BY_NSEC3     | ERROR   | ns_ip_list | The non-existent name is not correctly covered by the NSEC3 records.
DS10_NON_EXISTENT_RESPONSE_ERROR   | ERROR   | ns_ip_list | No or error in response of an expected non-existent name.
DS10_NSEC3_MISSING_SIGNATURE       | ERROR   | ns_ip_list | Missing signatures for NSEC3 record or records.
DS10_NSEC3_RRSIG_VERIFY_ERROR      | ERROR   | ns_ip_list | The signature or signatures on the NSEC3 record or records cannot be correctly verfied.
DS10_NSEC_MISSING_SIGNATURE        | ERROR   | ns_ip_list | Missing signatures for NSEC record or records.
DS10_NSEC_RRSIG_VERIFY_ERROR       | ERROR   | ns_ip_list | The signature or signatures on the NSEC record or records cannot be correctly verfied.

The value in the Level column is the default severity level of the message. The
severity level can be changed in the [Zonemaster-Engine profile]. Also see the
[Severity Level Definitions] document.

The argument names in the Arguments column lists the arguments used in the
message. The argument names are defined in the [argument list].



## Test procedure

1.  Create a DNSKEY query with DO flag set for *Child Zone* ("DNSKEY Query").

2.  Create an A query with DO flag set for *Non-Existent Query Name*
    ("Non-Existent Query").

3.  Retrieve all name server IP addresses for the
    *Child Zone* using [Method4] and [Method5] ("NS IP").

4.  Create the following empty sets:
    1.  Name server IP address ("Has NSEC").
    2.  Name server IP address ("Has NSEC3").
    3.  Name server IP address ("No NSEC or NSEC3").
    4.  Name server IP address ("Mixed NSEC/NSEC3").
    5.  Name server IP address ("Name not covered by NSEC").
    6.  Name server IP address ("Name not covered by NSEC3").
    7.  Name server IP address ("NSEC Missing Signature").
    8.  Name server IP address ("NSEC3 Missing Signature").
    9.  Name server IP address ("Non-Existent Response Error").
    10. Name server IP address ("NSEC RRSIG Verify Error").
    11. Name server IP address ("NSEC3 RRSIG Verify Error").
    12. Name server IP address, DNSKEY record key tag and DNSKEY algorithm code
       ("Algo Not Supported By ZM").

5.  For each name server IP address in *NS IP* do:

    1. Send *DNSKEY Query* to the name server IP.
    2. If at least one of the following criteria is met, then go to next name
       server IP:
         1. There is no DNS response.
         2. RCODE is not NOERROR.
         3. AA flag is not set.
         4. There are no DNSKEY records in the answer section.
    3. Retrieve the DNSKEY records from the answer section.
    4. Send *Non-Existent Query* over UDP to the name server IP.
    5. If at least one of the following createria is met, then add the name
       server IP to the *Non-Existent Response Error* set and go to next name
       server IP:
         1. There is no DNS response.
         2. RCODE is neither NOERROR nor NXDOMAIN.
         3. AA flag is not set.
    6. If the answer section of the the DNS response is non-empty, the go to next
       name server IP.
    7. If the authority section has both NSEC and NSEC3 records, add the name
      server IP to the *Mixed NSEC/NSEC3* set.
    8. Else, if the authority section has neither NSEC nor NSEC3 records, then
      add the name server IP to the *No NSEC or NSEC3* set.
    9. Else (the authority section has one or more NSEC records but no NSEC3
       records or one or more NSEC3 records but no NSEC records) do:
       1. Add the name server IP to the *Has NSEC* set (*Has NSEC3*
          set).
       2. Retrieve all NSEC (NSEC3) records from the response.
       3. Verify if the NSEC (NSEC3) records cover the
          *Non-Existent Query Name*.
          * If not then add the name server IP to the
            *Name not covered by NSEC* (*Name not covered by NSEC3*) set.
       4. Retreive the RRSIG records for the retreived NSEC records
         (NSEC3 records).
       5. If any of the NSEC records (NSEC3 records) do not have
          a matching RRSIG record, then add the name server IP to the
          *NSEC Missing Signature* (*NSEC3 Missing Signature*) set.
       6. If no NSEC (NSEC3) record was signed, go to next name server IP.
       7. Compare the RRSIG records with the retrieved DNSKEY records.
       8. For each NSEC RRSIG (NSEC3 RRSIG) do:
          1. Verify the RRSIG record by the DNSKEY records.
          2. If the Zonemaster installation does not have support for the DNSKEY
             algorithm that created the RRSIG, then add name server IP, DNSKEY
             algorithm and DNSKEY key tag to the *Algo Not Supported By ZM* set.
          2. Else, if one or more of the following criteria is met, add the name
             server IP to the *NSEC RRSIG Verify Error*
             (*NSEC3 RRSIG Verify Error*) set.
             1. No DNSKEY records are available.
             2. The RRSIG record has a validity period that starts after or ends
                before the time of test execution.
             3. There is no DNSKEY that matches RRSIG by key tag.
             4. The RRSIG cannot be validated by the DNSKEY record appointed.


6.  If the *Non-Existent Response Error* set is non-empty then output
    *[DS10_NON_EXISTENT_RESPONSE_ERROR]* with the name server IP addresses from
    the set.

7.  If the *No NSEC or NSEC3* set is non-empty then output
    *[DS10_MISSING_NSEC_NSEC3]* with the name server IP addresses from the set.

8.  If both the *Has NSEC* and the *Has NSEC3* are non-empty, then output
    *[DS10_INCONSISTENT_NSEC_NSEC3]* with the name server IP addresses from the
    sets (two sets of name server IP addresses).

9.  If the *Mixed NSEC/NSEC3* set is non-empty, then output
    *[DS10_MIXED_NSEC_NSEC3]* with the name server IP addresses from the set.

10. If the *Has NSEC* set is non-empty and all the following sets are empty, then
    output *[DS10_HAS_NSEC]*:
    1. *No NSEC or NSEC3* set
    2. *Has NSEC3* set
    3. *Mixed NSEC/NSEC3* set

11. If the *Has NSEC3* set is non-empty and all the following sets are empty,
    then output *[DS10_HAS_NSEC3]*:
    1. *No NSEC or NSEC3* set
    2. *Has NSEC* set
    3. *Mixed NSEC/NSEC3* set

12. If the *Name not covered by NSEC* set is non-empty then output
    *[DS10_NAME_NOT_COVERED_BY_NSEC]* with the name server IP addresses from the
    set.

13. If the *Name not covered by NSEC3* set is non-empty then output
    *[DS10_NAME_NOT_COVERED_BY_NSEC3]* with the name server IP addresses from the
    set.

14. If the *NSEC Missing Signature* set is non-empty then output
    *[DS10_NSEC_MISSING_SIGNATURE]* with the name server IP addresses from the
    set.

15. If the *NSEC3 Missing Signature* set is non-empty then output
    *[DS10_NSEC3_MISSING_SIGNATURE]* with the name server IP addresses from the
    set.

16. If the *NSEC RRSIG Verify Error* set is non-empty, then output
    *[DS10_NSEC_RRSIG_VERIFY_ERROR]* with the name server IP addresses from the
    set.

17. If the *NSEC3 RRSIG Verify Error* set is non-empty, then output
    *[DS10_NSEC3_RRSIG_VERIFY_ERROR]* with the name server IP addresses from the
    set.

18. If the *Algo Not Supported By ZM* set is non-empty, then output
    *[DS10_ALGO_NOT_SUPPORTED_BY_ZM]* for each DNSKEY key tag with the name
    server IP addresses, the key tag and the algorithm name and code from the set.


## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *[ERROR]* or *[CRITICAL]*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *[WARNING]*, but no message with severity level
*ERROR* or *CRITICAL*.

In other cases, no message or only messages with severity level
*[INFO]* or *[NOTICE]*, the outcome of this Test Case is "pass".


## Special procedural requirements

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
on the ignored result.

See the [DNSSEC README] document about DNSSEC algorithms.


## Intercase dependencies

None.


## Terminology

No special terminology for this test case.



[Argument list]:                             https://github.com/zonemaster/zonemaster-engine/blob/master/docs/logentry_args.md
[Basic04]:                                   ../Basic-TP/basic04.md
[CRITICAL]:                                  ../SeverityLevelDefinitions.md#critical
[DNSSEC README]:                             README.md
[DS10_ALGO_NOT_SUPPORTED_BY_ZM]:             #Summary
[DS10_HAS_NSEC3]:                            #Summary
[DS10_HAS_NSEC]:                             #Summary
[DS10_INCONSISTENT_NSEC_NSEC3]:              #Summary
[DS10_MISSING_NSEC_NSEC3]:                   #Summary
[DS10_MIXED_NSEC_NSEC3]:                     #Summary
[DS10_NAME_NOT_COVERED_BY_NSEC3]:            #Summary
[DS10_NAME_NOT_COVERED_BY_NSEC]:             #Summary
[DS10_NON_EXISTENT_RESPONSE_ERROR]:          #Summary
[DS10_NSEC3_MISSING_SIGNATURE]:              #Summary
[DS10_NSEC3_RRSIG_VERIFY_ERROR]:             #Summary
[DS10_NSEC_MISSING_SIGNATURE]:               #Summary
[DS10_NSEC_RRSIG_VERIFY_ERROR]:              #Summary
[ERROR]:                                     ../SeverityLevelDefinitions.md#error
[INFO]:                                      ../SeverityLevelDefinitions.md#info
[Method4]:                                   ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                                   ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[NOTICE]:                                    ../SeverityLevelDefinitions.md#notice
[RFC 4034#section-4]:                        https://tools.ietf.org/html/rfc4034#section-4
[RFC 4035#section-3.1.3]:                    https://tools.ietf.org/html/rfc4035#section-3.1.3
[RFC 5155#section-3]:                        https://tools.ietf.org/html/rfc5155#section-3
[RFC 5155#section-7.2]:                      https://tools.ietf.org/html/rfc5155#section-7.2
[Severity Level Definitions]:                ../SeverityLevelDefinitions.md
[WARNING]:                                   ../SeverityLevelDefinitions.md#warning
[Zonemaster-Engine profile]:                 https://github.com/zonemaster/zonemaster-engine/blob/master/docs/Profiles.md
