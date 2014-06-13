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
|R01|UDP connectivity                            | NAMESERVER:NO_UDP                           |[CONNECTIVITY01](../specifications/tests/connectivity01.md)|
|R02|TCP connectivity                            | NAMESERVER:NO_TCP                           |Connectivity|
|R03|address in a private network                | ADDRESS:PRIVATE_IPV4                        |Address|
|R04|address should not be part of a bogon prefix | Partly implemented                         |Connectivity|
|R05|illegal symbols in domain name              | HOST:ILLEGAL_NAME / ZONE:INVALID_NAME ?     |Syntax|
|R06|dash ('-') at start or beginning of domain name | HOST:ILLEGAL_NAME / ZONE:INVALID_NAME ? |Syntax|
|R07|double dash in domain name                  | HOST:ILLEGAL_NAME / ZONE:INVALID_NAME       |Syntax|
|R09|at least two nameservers for the domain     | DELEGATION:TOO_FEW_NS                       |Delegation|
|R10|identical addresses                         | DELEGATION:TOO_FEW_NS_IPV4 ?                |Delegation|
|R11|nameserver addresses on same subnet         | __Indirectly done through AS checks (R54)__!                 |Connectivity|
|R12|nameserver addresses are all on the same subnet | __indirectly done through AS checks (R54)__! |Connectivity|
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
|R31|SOA 'minimum' less than 1 day               | SOA:MINIMUM_OK                              |Zone|
|R32|SOA master is not an alias                  | SOA:MNAME_IS_CNAME                          |Zone|
|R33|coherence of serial number with primary nameserver | CONSISTENCY:SOA_SERIAL_CONSISTENT    |Consistency|
|R34|coherence of administrative contact with primary nameserver | CONSISTENCY:SOA_DIGEST_CONSISTENT |Consistency|
|R36|coherence of SOA with primary nameserver    | CONSISTENCY:SOA_DIGEST_CONSISTENT           |Consistency|
|R40|nameserver IP reverse                       | ADDRESS:PTR_NOT_FOUND                       |Address|
|R41|nameserver IP reverse matching nameserver name | __not implemented__?                     |Address|
|R42|check if server is really recursive         | NAMESERVER:RECURSIVE                        |Name server|
|R43|nameserver doesn't allow recursion          | NAMESERVER:RECURSIVE __dup__?               |Name server|
|R46|test if server is recursive                 | NAMESERVER:RECURSIVE __dup__?               |Name server|
|R47|MX record present                           | MAIL:ALL_MX_IN_ZONE                         |Zone|
|R49|MX syntax is valid for an hostname          | MAIL:HOST_ERROR                             |Syntax|
|R50|MX is not an alias                          | MAIL:HOST_ERROR                             |Zone|
|R52|MX can be resolved                          | MAIL:ALL_MX_IN_ZONE __dup__?                |Zone|
|R53|behaviour against AAAA query (RFC 4074)     | __implicit in all other tests__             |Name server|
|R54|nameservers belong all to the same AS       | CONNECTIVITY:TOO_FEW_ASN / CONNECTIVITY:V6_TOO_FEW_ASN |Connectivity|
|R55|serial number of the form YYYYMMDDnn        | New test to identify serial number scheme   |Syntax|


Comment regarding addresses in bogon prefixes: DNSCheck implements checks against invalid addresses defined in RFCs. Since all of IPv4 space has been delegated to the RIRs, that is the whole of the low-volatility bogon space. The high-voltility bogon list would require daily (or even more frequent) updates, which is not practical in a standalone library.


Tests to implement from DNSCheck
--------------------------------

Although the list of [All DNSCheck Messages](https://github.com/dotse/dnscheck/wiki/Detailed-list-of-all-possible-dnscheck-messages)
is comprehensive, it is not a list of tests as such. It is a list of messages emitted by DNSCheck.

|Req| DNSCheck                                                             | DNSCheck | Level |
|:--|:---------------------------------------------------------------------|:---------|:------|
|R58|Legal values for the DS hash digest algorithm                         |&nbsp;    |DNSSEC|
|R59|DS must match a DNSKEY in the designated zone                         |&nbsp;    |DNSSEC|
|R60|Check for too many NSEC3 iterations                                   |&nbsp;    |DNSSEC|
|R61|Check for too short or too long RRSIG lifetimes                       |&nbsp;    |DNSSEC|
|R62|Check for invalid DNSKEY algorithms                                   |&nbsp;    |DNSSEC|
|R63|Verify DNSSEC additional processing                                   |&nbsp;    |DNSSEC|
|R64|If there exists DNSKEY at child, the parent should have a DS          |&nbsp;    |DNSSEC|
|R65|RRSIG(DNSKEY) must be valid and created by a valid DNSKEY             |&nbsp;    |DNSSEC|
|R66|RRSIG(SOA) must be valid and created by a valid DNSKEY                |&nbsp;    |DNSSEC|
|R67|There must be NS records for the zone being tested on the parent side |&nbsp;    |Basic|
|R08|The child domain must have at least one working nameserver            |&nbsp;    |Basic|
|R69|NS records from parent exists, but the child does not have NS but answers for A|&nbsp;|Basic|
|R70|Coherence of all other SOA-fields where SOA Serial is the same        |&nbsp;    |Consistency|
|R71|Total mismatch between child and parent NS records, delegation works due to same IP|&nbsp;    |Delegation|
|R72|Test of EDNS0 support                                                 |&nbsp;    |Name server|
|R73|Test availability of zone transfer (AXFR)                             |&nbsp;    |Name server|
|R74|Answer from name server came from an IP address other than expected (wrong source IP)|&nbsp;|Name server|
|R75|SOA serial may not be zero                                            |&nbsp;    |Delegation|
|R76|Zone contains NSEC or NSEC3 records                                   |&nbsp;    |DNSSEC|

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
