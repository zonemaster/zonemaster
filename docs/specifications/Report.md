Reading docs/requirements/Test Requirements.md
LEVEL Consistency-TP
LEVEL Nameserver-TP
LEVEL Zone-TP
LEVEL Syntax-TP
LEVEL Address-TP
LEVEL Delegation-TP
LEVEL DNSSEC-TP
LEVEL Basic-TP
LEVEL Connectivity-TP
|Req|Requirement desription|Level     |Test Case ID|Test Description|
|:--|:---------------------|:---------|:-----------|:---------------|
|R22|missused '@' characters in SOA contact name| Syntax-TP|[SYNTAX05](docs/specifications/Syntax-TP/syntax05.md)|Misuse of '@' character in the SOA RNAME field|
|R02|       TCP connectivity|Connectivity-TP|[CONNECTIVITY02](docs/specifications/Connectivity-TP/connectivity02.md)|The domain must answer DNS queries over TCP on port 53|
|R13|delegation response fit in a 512 byte UDP packet|Delegation-TP|[DELEGATION03](docs/specifications/Delegation-TP/delegation03.md)|Test whether referral response at the authoritative section fit into a 512 byte UDP packet|
|R47|      MX record present|   Zone-TP|[ZONE09](docs/specifications/Zone-TP/zone09.md)|MX record present|
|R45|correctness of given nameserver list|Consistency-TP|[DELEGATION09](docs/specifications/Consistency-TP/../Delegation-TP/delegation09.md)|This test is done to verify that the NS records for the domain are same at the parent as well as at the child|
|R23|illegal characters in SOA contact name| Syntax-TP|[SYNTAX06](docs/specifications/Syntax-TP/syntax06.md)|No illegal characters in the SOA RNAME field|
|R08|one nameserver for the domain|Delegation-TP|[BASIC02](docs/specifications/Delegation-TP/../Basic-TP/basic02.md)|The domain must have at least one working name server|
|R53|behaviour against AAAA query|   missing|missing   |          missing|
|R41|nameserver IP reverse matching nameserver name|Address-TP|[ADDR03](docs/specifications/Address-TP/addr03.md)|Reverse DNS entry matches name server name|
|R38| loopback is resolvable|   missing|missing   |          missing|
|R07|double dash in domain name| Syntax-TP|[SYNTAX03](docs/specifications/Syntax-TP/syntax03.md)|There must be no double hyphen ('--') in position 3 and 4 of the domain name|
|R39|hostmaster MX is not an alias|   missing|missing   |          missing|
|R03|address in a private network|Address-TP|[ADDR01](docs/specifications/Address-TP/addr01.md)|Name server address must not be in private network|
|R67|There must be NS records for the zone being tested on the parent side|  Basic-TP|[BASIC01](docs/specifications/Basic-TP/basic01.md)|The domain must have a parent domain|
|R05|illegal symbols in domain name| Syntax-TP|[SYNTAX01](docs/specifications/Syntax-TP/syntax01.md)|No illegal symbols in the domain name|
|R11|nameserver addresses on same subnet|Connectivity-TP|[CONNECTIVITY04](docs/specifications/Connectivity-TP/connectivity04.md)|Each IP address of the domain's authoritative name server should be part of a different subnet|
|R01|       UDP connectivity|Connectivity-TP|[CONNECTIVITY01](docs/specifications/Connectivity-TP/connectivity01.md)|The domain must answer DNS queries over UDP on port 53|
|R63|Verify DNSSEC additional processing| DNSSEC-TP|[DNSSEC06](docs/specifications/DNSSEC-TP/dnssec06.md)|Verify DNSSEC additional processing|
|R25|fully qualified master nameserver in SOA|   Zone-TP|[ZONE01](docs/specifications/Zone-TP/zone01.md)|Fully qualified master nameserver in SOA|
|R35|coherence of master with primary nameserver|Consistency-TP|[CONSISTENCY03](docs/specifications/Consistency-TP/consistency03.md)|The MNAME (i.e. the primary source of data for the zone) field in the SOA RDATA must be consistent between authoritative name servers |
|R76|Zone contains NSEC or NSEC3 records| DNSSEC-TP|[DNSSEC10](docs/specifications/DNSSEC-TP/dnssec10.md)|Zone contains NSEC or NSEC3 records|
|R14|delegation response with additional fit in a 512 byte UDP packet|Delegation-TP|[DELEGATION04](docs/specifications/Delegation-TP/delegation04.md)|Test whether the referrals response at the authoritative and additional section fit into 512 byte UDP packet|
|R46|test if server is recursive|Nameserver-TP|[NS01](docs/specifications/Nameserver-TP/ns01.md)|A name server should not be a recursor|
|R24|illegal characters in SOA master nameserver| Syntax-TP|[SYNTAX07](docs/specifications/Syntax-TP/syntax07.md)|No illegal characters in the SOA MNAME field|
|R34|coherence of administrative contact with primary nameserver|Consistency-TP|[CONSISTENCY02](docs/specifications/Consistency-TP/consistency02.md)|The administrative contact must be consistent between authoritative name servers |
|R12|nameserver addresses are all on the same subnet|Connectivity-TP|[CONNECTIVITY05](docs/specifications/Connectivity-TP/connectivity05.md)|Check whether all the IP addresses of the child domain's authoritative name server is part of the same subnet|
|R37|    loopback delegation|   missing|missing   |          missing|
|R10|    identical addresses|Delegation-TP|[DELEGATION02](docs/specifications/Delegation-TP/delegation02.md)|Verify that the nameservers delegated has distinct IP addresses|
|R04|address should not be part of a bogon prefix|Connectivity-TP|[CONNECTIVITY03](docs/specifications/Connectivity-TP/connectivity03.md)|The IPv6 addresses of the authoritative name servers of the domain should not be part of a bogon prefix|
|R69|NS records from parent exists, but the child does not have NS but answers for A|  Basic-TP|[BASIC03](docs/specifications/Basic-TP/basic03.md)|The _Broken but functional_ test|
|R17|NS name has a valid domain/hostname syntax| Syntax-TP|[SYNTAX04](docs/specifications/Syntax-TP/syntax04.md)|The NS name must have a valid domain/hostname|
|R55|serial number of the form YYYYMMDDnn| Syntax-TP|[SYNTAX09](docs/specifications/Syntax-TP/syntax09.md)|The SOA serial number field should be in the YYYYMMDDnn format|
|R64|If there exists DNSKEY at child, the parent should have a DS| DNSSEC-TP|[DNSSEC07](docs/specifications/DNSSEC-TP/dnssec07.md)|If DNSKEY at child, parent should have DS|
|R27|SOA 'retry' lower than 'refresh'|   Zone-TP|[ZONE03](docs/specifications/Zone-TP/zone03.md)|SOA 'retry' lower than 'refresh'|
|R16|NS authoritative answer|Delegation-TP|[DELEGATION05](docs/specifications/Delegation-TP/delegation05.md)|Test whether there is an authoritative ANSWER for the name server|
|R40|  nameserver IP reverse|Address-TP|[ADDR02](docs/specifications/Address-TP/addr02.md)|Reverse DNS entry exists for name server IP address|
|R26|SOA 'refresh' at least 6 hours|   Zone-TP|[ZONE02](docs/specifications/Zone-TP/zone02.md)|SOA 'refresh' minimum value|
|R70|Coherence of all other SOA-fields where SOA Serial is the same|Consistency-TP|[CONSISTENCY04](docs/specifications/Consistency-TP/consistency04.md)|The RDATA fields "REFRESH", "RETRY", "EXPIRE" and "MINIMUM"  must be consistent between authoritative name servers|
|R49|MX syntax is valid for an hostname| Syntax-TP|[SYNTAX08](docs/specifications/Syntax-TP/syntax08.md)|MX name must have a valid hostname|
|R48|MX authoritative answer|   missing|missing   |          missing|
|R15|      NS record present|   missing|missing   |          missing|
|R31|SOA 'minimum' less than 1 day|   Zone-TP|[ZONE06](docs/specifications/Zone-TP/zone06.md)|SOA 'minimum' maximum value|
|R71|Total mismatch between child and parent NS records, delegation works due to same IP|Delegation-TP|[DELEGATION09](docs/specifications/Delegation-TP/delegation09.md)|This test is done to verify that the NS records for the domain are same at the parent as well as at the child|
|R30|SOA 'expire' at least 7 times 'refresh'|   missing|missing   |          missing|
|R50|     MX is not an alias|   Zone-TP|[ZONE08](docs/specifications/Zone-TP/zone08.md)|MX is not an alias|
|R32|SOA master is not an alias|   Zone-TP|[ZONE07](docs/specifications/Zone-TP/zone07.md)|SOA master is not an alias|
|R21|SOA authoritative answer|Delegation-TP|[DELEGATION08](docs/specifications/Delegation-TP/delegation08.md)|Test the existence of SOA record in the domain's zone|
|R74|Answer from name server came from an IP address other than expected (wrong source IP)|Nameserver-TP|[missing](docs/specifications/Nameserver-TP/ns04.md)|          missing|
|R56|And much more such as DNSSEC checks...|   missing|missing   |          missing|
|R54|nameservers belong all to the same AS|Connectivity-TP|[CONNECTIVITY06](docs/specifications/Connectivity-TP/connectivity06.md)|All IP addresses of the domain's authoritative name server should not be part of same AS|
|R75|SOA serial may not be zero|Delegation-TP|[DELEGATION10](docs/specifications/Delegation-TP/delegation10.md)|Test whether the SOA serial number of the domain's zone is set to zero|
|R61|Check for too short or too long RRSIG lifetimes| DNSSEC-TP|[DNSSEC04](docs/specifications/DNSSEC-TP/dnssec04.md)|Check for too short or too long RRSIG lifetimes|
|R36|coherence of SOA with primary nameserver|Consistency-TP|[CONSISTENCY04](docs/specifications/Consistency-TP/consistency04.md)|The RDATA fields "REFRESH", "RETRY", "EXPIRE" and "MINIMUM"  must be consistent between authoritative name servers|
|R18|     NS is not an alias|Delegation-TP|[DELEGATION06](docs/specifications/Delegation-TP/delegation06.md)|Test that the NS record is not pointing to a CNAME alias|
|R20|     SOA record present|Delegation-TP|[DELEGATION08](docs/specifications/Delegation-TP/delegation08.md)|Test the existence of SOA record in the domain's zone|
|R52|     MX can be resolved|   Zone-TP|[ZONE09](docs/specifications/Zone-TP/zone09.md)|MX record present|
|R33|coherence of serial number with primary nameserver|Consistency-TP|[CONSISTENCY01](docs/specifications/Consistency-TP/consistency01.md)|Serial number must be consistent between authoritative name servers |
|R62|Check for invalid DNSKEY algorithms| DNSSEC-TP|[DNSSEC05](docs/specifications/DNSSEC-TP/dnssec05.md)|Check for invalid DNSKEY algorithms|
|R68|The child domain must have at least one working nameserver|  Basic-TP|[BASIC02](docs/specifications/Basic-TP/basic02.md)|The domain must have at least one working name server|
|R42|check if server is really recursive|Nameserver-TP|[NS01](docs/specifications/Nameserver-TP/ns01.md)|A name server should not be a recursor|
|R09|at least two nameservers for the domain|Delegation-TP|[DELEGATION01](docs/specifications/Delegation-TP/delegation01.md)|The domain must have a minimum of two authoritative name servers   |
|R58|Legal values for the DS hash digest algorithm| DNSSEC-TP|[DNSSEC01](docs/specifications/DNSSEC-TP/dnssec01.md)|Legal values for the DS hash digest algorithm|
|R19|     NS can be resolved|Delegation-TP|[DELEGATION07](docs/specifications/Delegation-TP/delegation07.md)|Test that the authoritative name servers for the domain be accessible over Internet|
|R60|Check for too many NSEC3 iterations| DNSSEC-TP|[DNSSEC03](docs/specifications/DNSSEC-TP/dnssec03.md)|Check for too many NSEC3 iterations|
|R72|  Test of EDNS0 support|Nameserver-TP|[NS02](docs/specifications/Nameserver-TP/ns02.md)|Test of EDNS0 support|
|R65|RRSIG(DNSKEY) must be valid and created by a valid DNSKEY| DNSSEC-TP|[DNSSEC08](docs/specifications/DNSSEC-TP/dnssec08.md)|RRSIG(DNSKEY) must be valid and created by a valid DNSKEY|
|R29|SOA 'expire' at least 7 days|   Zone-TP|[ZONE05](docs/specifications/Zone-TP/zone05.md)|SOA 'expire' minimum value|
|R73|Test availability of zone transfer (AXFR)|Nameserver-TP|[NS03](docs/specifications/Nameserver-TP/ns03.md)|Test availability of zone transfer (AXFR)|
|R28|SOA 'retry' at least 1 hour|   Zone-TP|[ZONE04](docs/specifications/Zone-TP/zone04.md)|SOA 'retry' at least 1 hour|
|R43|nameserver doesn't allow recursion|Nameserver-TP|[NS01](docs/specifications/Nameserver-TP/ns01.md)|A name server should not be a recursor|
|R06|dash ('-') at start or beginning of domain name| Syntax-TP|[SYNTAX02](docs/specifications/Syntax-TP/syntax02.md)|No hyphen ('-') at the start or end of the domain name|
|R44|given primary nameserver is primary|   missing|missing   |          missing|
|R51| absence of wildcard MX|   missing|missing   |          missing|
|R59|DS must match a DNSKEY in the designated zone| DNSSEC-TP|[DNSSEC02](docs/specifications/DNSSEC-TP/dnssec02.md)|DS must match a DNSKEY in the designated zone|
