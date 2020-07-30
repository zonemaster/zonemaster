# Test requirements

## Overview

Zonemaster is implemented as a number of test cases. Behind the test cases are
requirements on a DNS zone and its name servers. The requirements are derived
from the DNS protocol specifications and best practices. Each test case is
meant to verify one or a few of the requirements.

## Requirements

In the table below, all requirements behind the Zonemaster test cases are
listed. For each requirement there is a link to a reference and a link to
the specification of the Zonemaster test case that verifies that
requirement. In the test case specification more details are found.

This is not a static document. As DNS evolves and new issues are pointed
at requirements will be added, removed or modiefied just as the test cases.

<!-- When updating the table, read TestRequirements-table-specification.txt -->
<!-- START-TABLE -->
Req ID| Requirement specification                                                          | Reference           | Test case
:---- |:-----------------------------------------------------------------------------------|:--------------------|:----------------
R00100| A name server IP address should be globally routable on Internet.                  |                     |[ADDRESS01]
R00200| A name server IP address should be registered in the DNS reverse lookup tree.      |                     |[ADDRESS02]
R00300| A name server IP address reverse lookup entry should be valid.                     |[RFC1912]           |[ADDRESS03]
R00400| The zone name should consists of valid IDN or non-IDN ASCII labels (names).        |                     |[BASIC00]
R00500| IDN labels (names) should be valid.                                                |[RFC5890]           |[BASIC00]
R00600| Non-IDN ASCII labels (names) should be valid.                                      |[RFC1123] [RFC2782]|[BASIC00]
R00700| A DNS zone should have a parent zone from which it is delegated.                   |                     |[BASIC01]
R00800| A DNS zone should have at least one accessible name server that hosts it.          |                     |[BASIC02]
R00900| A name server for a zone should respond on a query.                                |                     |[BASIC04]
R01000| A name server for a zone should respond with SOA record on SOA query.              |[RFC2181]           |[BASIC04] [DELEGATION06]
R01100| A name server for a zone should respond with RCODE NoError on SOA query.           |                     |[BASIC04]
R01200| A name server for a zone should respond with AA flag set on SOA query.             |[RFC2181]           |[BASIC04]
R01300| A name server for a zone should respond with NS RRset on NS query.                 |[RFC2181]           |[BASIC04]
R01400| A name server for a zone should respond with RCODE NoError on NS query.            |                     |[BASIC04]
R01500| A name server for a zone should respond with AA flag set on NS query.              |[RFC2181]           |[BASIC04]
R01600| A name server should respond on port 53 over UDP.                                  |[RFC1035]           |[CONNECTIVITY01]
R01700| A name server should respond on port 53 over TCP.                                  |[RFC7766]           |[CONNECTIVITY02]
R01800| The name server IP addresses should be announce from different ASNs.               |[RFC2182]           |[CONNECTIVITY03]
R01900| The name server IP addresses should not be on the same subnet.                     |                     |[CONNECTIVITY03]
R02000| All name servers for a zone should respond with the same SOA serial number.        |[RFC1034]           |[CONSISTENCY01]
R02100| All name servers for a zone should respond with the same SOA RNAME value.          |[RFC1034]           |[CONSISTENCY02]
R02200| All name servers for a zone should respond with the same SOA REFRESH value.        |[RFC1034]           |[CONSISTENCY03]
R02300| All name servers for a zone should respond with the same SOA RETRY value.          |[RFC1034]           |[CONSISTENCY03]
R02400| All name servers for a zone should respond with the same SOA EXPIRE value.         |[RFC1034]           |[CONSISTENCY03]
R02500| All name servers for a zone should respond with the same SOA MINIMUM value.        |[RFC1034]           |[CONSISTENCY03]
R02600| All name servers for a zone should respond with the same NS RRset.                 |[RFC1034]           |[CONSISTENCY04]
R02700| The NS RRset in the delegation should be identical to the NS RRset in the zone.    |[RFC1034] [IANA]    |[CONSISTENCY05] [DELEGATION07]
R02800| All name servers for a zone should respond with the same SOA MNAME value.          |[RFC1034]           |[CONSISTENCY06]
R02900| The SOA MNAME value should point at the primary master server of the zone.         |[RFC1035]           |[CONSISTENCY06]
R03000| A zone should be hosted by at least two names servers (on IPv4).                   |[RFC1034]           |[DELEGATION01]
R03100| A zone should be hosted by at least two names servers (on IPv6).                   |                     |[DELEGATION01]
R03200| A zone should be hosted on IPv4.                                                   |[RFC3901] [RFC4472]|[DELEGATION01]
R03300| Name servers for a zone should have distinct IP addresses.                         |                     |[DELEGATION02]
R03400| Referral from parent name servers should fit into 512 octets.                      |[IANA]               |[DELEGATION03]
R03500| The name server for the zone should respond authoritively for the zone.            |[RFC2181]           |[DELEGATION04]
R03600| The name server name should not point at a CNAME.                                  |[RFC2181]           |[DELEGATION05]
R03700| Signed zone must have DNSKEY.                                                      |                     |
R03800| Only valid DS hash algorithm should be used.                                       |[RFC8624]           |[DNSSEC01]
R03900| If child zone is signed then parent zone should have DS record(s).                 |[RFC4035]           |[DNSSEC07]
R04000| DS at parent must match a DNSKEY at child.                                         |[RFC4035] [RFC6840]|[DNSSEC02]
R04100| Parent name server should respond with NoError on DS query.                        |                     |[DNSSEC02]
R04200| Parent name server should respond with AA on DS query.                             |                     |[DNSSEC02]
R04300| DNSKEY RRset should be signed by DNSKEY from RRset.                                |                     |[DNSSEC02]
R04400| DNSKEY(DS) should have SEP flag set.                                               |                     |[DNSSEC02]
R04500| RRSIG(DNSKEY RRset) should match appointed DNSKEY from DNSKEY RRset.               |                     |[DNSSEC02] [DNSSEC08]
R04600| The number of NSEC3 iterations should be limited.                                  |[RFC5155]           |[DNSSEC03]
R04700| RRSIG lifetime should not be too short.                                            |[RFC6781]           |[DNSSEC04]
R04800| RRSIG lifetime should not be too long.                                             |[RFC6781]           |[DNSSEC04]
R04900| Only valid DNSKEY algorithms should be used.                                       |[RFC8624]           |[DNSSEC05]
R05000| Query with DO set should include RRSIG in response for signed zone.                |[RFC4035]           |[DNSSEC06]
R05100| If the zone is signed, then there should be a DS record in the delegation.         |[RFC4035]           |[DNSSEC07]
R05200| Name servers should respond with NoError on DNSKEY query.                          |                     |[DNSSEC08]
R05300| Name servers should respond with AA on DNSKEY query.                               |                     |[DNSSEC08]
R05400| Name servers should respond with *one* DNSKEY RRset.                               |                     |[DNSSEC08]
R05500| RRSIG(SOA) should match appointed DNSKEY from DNSKEY RRset.                        |[RFC4035]           |[DNSSEC09]
R05600| NXDOMAIN response should include NSEC/NSEC3 for signed zone.                       |[RFC4035] [RFC5155]|[DNSSEC10]
R05700| NSEC and NSEC3 should not be mixed in responses.                                   |                     |[DNSSEC10]
R05800| NSEC/NSEC3 record should be signed by RRSIG.                                       |                     |[DNSSEC10]
R05900| If parent zone has DS record(s) then child zone must be signed.                    |                     |[DNSSEC11]
R06000| It should be possible to verify SOA using DS from parent as trust anchor.          |                     |[DNSSEC12]
R06100| It should be possible to verify NS using DS from parent as trust anchor.           |                     |[DNSSEC12]
R06200| It should be possible to verify DNSKEY using DS as trust anchor.                   |                     |[DNSSEC12]
R06300| Every algorithm represented in DNSKEY RRset must be used to sign the entire zone.  |[RFC6840]           | -
R06400| Every algorithm represented in DNSKEY RRset must be used to sign the SOA RRset.    |[RFC6840]           |[DNSSEC13]
R06500| Every algorithm represented in DNSKEY RRset must be used to sign the NS RRset.     |[RFC6840]           |[DNSSEC13]
R06600| Every algorithm represented in DNSKEY RRset must be used to sign the DNSKEY RRset. |[RFC6840]           |[DNSSEC13]
R06700| DNSKEY of type RSASHA1 (5) should have a key size of 512 to 4096 bits.             |[RFC3110]           |[DNSSEC14]
R06800| DNSKEY of type RSASHA1-NSEC3-SHA1 (7) should have a key size of 512 to 4096 bits.  |[RFC5155]           |[DNSSEC14]
R06900| DNSKEY of type RSASHA256 (8) should have a key size of 512 to 4096 bits.           |[RFC5702]           |[DNSSEC14]
R07000| DNSKEY of type RSASHA512 (10) should have a key size of 1024 to 4096 bits.         |[RFC5702]           |[DNSSEC14]
R07100| A name server hosting a zone should not also be a recursive name server.           |[RFC5358] [RFC2870]|[NAMESERVER01]
R07200| A name server should support EDNS.                                                 |                     |[NAMESERVER02]
R07300| A name server not supporting EDNS should respond with FORMERR.                     |[RFC6891]           |[NAMESERVER02]
R07400| A name server should not support open zone transfer for its zone or zones.         |                     |[NAMESERVER03]
R07500| A name server should respond with the same source IP as the query was sent to.     |[RFC2181]           |[NAMESERVER04]
R07600| A name server should handle queries for AAAA correctly.                            |[RFC4074]           |[NAMESERVER05]
R07700| The name of the name server, as given in the NS record, must be resolvable in DNS. |[RFC1035]           |[NAMESERVER06]
R07800| A name server should not return a referal to root on queries for zones not hosted. |                     |[NAMESERVER07]
R07900| A name server should preserve case of query name when creating response.           |Ref?                 |[NAMESERVER08]
R08000| A name server should treat query name without considering character case.          |Ref?                 |[NAMESERVER09]
R08100| A name server should respond with BADVERS on unsupported EDNS version.             |[RFC6891]           |[NAMESERVER10]
R08200| A name server should completely ignore unsupported EDNS OPTION-CODE.               |[RFC6891]           |[NAMESERVER11]
R08300| A name server should completely ignore unsupported ENDS flag bit (Z flag bits).    |[RFC6891]           |[NAMESERVER12]
R08400| A name server with EDNS support should include OPT record in truncated response.   |[RFC6891]           |[NAMESERVER13]
R08500| A name server should respond with BADVERS and ignore OPTION-CODE on query with unsupported EDNS version and unsupported OPTION-CODE.|[RFC6891]|[NAMESERVER14]
R08600| The zone (domain) name should only contain legal characters. |[RFC1035] [RFC1123] [RFC2182] [RFC3696]|[SYNTAX01]
R08700| No label of the zone name should start or end with hyphen ("-"). |[RFC1035] [RFC1123] [RFC2182] [RFC3696]|[SYNTAX02]
R08800| No label of the zone name should have "--" in positions 3 and 4 unless it starts with "xn--". |[RFC3696]|[SYNTAX03]
R08900| If the zone name has a label that starts with "xn--" it should be a valid A-label. |                     |
R09000| If the zone name has an IDN label, its U-label should be valid.                    |                     |
R09100| If the zone name has an IDN label, its U-label should not start or end with hyphen ("-").  |             |
R09200| If the zone name has an IDN label, its U-label should not have "--" om positions 3 and 4.  |             |
R09300| If the zone name has an IDN label, its U-label should not have UNASSIGNED or DISALLOWED characters.  |   |
R09400| If the zone name has an IDN label, any CONTEXTO or CONTEXTJ character in its U-label must follow the rules.  |   |
R09500| The names of the server names of the zone must be valid hostnames.   |[RFC0952] [RFC1123] [RFC2182] [RFC3696]|[SYNTAX04]
R09600| In the SOA RNAME field there should be no "@" character.                           |[RFC1035]           |[SYNTAX05]
R09700| The SOA RNAME field should, after conversion, be a valid email address.            |[RFC1035] [RFC1912] [RIPE-203]|[SYNTAX06]
R09800| The SOA MNAME should be a valid hostname.                            |[RFC0952] [RFC1123] [RFC2182] [RFC3696]|[SYNTAX07]
R09900| The MX record or records of apex, if any, should have valid domain names for the mail target.|[RFC0952] [RFC1123] [RFC2182] [RFC3696]|[SYNTAX08]
R10000| The SOA MNAME field should be a fully qualified master name server of the zone.    |[RFC1035] [RIPE-203]|[ZONE01]
R11000| The SOA REFRESH value should be at least 4 hours.                                  |[RFC1912] [RIPE-203]|[ZONE02]
R12000| The SOA RETRY value should be lower than the REFRESH value.                        |[RFC1912] [RIPE-203]|[ZONE03]
R13000| The SOA RETRY value should be at least 1 hour.                                     |[RFC1912] [RIPE-203]|[ZONE04]
R14000| The SOA EXPIRE value should be at least 2 weeks (1,209,600 sec).                   |[RFC1912] [RIPE-203]|[ZONE05]
R15000| The SOA MINUMUM value should be at least 300 sec and not more than 86400 sec.      |[RFC1912] [RIPE-203]|[ZONE06]
R16000| The SOA MNAME field should not point at a CNAME.                                   |                     |[ZONE07]
R17000| The mail exchange field in MX records should not point at a CNAME.                 |[RFC2181] [RFC5321]|[ZONE08]
R18000| Apex of every zone should be a valid mail domain.                                  |[RFC2142]           |[ZONE09]
R19000| The should be exactly one SOA record in every zone.                                |[RFC1035]           |[ZONE10]
<!-- END-TABLE -->
<!-- When updating the table, read TestRequirements-table-specification.txt -->



[ADDRESS01]:      ../specifications/tests/Address-TP/address01.md
[ADDRESS02]:      ../specifications/tests/Address-TP/address02.md
[ADDRESS03]:      ../specifications/tests/Address-TP/address03.md
[BASIC00]:        ../specifications/tests/Basic-TP/basic00.md
[BASIC01]:        ../specifications/tests/Basic-TP/basic01.md
[BASIC02]:        ../specifications/tests/Basic-TP/basic02.md
[BASIC04]:        ../specifications/tests/Basic-TP/basic04.md
[CONNECTIVITY01]: ../specifications/tests/Connectivity-TP/connectivity01.md
[CONNECTIVITY02]: ../specifications/tests/Connectivity-TP/connectivity02.md
[CONNECTIVITY03]: ../specifications/tests/Connectivity-TP/connectivity03.md
[CONSISTENCY01]:  ../specifications/tests/Consistency-TP/consistency01.md
[CONSISTENCY02]:  ../specifications/tests/Consistency-TP/consistency02.md
[CONSISTENCY03]:  ../specifications/tests/Consistency-TP/consistency03.md
[CONSISTENCY04]:  ../specifications/tests/Consistency-TP/consistency04.md
[CONSISTENCY05]:  ../specifications/tests/Consistency-TP/consistency05.md
[CONSISTENCY06]:  ../specifications/tests/Consistency-TP/consistency06.md
[DELEGATION01]:   ../specifications/tests/Delegation-TP/delegation01.md
[DELEGATION02]:   ../specifications/tests/Delegation-TP/delegation02.md
[DELEGATION03]:   ../specifications/tests/Delegation-TP/delegation03.md
[DELEGATION04]:   ../specifications/tests/Delegation-TP/delegation04.md
[DELEGATION05]:   ../specifications/tests/Delegation-TP/delegation05.md
[DELEGATION06]:   ../specifications/tests/Delegation-TP/delegation06.md
[DELEGATION07]:   ../specifications/tests/Delegation-TP/delegation07.md
[DNSSEC01]:       ../specifications/tests/DNSSEC-TP/dnssec01.md
[DNSSEC02]:       ../specifications/tests/DNSSEC-TP/dnssec02.md
[DNSSEC03]:       ../specifications/tests/DNSSEC-TP/dnssec03.md
[DNSSEC04]:       ../specifications/tests/DNSSEC-TP/dnssec04.md
[DNSSEC05]:       ../specifications/tests/DNSSEC-TP/dnssec05.md
[DNSSEC06]:       ../specifications/tests/DNSSEC-TP/dnssec06.md
[DNSSEC07]:       ../specifications/tests/DNSSEC-TP/dnssec07.md
[DNSSEC08]:       ../specifications/tests/DNSSEC-TP/dnssec08.md
[DNSSEC09]:       ../specifications/tests/DNSSEC-TP/dnssec09.md
[DNSSEC10]:       ../specifications/tests/DNSSEC-TP/dnssec10.md
[DNSSEC11]:       ../specifications/tests/DNSSEC-TP/dnssec11.md
[DNSSEC12]:       ../specifications/tests/DNSSEC-TP/dnssec12.md
[DNSSEC13]:       ../specifications/tests/DNSSEC-TP/dnssec13.md
[DNSSEC14]:       ../specifications/tests/DNSSEC-TP/dnssec14.md
[IANA]:           https://www.iana.org/help/nameserver-requirements
[NAMESERVER01]:   ../specifications/tests/Nameserver-TP/nameserver01.md
[NAMESERVER02]:   ../specifications/tests/Nameserver-TP/nameserver02.md
[NAMESERVER03]:   ../specifications/tests/Nameserver-TP/nameserver03.md
[NAMESERVER04]:   ../specifications/tests/Nameserver-TP/nameserver04.md
[NAMESERVER05]:   ../specifications/tests/Nameserver-TP/nameserver05.md
[NAMESERVER06]:   ../specifications/tests/Nameserver-TP/nameserver06.md
[NAMESERVER07]:   ../specifications/tests/Nameserver-TP/nameserver07.md
[NAMESERVER08]:   ../specifications/tests/Nameserver-TP/nameserver08.md
[NAMESERVER09]:   ../specifications/tests/Nameserver-TP/nameserver09.md
[NAMESERVER10]:   ../specifications/tests/Nameserver-TP/nameserver10.md
[NAMESERVER11]:   ../specifications/tests/Nameserver-TP/nameserver11.md
[NAMESERVER12]:   ../specifications/tests/Nameserver-TP/nameserver12.md
[NAMESERVER13]:   ../specifications/tests/Nameserver-TP/nameserver13.md
[NAMESERVER14]:   ../specifications/tests/Nameserver-TP/nameserver14.md
[RFC0952]:       https://tools.ietf.org/html/rfc952
[RFC1034]:       https://tools.ietf.org/html/rfc1034
[RFC1035]:       https://tools.ietf.org/html/rfc1035
[RFC1123]:       https://tools.ietf.org/html/rfc1123
[RFC1912]:       https://tools.ietf.org/html/rfc1912
[RFC2142]:       https://tools.ietf.org/html/rfc2142
[RFC2181]:       https://tools.ietf.org/html/rfc2181
[RFC2182]:       https://tools.ietf.org/html/rfc2182
[RFC2782]:       https://tools.ietf.org/html/rfc2782
[RFC2870]:       https://tools.ietf.org/html/rfc2870
[RFC3110]:       https://tools.ietf.org/html/rfc3110
[RFC3696]:       https://tools.ietf.org/html/rfc3696
[RFC3901]:       https://tools.ietf.org/html/rfc3901
[RFC4035]:       https://tools.ietf.org/html/rfc4035
[RFC4074]:       https://tools.ietf.org/html/rfc4074
[RFC4472]:       https://tools.ietf.org/html/rfc4472
[RFC5155]:       https://tools.ietf.org/html/rfc5155
[RFC5321]:       https://tools.ietf.org/html/rfc5321
[RFC5358]:       https://tools.ietf.org/html/rfc5358
[RFC5702]:       https://tools.ietf.org/html/rfc5702
[RFC5890]:       https://tools.ietf.org/html/rfc5890
[RFC6781]:       https://tools.ietf.org/html/rfc6781
[RFC6840]:       https://tools.ietf.org/html/rfc6840
[RFC6891]:       https://tools.ietf.org/html/rfc6891
[RFC7766]:       https://tools.ietf.org/html/rfc7766
[RFC8624]:       https://tools.ietf.org/html/rfc8624
[RIPE-203]:       https://www.ripe.net/publications/docs/ripe-203
[SYNTAX01]:       ../specifications/tests/Syntax-TP/syntax01.md
[SYNTAX02]:       ../specifications/tests/Syntax-TP/syntax02.md
[SYNTAX03]:       ../specifications/tests/Syntax-TP/syntax03.md
[SYNTAX04]:       ../specifications/tests/Syntax-TP/syntax04.md
[SYNTAX05]:       ../specifications/tests/Syntax-TP/syntax05.md
[SYNTAX06]:       ../specifications/tests/Syntax-TP/syntax06.md
[SYNTAX07]:       ../specifications/tests/Syntax-TP/syntax07.md
[SYNTAX08]:       ../specifications/tests/Syntax-TP/syntax08.md
[ZONE01]:         ../specifications/tests/Zone-TP/zone01.md
[ZONE02]:         ../specifications/tests/Zone-TP/zone02.md
[ZONE03]:         ../specifications/tests/Zone-TP/zone03.md
[ZONE04]:         ../specifications/tests/Zone-TP/zone04.md
[ZONE05]:         ../specifications/tests/Zone-TP/zone05.md
[ZONE06]:         ../specifications/tests/Zone-TP/zone06.md
[ZONE07]:         ../specifications/tests/Zone-TP/zone07.md
[ZONE08]:         ../specifications/tests/Zone-TP/zone08.md
[ZONE09]:         ../specifications/tests/Zone-TP/zone09.md
[ZONE10]:         ../specifications/tests/Zone-TP/zone10.md


