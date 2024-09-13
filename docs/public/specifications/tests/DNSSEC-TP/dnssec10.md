# DNSSEC10: Zone contains NSEC or NSEC3 records


## Test case identifier
**DNSSEC10**


## Table of contents

* [Objective](#objective)
* [Scope](#scope)
* [Inputs](#inputs)
* [Summary](#summary)
  * [Comments on mixing of NSEC and NSEC3](#comments-on-mixing-of-nsec-and-nsec3)
* [Test procedure]
* [Outcome(s)](#outcomes)
* [Special procedural requirements](#special-procedural-requirements)
* [Intercase dependencies](#intercase-dependencies)
* [Terminology](#terminology)


## Objective

When DNSSEC is enabled, NSEC or NSEC3 records provide a secure denial of
existence for records not present in the zone. This Test Case verifies that
correct NSEC or NSEC3 records with valid signatures are returned for a query for
an RR type that does not exist for that specific name (node in the DNS tree).
The existing RR types are listed in the [IANA RR Type List].

Furthermore, it is verified that the name servers for the zone are consistent
about NSEC and NSEC3, i.e. either all servers should use NSEC or all servers
should use NSEC3. It is never permitted to serve both NSEC and NSEC3 for the
same zone.

The NSEC3PARAM RR that must exist in the zone (in apex, and apex only) if NSEC3
is used, but must not exist in a zone using NSEC.

The use of the NSEC RR type is described in [RFC 4035][RFC 4035#section-3.1.3],
section 3.1.3, and the description of the NSEC RR itself is in
[RFC 4034][RFC 4034#section-4], section 4.

The description of the NSEC3 and NSEC3PARAM RRs are found in
[RFC 5155][RFC 5155#section-3], section 3, and [RFC 5155][RFC 5155#section-4],
section 4, respectively. The use of NSEC3 in the DNS response is described in
[RFC 5155][RFC 5155#section-7.2], section 7.2.


## Scope

This test case will just ignore non-responsive name servers or name servers not
giving a correct DNS response for an authoritative name server (covered by
[Connectivity01]).

This test case is only relevant if the zone has been DNSSEC signed.


## Inputs

* "Child Zone" - The domain name to be tested.


## Summary

* If no DNSKEY records are found, then further investigation will not be done
  and no messages will be outputted.

Message Tag outputted              | Level   | Arguments  | Message ID for message tag
:----------------------------------|:--------|:-----------|:--------------------------------------------
DS10_ALGO_NOT_SUPPORTED_BY_ZM      | NOTICE  | ns_list, algo_mnemo, algo_num, keytag | DNSKEY with tag {keytag} uses unsupported algorithm {algo_num} ({algo_mnemo}) by this installation of Zonemaster. Fetched from name servers "{ns_list}".
DS10_ERR_MULT_NSEC                 | ERROR   | ns_list | Multiple NSEC records when one is expected. Fetched from name servers "{ns_list}".
DS10_ERR_MULT_NSEC3                | ERROR   | ns_list | Multiple NSEC3 records when one is expected. Fetched from name servers "{ns_list}".
DS10_EXPECTED_NSEC_NSEC3_MISSING   | ERROR   | ns_list | The server responded with DNSKEY but not with expected NSEC or NSEC3. Fetched from name servers "{ns_list}".
DS10_HAS_NSEC                      | INFO    | ns_list | The zone has NSEC records. Fetched from name servers "{ns_list}".
DS10_HAS_NSEC3                     | INFO    | ns_list | The zone has NSEC3 records. Fetched from name servers "{ns_list}".
DS10_INCONSISTENT_NSEC             | ERROR   | ns_list | Inconsistent responses from zone with NSEC. Fetched from name servers "{ns_list}".
DS10_INCONSISTENT_NSEC3            | ERROR   | ns_list | Inconsistent responses from zone with NSEC3. Fetched from name servers "{ns_list}".
DS10_INCONSISTENT_NSEC_NSEC3       | ERROR   |ns_list_nsec, ns_list_nsec3| The zone is inconsistent on NSEC and NSEC3. NSEC is fetched from name servers "{ns_list_nsec}". NSEC3 is fetched from name servers "{ns_list_nsec3}".
DS10_MIXED_NSEC_NSEC3              | ERROR   | ns_list | The zone responds with both NSEC and NSEC3, where only one of them is expected. Fetched from name servers "{ns_list}".
DS10_NSEC3PARAM_GIVES_ERR_ANSWER   | ERROR   | ns_list | Unexpected DNS record in the answer section on an NSEC3PARAM query. Fetched from name servers "{ns_list}".
DS10_NSEC3PARAM_QUERY_RESPONSE_ERR | ERROR   | ns_list | No response or error in response on query for NSEC3PARAM. Fetched from name servers "{ns_list}".
DS10_NSEC3_ERR_TYPE_LIST           | ERROR   | ns_list | NSEC3 record for the zone apex with incorrect type list. Fetched from name servers "{ns_list}".
DS10_NSEC3_MISMATCHES_APEX         | ERROR   | ns_list | The returned NSEC3 record unexpectedly does not match the zone name. Fetched from name servers "{ns_list}".
DS10_NSEC3_MISSING_SIGNATURE       | ERROR   | ns_list | Missing RRSIG (signature) for the NSEC3 record or records. Fetched from name servers "{ns_list}".
DS10_NSEC3_NODATA_MISSING_SOA      | ERROR   | ns_list | Missing SOA record in NODATA response with NSEC3. Fetched from name servers "{ns_list}".
DS10_NSEC3_NODATA_WRONG_SOA        | ERROR   | ns_list, domain | Wrong owner name ("{domain}") on SOA record in NODATA response with NSEC3. Fetched from name servers "{ns_list}".
DS10_NSEC3_NO_VERIFIED_SIGNATURE   | ERROR   | ns_list | The RRSIG (signature) for the NSEC3 record cannot be verified. Fetched from name servers "{ns_list}".
DS10_NSEC3_RRSIG_EXPIRED           | ERROR   | ns_list, keytag | The RRSIG (signature) with tag {keytag} for the NSEC3 record has expired. Fetched from name servers "{ns_list}".
DS10_NSEC3_RRSIG_NOT_YET_VALID     | ERROR   | ns_list, keytag | The RRSIG (signature) with tag {keytag} for the NSEC3 record it not yet valid. Fetched from name servers "{ns_list}".
DS10_NSEC3_RRSIG_NO_DNSKEY         | WARNING | ns_list, keytag | There is no DNSKEY record matching the RRSIG (signature) with tag {keytag} for the NSEC3 record. Fetched from name servers "{ns_list}".
DS10_NSEC3_RRSIG_VERIFY_ERROR      | ERROR   | ns_list, keytag | The RRSIG (signature) with tag {keytag} for the NSEC3 record cannot be verified. Fetched from name servers "{ns_list}".
DS10_NSEC_ERR_TYPE_LIST            | ERROR   | ns_list | NSEC record for the zone apex with incorrect type list. Fetched from name servers "{ns_list}".
DS10_NSEC_GIVES_ERR_ANSWER         | ERROR   | ns_list | Unexpected DNS record in the answer section on an NSEC query. Fetched from name servers "{ns_list}".
DS10_NSEC_MISMATCHES_APEX          | ERROR   | ns_list | The returned NSEC record has an unexpected non-apex owner name. Fetched from name servers "{ns_list}".
DS10_NSEC_MISSING_SIGNATURE        | ERROR   | ns_list | Missing RRSIG (signature) for the NSEC record or records. Fetched from name servers "{ns_list}".
DS10_NSEC_NODATA_MISSING_SOA       | ERROR   | ns_list | Missing SOA record in NODATA response with NSEC. Fetched from name servers "{ns_list}".
DS10_NSEC_NODATA_WRONG_SOA         | ERROR   | ns_list, domain | Wrong owner name ("{domain}") on SOA record in NODATA response with NSEC. Fetched from name servers "{ns_list}".
DS10_NSEC_NO_VERIFIED_SIGNATURE    | ERROR   | ns_list | There is no RRSIG (signature) for the NSEC record that can be verified. Fetched from name servers "{ns_list}".
DS10_NSEC_QUERY_RESPONSE_ERR       | ERROR   | ns_list | No response or error in response on query for NSEC. Fetched from name servers "{ns_list}".
DS10_NSEC_RRSIG_EXPIRED            | ERROR   | ns_list, keytag | The RRSIG (signature) with tag {keytag} for the NSEC record has expired. Fetched from name servers "{ns_list}".
DS10_NSEC_RRSIG_NOT_YET_VALID      | ERROR   | ns_list, keytag | The RRSIG (signature) with tag {keytag} for the NSEC record it not yet valid. Fetched from name servers "{ns_list}".
DS10_NSEC_RRSIG_NO_DNSKEY          | WARNING | ns_list, keytag | There is no DNSKEY record matching the RRSIG (signature) with tag {keytag} for the NSEC record. Fetched from name servers "{ns_list}".
DS10_NSEC_RRSIG_VERIFY_ERROR       | ERROR   | ns_list, keytag | The RRSIG (signature) with tag {keytag} for the NSEC record cannot be verified. Fetched from name servers "{ns_list}".
DS10_SERVER_NO_DNSSEC              | ERROR   | ns_list | The following name servers do not support DNSSEC or have not been properly configured. Testing for NSEC and NSEC3 has been skipped on these servers. Fetched from name servers "{ns_list}".
DS10_ZONE_NO_DNSSEC                | NOTICE  | ns_list | The zone is not DNSSEC signed or not properly DNSSEC signed. Testing for NSEC and NSEC3 has been skipped. Fetched from name servers "{ns_list}".


The value in the Level column is the default severity level of the message. The
severity level can be changed in the [Zonemaster-Engine profile]. Also see the
[Severity Level Definitions] document.

The argument names in the Arguments column lists the arguments used in the
message. The argument names are defined in the [argument list].

The name server names are assumed to be available at the time when the msgid
is created, if the argument name is "ns" or "ns_list" even when in the
"[Test procedure]" below it is only referred to the IP address of the name
servers.

For the Zonemaster definition of the mnemonics for DNSKEY algorithms, see the
algorithm table in the "Objective" section in [DNSSEC05][DNSSEC05#objective].

### Comments on mixing of NSEC and NSEC3

In section "[Test procedure]" below, if the server returns an NSEC record (either
in the answer section when querying for NSEC or on the authority section when
querying for NSEC3PARAM) it is considered to be "NSEC type" for the zone.

If the server returns NSEC3PARAM record in the answer section when querying for
it or an NSEC3 record in the authority section when querying for NSEC it is
considered the server to "NSEC3 type" for the zone.

*[DS10_MIXED_NSEC_NSEC3]* means that one or several servers have been
identified as both NSEC type and NSEC3 type.

*[DS10_INCONSISTENT_NSEC_NSEC3]* means that some servers are non-mixed
"NSEC type" and others are non-mixed NSEC3 type for the same zone.


## Test procedure

In this section and unless otherwise specified below, the term "[DNSSEC Query]"
follow the specification for DNS queries as specified in
[DNS Query and Response Defaults]. The handling of the DNS responses on the DNS
queries follow, unless otherwise specified below, what is specified for
[DNSSEC Response] in the same specification.

A complete list of all DNS Resource Record types can be found in the
[IANA RR Type List].

1. Create a [DNSSEC Query] with query type DNSKEY and query name *Child Zone*
   ("DNSKEY Query").

2. Create a [DNSSEC Query] with query type NSEC and query name *Child Zone*
   ("NSEC Query").

3. Create a [DNSSEC Query] with query type NSEC3PARAM and query name *Child Zone*
   ("NSEC3PARAM Query").

4.  Retrieve all name server names and IP addresses for the
    *Child Zone* using [Method4] and [Method5] ("NS IP").

5.  Create the following empty sets:

    1.  Name server IP address, DNSKEY record key tag and DNSKEY algorithm code
        ("Algo Not Supported By ZM").
    2.  Name server IP address ("Erroneous Multiple NSEC").
    3.  Name server IP address ("Erroneous Multiple NSEC3").
    4.  Name server IP address ("NSEC In Answer").
    5.  Name server IP address ("NSEC Incorrect Type List").
    6.  Name server IP address ("NSEC Mismatches Apex").
    7.  Name server IP address ("NSEC Missing Signature").
    8.  Name server IP address and owner name (domain name data)
        ("NSEC NODATA Wrong SOA").
    9.  Name server IP address ("NSEC NODATA Missing SOA").
    10. Name server IP address ("NSEC Query Gives Erroneous Answer").
    11. Name server IP address ("NSEC Query Gives NSEC3 NODATA").
    12. Name server IP address and key tag ("NSEC RRSIG Verify Error").
    13. Name server IP address and key tag ("NSEC RRSIG Expired").
    14. Name server IP address and key tag ("NSEC RRSIG Not Yet Valid").
    15. Name server IP address and key tag ("NSEC RRSIG No DNSKEY").
    16. Name server IP address ("NSEC RRSIG Verified").
    17. Name server IP address ("NSEC Query Response Error").
    18. Name server IP address ("NSEC3 Incorrect Type List").
    19. Name server IP address ("NSEC3 Mismatches Apex").
    20. Name server IP address ("NSEC3 Missing Signature").
    21. Name server IP address and owner name (domain name data)
        ("NSEC3 NODATA Wrong SOA").
    22. Name server IP address ("NSEC3 NODATA Missing SOA").
    23. Name server IP address and key tag ("NSEC3 RRSIG Verify Error").
    24. Name server IP address and key tag ("NSEC3 RRSIG Expired").
    25. Name server IP address and key tag ("NSEC3 RRSIG Not Yet Valid").
    26. Name server IP address and key tag ("NSEC3 RRSIG No DNSKEY").
    27. Name server IP address ("NSEC3 RRSIG Verified").
    28. Name server IP address ("NSEC3PARAM In Answer").
    29. Name server IP address ("NSEC3PARAM Query Gives Erroneous Answer").
    30. Name server IP address ("NSEC3PARAM Query Gives NSEC NODATA").
    31. Name server IP address ("NSEC3PARAM Query Response Error").
    32. Name server IP address ("Responds without DNSKEY").
    33. Name server IP address ("Responds with DNSKEY").

6.  For each name server IP address in *NS IP* do:

    1. Send *DNSKEY Query* to the name server IP.
    2. If at least one of the following criteria is met, then go to next name
       server IP:
         1. There is no DNS response.
         2. The [RCODE Name] in the response is not "NoError".
         3. The AA flag is not set in the response.
    3. If the response does not contain any DNSKEY record with owner name
       matching *Child Zone* in the answer section, add name server name and IP
       to the *Responds without DNSKEY* set and go to next server.
    4. Else, add name server IP to the *Responds with DNSKEY* set and retrieve
       the DNSKEY records from the answer section to be used in validation below.
    5. Send *NSEC Query* to the name server IP and do:
       1. If at least one of the following criteria is met, then add the name
          server IP to the *NSEC Query Response Error* set:
          1. There is no DNS response.
          2. The [RCODE Name] in the response is not "NoError".
          3. The AA flag is not set in the response.
       2. Else if the answer section is non-empty, then do:
          1. If the answer section has a NSEC RR then do:
             1. Add the name server IP to the *NSEC In Answer* set.
             2. If the owner name of the NSEC record is not *Child Zone* then
                add name server IP to the *NSEC Mismatches Apex* set.
          2. Else then add the name server IP to the
             *NSEC Query Gives Erroneous Answer* set.
       3. Else if the answer section is empty, then do:
          1. If the authority section contains no NSEC3 record then go to next
             name server IP.
          2. Else do:
             1. Add the name server IP to the *NSEC Query Gives NSEC3 NODATA*
                set.
             2. If the SOA record is missing from the authority section then add name
                server IP to the *NSEC3 NODATA Missing SOA* set.
             3. Else if the owner name of SOA record is is not *Child Zone* then
                add name server IP and owner name to the *NSEC3 NODATA Wrong SOA*
                set.
             4. If the authority section contains more than one NSEC3 record then
                add name server IP to the *Erroneous Multiple NSEC3* set.
             5. Else do:
                1. If the hash owner name of the NSEC3 record does not match apex
                   of *Child Zone* then add name server IP to the
                   *NSEC3 Mismatches Apex* set.
                2. Else if the type list in the NSEC3 record matches at least one
                   of the following criteria then add name server IP to the
                   *NSEC3 Incorrect Type List* set:
                   1. At least one of SOA, NS, DNSKEY, NSEC3PARAM or RRSIG is
                      missing.
                   2. At least one of NSEC or NSEC3 is included.
                3. Retrieve the NSEC3 record from the response.
                4. Retrieve the RRSIG records for the retrieved NSEC3 record.
                5. If the NSEC3 records do not have a matching RRSIG
                   record, then add the name server IP to the
                   *NSEC3 Missing Signature* set.
                6. Else do:
                   1. Use the DNSKEY records retrieved above.
                   2. For each NSEC3 RRSIG do:
                      1. Verify the RRSIG record by the DNSKEY records.
                      2. If there is no DNSKEY that matches RRSIG by key tag,
                         then add the name server IP and RRSIG key ID to the
                         *NSEC3 RRSIG No DNSKEY* set.
                      3. If the RRSIG record has a validity period that ends
                         before the time of test execution, then add the name
                         server IP and RRSIG key ID to the
                         *NSEC3 RRSIG Expired* set.
                      4. If the RRSIG record has a validity period that starts
                         after the time of test execution, then add the name
                         server IP and RRSIG key ID to the
                         *NSEC3 RRSIG Not Yet Valid* set.
                      5. If the Zonemaster installation does not have support for
                         the DNSKEY algorithm that created the RRSIG, then add
                         name server IP, DNSKEY algorithm and DNSKEY key tag to
                         the *Algo Not Supported By ZM* set.
                      6. If the RRSIG cannot be validated by the DNSKEY record
                         appointed, then add
                         name server IP, DNSKEY algorithm and DNSKEY key tag to
                         the *NSEC3 RRSIG Verify Error* set.
                      7. Else, add the name server IP to the
                         *NSEC3 RRSIG Verified* set (unless it is already a member
                         of the set).

    6. Send *NSEC3PARAM Query* to the name server IP and do:
       1. If at least one of the following criteria is met, then add the name
          server IP to the *NSEC3PARAM Query Response Errors* set:
          1. There is no DNS response.
          2. The [RCODE Name] in the response is not "NoError".
          3. The AA flag is not set in the response.
       2. Else if the answer section is non-empty, then do:
          1. If the answer section has a NSEC3PARAM RR with owner name
             *Child Zone* then add the name server IP to the
             *NSEC3PARAM In Answer* set.
          2. Else, then add the name server IP to the
             *NSEC3PARAM Query Gives Erroneous Answer* set.
       3. Else if the answer section is empty, then do:
          1. If the authority section contains no NSEC record then go to the next
             name server IP.
          2. Else do:
             1. Add the name server IP to the *NSEC3PARAM Query Gives NSEC NODATA* set.
             2. If the SOA record is missing the authority section then add the
                name server IP to the *NSEC NODATA Missing SOA* set.
             3. Else if the owner name of the SOA record is not *Child Zone* then
                add name server IP and the owner name to the
                *NSEC NODATA Wrong SOA* set.
             4. If the authority section contains more than one NSEC record then
                add name server IP to the *Erroneous Multiple NSEC* set.
             5. Else do:
                1. If the owner name of the NSEC record is not *Child Zone* then
                   add name server IP to the *NSEC Mismatches Apex* set.
                2. Else if the type list in the NSEC record matches at least one
                   of the following criteria then add name server IP to the
                   *NSEC Incorrect Type List* set:
                   1. At least one of SOA, NS, DNSKEY, NSEC or RRSIG is missing.
                   2. At least one of NSEC3PARAM or NSEC3 is included.
                3. Retrieve the NSEC record from the response.
                4. Retrieve the RRSIG records for the retrieved NSEC record.
                5. If the NSEC record does not have a matching RRSIG
                   record, then add the name server IP to the
                   *NSEC Missing Signature* set.
                6. Else do:
                   1. Use the DNSKEY records retrieved above.
                   2. For each NSEC RRSIG do:
                      1. Verify the RRSIG record by the DNSKEY records.
                      2. If there is no DNSKEY that matches RRSIG by key tag,
                         then add the name server IP and RRSIG key ID to the
                         *NSEC RRSIG No DNSKEY* set.
                      3. If the RRSIG record has a validity period that ends
                         before the time of test execution, then add the name
                         server IP and RRSIG key ID to the
                         *NSEC RRSIG Expired* set.
                      4. If the RRSIG record has a validity period that starts
                         after the time of test execution, then add the name
                         server IP and RRSIG key ID to the
                         *NSEC RRSIG Not Yet Valid* set.
                      5. If the Zonemaster installation does not have support for
                         the DNSKEY algorithm that created the RRSIG, then add
                         name server IP, DNSKEY algorithm and DNSKEY key tag to
                         the *Algo Not Supported By ZM* set.
                      6. If the RRSIG cannot be validated by the DNSKEY record
                         appointed, then add
                         name server IP, DNSKEY algorithm and DNSKEY key tag to
                         the *NSEC RRSIG Verify Error* set.
                      7. Else, add the name server IP to the
                         *NSEC RRSIG Verified* set (unless it is already a member
                         of the set).

7.  If the *Erroneous Multiple NSEC* set is non-empty then output
    *[DS10_ERR_MULT_NSEC]* with the name server IP addresses from the
    set.

8.  If the *Erroneous Multiple NSEC3* set is non-empty then output
    *[DS10_ERR_MULT_NSEC3]* with the name server IP addresses from the
    set.

9.  Create a list of those name server IP included in the *NSEC In Answer* set
    but not in the *NSEC3PARAM Query Gives NSEC NODATA* set, or the other way
    around. From that list remove any name server IP included in the
    *NSEC3PARAM In Answer* set or in the *NSEC Query Gives NSEC3 NODATA* set.
    Output *[DS10_INCONSISTENT_NSEC]* with the resulting list of name server
    IP addresses.

10. Create a list of those name server IP included in the *NSEC3PARAM In Answer*
    set but not in the *NSEC Query Gives NSEC3 NODATA* set, or the other way
    around. From that list remove any name server IP included in the
    *NSEC In Answer* set or the *NSEC3PARAM Query Gives NSEC NODATA* set.
    Output *[DS10_INCONSISTENT_NSEC3]* with the resulting list of name server
    IP addresses.

11. Create a list of those name server IP included in the *NSEC3PARAM In Answer*
    set or in the *NSEC Query Gives NSEC3 NODATA* set, and also included in the
    *NSEC In Answer* set or the *NSEC3PARAM Query Gives NSEC NODATA* set. Output
    *[DS10_MIXED_NSEC_NSEC3]* with the resulting list of name server IP
    addresses.

12. If the *NSEC In Answer* set or the *NSEC3PARAM Query Gives NSEC NODATA* set
    (or both) is non-empty and both the *NSEC3PARAM In Answer* set and the
    *NSEC Query Gives NSEC3 NODATA* set are empty, then output *[DS10_HAS_NSEC]*
    with the name server IP addresses from the sets.

13. If the *NSEC3PARAM In Answer* set or the *NSEC Query Gives NSEC3 NODATA* set
    (or both) is non-empty and both the *NSEC In Answer* set and the
    *NSEC3PARAM Query Gives NSEC NODATA* set are empty, then output
    *[DS10_HAS_NSEC3]* with the name server IP addresses from the sets.

14. Create a list of the name server IP in the *NSEC3PARAM In Answer* set or in
    the *NSEC Query Gives NSEC3 NODATA* set (or both). Create a second list of
    the name server IP in the *NSEC In Answer* set or in the
    *NSEC3PARAM Query Gives NSEC NODATA* set (or both). If both lists are
    non-empty then output *[DS10_INCONSISTENT_NSEC_NSEC3]* with both the lists.

15. If the *NSEC Incorrect Type List* set is non-empty, then output
    *[DS10_NSEC_ERR_TYPE_LIST] with the list of name server IP in the set.

16. If the *NSEC Mismatches Apex* set is non-empty, then output
    *[DS10_NSEC_MISMATCHES_APEX] with the list of name server IP in the set.

17. If the *NSEC NODATA Wrong SOA* set is non-empty, then for each owner name
    in the set output *[DS10_NSEC_NODATA_WRONG_SOA]* with the owner name and the
    list of name server IP in the set for that owner name.

18. If the *NSEC NODATA Missing SOA* set is non-empty, then output
    *[DS10_NSEC_NODATA_MISSING_SOA]* with the list of name server IP in the set.

19. If the *NSEC Query Gives Erroneous Answer* set is non-empty, then output
    *[DS10_NSEC_QUERY_GIVES_ERR_ANSWER]* with the list of name server IP in the
    set.

20. If the *NSEC Query Response Error* set is non-empty, then output
    *[DS10_NSEC_QUERY_RESPONSE_ERR]* with the list of name server IP in the set.

21. If the *NSEC3 Incorrect Type List* set is non-empty, then output
    *[DS10_NSEC3_ERR_TYPE_LIST] with the list of name server IP in the set.

22. If the *NSEC3 Mismatches Apex* set is non-empty, then output
    *[DS10_NSEC3_MISMATCHES_APEX] with the list of name server IP in the set.

23. If the *NSEC3 NODATA Wrong SOA* set is non-empty, then for each owner name
    in the set output *[DS10_NSEC3_NODATA_WRONG_SOA]* with the owner name and the
    list of name server IP in the set for that owner name.

24. If the *NSEC3 NODATA Missing SOA* set is non-empty, then output
    *[DS10_NSEC3_NODATA_MISSING_SOA]* with the list of name server IP in the set.

25. If the *NSEC3PARAM Query Gives Erroneous Answer* set is non-empty, then
    output *[DS10_NSEC3PARAM_GIVES_ERR_ANSWER]* with the list of name server IP
    in the set.

26. If the *NSEC3PARAM Query Response Error* set is non-empty, then output
    *[DS10_NSEC3PARAM_QUERY_RESPONSE_ERR]* with the list of name server IP in the
    set.

27. If the *NSEC Missing Signature* set is non-empty then output
    *[DS10_NSEC_MISSING_SIGNATURE]* with the name server IP addresses from the
    set.

28. If the *NSEC3 Missing Signature* set is non-empty then output
    *[DS10_NSEC3_MISSING_SIGNATURE]* with the name server IP addresses from the
    set.

29. If the *NSEC RRSIG No DNSKEY* set is non-empty, then for each key ID
    output *[DS10_NSEC_RRSIG_NO_DNSKEY]* with the key ID and the name server
    IP addresses from the set for the key ID.

30. If the *NSEC RRSIG Expired* set is non-empty, then for each key ID
    output *[DS10_NSEC_RRSIG_EXPIRED]* with the key ID and the name server
    IP addresses from the set for the key ID.

31. If the *NSEC RRSIG Not Yet Valid* set is non-empty, then for each key ID
    output *[DS10_NSEC_RRSIG_NOT_YET_VALID]* with the key ID and the name server
    IP addresses from the set for the key ID.

32. If the *NSEC RRSIG Verify Error* set is non-empty, then for each key ID
    output *[DS10_NSEC_RRSIG_VERIFY_ERROR]* with the key ID and the name server
    IP addresses from the set for the key ID.

33. If the combined set of the unique name server IP addresses of the
    *NSEC RRSIG No DNSKEY*, *NSEC RRSIG Expired*, *NSEC RRSIG Not Yet Valid* and
    *NSEC RRSIG Verify Error* sets is non-empty, then do:
    1. For each name server IP address in the combined set store the IP address
       in a temporary set for the next step if the IP address is not a member of
       the *NSEC RRSIG Verified*.
    2. If the temporary set is non-empty then output
       *[DS10_NSEC_NO_VERIFIED_SIGNATURE]* with the name server IP addresses from
       the set.

34. If the *NSEC3 RRSIG No DNSKEY* set is non-empty, then for each key ID
    output *[DS10_NSEC3_RRSIG_NO_DNSKEY]* with the key ID and the name server
    IP addresses from the set for the key ID.

35. If the *NSEC3 RRSIG Expired* set is non-empty, then for each key ID
    output *[DS10_NSEC3_RRSIG_EXPIRED]* with the key ID and the name server
    IP addresses from the set for the key ID.

36. If the *NSEC3 RRSIG Not Yet Valid* set is non-empty, then for each key ID
    output *[DS10_NSEC3_RRSIG_NOT_YET_VALID]* with the key ID and the name server
    IP addresses from the set for the key ID.

37. If the *NSEC3 RRSIG Verify Error* set is non-empty, then for each key ID
    output *[DS10_NSEC3_RRSIG_VERIFY_ERROR]* with the key ID and the name server
    IP addresses from the set for the key ID.

38. If the combined set of the *NSEC3 RRSIG No DNSKEY*, *NSEC3 RRSIG Expired*,
    *NSEC3 RRSIG Not Yet Valid* and *NSEC3 RRSIG Verify Error* sets is non-empty,
    then do:
    1. Extract all unique name server IP address in the combined set that are
       not members the *NSEC3 RRSIG Verified* set.
    2. If the extracted name server IP addresses is a non-empty set then output
       *[DS10_NSEC3_NO_VERIFIED_SIGNATURE]* with the extracted name server IP
       addresses.

39. If the *Algo Not Supported By ZM* set is non-empty, then output
    *[DS10_ALGO_NOT_SUPPORTED_BY_ZM]* for each DNSKEY key tag with the name
    server IP addresses, the key tag and the algorithm name and code from the
    set.

40. If the *Responds with DNSKEY* set is empty and the *Responds without DNSKEY*
    is non-empty then output *[DS10_ZONE_NO_DNSSEC]* with the name server IP
    addresses from the *Responds without DNSKEY* set.

41. If both the *Responds with DNSKEY* set and the *Responds without DNSKEY* set
    are non-empty then output *[DS10_SERVER_NO_DNSSEC]* with the name server IP
    addresses from the *Responds without DNSKEY* set.

42. Extract all members of the *NS IP* set that is not also a member of
    the *Responds without DNSKEY* set, the *NSEC In Answer* set, the
    *NSEC3PARAM Query Gives NSEC NODATA* set, the *NSEC3PARAM In Answer* set or
    the *NSEC Query Gives NSEC3 NODATA* set. If the extracted set is non-empty,
    then output *[DS10_EXPECTED_NSEC_NSEC3_MISSING]* with the extracted list of
    name server IP addresses.

## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *[ERROR]* or *[CRITICAL]*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *[WARNING]*, but no message with severity level
*ERROR* or *CRITICAL*.

In other cases, no message or only messages with severity level
*[INFO]* or *[NOTICE]*, the outcome of this Test Case is "pass".


## Special procedural requirements

If either IPv4 or IPv6 transport is disabled, skip sending queries over that
transport protocol. A message will be outputted reporting that the transport
protocol has been skipped.

See the [DNSSEC README] document about DNSSEC algorithms.


## Intercase dependencies

None.


## Terminology

No special terminology for this Test Case.


[Argument list]:                              ../ArgumentsForTestCaseMessages.md
[Connectivity01]:                             ../Connectivity-TP/connectivity01.md
[CRITICAL]:                                   ../SeverityLevelDefinitions.md#critical
[DNS Query and Response Defaults]:            ../DNSQueryAndResponseDefaults.md
[DNSSEC Query]:                               ../DNSQueryAndResponseDefaults.md#default-setting-in-dnssec-query
[DNSSEC README]:                              README.md
[DNSSEC Response]:                            ../DNSQueryAndResponseDefaults.md#default-handling-of-a-dnssec-response
[DNSSEC05#objective]:                         ../DNSSEC-TP/dnssec05.md#objective
[DS10_ALGO_NOT_SUPPORTED_BY_ZM]:              #summary
[DS10_ERR_MULT_NSEC3]:                        #summary
[DS10_ERR_MULT_NSEC]:                         #summary
[DS10_EXPECTED_NSEC_NSEC3_MISSING]:           #summary
[DS10_HAS_NSEC3]:                             #summary
[DS10_HAS_NSEC]:                              #summary
[DS10_INCONSISTENT_NSEC3]:                    #summary
[DS10_INCONSISTENT_NSEC]:                     #summary
[DS10_INCONSISTENT_NSEC_NSEC3]:               #summary
[DS10_MIXED_NSEC_NSEC3]:                      #summary
[DS10_NSEC3PARAM_GIVES_ERR_ANSWER]:           #summary
[DS10_NSEC3PARAM_QUERY_RESPONSE_ERR]:         #summary
[DS10_NSEC3_ERR_TYPE_LIST]:                   #summary
[DS10_NSEC3_MISMATCHES_APEX]:                 #summary
[DS10_NSEC3_MISSING_SIGNATURE]:               #summary
[DS10_NSEC3_NODATA_MISSING_SOA]:              #summary
[DS10_NSEC3_NODATA_WRONG_SOA]:                #summary
[DS10_NSEC3_NO_VERIFIED_SIGNATURE]:           #summary
[DS10_NSEC3_RRSIG_EXPIRED]:                   #summary
[DS10_NSEC3_RRSIG_NOT_YET_VALID]:             #summary
[DS10_NSEC3_RRSIG_NO_DNSKEY]:                 #summary
[DS10_NSEC3_RRSIG_VERIFY_ERROR]:              #summary
[DS10_NSEC_ERR_TYPE_LIST]:                    #summary
[DS10_NSEC_MISMATCHES_APEX]:                  #summary
[DS10_NSEC_MISSING_SIGNATURE]:                #summary
[DS10_NSEC_NODATA_MISSING_SOA]:               #summary
[DS10_NSEC_NODATA_WRONG_SOA]:                 #summary
[DS10_NSEC_NO_VERIFIED_SIGNATURE]:            #summary
[DS10_NSEC_QUERY_GIVES_ERR_ANSWER]:           #summary
[DS10_NSEC_QUERY_RESPONSE_ERR]:               #summary
[DS10_NSEC_RRSIG_EXPIRED]:                    #summary
[DS10_NSEC_RRSIG_NOT_YET_VALID]:              #summary
[DS10_NSEC_RRSIG_NO_DNSKEY]:                  #summary
[DS10_NSEC_RRSIG_VERIFY_ERROR]:               #summary
[DS10_SERVER_NO_DNSSEC]:                      #summary
[DS10_ZONE_NO_DNSSEC]:                        #summary
[ERROR]:                                      ../SeverityLevelDefinitions.md#error
[IANA RR Type List]:                          https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-4
[INFO]:                                       ../SeverityLevelDefinitions.md#info
[Method4]:                                    ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                                    ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[NOTICE]:                                     ../SeverityLevelDefinitions.md#notice
[RCODE Name]:                                 https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[RFC 4034#section-4]:                         https://datatracker.ietf.org/doc/html/rfc4034#section-4
[RFC 4035#section-3.1.3]:                     https://datatracker.ietf.org/doc/html/rfc4035#section-3.1.3
[RFC 5155#section-3]:                         https://datatracker.ietf.org/doc/html/rfc5155#section-3
[RFC 5155#section-4]:                         https://datatracker.ietf.org/doc/html/rfc5155#section-4
[RFC 5155#section-7.2]:                       https://datatracker.ietf.org/doc/html/rfc5155#section-7.2
[Severity Level Definitions]:                 ../SeverityLevelDefinitions.md
[Test procedure]:                             #test-procedure
[WARNING]:                                    ../SeverityLevelDefinitions.md#warning
[Zonemaster-Engine profile]:                  ../../../configuration/profiles.md
