# DNSSEC11: Must be signed if there is DS in delegation

## Test case identifier
**DNSSEC11**

## Objective

If the delegation of the zone contains DS records, i.e. if the parent
zone has DS records with the same owner name as the apex of the zone,
then the zone must be signed. If not, a DNSSEC aware resolver should
consider the zone to be "[bogus][Terminology]" (see
[RFC 4033][RFC 4033#section-5], section 5), and the zone will be unavailable.

This test case will verify that a zone with DS in delegation from
parent is also signed. Here we just verify that it has DNSKEY in apex.
Test case [DNSSEC08] verifies that in a zone with DNSKEY that the
DNSKEY RRset is signed and test case [DNSSEC09] that in a zone
with DNSKEY the SOA record is signed.

## Inputs

* "Child Zone" - The domain name to be tested.
* "Test Type" - The test type with value "[undelegated]" or "normal".
* "Undelegated DS" - The DS record or records submitted
  (only if *Test Type* is [undelegated]).


## Ordered description of steps to be taken to execute the test case

1.  Create empty sets of name server IP addresses:
    1. "Indetermined DS"
    2. "No DS Record"
    3. "Has DS Record"

2.  If the *Test Type* is "normal", then:

    1. Create a DS query with the DO flag set for the name of the *Child Zone*.

    2. Retrieve all name server IP addresses for the parent zone of
       *Child Zone* using [Method1] ("Parent NS IP").

    3. For each IP address in *Parent NS IP* do:

       1. If the response has the TC flag set, re-query over TCP and use that
          response instead.
       2. If there is no DNS response, then add the name server (IP) to the
          *Indetermined DS* set.
       3. Else, if the RCODE of response is not "NoError" ([IANA RCODE List]),
          then add the name server (IP) to the *Indetermined DS* set.
       4. Else, if the AA flag is not set in the response, then add the name
          server (IP) to the *Indetermined DS* set.
       5. Else, if there is no DS record with matching owner name in the
          answer section, then add the name server (IP) to the
          *No DS Record* set.
       7. Else add the name server (IP) to the *Has DS Record* set.

    4. If the *Indetermined DS* set is non-empty and both the
       *No DS Record* and *Has DS Record* sets are empty then do:
       1. Output *[DS11_INDETERMINED_DS]*.
       2. Exit this test case.

    5. If the *No DS Record* set is non-empty and the *Has DS Record* set is
       empty then do:
       1. Output *[DS11_NO_DS]*.
       2. Exit this test case.

    6. If both the *No DS Record* and *Has DS Record* sets are non-empty,
       then do:
       1. Output *[DS11_INCONSISTENT_DS]*.
       2. Output *[DS11_PARENT_WITHOUT_DS]* and list parent name servers in
          *No DS Record*.
       3. Output *[DS11_PARENT_WITH_DS]* and list parent name servers in
          *Has DS Record*.

3.  If the *Test Type* is "[undelegated]" and if *Undelegated DS* is empty,
    then do:
    1. Output *[DS11_NO_DS]*.
    2. Exit this test case.

4.  Create DNS queries for the child zone:

    1.  SOA query for the *Child Zone* without any OPT record (no EDNS).
    2.  DNSKEY query for the *Child Zone* with the DO flag set.

5.  Obtain the set of child name server IP addresses using [Method4] and
    [Method5] ("Name Server IP").

6.  Create empty sets of name server IP addresses:

    1. "Indeterminded DNSKEY".
    2. "No DNSKEY Record".
    3. "Has DNSKEY Record".

7.  For each name server in *Name Server IP* do:

    1. Send the SOA query over UDP to the name server, collect the response,
       add name server IP to *Indeterminded DNSKEY* and go to next server if
       1. there is no DNS response on the SOA query, or
       2. the RCODE of the response is not "NoError" ([IANA RCODE List]), or
       3. the AA flag is not set in the response, or
       4. there is no SOA record with owner name matching the query.

    2. Else, send the DNSKEY query over UDP to the name server and collect the
       response, and:
       1. If the response has the TC flag set, re-query over TCP and use that
          response instead.
       2. If there is no DNS response, then add the name server (IP) to the
          *Indeterminded DNSKEY* set.
       3. Else, if the RCODE of response is not "NoError" ([IANA RCODE List]),
          then add the name server (IP) to the *Indeterminded DNSKEY* set.
       4. Else, if the AA flag is not set in the response, then add the name
          server (IP) to the *Indeterminded DNSKEY* set.
       5. Else, if there is no DNSKEY record with matching owner name in the
          answer section, then add the name server (IP) to the
          *No DNSKEY Record* set.
       7. Else add the name server (IP) to the *Has Record Record* set.

8.  If the *Indetermined DNSKEY* set is non-empty and both the
    *No DNSKEY Record* and *Has DNSKEY Record* sets are empty then output
    *[DS11_INDETERMINED_SIGNED_ZONE]*.

9.  Else, if the *No DNSKEY Record* set is non-empty and the
    *Has DNSKEY Record* set is empty then output
    *[DS11_UNSIGNED_ZONE_WITH_DS]*.

10. Else, if both the *No DNSKEY Record* and *Has DNSKEY Record* sets
    are non-empty, then do:
    1. Output *[DS11_INCONSISTENT_SIGNED_ZONE_AND_DS]*.
    2. Output *[DS11_UNSIGNED_ZONE]* and list name servers in
       *No DNSKEY Record*.
    3. Output *[DS11_SIGNED_ZONE]* and list name servers in
       *Has DNSKEY Record*.

11. Else, output *[DS11_SIGNED_AND_DS]*.


## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the [severity level] *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the [severity level] *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

The outcome of this Test case is "pass" in all other cases.

Message                                        | Default [severity level]
:----------------------------------------------|:-----------------------------------
DS11_INCONSISTENT_DS                           | WARNING
DS11_INCONSISTENT_SIGNED_ZONE_AND_DS           | ERROR
DS11_INDETERMINED_DS                           | ERROR
DS11_INDETERMINED_SIGNED_ZONE                  | ERROR
DS11_NO_DS                                     | INFO
DS11_PARENT_WITHOUT_DS                         | NOTICE
DS11_PARENT_WITH_DS                            | NOTICE
DS11_SIGNED_AND_DS                             | INFO
DS11_SIGNED_ZONE                               | NOTICE
DS11_UNSIGNED_ZONE                             | WARNING
DS11_UNSIGNED_ZONE_WITH_DS                     | ERROR

## Special procedural requirements

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
on the ignored result.

It is assumed that [DNSSEC02] has been executed and that any irregularities
in fetching the DS record from parent zone has been reported there.

It is assumed that [DNSSEC08] and [DNSSEC09] have verified that the DNSKEY
and SOA records in the zone, if any DNSKEY record, are signed.

Errors associated with the response to the query for the SOA record without
EDNS are expected to have been caught by [Basic04].

See the [DNSSEC README] document about DNSSEC algorithms.

This test case is always performed.


## Intercase dependencies

None.


## Terminology

The terms "bogus" is also discussed in in [RFC 8499][RFC 8499#section-11], section 11.

[Basic04]:                                    ../Basic-TP/basic014.md
[DNSSEC README]:                              README.md
[DNSSEC02]:                                   dnssec02.md
[DNSSEC08]:                                   dnssec08.md
[DNSSEC09]:                                   dnssec09.md
[DS11_INCONSISTENT_DS]:                       #outcomes
[DS11_INCONSISTENT_SIGNED_ZONE_AND_DS]:       #outcomes
[DS11_INDETERMINED_DS]:                       #outcomes
[DS11_INDETERMINED_SIGNED_ZONE]:              #outcomes
[DS11_NO_DS]:                                 #outcomes
[DS11_NO_DS]:                                 #outcomes
[DS11_PARENT_WITHOUT_DS]:                     #outcomes
[DS11_PARENT_WITH_DS]:                        #outcomes
[DS11_SIGNED_AND_DS]:                         #outcomes
[DS11_SIGNED_ZONE]:                           #outcomes
[DS11_UNSIGNED_ZONE]:                         #outcomes
[DS11_UNSIGNED_ZONE_WITH_DS]:                 #outcomes
[IANA RCODE List]:                            https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[Method1]:                                    ../Methods.md#method-1-obtain-the-parent-domain
[Method4]:                                    ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                                    ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[RFC 4033#section-5]:                         https://tools.ietf.org/html/rfc4033#section-5
[RFC 8499#section-11]:                        https://tools.ietf.org/html/rfc8499#section-11
[Severity Level]:                             ../SeverityLevelDefinitions.md
[Terminology]:                                #terminology
[Undelegated]:                                ../../test-types/undelegated-test.md


