# DNSSEC02: DS must match a valid DNSKEY in the child zone

## Test case identifier
**DNSSEC02**


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
[Connectivity01]).

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

Message Tag outputted              | Level   | Arguments                              | Description of when message tag is outputted
:----------------------------------|:--------|:---------------------------------------|:-----------------------------------------------------------------------
DS02_ALGO_NOT_SUPPORTED_BY_ZM      | NOTICE  |ns_ip_list, algo_mnemo, algo_num, keytag| DNSKEY with tag {keytag} uses unsupported algorithm {algo_num} ({algo_mnemo}) by this installation of Zonemaster. Fetched from the nameservers with IP addresses "{ns_ip_list}".
DS02_DNSKEY_NOT_FOR_ZONE_SIGNING   | ERROR   | ns_ip_list, keytag                     | Flags field of DNSKEY record with tag {keytag} does not have ZONE bit set although DS with same tag is present in parent. Fetched from the nameservers with IP addresses "{ns_ip_list}".
DS02_DNSKEY_NOT_SEP                | NOTICE  | ns_ip_list, keytag                     | Flags field of DNSKEY record with tag {keytag} does not have SEP bit set although DS with same tag is present in parent. Fetched from the nameservers with IP addresses "{ns_ip_list}".
DS02_DNSKEY_NOT_SIGNED_BY_ANY_DS   | ERROR   | ns_ip_list                             | The DNSKEY RRset has not been signed by any DNSKEY matched by a DS record. Fetched from the nameservers with IP addresses "{ns_ip_list}".
DS02_NO_DNSKEY_FOR_DS              | WARNING | ns_ip_list, keytag                     | The DNSKEY record with tag {keytag} that the DS refers to does not exist in the DNSKEY RRset. Fetched from the nameservers with IP "{ns_ip_list}".
DS02_NO_MATCHING_DNSKEY_RRSIG      | WARNING | ns_ip_list, keytag                     | The DNSKEY RRset is not signed by the DNSKEY with tag {keytag} that the DS record refers to. Fetched from the nameservers with IP "{ns_ip_list}".
DS02_NO_MATCH_DS_DNSKEY            | ERROR   | ns_ip_list, keytag                     | The DS record does not match the DNSKEY with tag {keytag} by algorithm or digest. Fetched from the nameservers with IP "{ns_ip_list}".
DS02_NO_VALID_DNSKEY_FOR_ANY_DS    | ERROR   | ns_ip_list                             | There is no valid DNSKEY matched by any of the DS records. Fetched from the nameservers with IP addresses "{ns_ip_list}".
DS02_RRSIG_NOT_VALID_BY_DNSKEY     | ERROR   | ns_ip_list, keytag                     | The DNSKEY RRset is signed with an RRSIG with tag {keytag} which cannot be validated by the matching DNSKEY. Fetched from the nameservers with IP addresses "{ns_ip_list}".

The value in the Level column is the default severity level of the message. The
severity level can be overridden in the [Zonemaster-Engine profile]. Also see the
[Severity Level Definitions] document.

The argument names in the Arguments column lists the arguments used in the
message. The argument names are defined in the [argument list].


## Test procedure

In this section and unless otherwise specified below, the term "[DNSSEC Query]"
follows the specification for DNS queries as specified in
[DNS Query and Response Defaults]. The handling of the DNS responses on the DNS
queries follow, unless otherwise specified below, what is specified for
[DNSSEC Response] in the same specification.

1.  Create the following empty sets:
    1.  DS record RDATA ("DS Record").
    2.  Name server IP and key tag from DS record ("No DNSKEY for DS").
    3.  Name server IP and key tag from DS record ("No Match DS DNSKEY").
    4.  Name server IP and DNSKEY record key tag ("DNSKEY Not for Zone Signing").
    5.  Name server IP and DNSKEY record key tag ("DNSKEY not SEP").
    6.  Name server IP and DNSKEY record key tag ("No Matching DNSKEY RRSIG").
    7.  Name server IP address, DNSKEY record key tag and DNSKEY algorithm code
        ("Algo Not Supported By ZM").
    8.  Name server IP and key tag from RRSIG record ("RRSIG Not Valid by DNSKEY").
    9.  Name server IP ("Responding Child Name Servers").
    10. DNSKEY record and key tag ("DNSKEY Matching DS").
    11. Name server IP ("Has DNSKEY Match DS").
    12. Name server IP ("Has DNSKEY RRSIG Match DS").

2.  If the *Test Type* is "[undelegated]" do:
    1. If *Undelegated DS* is empty then do terminate this test case.
    2. Else add *Undelegated DS* as DS records to the *DS Record* set.

3.  If *Test Type* is "normal", then:
    1. Create a [DNSSEC Query] with query type DS and query name *Child Zone*
       ("DS Query").
    2. Retrieve all name server IP addresses for the parent zone of
       *Child Zone* using [Method1] (store as "Parent NS IP").
    3. For each parent name server in *Parent NS IP* do:
       1. Send *DS Query* to the name server IP.
       2. If at least one of the following criteria is met, then go to next
          parent name server:
          1. There is no [DNSSEC Response].
          2. The RCODE in the [DNSSEC Response] is not "NoError"
             ([IANA RCODE List]).
          3. The OPT record is absent in the [DNSSEC Response].
          4. The DO flag is unset in the [DNSSEC Response].
          5. The AA flag is not set in the [DNSSEC Response].
          6. There is no DS record with matching owner name in the answer
             section of the [DNSSEC Response].
       3. Retrieve the DS records from the [DNSSEC Response] and add them to the
          *DS Record* set.
    4. If the *DS Record* set is empty exit this test case.

4. Create a [DNSSEC Query] with query type DNSKEY and query name *Child Zone*
   ("DNSKEY Query").

5.  Obtain the set of child name server IP addresses using [Method4] and
    [Method5] (store as "Child NS IP").

6.  For each child name server in *Child NS IP* do:
    1. Send *DNSKEY Query* to the name server IP and collect the response.
    2. If at least one of the following criteria is met, then go to next
       child name server:
       1. There is no [DNSSEC Response].
       2. The RCODE in the [DNSSEC Response] is not "NoError"
          ([IANA RCODE List]).
       3. The OPT record is absent in the [DNSSEC Response].
       4. The DO flag is unset in the [DNSSEC Response].
       5. The AA flag is not set in the [DNSSEC Response].
       6. There is no DNSKEY record with matching owner name in the answer
          section of the [DNSSEC Response].
    3. Add the name server IP address to the *Responding Child Name Servers* set.
    4. Retrieve the DNSKEY RRset (store as "DNSKEY RRs") from the
       [DNSSEC Response].
    5. Retrieve the RRSIG records covering the DNSKEY RRset, possibly
       none (store as "DNSKEY RRSIG") from the [DNSSEC Response].
    6. Empty the *DNSKEY Matching DS* set.
    7. For each DS in *DS Records*, do:
       1. Find the equivalent DNSKEY in *DNSKEY RRs* by key ID (key tag). If
          there is more than one such DNSKEY, select the correct one.
       2. If matching DNSKEY is not found add DS key tag and name server IP to
          the *No DNSKEY for DS* set and go to next DS.
       3. Verify if the Zonemaster installation has support for the digest
          algorithm that created the DS:
          1. If no support, then ignore the following test if the DS matches
             the DNSKEY.
          2. Else, if the DS values (algorithm and digest) do not match the
             DNSKEY record then add DS key tag and name server IP to the
             *No Match DS DNSKEY* set.
       4. If bit 7 of the DNSKEY flags field is unset (value 0), then do:
          1. Add DS key tag and name server IP to the
             *DNSKEY Not for Zone Signing* set.
          2. Go to next DS.
       5. If bit 15 of the DNSKEY flags field is unset (value 0), then add the
          DNSKEY record key tag and name server IP to the *DNSKEY not SEP*
          set.
       6. Add the DNSKEY record and key tag to the *DNSKEY Matching DS*
          set.
       7. Add the name server IP to the *Has DNSKEY Match DS*
          set.
    8. For each DNSKEY in the *DNSKEY Matching DS* set, do:
       1. Look for an RRSIG record created by the DNSKEY in *DNSKEY RRSIG*.
          * Use key ID (key tag) to identify the corresponding RRSIG record.
          * If there is more than one such RRSIG record, select the correct one
            by verifying the signature against the DNSKEY.
       2. If a matching RRSIG is not found, add DNSKEY record key tag and name
          server IP to the *No Matching DNSKEY RRSIG* set.
       3. Else, if the Zonemaster installation does not have support for the
          DNSKEY algorithm that created the RRSIG, then add name server IP,
          DNSKEY algorithm and DNSKEY key tag to the *Algo Not Supported By ZM*
          set.
       4. Else, if the RRSIG values (algorithm and signature) do not match
          the DNSKEY then add the key tag from the RRSIG record and name server
          IP to the *RRSIG Not Valid by DNSKEY* set.
       5. Else add the name server IP address to the *Has DNSKEY RRSIG Match DS*
          set.

7.  If the *No DNSKEY for DS* set is non-empty, then for each key tag from the DS
    record from the set output *[DS02_NO_DNSKEY_FOR_DS]* with the key tag and the
    name servers IP addresses from the set.

8.  If the *No Match DS DNSKEY* set is non-empty, then for each key tag from the
    DS record from the set output *[DS02_NO_MATCH_DS_DNSKEY]* with the key tag
    and the name servers IP addresses from the set.

9.  If the *DNSKEY Not for Zone Signing* set is non-empty, then for each DNSKEY
    key tag from the set output *[DS02_DNSKEY_NOT_FOR_ZONE_SIGNING]* with the key
    tag and the name servers IP addresses from the set.

10. If the *DNSKEY not SEP* set is non-empty, then for each DNSKEY key tag from
    the set output *[DS02_DNSKEY_NOT_SEP]* with the key tag and the name servers
    IP addresses from the set.

11. If the *No Matching DNSKEY RRSIG* set is non-empty, then for each DNSKEY key
    tag from the set output *[DS02_NO_MATCHING_DNSKEY_RRSIG]* with the key tag
    and the name servers IP addresses from the set.

12. If the *Algo Not Supported By ZM* set is non-empty, then output
    *[DS02_ALGO_NOT_SUPPORTED_BY_ZM]* for each DNSKEY key tag with the name
    server IP addresses, the key tag and the algorithm code from the set.

13. If the *RRSIG Not Valid by DNSKEY* set is non-empty, then for each key tag
    from the RRSIG record from the set output *[DS02_RRSIG_NOT_VALID_BY_DNSKEY]*
    with the key tag and the name servers IP addresses from the set.

14. Extract the name server IP addresses that are members of
    *Responding Child Name Servers* but are not members of *Has DNSKEY Match DS*
    set.
    
15. If the subset from previous step is non-empty, then output
    *[DS02_NO_VALID_DNSKEY_FOR_ANY_DS]* with the subset of name server IP
    addresses.
    
16. Else do:
    1. Extract the name server IP addresses that are members of
       *Responding Child Name Servers* but are not members of
       *Has DNSKEY RRSIG Match DS* set.
    2. If that subset is non-empty, then output
       *[DS02_DNSKEY_NOT_SIGNED_BY_ANY_DS]* with the subset of name server IP
       addresses.


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
transport protocol. Output a message reporting that the transport protocol has
been disabled.

See the [DNSSEC README] document about DNSSEC algorithms.


## Intercase dependencies

None.


## Terminology

No special terminology for this test case.


[Argument list]:                              ../ArgumentsForTestCaseMessages.md
[Connectivity01]:                             ../Connectivity-TP/connectivity01.md
[CRITICAL]:                                   ../SeverityLevelDefinitions.md#critical
[DNS Query and Response Defaults]:            ../DNSQueryAndResponseDefaults.md
[DNSSEC Query]:                               ../DNSQueryAndResponseDefaults.md#default-setting-in-dnssec-query
[DNSSEC README]:                              README.md
[DNSSEC Response]:                            ../DNSQueryAndResponseDefaults.md#default-handling-of-a-dnssec-response
[DNSSEC11]:                                   dnssec11.md
[DS02_ALGO_NOT_SUPPORTED_BY_ZM]:              #summary
[DS02_DNSKEY_NOT_FOR_ZONE_SIGNING]:           #summary
[DS02_DNSKEY_NOT_SEP]:                        #summary
[DS02_DNSKEY_NOT_SIGNED_BY_ANY_DS]:           #summary
[DS02_NO_DNSKEY_FOR_DS]:                      #summary
[DS02_NO_MATCHING_DNSKEY_RRSIG]:              #summary
[DS02_NO_MATCH_DS_DNSKEY]:                    #summary
[DS02_NO_VALID_DNSKEY_FOR_ANY_DS]:            #summary
[DS02_RRSIG_NOT_VALID_BY_DNSKEY]:             #summary
[ERROR]:                                      ../SeverityLevelDefinitions.md#error
[IANA RCODE List]:                            https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[INFO]:                                       ../SeverityLevelDefinitions.md#info
[Method1]:                                    ../Methods.md#method-1-obtain-the-parent-domain
[Method4]:                                    ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                                    ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[NOTICE]:                                     ../SeverityLevelDefinitions.md#notice
[RFC 4034#section-2.1.1]:                     https://datatracker.ietf.org/doc/html/rfc4034#section-2.1.1
[RFC 4034#section-5.2]:                       https://datatracker.ietf.org/doc/html/rfc4034#section-5.2
[RFC 4035#section-5]:                         https://datatracker.ietf.org/doc/html/rfc4035#section-5
[Severity Level Definitions]:                 ../SeverityLevelDefinitions.md
[Undelegated]:                                ../../test-types/undelegated-test.md
[WARNING]:                                    ../SeverityLevelDefinitions.md#warning
[Zonemaster-Engine profile]:                  ../../../configuration/profiles.md
