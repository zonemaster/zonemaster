# DNSSEC08: RRSIG(DNSKEY) must be valid and created by a valid DNSKEY

## Test case identifier
**DNSSEC08**

## Objective

A DNSSEC signed zone should have a DNSKEY RRset in the zone apex
([RFC 4035][RFC 4035#section-2.1], section 2.1) and that RRset
should be signed by a key that matches one of records in the
DNSKEY RRset ([RFC 4035][RFC 4035#section-2.2], section 2.2).

This test case will verify if the *Child Zone* meets that
requirement.


## Inputs

* "Child Zone" - The domain name to be tested.


## Ordered description of steps to be taken to execute the test case

1.  Create DNS queries:

    1.  SOA query for the *Child Zone* without any OPT record (no EDNS).
    2.  DNSKEY query for the *Child Zone* with the DO flag set.

2.  Obtain the set of name server IP addresses using [Method4] and [Method5]
    ("Name Server IP").

3.  Create empty sets of name server IP addresses:

    1. "No Response DNSKEY Query".
    2. "Unexpected RCODE DNSKEY Query" with associated RCODE.
    3. "Non-authoritative DNSKEY".
    4. "No DNSKEY Record".
    5. "DNSKEY without RRSIG".
    6. "DNSKEY-RRSIG Record RDATA" with associated DNSKEY and RRSIG record
       RDATA.

4.  For each name server in *Name Server IP* do:

    1. Send the SOA query over UDP to the name server, collect the response
       and go to next server if
       1. there is no DNS response on the SOA query, or
       2. the RCODE of the response is not "NoError" ([IANA RCODE List]), or
       3. the AA flag is not set in the response, or
       4. there is no SOA record with owner name matching the query.

    2. Else, send the DNSKEY query over UDP to the name server and collect the
       response, and:
       1. If the response has the TC flag set, re-query over TCP and use that
          response instead.
       2. If there is no DNS response, then add the name server (IP) to the
          set *No Response DNSKEY Query*.
       3. Else, if the RCODE of response is not "NoError" ([IANA RCODE List]),
          then add the name server (IP) and the RCODE to the set
          *Unexpected RCODE DNSKEY Query*.
       4. Else, if the AA flag is not set in the response, then add the name
          server (IP) to the set *Non-authoritative DNSKEY*.
       5. Else, if there is no DNSKEY record with matching owner name in the
          answer section, then add the name server (IP) to the set
          *No DNSKEY Record*.
       6. Else, if there is no RRSIG record attached to the DNSKEY RRset, then
          add the name server (IP) to the set *DNSKEY without RRSIG*.
       7. Else add the name server (IP) and the DNSKEY and RRSIG record RDATA
          sets to the set *DNSKEY-RRSIG Record RDATA*. (One RDATA set can
          contain RDATA from more than one DNS record.)

5.  If the set *No Response DNS Query* is non-empty, then output
    *[DS08_NO_RESPONSE_DNSKEY_QUERY]* and list those name servers.

6.  If the set *Unexpected RCODE DNSKEY Query* is non-empty, then for each
    RCODE in the set output *[DS08_UNEXPECTED_RCODE_DNSKEY_RESPONSE]* and print
    the RCODE name ([IANA RCODE List]) and list the those name servers.

7.  If the set *Non-authoritative DNSKEY* is non-empty, then output
    *[DS08_NON-AUTHORITATIVE_DNSKEY_RESPONSE]* and list those name servers.

8.  If the sets *No DNSKEY Record* is non-empty, then output
    *[DS08_EMPTY_DNSKEY_RESPONSE]* and list those name servers.

9.  If the sets *DNSKEY without RRSIG* is non-empty, then output
    *[DS08_MISSING_RRSIG_IN_RESPONSE]* and list those name servers.

10. If the set *DNSKEY-RRSIG Record RDATA* is empty, then output
     *[DS08_NO_VALID_DNSKEY_RESPONSE]*.

11. Else, do:
    1. If there are more than one DNSKEY RDATA set in set
       *DNSKEY-RRSIG Record RDATA* then do:
       1. Output *[DS08_INCONSISTENT_DNSKEY_RRSET]*.
       2. For each DNSKEY RDATA set output *[DS08_FOUND_DNSKEY_RRSET]*
          with list of key tags and list those name servers.
    2. Else, if there is more than one RRSIG RDATA set in the
       *DNSKEY-RRSIG Record RDATA* set then do:
       1. Output *[DS08_INCONSISTENT_DNSKEY_RRSIG]*.
       2. For each RRSIG RDATA set output *[DS08_FOUND_DNSKEY_RRSIG_SET]*
          and list those name servers.
    3. Else, for each RRSIG record in the *DNSKEY-RRSIG Record RDATA*
       set do:
       1. If the Zonemaster installation does not have support for the
          algorithm that created the RRSIG, then output
          *[DS08_ALGO_NOT_SUPPORTED_BY_ZM]* and print algorithm and DNSKEY
          key tag.
       2. Else, if the RRSIG values (algorithm and signature) do not match
          the DNSKEY then output *[DS08_NON_MATCHING_RRSIG_FOR_DNSKEY_RRSET]*
          and print DNSKEY key tag and the name server IP address.

## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the [severity level] *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the [severity level] *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

The outcome of this Test case is "pass" in all other cases.

Message                                        | Default [severity level] of message
:----------------------------------------------|:-----------------------------------
DS08_ALGO_NOT_SUPPORTED_BY_ZM                  | NOTICE
DS08_EMPTY_DNSKEY_RESPONSE                     | WARNING
DS08_FOUND_DNSKEY_RRSET                        | NOTICE
DS08_FOUND_DNSKEY_RRSIG_SET                    | NOTICE
DS08_INCONSISTENT_DNSKEY_RRSET                 | WARNING
DS08_INCONSISTENT_DNSKEY_RRSIG                 | WARNING
DS08_MISSING_RRSIG_IN_RESPONSE                 | WARNING
DS08_NON-AUTHORITATIVE_DNSKEY_RESPONSE         | WARNING
DS08_NON_MATCHING_RRSIG_FOR_DNSKEY_RRSET       | WARNING
DS08_NO_RESPONSE_DNSKEY_QUERY                  | WARNING
DS08_NO_VALID_DNSKEY_RESPONSE                  | WARNING
DS08_UNEXPECTED_RCODE_DNSKEY_RESPONSE          | WARNING


## Special procedural requirements

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
on the ignored result.

Errors associated with the response to the query for the SOA record without
EDNS are expected to have been caught by [Basic04].

See the [DNSSEC README] document about DNSSEC algorithms.

Test case is only performed if DNSKEY records are found.


## Intercase dependencies

None.

[Basic04]:                                    ../Basic-TP/basic014.md
[DNSSEC README]:                              README.md
[DS08_ALGO_NOT_SUPPORTED_BY_ZM]:              #OUTCOMES
[DS08_EMPTY_DNSKEY_RESPONSE]:                 #OUTCOMES
[DS08_FOUND_DNSKEY_RRSET]:                    #OUTCOMES
[DS08_FOUND_DNSKEY_RRSIG_SET]:                #OUTCOMES
[DS08_INCONSISTENT_DNSKEY_RRSET]:             #OUTCOMES
[DS08_INCONSISTENT_DNSKEY_RRSIG]:             #OUTCOMES
[DS08_MISSING_RRSIG_IN_RESPONSE]:             #OUTCOMES
[DS08_NON-AUTHORITATIVE_DNSKEY_RESPONSE]:     #OUTCOMES
[DS08_NON_MATCHING_RRSIG_FOR_DNSKEY_RRSET]:   #OUTCOMES
[DS08_NO_RESPONSE_DNSKEY_QUERY]:              #OUTCOMES
[DS08_NO_VALID_DNSKEY_RESPONSE]:              #OUTCOMES
[DS08_UNEXPECTED_RCODE_DNSKEY_RESPONSE]:      #OUTCOMES
[IANA RCODE List]:                            https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[Method4]:                                    ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                                    ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[RFC 4035#section-2.1]:                       https://tools.ietf.org/html/rfc4035#section-2.1
[RFC 4035#section-2.2]:                       https://tools.ietf.org/html/rfc4035#section-2.2
[Severity Level]:                             ../SeverityLevelDefinitions.md