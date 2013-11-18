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
|R01|UDP connectivity                            | NAMESERVER:NO_UDP                           ||
|R02|TCP connectivity                            | NAMESERVER:NO_TCP                           ||
|R03|address in a private network                | ADDRESS:PRIVATE_IPV4                        ||
|R04|address shouldn't not be part of a bogon prefix | Partly implemented                      ||
|R05|illegal symbols in domain name              | HOST:ILLEGAL_NAME / ZONE:INVALID_NAME ?     ||
|R06|dash ('-') at start or beginning of domain name | HOST:ILLEGAL_NAME / ZONE:INVALID_NAME ? ||
|R07|double dash in domain name                  | HOST:ILLEGAL_NAME / ZONE:INVALID_NAME       ||
|R08|one nameserver for the domain               | DELEGATION:TOO_FEW_NS                       ||
|R09|at least two nameservers for the domain     | DELEGATION:TOO_FEW_NS                       ||
|R10|identical addresses                         | DELEGATION:TOO_FEW_NS_IPV4 ?                ||
|R11|nameserver addresses on same subnet         | CONNECTIVITY:TOO_FEW_ASN ?                  ||
|R12|nameserver addresses are all on the same subnet | CONNECTIVITY:TOO_FEW_ASN / CONNECTIVITY:V6_TOO_FEW_ASN ||
|R13|delegation response fit in a 512 byte UDP packet | DELEGATION:MIN_REFERRAL_SIZE_OK        ||
|R14|delegation response with additional fit in a 512 byte UDP packet | DELEGATION:MIN_REFERRAL_SIZE_OK ? ||
|R15|NS record present                           | DELEGATION:NOT_FOUND_AT_CHILD               ||
|R16|NS authoritative answer                     | DNS:NOT_AUTH                                ||
|R17|NS name has a valid domain/hostname syntax  | HOST:ILLEGAL_NAME                           ||
|R18|NS is not an alias                          | DELEGATION:NS_IS_CNAME                      ||
|R19|NS can be resolved                          | __not implemented__?                        ||
|R20|SOA record present                          | NAMESERVER:AUTH                             ||
|R21|SOA authoritative answer                    | NAMESERVER:AUTH                             ||
|R22|missused '@' characters in SOA contact name | SOA:RNAME_UNDELIVERABLE ?                   ||
|R23|illegal characters in SOA contact name      | SOA:RNAME_SYNTAX                            ||
|R24|illegal characters in SOA master nameserver | SOA:MNAME_ERROR                             ||
|R25|fully qualified master nameserver in SOA    | SOA:MNAME_IS_AUTH                           ||
|R26|SOA 'refresh' at least 6 hours              | SOA:REFRESH_OK                              ||
|R27|SOA 'retry' lower than 'refresh'            | SOA:RETRY_VS_REFRESH                        ||
|R28|SOA 'retry' at least 1 hour                 | SOA:RETRY_OK                                ||
|R29|SOA 'expire' at least 7 days                | SOA:EXPIRE_OK                               ||
|R30|SOA 'expire' at least 7 times 'refresh'     | SOA:EXPIRE_VS_REFRESH                       ||
|R31|SOA 'minimum' less than 1 day               | SOA:MINIMUM_OK                              ||
|R32|SOA master is not an alias                  | SOA:MNAME_IS_CNAME ?                        ||
|R33|coherence of serial number with primary nameserver | CONSISTENCY:SOA_SERIAL_CONSISTENT    ||
|R34|coherence of administrative contact with primary nameserver | CONSISTENCY:SOA_DIGEST_CONSISTENT ||
|R35|coherence of master with primary nameserver | CONSISTENCY:NS_SETS_OK ?                    ||
|R36|coherence of SOA with primary nameserver    | CONSISTENCY:SOA_DIGEST_CONSISTENT           ||
|R37|loopback delegation                         | __not implemented__?                        ||
|R38|loopback is resolvable                      | __not implemented__?                        ||
|R39|hostmaster MX is not an alias               | ?                                           ||
|R40|nameserver IP reverse                       | ADDRESS:PTR_NOT_FOUND                       ||
|R41|nameserver IP reverse matching nameserver name | __not implemented__?                     ||
|R42|check if server is really recursive         | NAMESERVER:RECURSIVE                        ||
|R43|nameserver doesn't allow recursion          | NAMESERVER:RECURSIVE __dup__?               ||
|R44|given primary nameserver is primary         | DNS:NOT_AUTH ?                              ||
|R45|correctness of given nameserver list        | CONSISTENCY:NS_SETS_OK ?                    ||
|R46|test if server is recursive                 | NAMESERVER:RECURSIVE __dup__?               ||
|R47|MX record present                           | MAIL:ALL_MX_IN_ZONE                         ||
|R48|MX authoritative answer                     | MAIL:ALL_MX_IN_ZONE                         ||
|R49|MX syntax is valid for an hostname          | MAIL:HOST_ERROR                             ||
|R50|MX is not an alias                          | MAIL:HOST_ERROR                             ||
|R51|absence of wildcard MX                      | __not implemented__?                        ||
|R52|MX can be resolved                          | MAIL:ALL_MX_IN_ZONE __dup__?                ||
|R53|behaviour against AAAA query                | ?                                           ||
|R54|nameservers belong all to the same AS       | CONNECTIVITY:TOO_FEW_ASN / CONNECTIVITY:V6_TOO_FEW_ASN ||
|R55|serial number of the form YYYYMMDDnn        | New test to identify serial number scheme   ||
|R56|And much more such as DNSSEC checks...      | ...                                         ||

Comment regarding addresses in bogon prefixes: DNSCheck implements checks against invalid addresses defined in RFCs. Since all of IPv4 space has been delegated to the RIRs, that is the whole of the low-volatility bogon space. The high-voltility bogon list would require daily (or even more frequent) updates, which is not practical in a standalone library.


Tests to implement from DNSCheck
--------------------------------

Although the list of [All DNSCheck Messages](https://github.com/dotse/dnscheck/wiki/Detailed-list-of-all-possible-dnscheck-messages)
is comprehensive, it is not a list of tests as such. It is a list of messages emitted by DNSCheck.

|Req| DNSCheck                                                             |
|:--|:---------------------------------------------------------------------|
|R58|Legal values for the DS hash digest algorithm                         |
|R59|DS must match a DNSKEY in the designated zone                         |
|R60|Check for too many NSEC3 iterations                                   |
|R61|Check for too short or too long RRSIG lifetimes                       |
|R62|Check for invalid DNSKEY algorithms                                   |
|R63|Verify DNSSEC additional processing                                   |
|R64|If there exists DNSKEY at child, the parent should have a DS          |
|R65|RRSIG(DNSKEY) must be valid and created by a valid DNSKEY             |
|R66|RRSIG(SOA) must be valid and created by a valid DNSKEY                |
|R67|There must be NS records for the zone being tested on the parent side |
|R68|The child domain must have at least one working nameserver            |
|R69|NS records from parent exists, but the child does not have NS but answers for A|
