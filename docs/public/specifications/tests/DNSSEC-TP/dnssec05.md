# DNSSEC05: Check for invalid DNSKEY algorithms

## Test case identifier
**DNSSEC05**


## Table of contents

* [Objective](#Objective)
* [Scope](#Scope)
* [Classification of algorithms]
* [Inputs](#Inputs)
* [Summary]
* [Test procedure]
* [Outcome(s)](#Outcomes)
* [Special procedural requirements](#Special-procedural-requirements)
* [Intercase dependencies](#Intercase-dependencies)
* [Terminology](#terminology)


## Objective

A domain name (zone) should only use DNSKEY algorithms that are specified by
[RFC 8624][RFC 8624#3.1], section 3.1 (including the update in
[RFC 9157][RFC 9157#upd-8624]) and the [IANA registry][IANA DNSSEC algo num] of
*DNSSEC Algorithm Numbers* to be used for DNSSEC signing. A public domain name
(zone) should not use private algorithms.


## Scope

It is assumed that *Child Zone* is also tested by [Connectivity01]. This test
case will just ignore non-responsive name servers or name servers not giving a
correct DNS response for an authoritative name server unless all such name
servers fail, in which case a message is outputted.

The RDATA of a DNSKEY record consists of four fields. The third field specifies
the algorithm number of the public key in the fourth field. This test case will only
check which algorithm is used by checking the third field. It will not verify
that the key is matching the algorithm.


## Classification of algorithms

In the table below, the first three columns are copied from the
[IANA registry][IANA DNSSEC algo num]. The fourth column is for Zonemaster
classification and it holds the relevant message tags listed in the
"[Summary]" section below. In the table below "mnemonic" is defined by Zonemaster
when undefined in the IANA table, which is available at
[IANA registry][IANA DNSSEC algo num].

The "Zonemaster classification" is based on the "Use for DNSSEC signing" in the
[IANA registry][IANA DNSSEC algo num] of *DNSSEC Algorithm Numbers*.

| Algorithm no | Algorithm (or description)       | Mnemonic           | Zonemaster classification | Note |
|:-------------|:---------------------------------|:-------------------|:--------------------------|:-----|
| 0            | Delete DS                        | DELETE             | DS05_ALGO_NOT_ZONE_SIGN   |      |
| 1            | RSA/MD5                          | RSAMD5             | DS05_ALGO_DEPRECATED      |      |
| 2            | Diffie-Hellman                   | DH                 | DS05_ALGO_NOT_ZONE_SIGN   |      |
| 3            | DSA/SHA1                         | DSA                | DS05_ALGO_DEPRECATED      |      |
| 4            | Reserved                         | RESERVED           | DS05_ALGO_RESERVED        | (1)  |
| 5            | RSA/SHA-1                        | RSASHA1            | DS05_ALGO_DEPRECATED      |      |
| 6            | DSA-NSEC3-SHA1                   | DSA-NSEC3-SHA1     | DS05_ALGO_DEPRECATED      |      |
| 7            | RSASHA1-NSEC3-SHA1               | RSASHA1-NSEC3-SHA1 | DS05_ALGO_DEPRECATED      |      |
| 8            | RSA/SHA-256                      | RSASHA256          | DS05_ALGO_OK              |      |
| 9            | Reserved                         | RESERVED           | DS05_ALGO_RESERVED        | (1)  |
| 10           | RSA/SHA-512                      | RSASHA512          | DS05_ALGO_NOT_RECOMMENDED |      |
| 11           | Reserved                         | RESERVED           | DS05_ALGO_RESERVED        | (1)  |
| 12           | GOST R 34.10-2001                | ECC-GOST           | DS05_ALGO_DEPRECATED      |      |
| 13           | ECDSA Curve P-256 with SHA-256   | ECDSAP256SHA256    | DS05_ALGO_OK              |      |
| 14           | ECDSA Curve P-384 with SHA-384   | ECDSAP384SHA384    | DS05_ALGO_OK              |      |
| 15           | Ed25519                          | ED25519            | DS05_ALGO_OK              |      |
| 16           | Ed448                            | ED448              | DS05_ALGO_OK              |      |
| 17           | SM2 signing algo w SM3 hash algo | SM2SM3             | DS05_ALGO_OK              |      |
| 18-22        | Unassigned                       | UNASSIGNED         | DS05_ALGO_UNASSIGNED      | (1)  |
| 23           | GOST R 34.10-2012                | ECC-GOST12         | DS05_ALGO_OK              |      |
| 24-122       | Unassigned                       | UNASSIGNED         | DS05_ALGO_UNASSIGNED      | (1)  |
| 123-251      | Reserved                         | RESERVED           | DS05_ALGO_RESERVED        | (1)  |
| 252          | Reserved for Indirect Keys       | INDIRECT           | DS05_ALGO_NOT_ZONE_SIGN   |      |
| 253          | private algorithm                | PRIVATEDNS         | DS05_ALGO_PRIVATE         |      |
| 254          | private algorithm OID            | PRIVATEOID         | DS05_ALGO_PRIVATE         |      |
| 255          | Reserved                         | RESERVED           | DS05_ALGO_RESERVED        | (1)  |

(1) Mnemonic defined for Zonemaster usage when undefined in the IANA table.


## Inputs

* The domain name to be tested ("Child Zone").
* The table in section "[Classification of algorithms]" above.


## Summary

| Message Tag               | Level   | Arguments                                         | Message ID for message tag                                                                                                                                                  |
|:--------------------------|:--------|:--------------------------------------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| DS05_ALGO_DEPRECATED      | ERROR   | ns_list, keytag, algo_num, algo_descr, algo_mnemo | The DNSKEY with tag {keytag} uses deprecated algorithm number {algo_num} ("{algo_descr}", {algomnemo}), on name servers "{ns_list}".                                        |
| DS05_ALGO_NOT_RECOMMENDED | WARNING | ns_list, keytag, algo_num, algo_descr, algo_mnemo | The DNSKEY with tag {keytag} uses an algorithm number {algo_num} ("{algo_descr}", {algomnemo}), which is not recommended to be used. Fetched from name servers "{ns_list}". |
| DS05_ALGO_NOT_ZONE_SIGN   | ERROR   | ns_list, keytag, algo_num, algo_descr, algo_mnemo | The DNSKEY with tag {keytag} uses algorithm number not meant for zone signing, algorithm number {algo_num} ("{algo_descr}", {algomnemo}), on name servers "{ns_list}".      |
| DS05_ALGO_OK              | INFO    | ns_list, keytag, algo_num, algo_descr, algo_mnemo | The DNSKEY with tag {keytag} uses algorithm number {algo_num} ("{algo_descr}", {algomnemo}), which is OK. Fetched from name servers "{ns_list}".                            |
| DS05_ALGO_PRIVATE         | ERROR   | ns_list, keytag, algo_num                         | The DNSKEY with tag {keytag} uses algorithm number {algo_num} for private use on name servers "{ns_list}".                                                                  |
| DS05_ALGO_RESERVED        | ERROR   | ns_list, keytag, algo_num                         | The DNSKEY with tag {keytag} uses reserved algorithm number {algo_num} on name servers "{ns_list}".                                                                         |
| DS05_ALGO_UNASSIGNED      | ERROR   | ns_list, keytag, algo_num                         | The DNSKEY with tag {keytag} uses unassigned algorithm number {algo_num} on name servers "{ns_list}".                                                                       |
| DS05_NO_RESPONSE          | WARNING | ns_list                                           | No response or error in response from all name servers on the DNSKEY query. Failing name servers: "{ns_list}".                                                              |
| DS05_SERVER_NO_DNSSEC     | ERROR   | ns_list                                           | Some name servers do not support DNSSEC or have not been properly configured. DNSKEY cannot be tested on those servers. Fetched from name servers "{ns_list}".              |
| DS05_ZONE_NO_DNSSEC       | NOTICE  | ns_list                                           | The zone is not DNSSEC signed or not properly DNSSEC signed. DNSKEY cannot be tested. Fetched from name servers "{ns_list}".                                                |

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
follows the specification for DNS queries as specified in
[DNS Query and Response Defaults]. The handling of the DNS responses on the DNS
queries follow, unless otherwise specified below, what is specified for
[DNSSEC Response] in the same specification.

A complete list of all DNS Resource Record types can be found in the
[IANA RR Type List].

1. Create a [DNSSEC Query] with query type DNSKEY and query name *Child Zone*
   ("DNSKEY Query").

2.  Retrieve all name server names and IP addresses for *Child Zone* using
    methods [Get-Del-NS-Names-and-IPs] and [Get-Zone-NS-Names-and-IPs]
    ("NS Name and IP").

3. The name server names are assumed to be available at the time when a `msgid`
   listed above in [Summary] is created. If the argument name is "ns" or
   "ns_list" the name server name is extracted from *NS Name and IP* even
   though it is only referred to the IP address of the name servers in the steps
   below. Furthermore, if there are more than one name server names for the same
   IP address, one entry is created for each name.

4.  Create the following empty sets:

    1.  Name server IP address ("Ignored NS IP")
    2.  Name server IP address ("Responds without valid DNSKEY")
    3.  Name server IP address ("Responds with DNSKEY")
    4.  Name server IP address, key tag and DNSKEY algorithm code ("DS05_ALGO_DEPRECATED")
    5.  Name server IP address, key tag and DNSKEY algorithm code ("DS05_ALGO_RESERVED")
    6.  Name server IP address, key tag and DNSKEY algorithm code ("DS05_ALGO_UNASSIGNED")
    7.  Name server IP address, key tag and DNSKEY algorithm code ("DS05_ALGO_NOT_RECOMMENDED")
    8.  Name server IP address, key tag and DNSKEY algorithm code ("DS05_ALGO_PRIVATE")
    9.  Name server IP address, key tag and DNSKEY algorithm code ("DS05_ALGO_NOT_ZONE_SIGN")
    10. Name server IP address, key tag and DNSKEY algorithm code ("DS05_ALGO_OK")

5.  For each unique name server IP address in *NS Name and IP* do:

    1. Send *DNSKEY Query* to the name server IP.
    2. Add the name server IP to the *Ignored NS IP* set and go to next name
       server IP if at least one of the following criteria is met:
       1. There is no DNS response.
       2. The [RCODE Name] in the response is not "NoError".
       3. The AA flag is not set in the response.
    3. If the response does not contain any valid DNSKEY record with owner name
       matching *Child Zone* in the answer section, add name server IP to the
       *Responds without valid DNSKEY* set and go to next server.
    4. Else, add name server IP to the *Responds with DNSKEY* set and retrieve
       valid DNSKEY records from the answer section.
    5. For each DNSKEY record retrieved do:
       1. Extract algorithm number from the third field of RDATA of the DNSKEY
          record.
       2. Calculate the key tag for the DNSKEY record.
       3. From section "[Classification of algorithms]" retrieve the table and
          extract the row matching the algorithm number.
       4. From the row extract the message tag from column "Zonemaster
          classification".
       5. Add name server IP, key tag and the algorithm code to the set with the
          same name as the extracted message tag.

6. For each of the sets matching each of the following message tags do if the set
   is non-empty:
   * For each combination of key tag and algorithm code do:
     * Output the message tag matching the set name with the list of name server
       IP from the subset (key tag and code) plus the key tag, the algorithm
       number, algorithm description and algorithm mnemonic from the table in
       section "[Classification of algorithms]". Exclude algorithm description
       and algorithm mnemonic if not listed for the tag in [Summary].
   * Sets:
     * *[DS05_ALGO_DEPRECATED]*
     * *[DS05_ALGO_RESERVED]*
     * *[DS05_ALGO_UNASSIGNED]*
     * *[DS05_ALGO_NOT_RECOMMENDED]*
     * *[DS05_ALGO_PRIVATE]*
     * *[DS05_ALGO_NOT_ZONE_SIGN]*
     * *[DS05_ALGO_OK]*

7. If the *Responds without valid DNSKEY* and *Responds with DNSKEY* sets are empty
   then output *[DS05_NO_RESPONSE]* with the list of name server IP addresses from
   the *Ignored NS IP* set.

8. If the *Responds without valid DNSKEY* is non-empty then do:
   1. If *Responds with DNSKEY* sets is empty then output *[DS05_ZONE_NO_DNSSEC]*
      with name server IP from the *Responds without valid DNSKEY* set.
   2. Else, output *[DS05_SERVER_NO_DNSSEC]* with name server IP from the
      *Responds without valid DNSKEY* set.


## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message with
the severity level *[ERROR]* or *[CRITICAL]*.

The outcome of this Test Case is "warning" if there is at least one message with
the severity level *[WARNING]*, but no message with severity level *ERROR* or
*CRITICAL*.

In other cases, no message or only messages with severity level *[INFO]* or
*[NOTICE]*, the outcome of this Test Case is "pass".


## Special procedural requirements

If either IPv4 or IPv6 transport is disabled, skip sending queries over that
transport protocol. A message will be outputted reporting that the transport
protocol has been skipped.

See the [DNSSEC README] document about DNSSEC algorithms.


## Intercase dependencies

None.


## Terminology

No special terminology for this Test Case.


[Argument list]:                                  ../ArgumentsForTestCaseMessages.md
[Classification of algorithms]:                   #classification-of-algorithms
[Connectivity01]:                                 ../Connectivity-TP/connectivity01.md
[DNS Query and Response Defaults]:                ../DNSQueryAndResponseDefaults.md
[DNSSEC Query]:                                   ../DNSQueryAndResponseDefaults.md#default-setting-in-dnssec-query
[DNSSEC README]:                                  ./README.md
[DNSSEC Response]:                                ../DNSQueryAndResponseDefaults.md#default-handling-of-a-dnssec-response
[DS05_ALGO_DEPRECATED]:                           #outcomes
[DS05_ALGO_NOT_RECOMMENDED]:                      #outcomes
[DS05_ALGO_NOT_ZONE_SIGN]:                        #outcomes
[DS05_ALGO_OK]:                                   #outcomes
[DS05_ALGO_PRIVATE]:                              #outcomes
[DS05_ALGO_RESERVED]:                             #outcomes
[DS05_ALGO_UNASSIGNED]:                           #outcomes
[DS05_NO_RESPONSE]:                               #outcomes
[DS05_SERVER_NO_DNSSEC]:                          #outcomes
[DS05_ZONE_NO_DNSSEC]:                            #outcomes
[Get-Del-NS-Names-and-IPs]:                       ../MethodsV2.md#method-get-delegation-ns-names-and-ip-addresses
[Get-Zone-NS-Names-and-IPs]:                      ../MethodsV2.md#method-get-zone-ns-names-and-ip-addresses
[IANA DNSSEC algo num]:                           https://www.iana.org/assignments/dns-sec-alg-numbers/dns-sec-alg-numbers.xml
[IANA RR Type List]:                              https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-4
[RCODE Name]:                                     https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[RFC 8624#3.1]:                                   https://www.rfc-editor.org/rfc/rfc8624.html#section-3.1
[RFC 9157#upd-8624]:                              https://www.rfc-editor.org/rfc/rfc9157#name-update-to-rfc-8624
[Severity Level Definitions]:                     ../SeverityLevelDefinitions.md
[Summary]:                                        #Summary
[Test procedure]:                                 #Test-procedure
[Zonemaster-Engine profile]:                      ../../../configuration/profiles.md
[CRITICAL]:                                       ../SeverityLevelDefinitions.md#critical
[ERROR]:                                          ../SeverityLevelDefinitions.md#error
[INFO]:                                           ../SeverityLevelDefinitions.md#info
[NOTICE]:                                         ../SeverityLevelDefinitions.md#notice
[WARNING]:                                        ../SeverityLevelDefinitions.md#warning
