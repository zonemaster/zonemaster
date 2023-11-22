# DNSSEC09: RRSIG(SOA) must be valid and created by a valid DNSKEY

## Test case identifier
**DNSSEC09**


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

If the zone is signed, the SOA RR should be signed with a valid RRSIG
using a DNSKEY from the DNSKEY RR set. This is described
in [RFC 4035][RFC 4035#section-2.2], section 2.2.

This test case will verify if the *Child Zone* meets that
requirement.


## Scope

It is assumed that *Child Zone* is tested and reported by [Connectivity01]. This test
case will just ignore non-responsive name servers or name servers not giving a
correct DNS response for an authoritative name server.

Inconsistencies in the SOA record are expected to be caught by [Consistency01],
[Consistency02], [Consistency03] and [Consistency06].

Inconsistencies in the DNSKEY RRset are expected to be caught by [DNSSEC08].

This test case is only relevant if the zone has been DNSSEC signed.


## Inputs

* "Child Zone" - The domain name to be tested.


## Summary

* If no DNSKEY records are found, then further investigation will not be done
  and no messages will be outputted.

Message Tag outputted              | Level   | Arguments          | Description of when message tag is outputted
:----------------------------------|:--------|:-------------------|:--------------------------------------------
DS09_ALGO_NOT_SUPPORTED_BY_ZM      | NOTICE  | ns_ip_list, algo_mnemo, algo_num, keytag | This installation of Zonemaster does not support the DNSKEY algorithm.
DS09_MISSING_RRSIG_IN_RESPONSE     | ERROR   | ns_ip_list         | SOA is unsigned which is against expectation
DS09_NO_MATCHING_DNSKEY            | ERROR   | ns_ip_list, keytag | SOA is signed with an RRSIG that does not match any DNSKEY
DS09_RRSIG_NOT_VALID_BY_DNSKEY     | ERROR   | ns_ip_list, keytag | SOA is signed with an RRSIG that cannot be validated by the matching DNSKEY
DS09_SOA_RRSIG_EXPIRED             | ERROR   | ns_ip_list, keytag | SOA is signed with an RRSIG that has expired
DS09_SOA_RRSIG_NOT_YET_VALID       | ERROR   | ns_ip_list, keytag | SOA is signed with a not yet valid RRSIG

The value in the Level column is the default severity level of the message. The
severity level can be changed in the [Zonemaster-Engine profile]. Also see the
[Severity Level Definitions] document.

The argument names in the Arguments column lists the arguments used in the
message. The argument names are defined in the [argument list].


## Test procedure

1.  Create a DNSKEY query with DO flag set for *Child Zone* ("DNSKEY Query").

2.  Create an SOA query with DO flag set for *Child Zone* ("SOA Query").

3.  Retrieve all name server IP addresses for the
    *Child Zone* using [Method4] and [Method5] ("NS IP").

4.  Create the following empty sets:
    1.  Name server IP address ("SOA without RRSIG").
    2.  Name server IP address and RRSIG key tag ("SOA RRSIG not yet valid").
    3.  Name server IP address and RRSIG key tag ("SOA RRSIG expired").
    4.  Name server IP address and RRSIG key tag ("No matching DNSKEY").
    5.  Name server IP address and RRSIG key tag ("RRSIG not valid by DNSKEY").
    6.  Name server IP address, DNSKEY record key tag and DNSKEY algorithm code
        ("Algo Not Supported By ZM").

5.  For each name server IP address in *NS IP* do:

    1. Send *DNSKEY Query* to the name server IP.
    2. If at least one of the following criteria is met, then go to next name
       server IP:
         1. There is no DNS response.
         2. The RCODE of response is not "NoError" ([IANA RCODE List]).
         3. The AA flag is not set in the response.
         4. There is no DNSKEY record with matching owner name in the answer
            section.
    3. Retrieve the DNSKEY records with matching owner name from the answer
       section (any DNSKEY records with non-matching owner name are ignored).
    4. Send *SOA Query* over UDP to the name server IP.
    5. If at least one of the following criteria is met, then go to next name
       server IP:
         1. There is no DNS response.
         2. The RCODE of response is not "NoError" ([IANA RCODE List]).
         3. The AA flag is not set in the response.
         4. There is no SOA record with matching owner name in the answer
            section.
    6. Retrieve the SOA record with matching owner name and its RRSIG record.
       * Retrieve only one SOA record if there are multiple records. Any SOA
         records with non-matching owner name are ignored.
    7. If there is no RRSIG for the SOA record, then add the name server IP
       address to the *SOA without RRSIG* set and go to next name server IP.
    8. Else, for each SOA RRSIG record do:
       1. If the RRSIG record start of validity is after the time of the
          test, then add name server IP and RRSIG key tag to the
          *SOA RRSIG not yet valid* set.
       2. Else, if the RRSIG record end of validity is before the time of the
          test, then add name server IP and RRSIG key tag to the
          *SOA RRSIG expired* set.
       3. Else, if the Zonemaster installation does not have support for the
          DNSKEY algorithm that created the RRSIG, then add name server IP,
          DNSKEY algorithm and DNSKEY key tag to the *Algo Not Supported By ZM*
          set.
       4. Else, if the RRSIG does not match any DNSKEY, then add the name server
          IP and the RRSIG key tag to the *No matching DNSKEY* set.
       5. Else, if the RRSIG cannot be validated by the matching DNSKEY record,
          then add the name server
          IP and the RRSIG key tag to the *RRSIG not valid by DNSKEY* set.

6.  If the *SOA without RRSIG* set is non-empty, then output
    *[DS09_MISSING_RRSIG_IN_RESPONSE]* with the name servers IP addresses from
    the set.

7.  If the *SOA RRSIG not yet valid* set is non-empty, then for each RRSIG key tag
    from the set output *[DS09_SOA_RRSIG_NOT_YET_VALID]* with the key tag and the
    name servers IP addresses from the set.

8.  If the *SOA RRSIG expired* set is non-empty, then for each RRSIG key tag
    from the set output *[DS09_SOA_RRSIG_EXPIRED]* with the key tag and the
    name servers IP addresses from the set.

9.  If the *No matching DNSKEY* set is non-empty, then for each RRSIG key tag
    from the set output *[DS09_NO_MATCHING_DNSKEY]* with the key tag and the
    name servers IP addresses from the set.

10. If the *RRSIG not valid by DNSKEY* set is non-empty, then for each RRSIG key
    ID from the set output *[DS09_RRSIG_NOT_VALID_BY_DNSKEY]* with the key tag and
    the name servers IP addresses from the set.

11. If the *Algo Not Supported By ZM* set is non-empty, then output
    *[DS09_ALGO_NOT_SUPPORTED_BY_ZM]* for each DNSKEY key tag with the name
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


[Argument list]:                              ../ArgumentsForTestCaseMessages.md
[Connectivity01]:                             ../Connectivity-TP/connectivity01.md
[CRITICAL]:                                   ../SeverityLevelDefinitions.md#critical
[Consistency01]:                              ../Consistency-TP/consistency01.md
[Consistency02]:                              ../Consistency-TP/consistency02.md
[Consistency03]:                              ../Consistency-TP/consistency03.md
[Consistency06]:                              ../Consistency-TP/consistency06.md
[DNSSEC README]:                              ./README.md
[DNSSEC08]:                                   ../DNSSEC-TP/dnssec08.md
[DS09_ALGO_NOT_SUPPORTED_BY_ZM]:              #summary
[DS09_MISSING_RRSIG_IN_RESPONSE]:             #summary
[DS09_NO_MATCHING_DNSKEY]:                    #summary
[DS09_RRSIG_NOT_VALID_BY_DNSKEY]:             #summary
[DS09_SOA_RRSIG_EXPIRED]:                     #summary
[DS09_SOA_RRSIG_NOT_YET_VALID]:               #summary
[ERROR]:                                      ../SeverityLevelDefinitions.md#error
[IANA RCODE List]:                            https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[INFO]:                                       ../SeverityLevelDefinitions.md#info
[Method4]:                                    ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                                    ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[NOTICE]:                                     ../SeverityLevelDefinitions.md#notice
[RFC 4035#section-2.2]:                       https://datatracker.ietf.org/doc/html/rfc4035#section-2.2
[Severity Level Definitions]:                 ../SeverityLevelDefinitions.md
[WARNING]:                                    ../SeverityLevelDefinitions.md#warning
[Zonemaster-Engine profile]:                  ../../../configuration/profiles.md
