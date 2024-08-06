# DNSSEC13: All DNSKEY algorithms used to sign the zone


## Test case identifier
**DNSSEC13**


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

From [RFC 6840][RFC 6840#section-5.11], section 5.11:

> The DS RRset and DNSKEY RRset are used to signal which algorithms are used to
> sign a zone. \[...] The zone MUST also be signed with each algorithm (though
> not each key) present in the DNSKEY RRset. \[...]

To verify that the whole zone is signed with all algorithms require access to the
complete zone, which is generally not possible for public zones. This test case
is limited to three RRsets that must be present in a signed zone, the SOA RRset,
the NS RRset and the DNSKEY RRset.

This test case will verify that for each DNSKEY algorithm, there is a RRSIG of
that algorithm for the three selected RRsets.


## Scope

It is assumed that *Child Zone* is also tested by [Connectivity01], [DNSSEC08] and
[DNSSEC09]. Issues covered by [Connectivity01] (basic name server issues), [DNSSEC08]
(signing of DNSKEY RRset) and [DNSSEC09] (signing of SOA RRset) will not result
in messages from this test case.


## Inputs

* "Child Zone" - The domain name to be tested.


## Summary

* If the name server reports no DNSKEY RRset, then this test case will not test
  or report anything.
* This test case will not report anything unless there is an issue to report.

Message Tag outputted         | Level   | Arguments                        | Description of when message tag is outputted
:-----------------------------|:--------|:---------------------------------|:--------------------------------------------
DS13_ALGO_NOT_SIGNED_DNSKEY   | WARNING | ns_ip_list, algo_mnemo, algo_num | The DNSKEY RRset is not signed with an algorithm present in the DNSKEY RRset
DS13_ALGO_NOT_SIGNED_NS       | WARNING | ns_ip_list, algo_mnemo, algo_num | The NS RRset is not signed with an algorithm present in the DNSKEY RRset
DS13_ALGO_NOT_SIGNED_SOA      | WARNING | ns_ip_list, algo_mnemo, algo_num | The SOA RRset is not signed with an algorithm present in the DNSKEY RRset

The value in the Level column is the default severity level of the message. The
severity level can be changed in the [Zonemaster-Engine profile]. Also see the
[Severity Level Definitions] document.

The argument names in the Arguments column lists the arguments used in the
message. The argument names are defined in the [argument list].


## Test procedure

1. Create a DNSKEY query with DO flag set for the apex of the
   *Child Zone* ("DNSKEY Query").

2. Create a SOA query with DO flag set for the apex of the
   *Child Zone* ("SOA Query").

3. Create a NS query with DO flag set for the apex of the
   *Child Zone* ("NS Query").

4. Retrieve all name server IP addresses for the
   *Child Zone* using [Method4] and [Method5] ("NS IP").

5. Create the following empty sets:

   1. Name server IP address and associated DNSKEY algorithm
      ("Algo not signed DNSKEY").
   2. Name server IP address and associated DNSKEY algorithm
      ("Algo not signed SOA").
   3. Name server IP address and associated DNSKEY algorithm
      ("Algo not signed NS").

6. For each name server IP in the *NS IP* set do:

   1. Create an empty set of DNSKEY algorithms ("DNSKEY Algorithm").
   2. Send *DNSKEY Query* over UDP and do:
      1. Go to next name server IP if any of the following criteria is met:
         1. No DNS response is returned.
         2. The RCODE value of the DNS response is not "NoError"
            ([IANA RCODE List]).
         3. The AA flag of the response is unset.
         4. The DNS response contains no DNSKEY record in the answer section.
         5. The DNS response contains no RRSIG for the DNSKEY RRset.
      2. Extract all DNSKEY records from the answer section.
      3. Extract the algorithm numbers from each DNSKEY record and add them to
         the *DNSKEY Algorithm* set.
      4. Extract all RRSIG records for the DNSKEY RRset from the response.
      5. For each algorithm in *DNSKEY Algorithm* do:
         * If there is no RRSIG for the DNSKEY RRset created by the algorithm
           then add name server IP and DNSKEY algorithm to the
           *Algo not signed DNSKEY* set.

   3. Send *SOA Query* over UDP and do:
      1. Go to next name server IP if any of the following criteria is met:
         1. No DNS response is returned.
         2. The RCODE value of the DNS response is not "NoError"
            ([IANA RCODE List]).
         3. The AA flag of the response is unset.
         4. The DNS response contains no SOA record in the answer section.
         5. The DNS response contains no RRSIG for the SOA RRset.
      2. Extract the SOA record from the answer section (ignore additional SOA
         records, if any).
      3. Extract all RRSIG records for the SOA RRset from the response.
      4. For each algorithm in *DNSKEY Algorithm* do:
         * If there is no RRSIG for the SOA RRset created by the algorithm then
           add name server IP and DNSKEY algorithm to the
               *Algo not signed SOA* set.

   4. Send *NS Query* over UDP.
      1. Go to next name server IP if any of the following criteria is met:
         1. No DNS response is returned.
         2. The RCODE value of the DNS response is not "NoError"
            ([IANA RCODE List]).
         3. The AA flag of the response is unset.
         4. The DNS response contains no NS record in the answer section.
         5. The DNS response contains no RRSIG for the NS RRset.
      2. Extract all NS records from the answer section.
      3. Extract all RRSIG records for the NS RRset from the response.
      4. For each algorithm in *DNSKEY Algorithm* do:
         * If there is no RRSIG for the NS RRset created by the algorithm then
           add name server IP and DNSKEY algorithm to the
           *Algo not signed NS* set.

7. If the *Algo not signed DNSKEY* set is non-empty, then for each DNSKEY
   algorithm in the set output *[DS13_ALGO_NOT_SIGNED_DNSKEY]* with the name
   server IP addresses from the set and the DNSKEY algorithm.

8. If the *Algo not signed SOA* set is non-empty, then for each DNSKEY
   algorithm in the set output *[DS13_ALGO_NOT_SIGNED_SOA]* with the name
   server IP addresses from the set and the SOA algorithm.

9. If the *Algo not signed NS* set is non-empty, then for each DNSKEY
   algorithm in the set output *[DS13_ALGO_NOT_SIGNED_NS]* with the name
   server IP addresses from the set and the NS algorithm.


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

Test case is only performed if DNSKEY records are found.


## Intercase dependencies

None.


## Terminology

No special terminology for this test case.


[Argument list]:                              ../ArgumentsForTestCaseMessages.md
[Connectivity01]:                             ../Connectivity-TP/connectivity01.md
[CRITICAL]:                                   ../SeverityLevelDefinitions.md#critical
[DNSSEC README]:                              README.md
[DNSSEC08]:                                   dnssec08.md
[DNSSEC09]:                                   dnssec09.md
[DS13_ALGO_NOT_SIGNED_DNSKEY]:                #summary
[DS13_ALGO_NOT_SIGNED_NS]:                    #summary
[DS13_ALGO_NOT_SIGNED_SOA]:                   #summary
[ERROR]:                                      ../SeverityLevelDefinitions.md#error
[IANA RCODE List]:                            https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[INFO]:                                       ../SeverityLevelDefinitions.md#info
[Method4]:                                    ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                                    ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[NOTICE]:                                     ../SeverityLevelDefinitions.md#notice
[RFC 6840#section-5.11]:                      https://datatracker.ietf.org/doc/html/rfc6840#section-5.11
[Severity Level Definitions]:                 ../SeverityLevelDefinitions.md
[WARNING]:                                    ../SeverityLevelDefinitions.md#warning
[Zonemaster-Engine profile]:                  ../../../configuration/profiles.md
