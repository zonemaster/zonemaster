# DNSSEC02: DS must match a valid DNSKEY in the child zone

## Test case identifier
**DNSSEC02**


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

DNS delegations from a parent to a child are secured with DNSSEC by
publishing one or several Delegation Signer (DS) records in the parent
zone, along with the NS records for the delegation.

For the secure delegation to work, at least one DS record must match a
DNSKEY record in the child zone ([RFC 4035][RFC 4035#section-5], section 5).
Each DS record should match a DNSKEY record in the child zone. More
than one DS may match the same DNSKEY. The DNSKEY that the DS record
refer to must be used to sign the DNSKEY RRset in the child zone
([RFC 4035][RFC 4035#section-5], section 5).

The DNSKEY record that the DS record refer to must have bit 7
("Zone Key flag") set in the DNSKEY RR Flags ([RFC 4034][RFC 4034#section-5.2],
section 5.2).

Bit 15 ("Secure Entry Point flag") on a DNSKEY record signals that it
is meant to be a KSK and pointed out by a DS record. It is noted if
the DNSKEY record that the DS points at does not have that flag set
([RFC 4034][RFC 4034#section-2.1.1], section 2.1.1).

## Scope

This test case will just ignore non-responsive name servers or name servers not
giving a correct DNS response for an authoritative name server (handled by
[Basic04]).

If no DS record is found in the parent zone or no DNSKEY record is found in the
*Child Zone* then this test case will be terminated (also see [DNSSEC11]).

This test case does not report if the parent servers are unresponsive or
inconsistent.


## Inputs

* "Child Zone" - The domain name to be tested.
* "Test Type" - The test type with value "undelegated" or "normal".
* "Undelegated DS" - The DS record or records submitted
  (only if *Test Type* is [undelegated]).


## Summary

* Both DS record and DNSKEY record must be found, or else no further
  investigation will be done and no messages will be outputted.
* No messages will be outputted due to errors in the responses from the parent
  name servers.

Message Tag outputted              | Level   | Arguments          | Description of when message tag is outputted
:----------------------------------|:--------|:-------------------|:--------------------------------------------
DS02_ALGO_NOT_SUPPORTED_BY_ZM      | NOTICE  | ns_ip_list, algo_mnemo, algo_num, keytag | This installation of Zonemaster does not support the DNSKEY algorithm.
DS02_DNSKEY_NOT_FOR_ZONE_SIGNING   | ERROR   | ns_ip_list, keytag | The DNSKEY record is not a key for DNSSEC signing.
DS02_DNSKEY_NOT_SEP                | NOTICE  | ns_ip_list, keytag | The DNSKEY record that the DS refers to does not have the SEP bit set.
DS02_NO_DNSKEY_FOR_DS              | ERROR   | ns_ip_list, keytag | The DNSKEY record that the DS record points to does not exist in the DNSKEY RRset.
DS02_NO_MATCHING_DNSKEY_RRSIG      | ERROR   | ns_ip_list, keytag | The DNSKEY RRset is not signed by the DNSKEY that the DS record refers to.
DS02_NO_MATCH_DS_DNSKEY            | ERROR   | ns_ip_list, keytag | The DS record does not match the DNSKEY record by algorithm or digest.
DS02_RRSIG_NOT_VALID_BY_DNSKEY     | ERROR   | ns_ip_list, keytag | The RRSIG cannot be validated by the DNSKEY that it refers to.

The value in the Level column is the default severity level of the message. The
severity level can be overridden in the [Zonemaster-Engine profile]. Also see the
[Severity Level Definitions] document.

The argument names in the Arguments column lists the arguments used in the
message. The argument names are defined in the [argument list].


## Test procedure

1.  Create the following empty sets:
    1. DS record RDATA ("DS Record").
    2. Name server IP and key tag from DS record ("No DNSKEY for DS").
    3. Name server IP and key tag from DS record ("No match DS DNSKEY").
    4. Name server IP and DNSKEY record key tag ("DNSKEY not for zone signing").
    5. Name server IP and DNSKEY record key tag ("DNSKEY not SEP").
    6. Name server IP and DNSKEY record key tag ("No matching DNSKEY RRSIG").
    7. Name server IP address, DNSKEY record key tag and DNSKEY algorithm code
       ("Algo Not Supported By ZM").
    8. Name server IP and key tag from RRSIG record ("RRSIG not valid by DNSKEY").

2.  If the *Test Type* is "[undelegated]" do:
    1. If *Undelegated DS* is empty then do terminate this test case.
    2. Else add *Undelegated DS* as DS records to the *DS Record* set.

3.  If *Test Type* is "normal", then:
    1. Create a DS query with the DO flag set for the name of the *Child Zone*
       ("DS Query").
    2. Retrieve all name server IP addresses for the parent zone of
       *Child Zone* using [Method1] (store as "Parent NS IP").
    3. For each parent name server in *Parent NS IP* do:
       1. Send *DS Query* to the name server IP.
       2. If at least one of the following criteria is met, then go to next
          parent name server:
          1. There is no DNS response.
          2. The RCODE of response is not "NoError" ([IANA RCODE List]).
          3. The AA flag is not set in the response.
          4. There is no DS record with matching owner name in the answer
             section.
       3. Retrieve the DS records from the response and add them to the
          *DS Record* set.
    4. If the *DS Record* set is empty exit this test case.

4.  Create a DNSKEY query for the *Child Zone* with the DO flag set
    ("DNSKEY Query").

5.  Obtain the set of child name server IP addresses using [Method4] and
    [Method5] (store as "Child NS IP").

6.  For each child name server in *Child NS IP* do:
    1. Send *DNSKEY Query* over UDP to the name server IP and collect the response.
    2. If at least one of the following criteria is met, then go to next
          child name server:
       1. There is no DNS response.
       2. The RCODE of the response is not "NoError" ([IANA RCODE List]).
       3. The AA flag is not set in the response.
       4. There is no DNSKEY record with owner name matching the query in the
          answer section.
    3. Retrieve the DNSKEY RRset (store as "DNSKEY RRs").
    4. Retrieve the RRSIG records covering the DNSKEY RRset, possibly
       none (store as "DNSKEY RRSIG").
    5. For each DS in *DS Records*, do:
       1. Find the equivalent DNSKEY in *DNSKEY RRs* by key ID (key tag). If
          there is more than one such DNSKEY, select the correct one.
       2. If matching DNSKEY is not found add DS key tag and name server IP to
          the *No DNSKEY for DS* set.
       3. If the DS values (algorithm and digest) do not match the DNSKEY record
          then add DS key tag and name server IP to the *No match DS DNSKEY* set.
       4. If bit 7 of the DNSKEY flags field is unset (value 0), then add DS key
          tag and name server IP to the *DNSKEY not for zone signing* set.
       5. If bit 15 of the DNSKEY flags field is unset (value 0), then add the
          DNSKEY record key tag and name server IP to the *DNSKEY not SEP*
          set.
       6. Find the equivalent RRSIG in *DNSKEY RRSIG* by key ID (key tag). If
          there is more than one such RRSIG record, select the correct one.
       7. If matching RRSIG is not found, add DNSKEY record key tag and name
          server IP to the *No matching DNSKEY RRSIG* set.
       8. Else, if the Zonemaster installation does not have support for the
          DNSKEY algorithm that created the RRSIG, then add name server IP,
          DNSKEY algorithm and DNSKEY key tag to the *Algo Not Supported By ZM*
          set.
       9. Else, if the RRSIG values (algorithm and signature) do not match
          the DNSKEY then add the key tag from the RRSIG record and name server
          IP to the *RRSIG not valid by DNSKEY* set.

7.  If the *No DNSKEY for DS* set is non-empty, then for each key tag from the DS
    record from the set output *[DS02_NO_DNSKEY_FOR_DS]* with the key tag and the
    name servers IP addresses from the set.

8.  If the *No match DS DNSKEY* set is non-empty, then for each key tag from the
    DS record from the set output *[DS02_NO_MATCH_DS_DNSKEY]* with the key tag
    and the name servers IP addresses from the set.

9.  If the *DNSKEY not for zone signing* set is non-empty, then for each DNSKEY
    key tag from the set output *[DS02_DNSKEY_NOT_FOR_ZONE_SIGNING]* with the key
    tag and the name servers IP addresses from the set.

10. If the *DNSKEY not SEP* set is non-empty, then for each DNSKEY key tag from
    the set output *[DS02_DNSKEY_NOT_SEP]* with the key tag and the name servers
    IP addresses from the set.

11. If the *No matching DNSKEY RRSIG* set is non-empty, then for each DNSKEY key
    tag from the set output *[DS02_NO_MATCHING_DNSKEY_RRSIG]* with the key tag
    and the name servers IP addresses from the set.

12. If the *Algo Not Supported By ZM* set is non-empty, then output
    *[DS02_ALGO_NOT_SUPPORTED_BY_ZM]* for each DNSKEY key tag with the name
    server IP addresses, the key tag and the algorithm name and code from the set.

13. If the *RRSIG not valid by DNSKEY* set is non-empty, then for each key tag
    from the RRSIG record from the set output *[DS02_RRSIG_NOT_VALID_BY_DNSKEY]*
    with the key tag and the name servers IP addresses from the set.


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
[Basic04]:                                    ../Basic-TP/basic04.md
[CRITICAL]:                                   ../SeverityLevelDefinitions.md#critical
[DNSSEC README]:                              README.md
[DNSSEC11]:                                   dnssec11.md
[DS02_ALGO_NOT_SUPPORTED_BY_ZM]:              #Summary
[DS02_DNSKEY_NOT_FOR_ZONE_SIGNING]:           #Summary
[DS02_DNSKEY_NOT_SEP]:                        #Summary
[DS02_NO_DNSKEY_FOR_DS]:                      #Summary
[DS02_NO_MATCHING_DNSKEY_RRSIG]:              #Summary
[DS02_NO_MATCH_DS_DNSKEY]:                    #Summary
[DS02_RRSIG_NOT_VALID_BY_DNSKEY]:             #Summary
[ERROR]:                                      ../SeverityLevelDefinitions.md#error
[IANA RCODE List]:                            https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[INFO]:                                       ../SeverityLevelDefinitions.md#info
[Method1]:                                    ../Methods.md#method-1-obtain-the-parent-domain
[Method4]:                                    ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                                    ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[NOTICE]:                                     ../SeverityLevelDefinitions.md#notice
[RFC 4034#section-2.1.1]:                     https://tools.ietf.org/html/rfc4034#section-2.1.1
[RFC 4034#section-5.2]:                       https://tools.ietf.org/html/rfc4034#section-5.2
[RFC 4035#section-5]:                         https://tools.ietf.org/html/rfc4035#section-5
[Severity Level Definitions]:                 ../SeverityLevelDefinitions.md
[Undelegated]:                                ../../test-types/undelegated-test.md
[WARNING]:                                    ../SeverityLevelDefinitions.md#warning
[Zonemaster-Engine profile]:                  https://github.com/zonemaster/zonemaster-engine/blob/master/docs/Profiles.md
