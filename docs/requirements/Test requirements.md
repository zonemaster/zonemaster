Test requirements
=================

Source documents
----------------

Source document for Zonecheck: http://www.zonecheck.fr/features.shtml
Source document for DNSCheck: https://github.com/dotse/dnscheck/wiki/Detailed-list-of-all-possible-dnscheck-messages


Discarded test cases
--------------------
 
 * ICMP answer
 * serial number of the form YYYYMMDDnn
 * delegated domain is not an openrelay
 * domain of the hostmaster email is not an openrelay
 * can deliver email to 'postmaster'
 * can deliver email to hostmaster
 * domain able to receive email (delivery using MX, A, AAAA)
 * test if mail delivery possible
 

 
To be defined
-------------

 * root servers list present
 * root servers list identical to ICANN
 * root servers addresses identical to ICANN
 * coherence between NS and ANY records
 * coherence between SOA and ANY records


Tests to implement (mapped from Zonecheck to DNSCheck)
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
|nameserver IP reverse
|nameserver IP reverse matching nameserver name
|check if server is really recursive
|nameserver doesn't allow recursion
|given primary nameserver is primary
|correctness of given nameserver list
|test if server is recursive
|MX record present
|MX authoritative answer
|MX syntax is valid for an hostname
|MX is not an alias
|absence of wildcard MX
|MX can be resolved
|coherence between MX and ANY records
|behaviour against AAAA query
|nameservers belong all to the same AS
|address shouldn't be part of a bogon prefix
|And much more such as DNSSEC checks...
