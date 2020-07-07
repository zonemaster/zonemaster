# DNSSEC09: RRSIG(SOA) must be valid and created by a valid DNSKEY

## Test case identifier
**DNSSEC09**

## Objective

If the zone is signed, the SOA RR should be signed with a valid RRSIG 
using a DNSKEY from the DNSKEY RR set. This is described
in [RFC 4035][RFC 4035#section-2.2], section 2.2.

This test case will verify if the *Child Zone* meets that
requirement.

## Inputs

* "Child Zone" - The domain name to be tested.

## Ordered description of steps to be taken to execute the test case

1.  Create an SOA query for the *Child Zone* without any OPT record (no EDNS).

2.  Create an SOA query for the *Child Zone* with the DO flag set.

3.  Create an DNSKEY query for the *Child Zone* with the DO flag set.

4.  Obtain the set of name server IP addresses using [Method4] and [Method5]
    ("Name Server IP").

5.  Create an empty sets of name server IP addresses:
    1. "No Response SOA Query".
    2. "Non-authoritative SOA".
    3. "No SOA Record".
    4. "SOA without RRSIG".

6.  Create an empty set of name server IP addresses and associated RCODE,
    "Unexpected RCODE SOA Query".

10. Create an empty set of name server IP addresses and associated SOA and
    RRSIG record RDATA, "SOA-RRSIG Record RDATA".

11. Create an empty set of name server IP addresses:
    1. "No Response DNSKEY Query".
    2. "Non-authoritative DNSKEY".
    3. "No DNSKEY Record".

12. Create an empty set of name server IP addresses and associated RCODE,
    "Unexpected RCODE DNSKEY Query".

13. Create an empty set of name server IP addresses and associated DNSKEY record 
    RDATA, "DNSKEY Record RDATA".

14. For each name server in *Name Server IP* do:

    1. Send the SOA query without OPT over UDP to the name server, collect the
       response and go to next server if
       1. there is no DNS response on the SOA query, or
       2. the RCODE of the response is not "NoError" ([IANA RCODE List]), or
       3. the AA flag is not set in the response, or
       4. there is no SOA record with owner name matching the query.

    2. Send the SOA query with DO flag set over UDP to the name server and collect
       the response, and:
       1. If the response has the TC flag set, re-query over TCP and use that
          response instead.
       2. In the following cases, register the data as specified and then go to
          next server:
          1. If there is no DNS response, then add the name server (IP) to the
             *No Response SOA Query* set.
          2. If the RCODE of response is not "NoError" ([IANA RCODE List]),
             then add the name server (IP) and the RCODE to the
             *Unexpected RCODE SOA Query* set.
          3. If the AA flag is not set in the response, then add the name
             server (IP) to the *Non-authoritative SOA* set.
          4. Else, if there is no SOA record with matching owner name in the
             answer section, then add the name server (IP) to the
             *No SOA Record* set.
          5. Else, if there is no RRSIG record attached to the SOA RRset, then
             add the name server (IP) to the *SOA without RRSIG* set.
       3. Else add the name server (IP) and the DNSKEY and RRSIG record RDATA
          sets to the *SOA-RRSIG Record RDATA* set. (One RDATA set can
          contain RDATA from more than one DNS record.)

    6. Send the DNSKEY query with DO flag set over UDP to the name server and
       collect the response, and:
       1. If the response has the TC flag set, re-query over TCP and use that
          response instead.
       2. In the following cases, register the data as specified and then go to
          next server:
          1. If there is no DNS response, then add the name server (IP) to the
             *No Response DNSKEY Query* set.
          2. If the RCODE of response is not "NoError" ([IANA RCODE List]),
             then add the name server (IP) and the RCODE to the
             *Unexpected RCODE DNSKEY Query* set.
          3. If the AA flag is not set in the response, then add the name
             server (IP) to the *Non-authoritative DNSKEY* set.
          4. If there is no DNSKEY record with matching owner name in the
             answer section, then add the name server (IP) to the
             *No DNSKEY Record* set.
       3. Else add the name server (IP) and the DNSKEY record RDATA set to the
          *DNSKEY Record RDATA* set. (One RDATA set can contain RDATA
          from more than one DNS record.)

15. If the *No Response SOA Query* set is non-empty, then output
    *[DS09_NO_RESPONSE_SOA_QUERY]* and list those name servers.

16. If the *Unexpected RCODE SOA Query* set is non-empty, then for each RCODE
    in the set, do:
    1. Output *[DS09_UNEXPECTED_RCODE_SOA_RESPONSE]* and print the RCODE name
       ([IANA RCODE List]) and list the those name servers.

17. If the *Non-authoritative SOA* set is non-empty, then output
    *[DS09_NON-AUTHORITATIVE_SOA_RESPONSE]* and list those name servers.

18. If the *No SOA Record* set is non-empty, then output
    *[DS09_EMPTY_SOA_RESPONSE]* and list those name servers.

19. If the *SOA without RRSIG* set is non-empty, then output
    *[DS09_MISSING_RRSIG_IN_RESPONSE]* and list those name servers.

20. If the *No Response DNSKEY Query* set is non-empty, then output
    *[DS09_NO_RESPONSE_DNSKEY_QUERY]* and list those name servers.

21. If the *Unexpected RCODE DNSKEY Query* set is non-empty, then for each RCODE
    in the set, do:
    1. Output *[DS09_UNEXPECTED_RCODE_DNSKEY_RESPONSE]* and print the RCODE name
       ([IANA RCODE List]) and list the those name servers.

22. If the *Non-authoritative DNSKEY* set is non-empty, then output
    *[DS09_NON-AUTHORITATIVE_DNSKEY_RESPONSE]* and list those name servers.

23. If the *No DNSKEY Record* set is non-empty, then output
    *[DS09_EMPTY_DNSKEY_RESPONSE]* and list those name servers.

24. If the *SOA-RRSIG Record RDATA* set or the *DNSKEY Record RDATA* set
    is empty, then do:
    1. If *SOA-RRSIG Record RDATA* is empty, then output
       *[DS09_NO_VALID_SOA_RESPONSE]*.
    2. If *DNSKEY Record RDATA* is empty, then output
     *[DS09_NO_VALID_DNSKEY_RESPONSE]*.
    3. Terminate this test case.

25. Else, for each name server IP address in *SOA-RRSIG Record RDATA* do:
    1. Extract the SOA RRset from *SOA-RRSIG Record RDATA*.
    2. Extract the SOA RRSIG set from *SOA-RRSIG Record RDATA*.
    3. Extract the DNSKEY RRset from the *DNSKEY Record RDATA*
       set.
    4. If there is no DNSKEY RRset, then output
       *[DS09_MISSING_DNSKEY_FOR_SOA_RRSIG]* with the expected
       DNSKEY key tag and the name server IP address, and go to
       next name server IP address.
    5. Else, for each RRSIG record do:
       1. If the RRSIG record start of validity is after the time of the
          test, then output *[DS09_RRSIG_FOR_SOA_RRSET_NOT_YET_VALID]*
          and the name server IP address.
       2. If the RRSIG record end of validity is before the time of the
          test, then output *[DS09_RRSIG_FOR_SOA_RRSET_EXPIRED]*
          and the name server IP address.
       3. If the Zonemaster installation does not have support for the
          algorithm that created the RRSIG, then output
          *[DS09_ALGO_NOT_SUPPORTED_BY_ZM]* print algorithm and DNSKEY
          key tag.
       4. Else, if the RRSIG values (algorithm and signature) do not match
          the DNSKEY in *DNSKEY Record RDATA* then output
          *[DS09_NON_MATCHING_RRSIG_FOR_SOA_RRSET]* and print
          DNSKEY key tag and the name server IP address.

## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

The outcome of this Test case is "pass" in all other cases.

Message                                        | Default severity level of message
:----------------------------------------------|:-----------------------------------
DS09_ALGO_NOT_SUPPORTED_BY_ZM                  | NOTICE
DS09_EMPTY_DNSKEY_RESPONSE                     | WARNING
DS09_EMPTY_SOA_RESPONSE                        | WARNING
DS09_MISSING_DNSKEY_FOR_SOA_RRSIG              | WARNING
DS09_MISSING_RRSIG_IN_RESPONSE                 | WARNING
DS09_NON-AUTHORITATIVE_DNSKEY_RESPONSE         | WARNING
DS09_NON-AUTHORITATIVE_SOA_RESPONSE            | WARNING
DS09_NON_MATCHING_RRSIG_FOR_SOA_RRSET          | WARNING
DS09_NO_RESPONSE_DNSKEY_QUERY                  | WARNING
DS09_NO_RESPONSE_SOA_QUERY                     | WARNING
DS09_NO_VALID_DNSKEY_RESPONSE                  | WARNING
DS09_NO_VALID_SOA_RESPONSE                     | WARNING
DS09_RRSIG_FOR_SOA_RRSET_EXPIRED               | WARNING
DS09_RRSIG_FOR_SOA_RRSET_NOT_YET_VALID         | WARNING
DS09_UNEXPECTED_RCODE_DNSKEY_RESPONSE          | WARNING
DS09_UNEXPECTED_RCODE_SOA_RESPONSE             | WARNING

## Special procedural requirements

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
on the ignored result.

Errors associated with the response to the query for the SOA record without
EDNS are expected to have been caught by [Basic04].

Inconsistencies in the SOA record are expected to be caught by [Consistency01],
[Consistency02], [Consistency03] and [Consistency06].

Inconsistencies in the DNSKEY RRset are expected to be caught by [DNSSEC08].

See the [DNSSEC README] document about DNSSEC algorithms.

Test case is only performed if DNSKEY records are found.


## Intercase dependencies

None.

[Basic04]:                                    ../Basic-TP/basic014.md
[Consistency01]:                              ../Consistency-TP/consistency01.md
[Consistency02]:                              ../Consistency-TP/consistency02.md
[Consistency03]:                              ../Consistency-TP/consistency03.md
[Consistency06]:                              ../Consistency-TP/consistency06.md
[DNSSEC README]:                              ./README.md
[DNSSEC08]:                                   ../DNSSEC-TP/dnssec08.md
[DS09_ALGO_NOT_SUPPORTED_BY_ZM]:              #OUTCOMES
[DS09_EMPTY_DNSKEY_RESPONSE]:                 #OUTCOMES
[DS09_EMPTY_SOA_RESPONSE]:                    #OUTCOMES
[DS09_MISSING_DNSKEY_FOR_SOA_RRSIG]:          #OUTCOMES
[DS09_MISSING_RRSIG_IN_RESPONSE]:             #OUTCOMES
[DS09_NON-AUTHORITATIVE_DNSKEY_RESPONSE]:     #OUTCOMES
[DS09_NON-AUTHORITATIVE_SOA_RESPONSE]:        #OUTCOMES
[DS09_NON_MATCHING_RRSIG_FOR_SOA_RRSET]:      #OUTCOMES
[DS09_NO_RESPONSE_DNSKEY_QUERY]:              #OUTCOMES
[DS09_NO_RESPONSE_SOA_QUERY]:                 #OUTCOMES
[DS09_NO_VALID_DNSKEY_RESPONSE]:              #OUTCOMES
[DS09_NO_VALID_SOA_RESPONSE]:                 #OUTCOMES
[DS09_RRSIG_FOR_SOA_RRSET_EXPIRED]:           #OUTCOMES
[DS09_RRSIG_FOR_SOA_RRSET_NOT_YET_VALID]:     #OUTCOMES
[DS09_UNEXPECTED_RCODE_DNSKEY_RESPONSE]:      #OUTCOMES
[DS09_UNEXPECTED_RCODE_SOA_RESPONSE]:         #OUTCOMES
[IANA RCODE List]:                            https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[Method4]:                                    ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                                    ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[RFC 4035#section-2.1]:                       https://tools.ietf.org/html/rfc4035#section-2.1
[RFC 4035#section-2.2]:                       https://tools.ietf.org/html/rfc4035#section-2.2



