# DNSSEC10: Zone contains NSEC or NSEC3 records


## Test case identifier
**DNSSEC10**


## Table of contents

* [Objective](#objective)
* [Scope](#scope)
* [Inputs](#inputs)
* [Summary](#summary)
* [Test procedure](#test-procedure)
* [Outcome(s)](#outcomes)
* [Special procedural requirements](#special-procedural-requirements)
* [Intercase dependencies](#intercase-dependencies)
* [Terminology](#terminology)


## Objective

When DNSSEC is enabled, NSEC or NSEC3 records provide a secure denial
of existence for records not present in the zone. This test case
verifies that correct NSEC or NSEC3 records with valid signatures are
returned for a query for a nonexistent name.

Furthermore, it is verified that the name servers for the zone are consistent
about NSEC and NSEC3, i.e. either all servers should use NSEC or all servers
should use NSEC3. It is never permitted to serve both NSEC and NSEC3 for the
same zone.

The use of the NSEC RR type is described in
[RFC 4035][RFC 4035#section-3.1.3], section 3.1.3, and
the description of the NSEC RR itself is in
[RFC 4034][RFC 4034#section-4], section 4.

The description of the NSEC3 RR is in
[RFC 5155][RFC 5155#section-3], section 3, and its
use in the DNS response is described in
[RFC 5155][RFC 5155#section-7.2], section 7.2.


## Scope

This test case will just ignore non-responsive name servers or name servers not
giving a correct DNS response for an authoritative name server (covered by
[Connectivity01]).

This test case is only relevant if the zone has been DNSSEC signed.


## Inputs

* "Child Zone" - The domain name to be tested.
* "[Nonexistent Query Name]" - A name constructed by prepending
  *Child Zone* with a label (e.g. "xx--zpeqz4v66tckbqkyw35k--xx") created by the
  following steps, resulting in e.g. "xx--zpeqz4v66tckbqkyw35k--xx.exemple.com".
  * Use the string "xx--" as a prefix for the label.
  * As middle part of the label, use a mixed string of 20 characters from the set
    "a-z0-9".
  * Use the string "--xx" as a suffix for the label.


## Summary

* If no DNSKEY records are found, then further investigation will not be done
  and no messages will be outputted.

Message Tag outputted              | Level   | Arguments  | Description of when message tag is outputted
:----------------------------------|:--------|:-----------|:--------------------------------------------
DS10_ALGO_NOT_SUPPORTED_BY_ZM      | NOTICE  | ns_ip_list, algo_mnemo, algo_num, keytag | This installation of Zonemaster does not support the DNSKEY algorithm.
DS10_ANSWER_VERIFY_ERROR           | ERROR   | ns_ip_list, domain, rrtype | RRSIG on record or records in answer section cannot be verified.
DS10_HAS_NSEC                      | INFO    |            | Consistent NSEC returned from servers.
DS10_HAS_NSEC3                     | INFO    |            | Consistent NSEC3 returned from servers.
DS10_INCONSISTENT_NSEC_NSEC3       | ERROR   |2 ns_ip_list| Some servers return NSEC, others return NSEC3.
DS10_MISSING_NSEC_NSEC3            | ERROR   | ns_ip_list | Missing expected NSEC or NSEC3 in a signed zone.
DS10_MIXED_NSEC_NSEC3              | ERROR   | ns_ip_list | Both NSEC and NSEC3 are returned from the same server.
DS10_NAME_NOT_COVERED_BY_NSEC      | ERROR   | ns_ip_list | The nonexistent name is not correctly covered by the NSEC records.
DS10_NAME_NOT_COVERED_BY_NSEC3     | ERROR   | ns_ip_list | The nonexistent name is not correctly covered by the NSEC3 records.
DS10_NON_EXISTENT_RESPONSE_ERROR   | ERROR   | ns_ip_list | No or error in response of an expected nonexistent name.
DS10_NSEC3_MISSING_SIGNATURE       | ERROR   | ns_ip_list | Missing signatures for NSEC3 record or records.
DS10_NSEC3_RRSIG_VERIFY_ERROR      | ERROR   | ns_ip_list | The signature or signatures on the NSEC3 record or records cannot be correctly verfied.
DS10_NSEC_MISSING_SIGNATURE        | ERROR   | ns_ip_list | Missing signatures for NSEC record or records.
DS10_NSEC_RRSIG_VERIFY_ERROR       | ERROR   | ns_ip_list | The signature or signatures on the NSEC record or records cannot be correctly verfied.
DS10_UNSIGNED_ANSWER               | ERROR   | ns_ip_list, domain, rrtype | RRSIG is missing for record or records in the answer section.

The value in the Level column is the default severity level of the message. The
severity level can be changed in the [Zonemaster-Engine profile]. Also see the
[Severity Level Definitions] document.

The argument names in the Arguments column lists the arguments used in the
message. The argument names are defined in the [argument list].


## Test procedure

1.  Create a DNSKEY query with DO flag set for *Child Zone* ("DNSKEY Query").

2.  Create an A query with DO flag set for *[Nonexistent Query Name]*
    ("Nonexistent Query").

3.  Retrieve all name server IP addresses for the
    *Child Zone* using [Method4] and [Method5] ("NS IP").

4.  Create the following empty sets:
    1.  Name server IP, RR type and owner name ("Unsigned Answer").
    2.  Name server IP, RR type and owner name("Answer Verify Error").
    3.  Name server IP address ("Has NSEC").
    4.  Name server IP address ("Has NSEC3").
    5.  Name server IP address ("No NSEC Or NSEC3").
    6.  Name server IP address ("Mixed NSEC/NSEC3").
    7.  Name server IP address ("Name Not Covered By NSEC").
    8.  Name server IP address ("Name Not Covered By NSEC3").
    9.  Name server IP address ("NSEC Missing Signature").
    10. Name server IP address ("NSEC3 Missing Signature").
    11. Name server IP address ("Nonexistent Response Error").
    12. Name server IP address ("NSEC RRSIG Verify Error").
    13. Name server IP address ("NSEC3 RRSIG Verify Error").
    14. Name server IP address, DNSKEY record key tag and DNSKEY algorithm code
       ("Algo Not Supported By ZM").

5.  For each name server IP address in *NS IP* do:

    1. Send *DNSKEY Query* to the name server IP.
    2. If at least one of the following criteria is met, then go to next name
       server IP:
         1. There is no DNS response.
         2. The RCODE of response is not "NoError" ([IANA RCODE List]).
         3. The AA flag is not set in the response.
         4. There is no DNSKEY record with matching owner name in the answer section.
    3. Retrieve the DNSKEY records from the answer section.
    4. Send *Nonexistent Query* over UDP to the name server IP.
    5. If at least one of the following criteria is met, then add the name
       server IP to the *Nonexistent Response Error* set and go to next name
       server IP:
         1. There is no DNS response.
         2. The RCODE of response is neither "NoError" nor "NXDomain"
            ([IANA RCODE List]).
         3. The AA flag is not set in the response.
    6. If the following criteria are met go to next name server IP:
       1. The The RCODE of response is "NoError" ([IANA RCODE List]).
       2. The answer section has an RRset of RR type "A" ([IANA RR Type List])
          and either:
          1. The "A" RRset has the same owner name as the query name, or
          2. There are one or more record of RR type "CNAME"
             ([IANA RR Type List]) chaining from the query name to the owner name
             of the "A" RRset.
       3. The answer section has RRsig record or records in the answer section
          meeting the following criteria:
          1. There is at least one RRsig for the "A" RRset in the answer section.
          2. If there are CNAME records in the answer section, then there is at
             least one RRsig for each CNAME record.
          3. None of the RRsig records are for a wildcard.
    7. If the following criteria are met go to next name server IP:
       1. The The RCODE of response is "NoError" ([IANA RCODE List]).
       2. The answer section has one or more record of RR type "CNAME"
          ([IANA RR Type List]) in a chain where first record has the owner name
          matching the query name.
       3. The answer section has RRsig record or records in the answer section
          meeting the following criteria:
          1. There is at least one RRsig for each CNAME record.
          2. None of the RRsig records are for a wildcard.
       4. There are neither NSEC nor NSEC3 records in the authority section.
    8. If the answer section has any RRset of RR type "A" or "CNAME"
       ([IANA RR Type List]) do ("RRset"):
       1. For each RRset in *RRset* add name server IP, RR type and owner name
          to the *Unsigned Answer* set if both criteria are true:
          1. There is no RRSIG record covering the owner name of the RRset.
          2. There is no RRSIG record covering a wild card record whose owner
             name covers the owner name of the RRset.
       2. Go to next name server IP if any data was added to the
          *Unsigned Answer* set in the loop above.
       3. For each RRset in *RRset* add name server IP, RR type and owner name to
          the *Answer Verify Error* set if its RRSIG cannot be verified by the
          corresponding DNSKEY or DNSKEY is missing.
       2. Go to next name server IP if any data was added to the
          *Answer Verify Error* set in the loop above.
    9.  If the authority section has both NSEC and NSEC3 records, add the name
        server IP to the *Mixed NSEC/NSEC3* set.
    10. Else, if the authority section has neither NSEC nor NSEC3 records, then
        add the name server IP to the *No NSEC Or NSEC3* set.
    11. Else (the authority section has one or more NSEC records but no NSEC3
        records or one or more NSEC3 records but no NSEC records) do:
        1. Add the name server IP to the *Has NSEC* set (*Has NSEC3*
           set).
        2. Retrieve all NSEC (NSEC3) records from the response.
        3. Verify if the NSEC (NSEC3) records cover the
           *[Nonexistent Query Name]*.
           * If not then add the name server IP to the
            *Name Not Covered By NSEC* (*Name Not Covered By NSEC3*) set.
        4. Retrieve the RRSIG records for the retrieved NSEC records
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


6.  If the *Nonexistent Response Error* set is non-empty then output
    *[DS10_NON_EXISTENT_RESPONSE_ERROR]* with the name server IP addresses from
    the set.

7.  If the *Unsigned Answer* set is non-empty then for each owner name and RR
    type output *[DS10_UNSIGNED_ANSWER]* with owner name, RR type and name server
    IP addresses.

8.  If the *Answer Verify Error* set is non-empty then for each owner name and RR
    type output *[DS10_ANSWER_VERIFY_ERROR]* with owner name, RR type and name
    server IP addresses.

9.  If the *No NSEC Or NSEC3* set is non-empty then output
    *[DS10_MISSING_NSEC_NSEC3]* with the name server IP addresses from the set.

10. If both the *Has NSEC* and the *Has NSEC3* are non-empty, then output
    *[DS10_INCONSISTENT_NSEC_NSEC3]* with the name server IP addresses from the
    sets (two sets of name server IP addresses).

11. If the *Mixed NSEC/NSEC3* set is non-empty, then output
    *[DS10_MIXED_NSEC_NSEC3]* with the name server IP addresses from the set.

12. If the *Has NSEC* set is non-empty and all the following sets are empty, then
    output *[DS10_HAS_NSEC]*:
    1. *No NSEC Or NSEC3* set
    2. *Has NSEC3* set
    3. *Mixed NSEC/NSEC3* set

13. If the *Has NSEC3* set is non-empty and all the following sets are empty,
    then output *[DS10_HAS_NSEC3]*:
    1. *No NSEC Or NSEC3* set
    2. *Has NSEC* set
    3. *Mixed NSEC/NSEC3* set

14. If the *Name Not Covered By NSEC* set is non-empty then output
    *[DS10_NAME_NOT_COVERED_BY_NSEC]* with the name server IP addresses from the
    set.

15. If the *Name Not Covered By NSEC3* set is non-empty then output
    *[DS10_NAME_NOT_COVERED_BY_NSEC3]* with the name server IP addresses from the
    set.

16. If the *NSEC Missing Signature* set is non-empty then output
    *[DS10_NSEC_MISSING_SIGNATURE]* with the name server IP addresses from the
    set.

17. If the *NSEC3 Missing Signature* set is non-empty then output
    *[DS10_NSEC3_MISSING_SIGNATURE]* with the name server IP addresses from the
    set.

18. If the *NSEC RRSIG Verify Error* set is non-empty, then output
    *[DS10_NSEC_RRSIG_VERIFY_ERROR]* with the name server IP addresses from the
    set.

19. If the *NSEC3 RRSIG Verify Error* set is non-empty, then output
    *[DS10_NSEC3_RRSIG_VERIFY_ERROR]* with the name server IP addresses from the
    set.

20. If the *Algo Not Supported By ZM* set is non-empty, then output
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

### The Nonexistent Query Name

The term "The Nonexistent Query Name" is used for a name in the *Child Zone*,
just below apex constructed for this test case to, with high certainty, not
exist, as a directly defined name. The first label starts with "xx--" which
should not be used as of [RFC 5890][RFC 5890#section-2.3.1], section 2.3.1.


[Argument list]:                              ../ArgumentsForTestCaseMessages.md
[Connectivity01]:                             ../Connectivity-TP/connectivity01.md
[CRITICAL]:                                   ../SeverityLevelDefinitions.md#critical
[DNSSEC README]:                              README.md
[DS10_ALGO_NOT_SUPPORTED_BY_ZM]:              #summary
[DS10_ANSWER_VERIFY_ERROR]:                   #summary
[DS10_HAS_NSEC3]:                             #summary
[DS10_HAS_NSEC]:                              #summary
[DS10_INCONSISTENT_NSEC_NSEC3]:               #summary
[DS10_MISSING_NSEC_NSEC3]:                    #summary
[DS10_MIXED_NSEC_NSEC3]:                      #summary
[DS10_NAME_NOT_COVERED_BY_NSEC3]:             #summary
[DS10_NAME_NOT_COVERED_BY_NSEC]:              #summary
[DS10_NON_EXISTENT_RESPONSE_ERROR]:           #summary
[DS10_NSEC3_MISSING_SIGNATURE]:               #summary
[DS10_NSEC3_RRSIG_VERIFY_ERROR]:              #summary
[DS10_NSEC_MISSING_SIGNATURE]:                #summary
[DS10_NSEC_RRSIG_VERIFY_ERROR]:               #summary
[DS10_UNSIGNED_ANSWER]:                       #summary
[ERROR]:                                      ../SeverityLevelDefinitions.md#error
[IANA RCODE List]:                            https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[IANA RR Type List]:                          https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-4
[INFO]:                                       ../SeverityLevelDefinitions.md#info
[Method4]:                                    ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                                    ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[NOTICE]:                                     ../SeverityLevelDefinitions.md#notice
[Nonexistent Query Name]:                     #the-nonexistent-query-name
[RFC 4034#section-4]:                         https://datatracker.ietf.org/doc/html/rfc4034#section-4
[RFC 4035#section-3.1.3]:                     https://datatracker.ietf.org/doc/html/rfc4035#section-3.1.3
[RFC 5155#section-3]:                         https://datatracker.ietf.org/doc/html/rfc5155#section-3
[RFC 5155#section-7.2]:                       https://datatracker.ietf.org/doc/html/rfc5155#section-7.2
[RFC 5890#section-2.3.1]:                     https://datatracker.ietf.org/doc/html/rfc5890#section-2.3.1
[Severity Level Definitions]:                 ../SeverityLevelDefinitions.md
[WARNING]:                                    ../SeverityLevelDefinitions.md#warning
[Zonemaster-Engine profile]:                  ../../../configuration/profiles.md
