## DNSSEC03: Verify NSEC3 parameters


### Test case identifier
**DNSSEC03**


## Table of contents

* [Objective](#objective)
* [Scope](#scope)
* [Inputs](#inputs)
* [Summary](#summary)
* [Test procedure]
* [Outcome(s)](#outcomes)
* [Special procedural requirements](#special-procedural-requirements)
* [Intercase dependencies](#intercase-dependencies)
* [Terminology](#terminology)


## Objective

The NSEC3 record type and its parameters are defined in [RFC 5155]. The
recommended values of the parameters have been updated by [RFC 9276].

For NSEC3 there are four fields that determine how the NSEC3 record are created
and interpreted ([RFC 5155][RFC 5155#section-3], section3):

* Hash algorithm
* Flags
* Iterations
* Salt

**Hash algorithm:** The only legal value of the hash algorithm is value 1
(SHA-1). See ([RFC 5155][RFC 5155#section-11], section 11 and
[IANA NSEC3 Parameters registry]).

**Flags:** The only defined flags in the flag field is bit 7, "opt-out". It may
only be set in the NSEC record, not in the NSEC3PARAM record
([RFC 5155][RFC 5155#section-11], section 11 and
[IANA NSEC3 Parameters registry]). "For small zones, the use of opt-out-based
NSEC3 records is NOT RECOMMENDED. For very large and sparsely signed zones, where
the majority of the records are insecure delegations, opt-out MAY be used"
([RFC 9276][RFC 9276#section-3.1], section 3.1). This means that unless the zone
is a TLD or a TLD like domain found in the [Public Suffix List] it should
not have the opt-out bit set.

**Iterations:** For a name server an increased number of NSEC3 iterations have a
negative impact on performance. The recommendation is to have 0 iterations. "If
NSEC3 must be used, then an iterations count of 0 MUST be used to alleviate
computational burdens" ([RFC 9276][RFC 9276#section-3.1], section 3.1).

**Salt:** The salt parameter has been seen as a security feature but
[RFC 9276][RFC 9276#section-3.1], section 3.1, states that zones "SHOULD NOT use
a salt by indicating a zero-length salt value instead". The justification for
the recommendation is found in [RFC 9276][RFC 9276#section-2.4], section 2.4.


## Scope

This test case will just ignore non-responsive name servers or name servers not
giving a correct DNS response for an authoritative name server (covered by
[Connectivity01]).

This test case is only relevant if the zone has been DNSSEC signed.


## Inputs

* "Child Zone" - The domain name to be tested.
* "Public Suffix List Data" - The list or a copy of the list found at
  [Public Suffix List data].


## Summary

* If no DNSKEY records are found, no further investigation will be done.

Message Tag outputted              | Level   | Arguments  | Message ID for message tag
:----------------------------------|:--------|:-----------|:--------------------------------------------
DS03_ERR_MULT_NSEC3                | ERROR   | ns_list | Multiple NSEC3 records when one is expected. Fetched from name servers "{ns_list}".
DS03_ILLEGAL_HASH_ALGO             | ERRRO   | ns_list, algo_num | The following servers respond with an illegal hash algorithm for NSEC3 ({algo_num}). Fetched from name servers "{ns_list}".
DS03_ILLEGAL_ITERATION_VALUE       | ERROR   | ns_list, int | The following servers respond with the NSEC3 iteration value {int} (not recommended). Fetched from name servers "{ns_list}".
DS03_ILLEGAL_SALT_LENGTH           | WARNING | ns_list, int | The following servers respond with a non-empty salt in NSEC3 ({int} octets). Fetched from name servers "{ns_list}".
DS03_INCONSISTENT_HASH_ALGO        | ERROR   |         | Inconsistent hash algorithms in NSEC3 in responses for the child zone from different name servers.
DS03_INCONSISTENT_ITERATION        | ERROR   |         | Inconsistent NSEC3 iteration values in responses for the child zone from different name servers.
DS03_INCONSISTENT_NSEC3_FLAGS      | ERROR   |         | Inconsistent NSEC3 flags in responses for the child zone from different name servers.
DS03_INCONSISTENT_SALT_LENGTH      | ERROR   |         | Inconsistent salt length in NSEC3 in responses for the child zone from different name servers.
DS03_LEGAL_EMPTY_SALT              | INFO    | ns_list | The following servers respond with a legal empty salt in NSEC3. Fetched from name servers "{ns_list}".
DS03_LEGAL_HASH_ALGO               | INFO    | ns_list | The following servers respond with a legal hash algorithm in NSEC3. Fetched from name servers "{ns_list}".
DS03_LEGAL_ITERATION_VALUE         | INFO    | ns_list | The following servers respond with no NSEC3 iterations (as recommended). Fetched from name servers "{ns_list}".
DS03_NO_DNSSEC_SUPPORT             | NOTICE  | ns_list | The zone is not DNSSEC signed or not properly DNSSEC signed. Testing for NSEC3 has been skipped. Fetched from name servers "{ns_list}".
DS03_NO_NSEC3                      | INFO    | ns_list | The zone does not use NSEC3. Testing for NSEC3 has been skipped. Fetched from name servers "{ns_list}".
DS03_NSEC3_OPT_OUT_DISABLED        | INFO    | ns_list | The following servers respond with NSEC3 opt-out disabled (as recommended). Fetched from name servers "{ns_list}".
DS03_NSEC3_OPT_OUT_ENABLED_NON_TLD | NOTICE  | ns_list | The following servers respond with NSEC3 opt-out enabled (not recommended). Fetched from name servers "{ns_list}".
DS03_NSEC3_OPT_OUT_ENABLED_TLD     | INFO    | ns_list | The following servers respond with NSEC3 opt-out enabled. Fetched from name servers "{ns_list}".
DS03_SERVER_NO_DNSSEC_SUPPORT      | ERROR   | ns_list | The following name servers do not support DNSSEC or have not been properly configured. Testing for NSEC3 has been skipped on those servers. Fetched from name servers "{ns_list}".
DS03_SERVER_NO_NSEC3               | ERROR   | ns_list | The following name servers do not use NSEC3, but others do. Testing for NSEC3 has been skipped on the following servers. Fetched from name servers "{ns_list}".
DS03_UNASSIGNED_FLAG_USED          | ERROR   | ns_list, int | The following servers respond with an NSEC3 record where an unassigned flag is used (flag {int}). Fetched from name servers "{ns_list}".

The value in the Level column is the default severity level of the message. The
severity level can be changed in the [Zonemaster-Engine profile]. Also see the
[Severity Level Definitions] document.

The argument names in the Arguments column lists the arguments used in the
message. The argument names are defined in the [argument list].

The name server names are assumed to be available at the time when the msgid
is created, if the argument name is "ns" or "ns_list" even when in the
"[Test procedure]" below it is only referred to the IP address of the name
servers.


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

3.  Retrieve all name server names and IP addresses for the
    *Child Zone* using [Method4] and [Method5] ("NS IP").

3.  Create the following empty sets:

    1.  Name server IP address ("Responds Without DNSKEY").
    2.  Name server IP address ("Responds With DNSKEY").
    3.  Name server IP address ("Responds Without NSEC3").
    4.  Name server IP address ("Responds With NSEC3").
    5.  Name server IP address ("Multiple NSEC3").
    6.  Name server IP address and NSEC3 hash algorithm ("Hash Algorithm").
    7.  Name server IP address and NSEC3 flags ("NSEC3 Flags").
    8.  Name server IP address and NSEC3 iterations value ("NSEC3 Iterations").
    9.  Name server IP address and NSEC3 salt length ("NSEC3 Salt Length").

6.  For each name server IP address in *NS IP* do:

    1. Send *DNSKEY Query* to the name server IP.
    2. If at least one of the following criteria is met, then go to next name
       server IP:
       1. There is no DNS response.
       2. The [RCODE Name] in the response is not "NoError".
       3. The AA flag is not set in the response.
    3. If the response does not contain any DNSKEY record with owner name
       matching *Child Zone* in the answer section, add name server IP to the
       *Responds Without DNSKEY* set and go to next name server.
    4. Add name server IP to the *Responds With DNSKEY* set.
    5. Send *NSEC Query* to the name server IP and do:

       1. If the authority section contains no NSEC3 record then add the name
          server IP to the *Responds Without NSEC3* set and go to next name
          server.
       2. Else do:
          1. If there are more than one NSEC record in the authority section then
             add name server IP to the *Multiple NSEC3* set and use one of them
             for the following steps.
          2. Add name server IP to the *Responds With NSEC3* set.
          3. Extract the NSEC3 hash algorithm and add it and the name server IP
             to the *Hash Algorithm* set.
          4. Extract the NSEC3 flags and add them and the name server IP to the
             *NSEC3 flags* set.
          5. Extract the NSEC3 hash iterations value and add it and the name
             server IP to the *NSEC3 Iterations* set.
          6. Extract the NSEC3 salt length and add it and the name server IP to
             the *NSEC3 Salt Length* set.

7.  If the *Responds With DNSKEY* set is empty and the *Responds Without DNSKEY*
    is non-empty then output *[DS03_NO_DNSSEC_SUPPORT]* with the name server IP
    addresses from the *Responds Without DNSKEY* set.

8.  If both the *Responds With DNSKEY* set and the *Responds Without DNSKEY* set
    are non-empty then output *[DS03_SERVER_NO_DNSSEC_SUPPORT]* with the name
    server IP addresses from the *Responds Without DNSKEY* set.

9.  If the *Responds With NSEC3* set is empty and the *Responds Without NSEC3*
    is non-empty then output *[DS03_NO_NSEC3]* with the name server IP
    addresses from the *Responds Without NSEC3* set.

10. If both the *Responds With NSEC3* set and the *Responds Without NSEC3*
    are non-empty then output *[DS03_SERVER_NO_NSEC3]* with the name server IP
    addresses from the *Responds Without NSEC3* set.

11. If the *Multiple NSEC3* set is non-empty then output *[DS03_ERR_MULT_NSEC3]*
    with the name server IP addresses from the set.

12. If the *Hash Algorithm* set is non-empty then do:
    1. If the set has more than one hash algorithm value then output
       *[DS03_INCONSISTENT_HASH_ALGO]*.
    2. For each algorithm value do:
       1. If the value is 1 output *[DS03_LEGAL_HASH_ALGO]* with the name servers
          IP addresses from the set with that value.
       2. Else, output *[DS03_ILLEGAL_HASH_ALGO]* with the hash algorithm value
          and the name servers IP addresses from the set with that value.

13. If the *NSEC3 Flags* set is non-empty then do:
    1. If the set has more than one flag list value then output
       *[DS03_INCONSISTENT_NSEC3_FLAGS]*.
    2. For each flag list value do:
       1. If any flag 0-6 (bits 0-6) is set then for each such flag output
          *[DS03_UNASSIGNED_FLAG_USED]* with the flag (bit) number and the name
          server IP addresses from the flag list value where the bit is set.
       2. If flag 7 (bit 7) is set, then do:
          1. If *Child Zone* is the root zone, a TLD zone or a zone matching
             *Public Suffix List Data* then output
             *[DS03_NSEC3_OPT_OUT_ENABLED_TLD]* with the name servers IP
             addresses from the set with that flag list value.
          2. Else, output *[DS03_NSEC3_OPT_OUT_ENABLED_NON_TLD]* with the name
             servers IP addresses from the set with that flag list value.
       3. Else, output *[DS03_NSEC3_OPT_OUT_DISABLED]* with the name servers IP
             addresses from the set with that flag list value.

13. If the *NSEC3 Iterations* set is non-empty then do:
    1. If the set has more than one iteration value then output
       *[DS03_INCONSISTENT_ITERATION]*.
    2. For each iteration value do:
       1. If the value is 0 output *[DS03_LEGAL_ITERATION_VALUE]* with the name
          servers IP addresses from the set with that iteration value.
       2. Else, output *[DS03_ILLEGAL_ITERATION_VALUE]* with the value and the
          name servers IP addresses from the set with that iteration value.

13. If the *NSEC3 Salt Length* set is non-empty then do:
    1. If the set has more than one salt length then output
       *[DS03_INCONSISTENT_SALT_LENGTH]*.
    2. For each iteration value do:
       1. If the length is 0 output *[DS03_LEGAL_EMPTY_SALT]* with the name
          servers IP addresses from the set with that salt length.
       2. Else, output *[DS03_ILLEGAL_SALT_LENGTH]* with the length and the
          name servers IP addresses from the set with that salt length.

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
[CRITICAL]:                                   ../SeverityLevelDefinitions.md#critical
[Connectivity01]:                             ../Connectivity-TP/connectivity01.md
[DNS Query and Response Defaults]:            ../DNSQueryAndResponseDefaults.md
[DNSSEC Query]:                               ../DNSQueryAndResponseDefaults.md#default-setting-in-dnssec-query
[DNSSEC README]:                              README.md
[DNSSEC Response]:                            ../DNSQueryAndResponseDefaults.md#default-handling-of-a-dnssec-response
[DS03_ERR_MULT_NSEC3]:                        #summary
[DS03_ILLEGAL_HASH_ALGO]:                     #summary
[DS03_ILLEGAL_ITERATION_VALUE]:               #summary
[DS03_ILLEGAL_SALT_LENGTH]:                   #summary
[DS03_INCONSISTENT_HASH_ALGO]:                #summary
[DS03_INCONSISTENT_ITERATION]:                #summary
[DS03_INCONSISTENT_NSEC3_FLAGS]:              #summary
[DS03_INCONSISTENT_SALT_LENGTH]:              #summary
[DS03_LEGAL_EMPTY_SALT]:                      #summary
[DS03_LEGAL_HASH_ALGO]:                       #summary
[DS03_LEGAL_ITERATION_VALUE]:                 #summary
[DS03_NO_DNSSEC_SUPPORT]:                     #summary
[DS03_NO_NSEC3]:                              #summary
[DS03_NSEC3_OPT_OUT_DISABLED]:                #summary
[DS03_NSEC3_OPT_OUT_ENABLED_NON_TLD]:         #summary
[DS03_NSEC3_OPT_OUT_ENABLED_TLD]:             #summary
[DS03_SERVER_NO_DNSSEC_SUPPORT]:              #summary
[DS03_SERVER_NO_NSEC3]:                       #summary
[DS03_UNASSIGNED_FLAG_USED]:                  #summary
[ERROR]:                                      ../SeverityLevelDefinitions.md#error
[IANA NSEC3 Parameters registry]:             https://www.iana.org/assignments/dnssec-nsec3-parameters/dnssec-nsec3-parameters.xhtml
[IANA RR Type List]:                          https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-4
[INFO]:                                       ../SeverityLevelDefinitions.md#info
[Method4]:                                    ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                                    ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[NOTICE]:                                     ../SeverityLevelDefinitions.md#notice
[Public Suffix List data]:                    https://publicsuffix.org/list/public_suffix_list.dat
[Public Suffix List]:                         https://publicsuffix.org/list/
[RCODE Name]:                                 https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[RFC 5155#section-11]:                        https://www.rfc-editor.org/rfc/rfc5155.html#section-11
[RFC 5155#section-3]:                         https://www.rfc-editor.org/rfc/rfc5155.html#section-3
[RFC 5155]:                                   https://www.rfc-editor.org/rfc/rfc5155.html
[RFC 9276#section-2.4]:                       https://www.rfc-editor.org/rfc/rfc9276.html#section-2.4
[RFC 9276#section-3.1]:                       https://www.rfc-editor.org/rfc/rfc9276.html#section-3.1
[RFC 9276]:                                   https://www.rfc-editor.org/rfc/rfc9276.html
[Severity Level Definitions]:                 ../SeverityLevelDefinitions.md
[Test procedure]:                             #test-procedure
[WARNING]:                                    ../SeverityLevelDefinitions.md#warning
[Zonemaster-Engine profile]:                  ../../../configuration/profiles.md
