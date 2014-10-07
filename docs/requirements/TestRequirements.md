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

 
Tests to implement from Zonecheck (mapped to DNSCheck)
------------------------------------------------------

|Req| Zonecheck                                  | DNSCheck                                    | Level       | 
|:--|:-------------------------------------------|:--------------------------------------------|:------------|
|R01|UDP connectivity                            | NAMESERVER:NO_UDP                           |[CONNECTIVITY](../specifications/tests/Connectivity-TP/connectivity01.md)|
|R02|TCP connectivity                            | NAMESERVER:NO_TCP                           |[CONNECTIVITY](../specifications/tests/Connectivity-TP/connectivity02.md)|
|R03|address in a private network                | ADDRESS:PRIVATE_IPV4                        |[ADDRESS](../specifications/tests/Address-TP/address01.md)|
|R04|address should not be part of a bogon prefix | Partly implemented                         |[ADDRESS](../specifications/tests/Address-TP/address04.md)|
|R05|illegal symbols in domain name              | HOST:ILLEGAL_NAME / ZONE:INVALID_NAME ?     |[SYNTAX](../specifications/tests/Syntax-TP/syntax01.md)|
|R06|dash ('-') at start or beginning of domain name | HOST:ILLEGAL_NAME / ZONE:INVALID_NAME ? |[SYNTAX](../specifications/tests/Syntax-TP/syntax02.md)|
|R07|double dash in domain name                  | HOST:ILLEGAL_NAME / ZONE:INVALID_NAME       |[SYNTAX](../specifications/tests/Syntax-TP/syntax03.md)|
|R09|at least two nameservers for the domain     | DELEGATION:TOO_FEW_NS                       |[DELEGATION](../specifications/tests/Delegation-TP/delegation01.md)|
|R10|identical addresses                         | DELEGATION:TOO_FEW_NS_IPV4 ?                |[DELEGATION](../specifications/tests/Delegation-TP/delegation02.md)|
|R11|nameserver addresses on same subnet         | __Indirectly done through AS checks (R54)__!                 |[CONNECTIVITY](../specifications/tests/Connectivity-TP/connectivity03.md)|
|R12|nameserver addresses are all on the same subnet | __indirectly done through AS checks (R54)__! |[CONNECTIVITY](../specifications/tests/Connectivity-TP/connectivity03.md)|
|R13|delegation response fit in a 512 byte UDP packet | DELEGATION:MIN_REFERRAL_SIZE_OK        |[DELEGATION](../specifications/tests/Delegation-TP/delegation03.md)|
|R14|delegation response with additional fit in a 512 byte UDP packet | DELEGATION:MIN_REFERRAL_SIZE_OK |[DELEGATION](../specifications/tests/Delegation-TP/delegation03.md)|
|R15|NS record present                           | ZONE:FATAL_NO_CHILD_NS                      |[BASIC](../specifications/tests/Basic-TP/basic02.md)|
|R16|NS authoritative answer                     | DNS:NOT_AUTH                                |[DELEGATION](../specifications/tests/Delegation-TP/delegation04.md)|
|R17|NS name has a valid domain/hostname syntax  | HOST:ILLEGAL_NAME                           |[SYNTAX](../specifications/tests/Syntax-TP/syntax04.md)|
|R18|NS is not an alias                          | DELEGATION:NS_IS_CNAME                      |[DELEGATION](../specifications/tests/Delegation-TP/delegation05.md)|
|R19|NS can be resolved                          | DELEGATION:NOT_FOUND_AT_CHILD               |[DELEGATION](../specifications/tests/Delegation-TP/??)|
|R20|SOA record present                          | NAMESERVER:AUTH                             |[DELEGATION](../specifications/tests/Delegation-TP/delegation06.md)|
|R21|SOA authoritative answer                    | NAMESERVER:AUTH                             |[DELEGATION](../specifications/tests/Delegation-TP/delegation06.md)|
|R22|missused '@' characters in SOA contact name | SOA:RNAME_SYNTAX                            |[SYNTAX](../specifications/tests/Syntax-TP/syntax05.md)|
|R23|illegal characters in SOA contact name      | SOA:RNAME_SYNTAX                            |[SYNTAX](../specifications/tests/Syntax-TP/syntax06.md)|
|R24|illegal characters in SOA master nameserver | SOA:MNAME_ERROR                             |[SYNTAX](../specifications/tests/Syntax-TP/syntax07.md)|
|R25|fully qualified master nameserver in SOA    | SOA:MNAME_IS_AUTH                           |[ZONE](../specifications/tests/Zone-TP/zone01.md)|
|R26|SOA 'refresh' at least 6 hours              | SOA:REFRESH_OK                              |[ZONE](../specifications/tests/Zone-TP/zone02.md)|
|R27|SOA 'retry' lower than 'refresh'            | SOA:RETRY_VS_REFRESH                        |[ZONE](../specifications/tests/Zone-TP/zone03.md)|
|R28|SOA 'retry' at least 1 hour                 | SOA:RETRY_OK                                |[ZONE](../specifications/tests/Zone-TP/zone04.md)|
|R29|SOA 'expire' at least 7 days                | SOA:EXPIRE_OK                               |[ZONE](../specifications/tests/Zone-TP/zone05.md)|
|R31|SOA 'minimum' less than 1 day               | SOA:MINIMUM_OK                              |[ZONE](../specifications/tests/Zone-TP/zone06.md)|
|R32|SOA master is not an alias                  | SOA:MNAME_IS_CNAME                          |[ZONE](../specifications/tests/Zone-TP/zone07.md)|
|R33|coherence of serial number with primary nameserver | CONSISTENCY:SOA_SERIAL_CONSISTENT    |[CONSISTENCY](../specifications/tests/Consistency-TP/consistency01.md)|
|R34|coherence of administrative contact with primary nameserver | CONSISTENCY:SOA_DIGEST_CONSISTENT |[CONSISTENCY](../specifications/tests/Consistency-TP/consistency02.md)|
|R36|coherence of SOA with primary nameserver    | CONSISTENCY:SOA_DIGEST_CONSISTENT           |[CONSISTENCY](../specifications/tests/Consistency-TP/consistency03.md)|
|R40|nameserver IP reverse                       | ADDRESS:PTR_NOT_FOUND                       |[ADDRESS](../specifications/tests/Address-TP/address02.md)|
|R41|nameserver IP reverse matching nameserver name | __not implemented__?                     |[ADDRESS](../specifications/tests/Address-TP/address03.md)|
|R42|check if server is really recursive         | NAMESERVER:RECURSIVE                        |[NAMESERVER](../specifications/tests/Nameserver-TP/nameserver01.md)|
|R43|nameserver doesn't allow recursion          | NAMESERVER:RECURSIVE __dup__?               |[NAMESERVER](../specifications/tests/Nameserver-TP/nameserver01.md)|
|R46|test if server is recursive                 | NAMESERVER:RECURSIVE __dup__?               |[NAMESERVER](../specifications/tests/Nameserver-TP/nameserver01.md)|
|R47|MX record present                           | MAIL:ALL_MX_IN_ZONE                         |[ZONE](../specifications/tests/Zone-TP/zone09.md)|
|R49|MX syntax is valid for an hostname          | MAIL:HOST_ERROR                             |[SYNTAX](../specifications/tests/Syntax-TP/syntax08.md)|
|R50|MX is not an alias                          | MAIL:HOST_ERROR                             |[ZONE](../specifications/tests/Zone-TP/zone08.md)|
|R52|MX can be resolved                          | MAIL:ALL_MX_IN_ZONE __dup__?                |[ZONE](../specifications/tests/Zone-TP/zone09.md)|
|R53|behaviour against AAAA query (RFC 4074)     | __implicit in all other tests__             |[NAMESERVER](../specifications/tests/Nameserver-TP/nameserver05.md)|
|R54|nameservers belong all to the same AS       | CONNECTIVITY:TOO_FEW_ASN / CONNECTIVITY:V6_TOO_FEW_ASN |[CONNECTIVITY](../specifications/tests/Connectivity-TP/connectivity03.md)|


Comment regarding addresses in bogon prefixes: DNSCheck implements checks against invalid addresses defined in RFCs. Since all of IPv4 space has been delegated to the RIRs, that is the whole of the low-volatility bogon space. The high-voltility bogon list would require daily (or even more frequent) updates, which is not practical in a standalone library.


Tests to implement from DNSCheck
--------------------------------

Although the list of [All DNSCheck Messages](https://github.com/dotse/dnscheck/wiki/Detailed-list-of-all-possible-dnscheck-messages)
is comprehensive, it is not a list of tests as such. It is a list of messages emitted by DNSCheck.

|Req| DNSCheck                                                             | DNSCheck | Level |
|:--|:---------------------------------------------------------------------|:---------|:------|
|R58|Legal values for the DS hash digest algorithm                         |&nbsp;    |[DNSSEC](../specifications/tests/DNSSEC-TP/dnssec01.md)|
|R59|DS must match a DNSKEY in the designated zone                         |&nbsp;    |[DNSSEC](../specifications/tests/DNSSEC-TP/dnssec02.md)|
|R60|Check for too many NSEC3 iterations                                   |&nbsp;    |[DNSSEC](../specifications/tests/DNSSEC-TP/dnssec03.md)|
|R61|Check for too short or too long RRSIG lifetimes                       |&nbsp;    |[DNSSEC](../specifications/tests/DNSSEC-TP/dnssec04.md)|
|R62|Check for invalid DNSKEY algorithms                                   |&nbsp;    |[DNSSEC](../specifications/tests/DNSSEC-TP/dnssec05.md)|
|R63|Verify DNSSEC additional processing                                   |&nbsp;    |[DNSSEC](../specifications/tests/DNSSEC-TP/dnssec06.md)|
|R64|If there exists DNSKEY at child, the parent should have a DS          |&nbsp;    |[DNSSEC](../specifications/tests/DNSSEC-TP/dnssec07.md)|
|R65|RRSIG(DNSKEY) must be valid and created by a valid DNSKEY             |&nbsp;    |[DNSSEC](../specifications/tests/DNSSEC-TP/dnssec08.md)|
|R66|RRSIG(SOA) must be valid and created by a valid DNSKEY                |&nbsp;    |[DNSSEC](../specifications/tests/DNSSEC-TP/dnssec09.md)|
|R67|There must be NS records for the zone being tested on the parent side |&nbsp;    |[BASIC](../specifications/tests/Basic-TP/basic01.md)|
|R68|The child domain must have at least one working nameserver            |&nbsp;    |[BASIC](../specifications/tests/Basic-TP/basic02.md)|
|R69|NS records from parent exists, but the child does not have NS but answers for A|&nbsp;|[BASIC](../specifications/tests/Basic-TP/basic03.md)|
|R70|Coherence of all other SOA-fields where SOA Serial is the same        |&nbsp;    |[CONSISTENCY](../specifications/tests/Consistency-TP/consistency03.md)|
|R71|Total mismatch between child and parent NS records, delegation works due to same IP|&nbsp;    |[DELEGATION](../specifications/tests/Delegation-TP/delegation07.md)|
|R72|Test of EDNS0 support                                                 |&nbsp;    |[NAMESERVER](../specifications/tests/Nameserver-TP/nameserver02.md)|
|R73|Test availability of zone transfer (AXFR)                             |&nbsp;    |[NAMESERVER](../specifications/tests/Nameserver-TP/nameserver03.md)|
|R74|Answer from name server came from an IP address other than expected (wrong source IP)|&nbsp;|[NAMESERVER](../specifications/tests/Nameserver-TP/nameserver04.md)|
|R76|Zone contains NSEC or NSEC3 records                                   |&nbsp;    |[DNSSEC](../specifications/tests/DNSSEC-TP/dnssec10.md)|
|R77|Perform input validation on the domain name                           |&nbsp;|[BASIC](../specifications/tests/Basic-TP/basic00.md)|

Future tests
------------
 * Case insensitivity in a name server, [RFC 4343](http://tools.ietf.org/html/rfc4343).
 * More tests of EDNS(0), [RFC 6891](http://tools.ietf.org/search/rfc6891).
 * AXFR is complex, perhaps do more inspection of data coming from AXFR,
   [RFC 5936](https://tools.ietf.org/html/rfc5936).
 * Check for algorithm completeness (DS->DNSKEY->RRSIG) as per section 2.2 of
   [RFC 4035](http://tools.ietf.org/html/rfc4035#section-2.2).
 * domain of the hostmaster email is not an openrelay
 * can deliver email to 'postmaster'
 * can deliver email to hostmaster
 * domain able to receive email (delivery using MX, A, AAAA)
 * test if mail delivery possible
 * ICMP answer
 * Test for referral to root (possible DDoS vector for authoritative name servers)
 * Check to see if removed authoritative name server is still authoritative (requires
   a new input parameter, "previous ns")
 * Test the preservation of qname case in DNS answers, RFC 1035 section 7.1. ("0x20" hack)

Discarded tests
---------------
 * loopback delegation (Section 4.1 of RFC 1912)
 * loopback is resolvable (Section 4.1 of RFC 1912)
 * serial number of the form YYYYMMDDnn (RFC 1912 is not normative)
 * SOA serial may not be zero

Requirements on writing test specifications
-------------------------------------------

These are some requirements for writing specifications for "Zonemaster":

 1. Follow the framework of the IEEE 829-2008.
 2. The documents must be in [Markdown Syntax]
    (http://daringfireball.net/projects/markdown/syntax).
 3. Keep the columns in the document below 80, preferrably shorter than 74
    columns. (Much easier to see changes in documents using the tools
	available for diffing).
 4. Use [normative language]
   (http://en.wikipedia.org/wiki/Normative#Standards_documents).
 5. Refer to any reference that is the rationale for implementing the test
    case. If there are no reference to any standards, describe the reason
    for implementing the test. For most references, we use RFCs from IETF.
 6. Use well defined terms. Terms such as FQDN and FQHN seems to have dual
    meanings.
 7. The name of the test case might be better than the name of the
    requirements. Feel free to improve the name of the test case if it is
    possible to improve on the wording to make the test case clearer for
    the reader and the user of the software. Text from the test cases
    probably will be reused in other contexts.
 8. Be very clear in what DNS queries are performed, and what answers are
	expected. If a specific DNS protocol flag has to be set in the query,
	specify this as well. In general, be closer to describing the DNS
	protocol actions than to use more generic language.
 9. Use the same headers and titles as in all other test cases. Try
	to use the same style as used in the other tests.
 10. Make sure to write the tests so that any implementer that implements
    the tests will have the same outcome as any other implementation.
