# DNSSEC08: Valid RRSIG for DNSKEY


## Test case identifier
**DNSSEC08**


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

A DNSSEC signed zone should have a DNSKEY RRset in the zone apex
([RFC 4035][RFC 4035#section-2.1], section 2.1) and that RRset
should be signed by a key that matches one of the records in the
DNSKEY RRset ([RFC 4035][RFC 4035#section-2.2], section 2.2).

This test case will verify if the *Child Zone* meets that
requirement.


## Scope

It is assumed that *Child Zone* is tested and reported by [Connectivity01]. This test
case will just ignore non-responsive name servers or name servers not giving a
correct DNS response for an authoritative name server.

This test case is only relevant if the zone has been DNSSEC signed.


## Inputs

* "Child Zone" - The domain name to be tested.


## Summary

* If no DNSKEY records are found, then further investigation will not be done
  and no messages will be outputted.

Message Tag outputted              | Level   | Arguments          | Description of when message tag is outputted
:----------------------------------|:--------|:-------------------|:--------------------------------------------
DS08_ALGO_NOT_SUPPORTED_BY_ZM      | NOTICE  | ns_ip_list, algo_mnemo, algo_num, keytag | This installation of Zonemaster does not support the DNSKEY algorithm.
DS08_DNSKEY_RRSIG_EXPIRED          | ERROR   | ns_ip_list, keytag | DNSKEY RRset is signed with an RRSIG that has expired.
DS08_DNSKEY_RRSIG_NOT_YET_VALID    | ERROR   | ns_ip_list, keytag | DNSKEY RRset is signed with a not yet valid RRSIG.
DS08_MISSING_RRSIG_IN_RESPONSE     | ERROR   | ns_ip_list         | DNSKEY is unsigned which is against expectation.
DS08_NO_MATCHING_DNSKEY            | ERROR   | ns_ip_list, keytag | DNSKEY RRset is signed with an RRSIG that does not match any DNSKEY.
DS08_RRSIG_NOT_VALID_BY_DNSKEY     | ERROR   | ns_ip_list, keytag | DNSKEY RRset is signed with an RRSIG that cannot be validated by the matching DNSKEY.

The value in the Level column is the default severity level of the message. The
severity level can be changed in the [Zonemaster-Engine profile]. Also see the
[Severity Level Definitions] document.

The argument names in the Arguments column lists the arguments used in the
message. The argument names are defined in the [argument list].


## Test procedure

1.  Create a DNSKEY query with DO flag set for *Child Zone* ("DNSKEY Query").

2.  Retrieve all name server IP addresses for the
    *Child Zone* using [Method4] and [Method5] ("NS IP").

3.  Create the following empty sets:
    1.  Name server IP address ("DNSKEY without RRSIG").
    2.  Name server IP address and RRSIG key tag ("DNSKEY RRSIG not yet valid").
    3.  Name server IP address and RRSIG key tag ("DNSKEY RRSIG expired").
    4.  Name server IP address and RRSIG key tag ("No matching DNSKEY").
    5.  Name server IP address and RRSIG key tag ("RRSIG not valid by DNSKEY").
    6.  Name server IP address, DNSKEY record key tag and DNSKEY algorithm code
        ("Algo Not Supported By ZM").

4.  For each name server IP address in *NS IP* do:

    1. Send *DNSKEY Query* to the name server IP.
    2. If at least one of the following criteria is met, then go to next name
       server IP:
         1. There is no DNS response.
         2. The RCODE of response is not "NoError" ([IANA RCODE List]).
         3. The AA flag is not set in the response.
         4. There is no DNSKEY record with matching owner name in the answer
            section.
    3. Retrieve the DNSKEY records and its RRSIG records from the answer section.
    4. If there is no RRSIG for the DNSKEY record, then add the name server IP
       address to the *DNSKEY without RRSIG* set and go to next name server IP.
    8. Else, for each DNSKEY RRSIG record do:
       1. If the RRSIG record start of validity is after the time of the
          test, then add name server IP and RRSIG key tag to the
          *DNSKEY RRSIG not yet valid* set.
       2. Else, if the RRSIG record end of validity is before the time of the
          test, then add name server IP and RRSIG key tag to the
          *DNSKEY RRSIG expired* set.
       3. Else, if the Zonemaster installation does not have support for the
          DNSKEY algorithm that created the RRSIG, then add name server IP,
          DNSKEY algorithm and DNSKEY key tag to the *Algo Not Supported By ZM*
          set.
       4. Else, if the RRSIG does not match any DNSKEY, then add the name server
          IP and the RRSIG key tag to the *No matching DNSKEY* set.
       5. Else, if the RRSIG cannot be validated by the matching DNSKEY record,
          then add the name server
          IP and the RRSIG key tag to the *RRSIG not valid by DNSKEY* set.

6.  If the *DNSKEY without RRSIG* set is non-empty, then output
    *[DS08_MISSING_RRSIG_IN_RESPONSE]* with the name servers IP addresses from
    the set.

7.  If the *DNSKEY RRSIG not yet valid* set is non-empty, then for each RRSIG key tag
    from the set output *[DS08_DNSKEY_RRSIG_NOT_YET_VALID]* with the key tag and the
    name servers IP addresses from the set.

8.  If the *DNSKEY RRSIG expired* set is non-empty, then for each RRSIG key tag
    from the set output *[DS08_DNSKEY_RRSIG_EXPIRED]* with the key tag and the
    name servers IP addresses from the set.

9.  If the *No matching DNSKEY* set is non-empty, then for each RRSIG key tag
    from the set output *[DS08_NO_MATCHING_DNSKEY]* with the key tag and the
    name servers IP addresses from the set.

10. If the *RRSIG not valid by DNSKEY* set is non-empty, then for each RRSIG key
    ID from the set output *[DS08_RRSIG_NOT_VALID_BY_DNSKEY]* with the key tag and
    the name servers IP addresses from the set.

11. If the *Algo Not Supported By ZM* set is non-empty, then output
    *[DS08_ALGO_NOT_SUPPORTED_BY_ZM]* for each DNSKEY key tag with the name
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


[Argument list]:                              https://github.com/zonemaster/zonemaster-engine/blob/master/docs/logentry_args.md
[Connectivity01]:                             ../Connectivity-TP/connectivity01.md
[CRITICAL]:                                   ../SeverityLevelDefinitions.md#critical
[DNSSEC README]:                              ./README.md
[DNSSEC README]:                              README.md
[DS08_ALGO_NOT_SUPPORTED_BY_ZM]:              #summary
[DS08_DNSKEY_RRSIG_EXPIRED]:                  #summary
[DS08_DNSKEY_RRSIG_NOT_YET_VALID]:            #summary
[DS08_MISSING_RRSIG_IN_RESPONSE]:             #summary
[DS08_NO_MATCHING_DNSKEY]:                    #summary
[DS08_RRSIG_NOT_VALID_BY_DNSKEY]:             #summary
[ERROR]:                                      ../SeverityLevelDefinitions.md#error
[IANA RCODE List]:                            https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[INFO]:                                       ../SeverityLevelDefinitions.md#info
[Method4]:                                    ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                                    ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[NOTICE]:                                     ../SeverityLevelDefinitions.md#notice
[RFC 4035#section-2.1]:                       https://datatracker.ietf.org/doc/html/rfc4035#section-2.1
[RFC 4035#section-2.2]:                       https://datatracker.ietf.org/doc/html/rfc4035#section-2.2
[Severity Level Definitions]:                 ../SeverityLevelDefinitions.md
[WARNING]:                                    ../SeverityLevelDefinitions.md#warning
[Zonemaster-Engine profile]:                  ../../../configuration/profiles.md
