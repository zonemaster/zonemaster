# DNSSEC01: Legal values for the DS hash digest algorithm


## Test case identifier
**DNSSEC01**


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

The list of allowed Digest Algorithms in a DS record published by the parent is
specified by [RFC 8624][RFC 8624#3.3], section 3.3, and is published in the
[IANA registry][IANA registry on DS Digest Algorithm] of
*DS RR Type Digest Algorithms*. No DS Digest Algorithm values, other than those
specified in the RFC and allocated by IANA, should be used in public DNS.

If [RFC 8624][RFC 8624#3.3] and the
[IANA registry][IANA registry on DS Digest Algorithm] disagree on the same DS
digest algorithm, the RFC takes precedence until the registry has a been updated
with a reference to the RFC.

At the time of writing (2020-04-08), algorithm 1 (SHA-1) is still in wide use
even though it is no longer considered to be secure
([Wikipedia][Wikipedia on SHA1]).

The table of algorithms below is for reference only and is copied from
[IANA registry][IANA registry on DS Digest Algorithm]. It is here to make it
easier to read the steps when symbolic names are given. This is only an excerpt
from the table. The full table is available at the IANA registry.

Algorithm number | Algorithm (or description)
:----------------|:-----------------------------------
0                | (Reserved)
1                | SHA-1
2                | SHA-256
3                | GOST R 34.11-94
4                | SHA-384
5-255            | (Unassigned)

This test case will verify that the Zonemaster implementation has support for the
DS digest algorithm of the DS record found, and if not output a message tag. If
the support is missing other test cases will not be able to verify that DS
record.


## Scope

This test case will query the name servers of the parent zone, and will just
ignore non-responsive name servers or name servers not giving a correct DNS
response for an authoritative name server.

If no DS record is found in the parent zone then this test case will be
terminated without outputting any message tag.

This test case does not report if the parent servers give inconsistent responses.

If the *Child Zone* is the root zone, then it has no parent zone, and no DS
records can be fetch.


## Inputs

* "Child Zone" - The domain name to be tested.
* "Algorithm Status" - The status of all DS digest algorithms from
  [RFC 8624][RFC 8624#3.3] and the
  [IANA registry][IANA registry on DS Digest Algorithm].
* "Test Type" - The test type with value "undelegated" or "normal".
* "Undelegated DS" - The DS record or records submitted, undefined unless
  *Test Type* is undelegated and empty if no DS record has been submitted.


## Summary

* At least one DS record must be found, or no further investigation will be done
  and no messages will be outputted.
* No messages will be outputted due to errors in the responses from the parent
  name servers.

Message Tag outputted          | Level   | Arguments                                | Description of when message tag is outputted
:------------------------------|:--------|:-----------------------------------------|:--------------------------------------------
DS01_DIGEST_NOT_SUPPORTED_BY_ZM| NOTICE  | ns_ip_list, algo_mnemo, algo_num, keytag | DS Digest cannot be validated by this installation of Zonemaster.
DS01_DS_ALGO_DEPRECATED        | ERROR   | ns_ip_list, algo_mnemo, algo_num, keytag | The DS digest algorithm is deprecated.
DS01_DS_ALGO_2_MISSING         | NOTICE  |                                          | Algo 2 (SHA-256) is expected but missing.
DS01_DS_ALGO_NOT_DS            | ERROR   | ns_ip_list, algo_mnemo, algo_num, keytag | The DS digest algorithm is not for DS.
DS01_DS_ALGO_RESERVED          | ERROR   | ns_ip_list, algo_mnemo, algo_num, keytag | No DS digest algorithm defined for the digest code.
DS01_DS_ALGO_SHA1_DEPRECATED   | WARNING | ns_ip_list, algo_mnemo, algo_num, keytag | The DS SHA1 digest algorithm is deprecated.

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

1.  If the *Test Type* is "[undelegated]" do:

    1. If *Undelegated DS* is empty then do terminate the test procedure.

    2. Else, for each DS record in *Undelegated DS* do:

       1. Extract the digest algorithm code and key tag from the DS record
          ("Digets Code" and "Key Tag", respectively).

       2. If *Digest Code* is 0 then output *[DS01_DS_ALGO_NOT_DS]* with
          *Digest Code* and *Key Tag* . Set IP address as "-".

       3. If *Digest Code* is 1 then output *[DS01_DS_ALGO_SHA1_DEPRECATED]*
          with *Digest Code* and *Key Tag*. Set IP address as "-".

       4. If *Digest Code* is 3 then output *[DS01_DS_ALGO_DEPRECATED]* with
          *Digest Code* and *Key Tag*. Set IP address as "-".

       5. If *Digest Code* is 5-255 then output *[DS01_DS_ALGO_RESERVED]* with
          *Digest Code* and *Key tag*. Set IP address as "-".

       6. Verify if the Zonemaster implementation can create a digest of any
          valid DNSKEY record using *Digest Code*. If the verification fails
          output *[DS01_DIGEST_NOT_SUPPORTED_BY_ZM]* with *Digest Code* and
          *Key tag*. Set IP address as "-".

    3. If none of the DS records has digest algorithm value 2 output
       *[DS01_DS_ALGO_2_MISSING]*.

    4. Terminated the test procedure.

2.  From here the test procedure is for normal test, not undelegated.

3.  If *Child Zone* is the root zone (".") then terminate the test procedure.

4.  Create the following empty set:
    1. Name server IP, key tag from DS record and digest algorithm code ("DS Records").

5.  Create a [DNSSEC Query] with query type DS and query name *Child Zone*
    ("DS Query").

6.  Retrieve all name server IP addresses for the parent zone of
    *Child Zone* using [Method1] (store as "Parent NS IP").

7.  For each parent name server in *Parent NS IP* do:
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
    3. Retrieve the DS records from the [DNSSEC Response] and add name sever IP,
       key tag from the DS record and the digest algorithm code from the DS
       record to the *DS Records* set.

8.  If the *DS Records* set is empty terminate the test procedure.

9.  For each subset in *DS Records* where both DS digest code ("Digest Code") and
    key tag ("Key Tag") are identical for all subset elements do:

    1. If *Digest Code* is 0 then output *[DS01_DS_ALGO_NOT_DS]* with
      *Digest Code*, *Key Tag* and list of name server IP addresses.
    2. If *Digest Code* is 1 then output *[DS01_DS_ALGO_SHA1_DEPRECATED]* with
       *Digest Code*, *Key Tag* and list of name server IP addresses.
    3. If *Digest Code* is 3 then output *[DS01_DS_ALGO_DEPRECATED]* with
       *Digest Code*, *Key Tag* and list of name server IP addresses.
    4. If *Digest Code* is 5-255 then output *[DS01_DS_ALGO_RESERVED]* with
       *Digest Code*, *Key Tag* and list of name server IP addresses.
    5. Verify that the Zonemaster implementation can create a digest of any valid
       DNSKEY record using *Digest Code*. If the verification fails output
       *[DS01_DIGEST_NOT_SUPPORTED_BY_ZM]* with *Digest Code*, *Key Tag* and list
       of name server IP addresses.

10. If none of the elements in *DS Records* has digest algorithm value 2 output
   *[DS01_DS_ALGO_2_MISSING]*.


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


[Argument list]:                                      https://github.com/zonemaster/zonemaster-engine/blob/master/docs/logentry_args.md
[CRITICAL]:                                           ../SeverityLevelDefinitions.md#critical
[DNS Query and Response Defaults]:                    ../DNSQueryAndResponseDefaults.md
[DNSSEC Query]:                                       ../DNSQueryAndResponseDefaults.md#default-setting-in-dnssec-query
[DNSSEC README]:                                      README.md
[DNSSEC Response]:                                    ../DNSQueryAndResponseDefaults.md#default-handling-of-a-dnssec-response
[DS01_DIGEST_NOT_SUPPORTED_BY_ZM]:                    #Summary
[DS01_DS_ALGO_2_MISSING]:                             #Summary
[DS01_DS_ALGO_DEPRECATED]:                            #Summary
[DS01_DS_ALGO_NOT_DS]:                                #Summary
[DS01_DS_ALGO_RESERVED]:                              #Summary
[DS01_DS_ALGO_SHA1_DEPRECATED]:                       #Summary
[ERROR]:                                              ../SeverityLevelDefinitions.md#error
[IANA RCODE List]:                                    https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[IANA registry on DS Digest Algorithm]:               https://www.iana.org/assignments/ds-rr-types/ds-rr-types.xml
[INFO]:                                               ../SeverityLevelDefinitions.md#info
[Method1]:                                            ../Methods.md#method-1-obtain-the-parent-domain
[NOTICE]:                                             ../SeverityLevelDefinitions.md#notice
[RFC 8624#3.3]:                                       https://tools.ietf.org/html/rfc8624#section-3.3
[Severity Level Definitions]:                         ../SeverityLevelDefinitions.md
[Undelegated]:                                        ../../test-types/undelegated-test.md
[WARNING]:                                            ../SeverityLevelDefinitions.md#warning
[Wikipedia on SHA1]:                                  https://en.wikipedia.org/wiki/SHA-1
[Zonemaster-Engine profile]:                          https://github.com/zonemaster/zonemaster-engine/blob/master/docs/Profiles.md
