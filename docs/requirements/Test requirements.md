Test requirements
=================

Overview
--------
The test requirements should list all current tests implemented in both Zonecheck and DNSCheck. This documents lists all current test cases.


Source documents
----------------

 * Source document for Zonecheck: [features.shtml](http://www.zonecheck.fr/features.shtml)
 * Policy document for Zonecheck: [tests-policy-2.html](http://www.afnic.fr/en/products-and-services/services/zonecheck/tests-policy-2.html)
 * Source document for DNSCheck: [Detailes list of all possible DNSCheck messages](https://github.com/dotse/dnscheck/wiki/Detailed-list-of-all-possible-dnscheck-messages)


(Zonecheck) Discarded test cases
--------------------------------
 * serial number of the form YYYYMMDDnn (see R56)
 * delegated domain is not an openrelay
 * domain of the hostmaster email is not an openrelay
 * can deliver email to 'postmaster'
 * can deliver email to hostmaster
 * domain able to receive email (delivery using MX, A, AAAA)
 * test if mail delivery possible

 
(Zonecheck) To be defined
-------------------------

 * ICMP answer
 * root servers list present
 * root servers list identical to ICANN
 * root servers addresses identical to ICANN
 * coherence between NS and ANY records
 * coherence between SOA and ANY records
 * coherence between MX and ANY records


Tests to implement from Zonecheck (mapped to DNSCheck)
------------------------------------------------------

|Req| Zonecheck                                  | DNSCheck                                    | Level       | 
|:--|:-------------------------------------------|:--------------------------------------------|:------------|
|R01|UDP connectivity                            | NAMESERVER:NO_UDP                           |Connectivity|
|R02|TCP connectivity                            | NAMESERVER:NO_TCP                           |Connectivity|
|R03|address in a private network                | ADDRESS:PRIVATE_IPV4                        |Address|
|R04|address should not be part of a bogon prefix | Partly implemented                         |Connectivity|
|R05|illegal symbols in domain name              | HOST:ILLEGAL_NAME / ZONE:INVALID_NAME ?     |Syntax|
|R06|dash ('-') at start or beginning of domain name | HOST:ILLEGAL_NAME / ZONE:INVALID_NAME ? |Syntax|
|R07|double dash in domain name                  | HOST:ILLEGAL_NAME / ZONE:INVALID_NAME       |Syntax|
|R08|one nameserver for the domain               | DELEGATION:TOO_FEW_NS                       |Delegation|
|R09|at least two nameservers for the domain     | DELEGATION:TOO_FEW_NS                       |Delegation|
|R10|identical addresses                         | DELEGATION:TOO_FEW_NS_IPV4 ?                |Delegation|
|R11|nameserver addresses on same subnet         | __think we removed this__!?                 |Connectivity|
|R12|nameserver addresses are all on the same subnet | __indirectly done through AS checks__!? |Connectivity|
|R13|delegation response fit in a 512 byte UDP packet | DELEGATION:MIN_REFERRAL_SIZE_OK        |Delegation|
|R14|delegation response with additional fit in a 512 byte UDP packet | DELEGATION:MIN_REFERRAL_SIZE_OK |Delegation|
|R15|NS record present                           | ZONE:FATAL_NO_CHILD_NS                      |Basic|
|R16|NS authoritative answer                     | DNS:NOT_AUTH                                |Delegation|
|R17|NS name has a valid domain/hostname syntax  | HOST:ILLEGAL_NAME                           |Syntax|
|R18|NS is not an alias                          | DELEGATION:NS_IS_CNAME                      |Delegation|
|R19|NS can be resolved                          | DELEGATION:NOT_FOUND_AT_CHILD               |Delegation|
|R20|SOA record present                          | NAMESERVER:AUTH                             |Delegation|
|R21|SOA authoritative answer                    | NAMESERVER:AUTH                             |Delegation|
|R22|missused '@' characters in SOA contact name | SOA:RNAME_SYNTAX                            |Syntax|
|R23|illegal characters in SOA contact name      | SOA:RNAME_SYNTAX                            |Syntax|
|R24|illegal characters in SOA master nameserver | SOA:MNAME_ERROR                             |Syntax|
|R25|fully qualified master nameserver in SOA    | SOA:MNAME_IS_AUTH                           |Zone|
|R26|SOA 'refresh' at least 6 hours              | SOA:REFRESH_OK                              |Zone|
|R27|SOA 'retry' lower than 'refresh'            | SOA:RETRY_VS_REFRESH                        |Zone|
|R28|SOA 'retry' at least 1 hour                 | SOA:RETRY_OK                                |Zone|
|R29|SOA 'expire' at least 7 days                | SOA:EXPIRE_OK                               |Zone|
|R30|SOA 'expire' at least 7 times 'refresh'     | SOA:EXPIRE_VS_REFRESH                       |Zone|
|R31|SOA 'minimum' less than 1 day               | SOA:MINIMUM_OK                              |Zone|
|R32|SOA master is not an alias                  | SOA:MNAME_IS_CNAME                          |Zone|
|R33|coherence of serial number with primary nameserver | CONSISTENCY:SOA_SERIAL_CONSISTENT    |Consistency|
|R34|coherence of administrative contact with primary nameserver | CONSISTENCY:SOA_DIGEST_CONSISTENT |Consistency|
|R35|coherence of master with primary nameserver | CONSISTENCY:NS_SETS_OK ?                    |Consistency|
|R36|coherence of SOA with primary nameserver    | CONSISTENCY:SOA_DIGEST_CONSISTENT           |Consistency|
|R37|loopback delegation                         | __not implemented__?                        |?|
|R38|loopback is resolvable                      | __not implemented__?                        |?|
|R39|hostmaster MX is not an alias               | __dup of R50__                              |Zone|
|R40|nameserver IP reverse                       | ADDRESS:PTR_NOT_FOUND                       |Address|
|R41|nameserver IP reverse matching nameserver name | __not implemented__?                     |Address|
|R42|check if server is really recursive         | NAMESERVER:RECURSIVE                        |Name server|
|R43|nameserver doesn't allow recursion          | NAMESERVER:RECURSIVE __dup__?               |Name server|
|R44|given primary nameserver is primary         | DNS:NOT_AUTH ?                              |Zone|
|R45|correctness of given nameserver list        | CONSISTENCY:NS_SETS_OK ?                    |Consistency|
|R46|test if server is recursive                 | NAMESERVER:RECURSIVE __dup__?               |Name server|
|R47|MX record present                           | MAIL:ALL_MX_IN_ZONE                         |Zone|
|R48|MX authoritative answer                     | MAIL:ALL_MX_IN_ZONE                         |Zone|
|R49|MX syntax is valid for an hostname          | MAIL:HOST_ERROR                             |Syntax|
|R50|MX is not an alias                          | MAIL:HOST_ERROR                             |Zone|
|R51|absence of wildcard MX                      | __not implemented__?                        |Zone|
|R52|MX can be resolved                          | MAIL:ALL_MX_IN_ZONE __dup__?                |Zone|
|R53|behaviour against AAAA query                | __not implemented__?                        |Name server|
|R54|nameservers belong all to the same AS       | CONNECTIVITY:TOO_FEW_ASN / CONNECTIVITY:V6_TOO_FEW_ASN |Connectivity|
|R55|serial number of the form YYYYMMDDnn        | New test to identify serial number scheme   |Syntax|
|R56|And much more such as DNSSEC checks...      | ...                                         |DNSSEC|

Comment regarding addresses in bogon prefixes: DNSCheck implements checks against invalid addresses defined in RFCs. Since all of IPv4 space has been delegated to the RIRs, that is the whole of the low-volatility bogon space. The high-voltility bogon list would require daily (or even more frequent) updates, which is not practical in a standalone library.


Tests to implement from DNSCheck
--------------------------------

Although the list of [All DNSCheck Messages](https://github.com/dotse/dnscheck/wiki/Detailed-list-of-all-possible-dnscheck-messages)
is comprehensive, it is not a list of tests as such. It is a list of messages emitted by DNSCheck.

|Req| DNSCheck                                                             | Level |
|:--|:---------------------------------------------------------------------|:------|
|R58|Legal values for the DS hash digest algorithm                         |DNSSEC|
|R59|DS must match a DNSKEY in the designated zone                         |DNSSEC|
|R60|Check for too many NSEC3 iterations                                   |DNSSEC|
|R61|Check for too short or too long RRSIG lifetimes                       |DNSSEC|
|R62|Check for invalid DNSKEY algorithms                                   |DNSSEC|
|R63|Verify DNSSEC additional processing                                   |DNSSEC|
|R64|If there exists DNSKEY at child, the parent should have a DS          |DNSSEC|
|R65|RRSIG(DNSKEY) must be valid and created by a valid DNSKEY             |DNSSEC|
|R66|RRSIG(SOA) must be valid and created by a valid DNSKEY                |DNSSEC|
|R67|There must be NS records for the zone being tested on the parent side |Basic|
|R68|The child domain must have at least one working nameserver            |Basic|
|R69|NS records from parent exists, but the child does not have NS but answers for A|Basic|
|R70|Coherence of all other SOA-fields where SOA Serial is the same|Consistency|
|R71|Total mismatch between child and parent NS records, delegation works due to same IP|Delegation|
|R72|Test of EDNS0 support|Name server|
|R73|Test availability of zone transfer (AXFR)|Name server|
|R74|Answer from name server came from an IP address other than expected (wrong source IP)|Name server|
|R75|SOA serial may not be zero|Delegation|
|R76|RTT: min, max, stddev, avg, per protocol and #queries sent per name server|Name server|
