# DNSSEC01: Legal values for the DS hash digest algorithm


## Test case identifier
**DNSSEC01**


## Table of contents

* [Objective](#objective)
* [Scope](#scope)
* [Classification of algorithms]
* [Inputs](#inputs)
* [Summary]
* [Test procedure](#test-procedure)
* [Outcome(s)](#outcomes)
* [Special procedural requirements](#special-procedural-requirements)
* [Intercase dependencies](#intercase-dependencies)
* [Terminology](#terminology)


## Objective

A parent zone should only use digest algorithms for DS records that are
specified by specified by [RFC 8624][RFC 8624#3.3], section 3.3 (including the
update in [RFC 9157][RFC 9157#upd-8624]), and is published in the [IANA
registry][IANA registry on DS Digest Algorithm] of *DS RR Type Digest
Algorithms*. No DS Digest Algorithm values, other than those specified in the
RFC and allocated by IANA, should be used in public DNS.

A DS record for a public domain name (zone) should not use private digestet
algorithms.

Both [RFC 8624][RFC 8624#3.3] and [IANA registry][IANA registry on DS Digest
Algorithm] recommends digest algorithm 2 (SHA-256) to be used, and if there is a
DS record for a DNSKEY, but no DS record based on that digest algorithm, a
message is outputted as a NOTICE.


## Scope

This test case will query the name servers of the parent zone, and will just
ignore non-responsive name servers or name servers not giving a correct DNS
response for an authoritative name server, unless all such names servers fail in
which case a message is outputted.

The RDATA of a DS record consists of four fields. The third field specifies the
digest algorithm number of the data in the fourth field. This test case will
only check what the algorithm is used by checking the third field. It will not
verify that the key is matching the algorithm.

This test case does not report if the parent servers give inconsistent
responses.

If the *Child Zone* is the root zone, then it has no parent zone, and no DS
records can be fetch, but DS can be provided as *Undelegated DS*.

If *Undelegated DS* or *Undelegated NS* has been submitted, parent zone is not
queried for DS. *Undelegated DS*, if any, is used instead.


## Classification of algorithms

In the table below, the first two columns are copied from the [IANA
registry][IANA registry on DS Digest Algorithm], where the complete IANA table
can be found. The third column is for Zonemaster classification and it holds the
the relevant message tags listed in the "[Summary]" section below.

The "Zonemaster classification" is based on the "Use for DNSSEC delegation" in
the [IANA registry][IANA registry on DS Digest Algorithm] of *DS Digest
Algorithms*.

| Algorithm number | Algorithm (or description) | Zonemaster classification |
|:-----------------|:---------------------------|:--------------------------|
| 0                | Reserved                   | DS01_DS_ALGO_NOT_DS       |
| 1                | SHA-1                      | DS01_DS_ALGO_DEPRECATED   |
| 2                | SHA-256                    | DS01_DS_ALGO_OK           |
| 3                | GOST R 34.11-94            | DS01_DS_ALGO_DEPRECATED   |
| 4                | SHA-384                    | DS01_DS_ALGO_OK           |
| 5                | GOST R 34.11-2012          | DS01_DS_ALGO_OK           |
| 6                | SM3                        | DS01_DS_ALGO_OK           |
| 7-127            | Unassigned                 | DS01_DS_ALGO_UNASSIGNED   |
| 128-252          | Reserved                   | DS01_DS_ALGO_RESERVED     |
| 253-254          | Reserved for Private Use   | DS01_DS_ALGO_PRIVATE      |
| 255              | Unassigned                 | DS01_DS_ALGO_UNASSIGNED   |


## Inputs

* "Child Zone" - The domain name to be tested.
* The table in section "[Classification of algorithms]" above.
* "Undelegated DS" - The DS record or records submitted. Empty unless submitted.
* "Undelegated Test" - TRUE if undelegated NS has been provided for the test.

## Summary

| Message Tag              | Level   | Arguments                                      | Message ID for message tag                                                                                                                                            |
|:-------------------------|:--------|:-----------------------------------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| DS01_DS_ALGO_2_MISSING   | NOTICE  | ns_ip_list, keytag                             | There is a DS record with keytag {keytag}. A DS record using digest algorithm 2 (SHA-256) is missing. Fetched from parent name servers "{ns_ip_list}".                |
| DS01_DS_ALGO_DEPRECATED  | ERROR   | ns_ip_list, keytag, ds_algo_num, ds_algo_descr | The DS record with keytag {keytag} uses a deprecated digest algorithm {ds_algo_num} ({ds_algo_descr}). Fetched from parent name servers "{ns_ip_list}".               |
| DS01_DS_ALGO_NOT_DS      | ERROR   | ns_ip_list, keytag, ds_algo_num, ds_algo_descr | The DS record with keytag {keytag} uses a digest algorithm {ds_algo_num} ({ds_algo_descr}) not meant for DS records. Fetched from parent name servers "{ns_ip_list}". |
| DS01_DS_ALGO_OK          | INFO    | ns_ip_list, keytag, ds_algo_num, ds_algo_descr | The DS record with keytag {keytag} uses digest algorithm {ds_algo_num} ({ds_algo_descr}), which is OK. Fetch from parent name servers "{ns_ip_list}".                 |
| DS01_DS_ALGO_PRIVATE     | ERROR   | ns_ip_list, keytag, ds_algo_num                | The DS record with keytag {keytag} uses a digest algorithm {ds_algo_num} for private use. Fetched from parent name servers "{ns_ip_list}".                            |
| DS01_DS_ALGO_RESERVED    | ERROR   | ns_ip_list, keytag, ds_algo_num                | The DS record with keytag {keytag} uses a reserved digest algorithm {ds_algo_num} on name servers "{ns_ip_list}".                                                     |
| DS01_DS_ALGO_UNASSIGNED  | ERROR   | ns_ip_list, keytag, ds_algo_num                | The DS record with keytag {keytag} uses an unassigned digest algorithm {ds_algo_num} on parent name servers "{ns_ip_list}".                                           |
| DS01_NO_RESPONSE         | WARNING | ns_ip_list                                     | No response or error in response from all parent name servers on the DS query. Name servers are "{ns_ip_list}".                                                       |
| DS01_PARENT_SERVER_NO_DS | ERROR   | ns_ip_list                                     | The following name servers do not provide DS record or have not been properly configured. Fetched from parent name servers "{ns_ip_list}".                            |
| DS01_PARENT_ZONE_NO_DS   | NOTICE  | ns_ip_list                                     | The parent zone provides no DS records for the child zone. Fetched from parent name servers "{ns_ip_list}".                                                           |
| DS01_ROOT_N_NO_UNDEL_DS  | INFO    |                                                | Tested zone is the root zone, but no undelegated DS has been provided. DS is not tested.                                                                              |
| DS01_UNDEL_N_NO_UNDEL_DS | INFO    |                                                | Tested zone is undelegated, but no undelegated DS has been provided. DS is not tested.                                                                                |

The value in the Level column is the default severity level of the message. The
severity level can be changed in the [Zonemaster-Engine profile]. Also see the
[Severity Level Definitions] document.

The argument names in the Arguments column lists the arguments used in the
message. The argument names are defined in the [argument list].


## Test procedure

In this section and unless otherwise specified below, the term "[DNSSEC Query]"
follows the specification for DNS queries as specified in
[DNS Query and Response Defaults]. The handling of the DNS responses on the DNS
queries follow, unless otherwise specified below, what is specified for
[DNSSEC Response] in the same specification.

1. Create a [DNSSEC Query] with query type DS and query name *Child Zone*
   ("DS Query").

2.  Retrieve all name server IP addresses for the parent of *Child Zone* using
    method [Get-Parent-NS-IP] ("Parent NS IP").

3.  Create the following empty sets:

    1.  Name server IP address ("Ignored Parent NS IP")
    2.  Name server IP address ("Responds Without Valid DS")
    3.  Name server IP address ("Responds With DS")
    4.  Name server IP address and key tag ("Non-Algo 2 DS")
    5.  Name server IP address and key tag ("Algo 2 DS")
    6.  Name server IP address, key tag and digest algorithm code ("DS01_DS_ALGO_DEPRECATED")
    7.  Name server IP address, key tag and digest algorithm code ("DS01_DS_ALGO_RESERVED")
    8.  Name server IP address, key tag and digest algorithm code ("DS01_DS_ALGO_UNASSIGNED")
    9.  Name server IP address, key tag and digest algorithm code ("DS01_DS_ALGO_PRIVATE")
    10. Name server IP address, key tag and digest algorithm code ("DS01_DS_ALGO_NOT_DS")
    11. Name server IP address, key tag and digest algorithm code ("DS01_DS_ALGO_OK")

4.  If *Undelegated DS* is non-empty then do:

    1. For each DS record in *Undelegated DS* do:
       1. Extract the digest algorithm code and key tag from the DS record.
       2. From section "[Classification of algorithms]" retrieve the table and
          extract the row matching the algorithm number.
       3. From the row extract the message tag from column "Zonemaster
          classification"
       4. Add name server IP as "-", key tag and the algorithm code to the set
          with the same name as the extracted message tag.
       5. If the digest algorithm code is 2 add IP address as "-" and the key tag
          to the *Algo 2 DS* set, else add IP address as "-" and the key tag to
          the *Non-Algo 2 DS* set.
    2. Add name server IP as "-" to the *Responds With DS* set.
    3. Make *Parent NS IP* an empty set.

>   Note: *Parent NS IP* will be empty if *Undelegated test* is TRUE, if
>   *Undelegated DS* is non-empty or if *Child Zone* is ".", i.e. root zone.

5.  For each name server IP in *Parent NS IP* do:
    1. Send *DS Query* to the name server IP.
    2. If at least one of the following criteria is met, then add name server IP
       to "Ignored Parent NS IP" and go to next parent name server:
       1. There is no [DNSSEC Response].
       2. The RCODE in the [DNSSEC Response] is not "NoError"
          ([IANA RCODE List]).
       3. The OPT record is absent in the [DNSSEC Response].
       4. The DO flag is unset in the [DNSSEC Response].
       5. The AA flag is not set in the [DNSSEC Response].
    3. If there is no valid DS record with matching owner name in the answer
       section of the [DNSSEC Response], then do:
       1. Add name server IP to "Responds Without Valid DS".
       2. Go to next parent name server.
    4. Add name server IP to the *Responds With DS* set.
    5. For each DS record in the answer section of the [DNSSEC Response] do:
       1. Extract the digest algorithm code and key tag from the DS record.
       2. From section "[Classification of algorithms]" retrieve the table and
          extract the row matching the algorithm number.
       3. From the row extract the message tag from column "Zonemaster
          classification"
       4. Add name server IP, key tag and the algorithm code to the set
          with the same name as the extracted message tag.
       5. If the digest algorithm code is 2 add IP address and the key tag to
          the *Algo 2 DS* set.
       6. Else, add IP address and the key tag to the *Non-Algo 2 DS* set.

6.  For each of the sets matching each of the following message tags do if the set
    is non-empty:
    * For each combination of key tag and digest algorithm code do:
      * Output the message tag matching the set name with the list of name server
        IP addresses from the subset (key tag and code) plus the key tag, the
        algorithm number and algorithm description from the table in section
        "[Classification of algorithms]". Exclude algorithm description if not
        listed for the tag in [Summary].
    * Sets:
      * *[DS01_DS_ALGO_DEPRECATED]*
      * *[DS01_DS_ALGO_RESERVED]*
      * *[DS01_DS_ALGO_UNASSIGNED]*
      * *[DS01_DS_ALGO_PRIVATE]*
      * *[DS01_DS_ALGO_NOT_DS]*
      * *[DS01_DS_ALGO_OK]*

7.  If the *Non-Algo 2 DS* set is non-empty do:
    1. For each pair of IP address and key tag in the *Algo 2 DS* set remove the
       same pair from the *Non-Algo 2 DS* set.
    2. For each key tag from the *Non-Algo 2 DS* set extract all IP addresses for
       the key tag and output DS01_DS_ALGO_2_MISSING with key tag and the
       extracted list of IP addresses.

8.  If the *Responds Without Valid DS* and *Responds With DS* sets are empty
    then output *[DS01_NO_RESPONSE]* with the name server IP from
    the *Ignored Parent NS IP* set.

9.  If the *Responds Without Valid DS* is non-empty then do:
    1. If the *Responds With DS* set is empty then output
       *[DS01_PARENT_ZONE_NO_DS]* with name server IP from the *Responds Without
       Valid DS* set.
    2. Else, output *[DS01_PARENT_SERVER_NO_DS]* with name server IP from the
       *Responds Without Valid DS* set.

10. If *Child Zone* is "." (i.e. root zone) and *Undelegated DS* is empty then
    output *[DS01_ROOT_N_NO_UNDEL_DS]*.

11. If *Undelegated Test* is TRUE and *Undelegated DS* is empty then output
    *[DS01_UNDEL_N_NO_UNDEL_DS]*.


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


[Argument list]:                                      ../ArgumentsForTestCaseMessages.md
[CRITICAL]:                                           ../SeverityLevelDefinitions.md#critical
[Classification of algorithms]:                       #classification-of-algorithms
[DNS Query and Response Defaults]:                    ../DNSQueryAndResponseDefaults.md
[DNSSEC Query]:                                       ../DNSQueryAndResponseDefaults.md#default-setting-in-dnssec-query
[DNSSEC README]:                                      README.md
[DNSSEC Response]:                                    ../DNSQueryAndResponseDefaults.md#default-handling-of-a-dnssec-response
[DS01_DS_ALGO_2_MISSING]:                             #summary
[DS01_DS_ALGO_DEPRECATED]:                            #summary
[DS01_DS_ALGO_NOT_DS]:                                #summary
[DS01_DS_ALGO_OK]:                                    #summary
[DS01_DS_ALGO_PRIVATE]:                               #summary
[DS01_DS_ALGO_RESERVED]:                              #summary
[DS01_DS_ALGO_UNASSIGNED]:                            #summary
[DS01_NO_RESPONSE]:                                   #summary
[DS01_PARENT_SERVER_NO_DS]:                           #summary
[DS01_PARENT_ZONE_NO_DS]:                             #summary
[DS01_ROOT_N_NO_UNDEL_DS]:                            #summary
[DS01_UNDEL_N_NO_UNDEL_DS]:                           #summary
[ERROR]:                                              ../SeverityLevelDefinitions.md#error
[Get-Parent-NS-IP]:                                   ../MethodsV2.md#method-get-parent-ns-ip-addresses
[IANA RCODE List]:                                    https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[IANA registry on DS Digest Algorithm]:               https://www.iana.org/assignments/ds-rr-types/ds-rr-types.xml
[INFO]:                                               ../SeverityLevelDefinitions.md#info
[NOTICE]:                                             ../SeverityLevelDefinitions.md#notice
[RFC 8624#3.3]:                                       https://datatracker.ietf.org/doc/html/rfc8624#section-3.3
[RFC 9157#upd-8624]:                                  https://www.rfc-editor.org/rfc/rfc9157#name-update-to-rfc-8624
[Severity Level Definitions]:                         ../SeverityLevelDefinitions.md
[Summary]:                                            #summary
[Undelegated]:                                        ../../test-types/undelegated-test.md
[WARNING]:                                            ../SeverityLevelDefinitions.md#warning
[Zonemaster-Engine profile]:                          ../../../configuration/profiles.md
