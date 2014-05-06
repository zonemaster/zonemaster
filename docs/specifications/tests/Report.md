## Report on Requirements to Test Case mapping

|Req|Requirement desription|Level     |Test Case ID|Test Description|
|:--|:---------------------|:---------|:-----------|:---------------|
|R01|       UDP connectivity|[Connectivity-TP](Connectivity-TP/level.md)|[CONNECTIVITY01](docs/specifications/tests/Connectivity-TP/connectivity01.md)| UDP connectivity|
|R02|       TCP connectivity|[Connectivity-TP](Connectivity-TP/level.md)|[CONNECTIVITY02](docs/specifications/tests/Connectivity-TP/connectivity02.md)| TCP connectivity|
|R03|address in a private network|[Address-TP](Address-TP/level.md)|[ADDRESS01](docs/specifications/tests/Address-TP/address01.md)|Name server address must be globally routable|
|R04|address should not be part of a bogon prefix|[Connectivity-TP](Connectivity-TP/level.md)|[CONNECTIVITY03](docs/specifications/tests/Connectivity-TP/connectivity03.md)|IPv6 address not part of bogon prefix|
|R05|illegal symbols in domain name|[ Syntax-TP](Syntax-TP/level.md)|[SYNTAX01](docs/specifications/tests/Syntax-TP/syntax01.md)|No illegal characters in the domain name|
|R06|dash ('-') at start or beginning of domain name|[ Syntax-TP](Syntax-TP/level.md)|[SYNTAX02](docs/specifications/tests/Syntax-TP/syntax02.md)|No hyphen ('-') at the start or end of the domain name|
|R07|double dash in domain name|[ Syntax-TP](Syntax-TP/level.md)|[SYNTAX03](docs/specifications/tests/Syntax-TP/syntax03.md)|There must be no double hyphen ('--') in position 3 and 4 of the domain name|
|R08|The child domain must have at least one working nameserver|**missing**|**missing**|      **missing**|
|R09|at least two nameservers for the domain|[Delegation-TP](Delegation-TP/level.md)|[DELEGATION01](docs/specifications/tests/Delegation-TP/delegation01.md)|Minimum number of name servers   |
|R10|    identical addresses|[Delegation-TP](Delegation-TP/level.md)|[DELEGATION02](docs/specifications/tests/Delegation-TP/delegation02.md)|Name servers must have distinct IP addresses|
|R11|nameserver addresses on same subnet|[Connectivity-TP](Connectivity-TP/level.md)|[CONNECTIVITY04](docs/specifications/tests/Connectivity-TP/connectivity04.md)|     AS Diversity|
|R12|nameserver addresses are all on the same subnet|[Connectivity-TP](Connectivity-TP/level.md)|[CONNECTIVITY04](docs/specifications/tests/Connectivity-TP/connectivity04.md)|     AS Diversity|
|R13|delegation response fit in a 512 byte UDP packet|[Delegation-TP](Delegation-TP/level.md)|[DELEGATION03](docs/specifications/tests/Delegation-TP/delegation03.md)|No truncation of referrals|
|R14|delegation response with additional fit in a 512 byte UDP packet|[Delegation-TP](Delegation-TP/level.md)|[DELEGATION03](docs/specifications/tests/Delegation-TP/delegation03.md)|No truncation of referrals|
|R15|      NS record present|**missing**|**missing**|      **missing**|
|R16|NS authoritative answer|[Delegation-TP](Delegation-TP/level.md)|[DELEGATION04](docs/specifications/tests/Delegation-TP/delegation04.md)|Name server is authoritative|
|R17|NS name has a valid domain/hostname syntax|[ Syntax-TP](Syntax-TP/level.md)|[SYNTAX04](docs/specifications/tests/Syntax-TP/syntax04.md)|The NS name must have a valid domain/hostname|
|R18|     NS is not an alias|[Delegation-TP](Delegation-TP/level.md)|[DELEGATION05](docs/specifications/tests/Delegation-TP/delegation05.md)|NS RR does not point to CNAME alias|
|R19|     NS can be resolved|**missing**|**missing**|      **missing**|
|R20|     SOA record present|[Delegation-TP](Delegation-TP/level.md)|[DELEGATION06](docs/specifications/tests/Delegation-TP/delegation06.md)| Existence of SOA|
|R21|SOA authoritative answer|[Delegation-TP](Delegation-TP/level.md)|[DELEGATION06](docs/specifications/tests/Delegation-TP/delegation06.md)| Existence of SOA|
|R22|missused '@' characters in SOA contact name|[ Syntax-TP](Syntax-TP/level.md)|[SYNTAX05](docs/specifications/tests/Syntax-TP/syntax05.md)|Misuse of '@' character in the SOA RNAME field|
|R23|illegal characters in SOA contact name|[ Syntax-TP](Syntax-TP/level.md)|[SYNTAX06](docs/specifications/tests/Syntax-TP/syntax06.md)|No illegal characters in the SOA RNAME field|
|R24|illegal characters in SOA master nameserver|[ Syntax-TP](Syntax-TP/level.md)|[SYNTAX07](docs/specifications/tests/Syntax-TP/syntax07.md)|No illegal characters in the SOA MNAME field|
|R25|fully qualified master nameserver in SOA|[   Zone-TP](Zone-TP/level.md)|[ZONE01](docs/specifications/tests/Zone-TP/zone01.md)|Fully qualified master nameserver in SOA|
|R26|SOA 'refresh' at least 6 hours|[   Zone-TP](Zone-TP/level.md)|[ZONE02](docs/specifications/tests/Zone-TP/zone02.md)|SOA 'refresh' minimum value|
|R27|SOA 'retry' lower than 'refresh'|[   Zone-TP](Zone-TP/level.md)|[ZONE03](docs/specifications/tests/Zone-TP/zone03.md)|SOA 'retry' lower than 'refresh'|
|R28|SOA 'retry' at least 1 hour|[   Zone-TP](Zone-TP/level.md)|[ZONE04](docs/specifications/tests/Zone-TP/zone04.md)|SOA 'retry' at least 1 hour|
|R29|SOA 'expire' at least 7 days|[   Zone-TP](Zone-TP/level.md)|[ZONE05](docs/specifications/tests/Zone-TP/zone05.md)|SOA 'expire' minimum value|
|R31|SOA 'minimum' less than 1 day|[   Zone-TP](Zone-TP/level.md)|[ZONE06](docs/specifications/tests/Zone-TP/zone06.md)|SOA 'minimum' maximum value|
|R32|SOA master is not an alias|[   Zone-TP](Zone-TP/level.md)|[ZONE07](docs/specifications/tests/Zone-TP/zone07.md)|SOA master is not an alias|
|R33|coherence of serial number with primary nameserver|[Consistency-TP](Consistency-TP/level.md)|[CONSISTENCY01](docs/specifications/tests/Consistency-TP/consistency01.md)|SOA serial number consistency|
|R34|coherence of administrative contact with primary nameserver|[Consistency-TP](Consistency-TP/level.md)|[CONSISTENCY02](docs/specifications/tests/Consistency-TP/consistency02.md)|RNAME consistency|
|R35|coherence of master with primary nameserver|**missing**|**missing**|      **missing**|
|R36|coherence of SOA with primary nameserver|[Consistency-TP](Consistency-TP/level.md)|[CONSISTENCY03](docs/specifications/tests/Consistency-TP/consistency03.md)|SOA parameters consistency|
|R40|  nameserver IP reverse|[Address-TP](Address-TP/level.md)|[ADDRESS02](docs/specifications/tests/Address-TP/address02.md)|Reverse DNS entry exists for name server IP address|
|R41|nameserver IP reverse matching nameserver name|[Address-TP](Address-TP/level.md)|[ADDRESS03](docs/specifications/tests/Address-TP/address03.md)|Reverse DNS entry matches name server name|
|R42|check if server is really recursive|[Nameserver-TP](Nameserver-TP/level.md)|[NAMESERVER01](docs/specifications/tests/Nameserver-TP/nameserver01.md)|A name server should not be a recursor|
|R43|nameserver doesn't allow recursion|[Nameserver-TP](Nameserver-TP/level.md)|[NAMESERVER01](docs/specifications/tests/Nameserver-TP/nameserver01.md)|A name server should not be a recursor|
|R45|correctness of given nameserver list|**missing**|**missing**|      **missing**|
|R46|test if server is recursive|[Nameserver-TP](Nameserver-TP/level.md)|[NAMESERVER01](docs/specifications/tests/Nameserver-TP/nameserver01.md)|A name server should not be a recursor|
|R47|      MX record present|[   Zone-TP](Zone-TP/level.md)|[ZONE09](docs/specifications/tests/Zone-TP/zone09.md)|MX record present|
|R49|MX syntax is valid for an hostname|[ Syntax-TP](Syntax-TP/level.md)|[SYNTAX08](docs/specifications/tests/Syntax-TP/syntax08.md)|MX name must have a valid hostname|
|R50|     MX is not an alias|[   Zone-TP](Zone-TP/level.md)|[ZONE08](docs/specifications/tests/Zone-TP/zone08.md)|MX is not an alias|
|R52|     MX can be resolved|[   Zone-TP](Zone-TP/level.md)|[ZONE09](docs/specifications/tests/Zone-TP/zone09.md)|MX record present|
|R53|behaviour against AAAA query (RFC 4074)|[Nameserver-TP](Nameserver-TP/level.md)|[NAMESERVER05](docs/specifications/tests/Nameserver-TP/nameserver05.md)|Behaviour against AAAA query|
|R54|nameservers belong all to the same AS|[Connectivity-TP](Connectivity-TP/level.md)|[CONNECTIVITY04](docs/specifications/tests/Connectivity-TP/connectivity04.md)|     AS Diversity|
|R55|serial number of the form YYYYMMDDnn|[ Syntax-TP](Syntax-TP/level.md)|[SYNTAX09](docs/specifications/tests/Syntax-TP/syntax09.md)|The SOA serial number field should be in the YYYYMMDDnn format|
|R58|Legal values for the DS hash digest algorithm|[ DNSSEC-TP](DNSSEC-TP/level.md)|[DNSSEC01](docs/specifications/tests/DNSSEC-TP/dnssec01.md)|Legal values for the DS hash digest algorithm|
|R59|DS must match a DNSKEY in the designated zone|[ DNSSEC-TP](DNSSEC-TP/level.md)|[DNSSEC02](docs/specifications/tests/DNSSEC-TP/dnssec02.md)|DS must match a DNSKEY in the designated zone|
|R60|Check for too many NSEC3 iterations|[ DNSSEC-TP](DNSSEC-TP/level.md)|[DNSSEC03](docs/specifications/tests/DNSSEC-TP/dnssec03.md)|Check for too many NSEC3 iterations|
|R61|Check for too short or too long RRSIG lifetimes|[ DNSSEC-TP](DNSSEC-TP/level.md)|[DNSSEC04](docs/specifications/tests/DNSSEC-TP/dnssec04.md)|Check for too short or too long RRSIG lifetimes|
|R62|Check for invalid DNSKEY algorithms|[ DNSSEC-TP](DNSSEC-TP/level.md)|[DNSSEC05](docs/specifications/tests/DNSSEC-TP/dnssec05.md)|Check for invalid DNSKEY algorithms|
|R63|Verify DNSSEC additional processing|[ DNSSEC-TP](DNSSEC-TP/level.md)|[DNSSEC06](docs/specifications/tests/DNSSEC-TP/dnssec06.md)|Verify DNSSEC additional processing|
|R64|If there exists DNSKEY at child, the parent should have a DS|[ DNSSEC-TP](DNSSEC-TP/level.md)|[DNSSEC07](docs/specifications/tests/DNSSEC-TP/dnssec07.md)|If DNSKEY at child, parent should have DS|
|R65|RRSIG(DNSKEY) must be valid and created by a valid DNSKEY|[ DNSSEC-TP](DNSSEC-TP/level.md)|[DNSSEC08](docs/specifications/tests/DNSSEC-TP/dnssec08.md)|RRSIG(DNSKEY) must be valid and created by a valid DNSKEY|
|R66|RRSIG(SOA) must be valid and created by a valid DNSKEY|[ DNSSEC-TP](DNSSEC-TP/level.md)|[DNSSEC09](docs/specifications/tests/DNSSEC-TP/dnssec09.md)|RRSIG(SOA) must be valid and created by a valid DNSKEY|
|R67|There must be NS records for the zone being tested on the parent side|[  Basic-TP](Basic-TP/level.md)|[BASIC01](docs/specifications/tests/Basic-TP/basic01.md)|The domain must have a parent domain|
|R69|NS records from parent exists, but the child does not have NS but answers for A|[  Basic-TP](Basic-TP/level.md)|[BASIC03](docs/specifications/tests/Basic-TP/basic03.md)|The _Broken but functional_ test|
|R70|Coherence of all other SOA-fields where SOA Serial is the same|[Consistency-TP](Consistency-TP/level.md)|[CONSISTENCY03](docs/specifications/tests/Consistency-TP/consistency03.md)|SOA parameters consistency|
|R71|Total mismatch between child and parent NS records, delegation works due to same IP|[Delegation-TP](Delegation-TP/level.md)|[DELEGATION07](docs/specifications/tests/Delegation-TP/delegation07.md)|Parent glue name records present in child|
|R72|  Test of EDNS0 support|[Nameserver-TP](Nameserver-TP/level.md)|[NAMESERVER02](docs/specifications/tests/Nameserver-TP/nameserver02.md)|Test of EDNS0 support|
|R73|Test availability of zone transfer (AXFR)|[Nameserver-TP](Nameserver-TP/level.md)|[NAMESERVER03](docs/specifications/tests/Nameserver-TP/nameserver03.md)|Test availability of zone transfer (AXFR)|
|R74|Answer from name server came from an IP address other than expected (wrong source IP)|[Nameserver-TP](Nameserver-TP/level.md)|[NAMESERVER04](docs/specifications/tests/Nameserver-TP/nameserver04.md)|Same source address|
|R75|SOA serial may not be zero|**missing**|**missing**|      **missing**|
|R76|Zone contains NSEC or NSEC3 records|[ DNSSEC-TP](DNSSEC-TP/level.md)|[DNSSEC10](docs/specifications/tests/DNSSEC-TP/dnssec10.md)|Zone contains NSEC or NSEC3 records|
