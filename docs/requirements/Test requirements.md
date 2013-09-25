Test requirements
=================

Source documents
----------------

 * Source document for Zonecheck: [features.shtml](http://www.zonecheck.fr/features.shtml)  
 * Source document for DNSCheck: [Detailes list of all possible DNSCheck messages](https://github.com/dotse/dnscheck/wiki/Detailed-list-of-all-possible-dnscheck-messages)


(Zonecheck) Discarded test cases
--------------------------------
 
 * ICMP answer
 * serial number of the form YYYYMMDDnn
 * delegated domain is not an openrelay
 * domain of the hostmaster email is not an openrelay
 * can deliver email to 'postmaster'
 * can deliver email to hostmaster
 * domain able to receive email (delivery using MX, A, AAAA)
 * test if mail delivery possible
 

 
(Zonecheck) To be defined
-------------------------

 * root servers list present
 * root servers list identical to ICANN
 * root servers addresses identical to ICANN
 * coherence between NS and ANY records
 * coherence between SOA and ANY records
 * coherence between MX and ANY records
 


Tests to implement from Zonecheck (mapped to DNSCheck)
------------------------------------------------------

| Zonecheck                                  | DNSCheck                                    |
|:-------------------------------------------|:--------------------------------------------|
|UDP connectivity                            | NAMESERVER:NO_UDP                           |
|TCP connectivity                            | NAMESERVER:NO_TCP                           |
|address in a private network                | ADDRESS:PRIVATE_IPV4                        |
|address shouldn not be part of a bogon prefix | __not implemented__?                      |
|illegal symbols in domain name              | HOST:ILLEGAL_NAME / ZONE:INVALID_NAME ?     |
|dash ('-') at start or beginning of domain name | HOST:ILLEGAL_NAME / ZONE:INVALID_NAME ? |
|double dash in domain name                  | HOST:ILLEGAL_NAME / ZONE:INVALID_NAME       |
|one nameserver for the domain               | DELEGATION:TOO_FEW_NS                       |
|at least two nameservers for the domain     | DELEGATION:TOO_FEW_NS                       |
|identical addresses                         | DELEGATION:TOO_FEW_NS_IPV4 ?                |
|nameserver addresses on same subnet         | CONNECTIVITY:TOO_FEW_ASN ?                  |
|nameserver addresses are all on the same subnet | CONNECTIVITY:TOO_FEW_ASN / CONNECTIVITY:V6_TOO_FEW_ASN |
|delegation response fit in a 512 byte UDP packet | DELEGATION:MIN_REFERRAL_SIZE_OK        |
|delegation response with additional fit in a 512 byte UDP packet | DELEGATION:MIN_REFERRAL_SIZE_OK ? |
|NS record present                           | DELEGATION:NOT_FOUND_AT_CHILD               |
|NS authoritative answer                     | DNS:NOT_AUTH                                |
|NS name has a valid domain/hostname syntax  | HOST:ILLEGAL_NAME                           |
|NS is not an alias                          | DELEGATION:NS_IS_CNAME                      |
|NS can be resolved                          | __not implemented__?                        |
|SOA record present                          | NAMESERVER:AUTH                             |
|SOA authoritative answer                    | NAMESERVER:AUTH                             |
|missused '@' characters in SOA contact name | SOA:RNAME_UNDELIVERABLE ?                   |
|illegal characters in SOA contact name      | SOA:RNAME_SYNTAX                            |
|illegal characters in SOA master nameserver | SOA:MNAME_ERROR                             |
|fully qualified master nameserver in SOA    | SOA:MNAME_IS_AUTH                           |
|SOA 'refresh' at least 6 hours              | SOA:REFRESH_OK                              |
|SOA 'retry' lower than 'refresh'            | SOA:RETRY_VS_REFRESH                        |
|SOA 'retry' at least 1 hour                 | SOA:RETRY_OK                                |
|SOA 'expire' at least 7 days                | SOA:EXPIRE_OK                               |
|SOA 'expire' at least 7 times 'refresh'     | SOA:EXPIRE_VS_REFRESH                       |
|SOA 'minimum' less than 1 day               | SOA:MINIMUM_OK                              |
|SOA master is not an alias                  | SOA:MNAME_IS_CNAME ?                        |
|coherence of serial number with primary nameserver | CONSISTENCY:SOA_SERIAL_CONSISTENT    |
|coherence of administrative contact with primary nameserver | CONSISTENCY:SOA_DIGEST_CONSISTENT |
|coherence of master with primary nameserver | CONSISTENCY:NS_SETS_OK ?                    |
|coherence of SOA with primary nameserver    | CONSISTENCY:SOA_DIGEST_CONSISTENT           |
|loopback delegation                         | __not implemented__?                        |
|loopback is resolvable                      | __not implemented__?                        |
|hostmaster MX is not an alias               | ?                                           |
|nameserver IP reverse                       | ADDRESS:PTR_NOT_FOUND                       |
|nameserver IP reverse matching nameserver name | __not implemented__?                     |
|check if server is really recursive         | NAMESERVER:RECURSIVE                        |
|nameserver doesn't allow recursion          | NAMESERVER:RECURSIVE __dup__?               |
|given primary nameserver is primary         | DNS:NOT_AUTH ?                              |
|correctness of given nameserver list        | CONSISTENCY:NS_SETS_OK ?                    |
|test if server is recursive                 | NAMESERVER:RECURSIVE __dup__?               |
|MX record present                           | MAIL:ALL_MX_IN_ZONE                         |
|MX authoritative answer                     | MAIL:ALL_MX_IN_ZONE                         |
|MX syntax is valid for an hostname          | MAIL:HOST_ERROR                             |
|MX is not an alias                          | MAIL:HOST_ERROR                             |
|absence of wildcard MX                      | __not implemented__?                        |
|MX can be resolved                          | MAIL:ALL_MX_IN_ZONE __dup__?                |
|behaviour against AAAA query                | ?                                           |
|nameservers belong all to the same AS       | CONNECTIVITY:TOO_FEW_ASN / CONNECTIVITY:V6_TOO_FEW_ASN |
|address shouldn't be part of a bogon prefix | Partly implemented                          |
|And much more such as DNSSEC checks...      | ...                                         |

Comment regarding addresses in bogon prefixes: DNSCheck implements checks against invalid addresses defined in RFCs. Since all of IPv4 space has been delegated to the RIRs, that is the whole of the low-volatility bogon space. The high-voltility bogon list would require daily (or even more frequent) updates, which is not practical in a standalone library.

Tests to implement from DNSCheck
--------------------------------

Although the list of [All DNSCheck Messages](https://github.com/dotse/dnscheck/wiki/Detailed-list-of-all-possible-dnscheck-messages)
is comprehensive, it is not a list of tests as such. It is a list of messages emitted by DNSCheck. However, it can be used as a list of tests to be implemented, so we will not repeat the list here.
