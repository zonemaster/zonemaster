Test requirements
=================

Overview
--------
Zonemaster is based on Zonecheck and DNSCheck, and most of the current set
of requirements are derived from those projects.

However, Zonemaster in its current form stands on its own, and this document
describes the current set of requirements on the tests to implement for
Zonemaster.

Any previous mapping detailing the inheritance on the requirements from
Zonecheck and DNSCheck can be found inolder versions of this document.

Source documents
----------------

Most of the requirements are derived from these documents:

Type of document             |Document copied from   |Document
:----------------------------|:----------------------|:------------------------------------
Source document for Zonecheck|Previois Zonecheck site|[Features](supporting-documents/ExistingZCFeaturesCLI.md)
Policy document for Zonecheck|Previois Zonecheck site|[Test Policy](supporting-documents/ExistingZCPolicy.md)
Source document for DNSCheck |DNSCheck Github Wiki   |[Detailes list of all messages](supporting-documents/Detailed-list-of-all-possible-dnscheck-messages.md)


Tests to implement
------------------

|Req| Requirement description                                | Level and Test Case      | 
|:--|:-------------------------------------------------------|:--------------------------------------------|
|R01|UDP connectivity                                        |[CONNECTIVITY](../specifications/tests/Connectivity-TP/connectivity01.md)|
|R02|TCP connectivity                                        |[CONNECTIVITY](../specifications/tests/Connectivity-TP/connectivity02.md)|
|R03|Address in a private network                            |[ADDRESS](../specifications/tests/Address-TP/address01.md)|
|R04|Address should not be part of a bogon prefix            |[ADDRESS](../specifications/tests/Address-TP/address01.md)|
|R05|Illegal symbols in domain name                          |[SYNTAX](../specifications/tests/Syntax-TP/syntax01.md)|
|R06|Dash ('-') at start or beginning of domain name         |[SYNTAX](../specifications/tests/Syntax-TP/syntax02.md)|
|R07|Double dash in domain name                              |[SYNTAX](../specifications/tests/Syntax-TP/syntax03.md)|
|R08|The child domain has atleast one working name server    |[BASIC](../specifications/tests/Basic-TP/basic02.md)|
|R09|At least two nameservers for the domain                 |[DELEGATION](../specifications/tests/Delegation-TP/delegation01.md)|
|R10|Identical addresses                                     |[DELEGATION](../specifications/tests/Delegation-TP/delegation02.md)|
|R11|Nameserver addresses on same subnet                     |[CONNECTIVITY](../specifications/tests/Connectivity-TP/connectivity03.md)|
|R12|Nameserver addresses are all on the same subnet         |[CONNECTIVITY](../specifications/tests/Connectivity-TP/connectivity03.md)|
|R13|Delegation response fit in a 512 byte UDP packet        |[DELEGATION](../specifications/tests/Delegation-TP/delegation03.md)|
|R14|Delegation response with additional fit in a 512 byte UDP packet |[DELEGATION](../specifications/tests/Delegation-TP/delegation03.md)|
|R15|NS record present                                       |[BASIC](../specifications/tests/Basic-TP/basic02.md)|
|R16|NS authoritative answer                                 |[DELEGATION](../specifications/tests/Delegation-TP/delegation04.md)|
|R17|NS name has a valid domain/hostname syntax              |[SYNTAX](../specifications/tests/Syntax-TP/syntax04.md)|
|R18|NS is not an alias                                      |[DELEGATION](../specifications/tests/Delegation-TP/delegation05.md)|
|R19|NS can be resolved                                      |[DELEGATION](../specifications/tests/Delegation-TP/??)|
|R20|SOA record present                                      |[DELEGATION](../specifications/tests/Delegation-TP/delegation06.md)|
|R21|SOA authoritative answer                                |[DELEGATION](../specifications/tests/Delegation-TP/delegation06.md)|
|R22|Missused '@' characters in SOA contact name             |[SYNTAX](../specifications/tests/Syntax-TP/syntax05.md)|
|R23|Illegal characters in SOA contact name                  |[SYNTAX](../specifications/tests/Syntax-TP/syntax06.md)|
|R24|Illegal characters in SOA master nameserver             |[SYNTAX](../specifications/tests/Syntax-TP/syntax07.md)|
|R25|Fully qualified master nameserver in SOA                |[ZONE](../specifications/tests/Zone-TP/zone01.md)|
|R26|SOA 'refresh' at least 6 hours                          |[ZONE](../specifications/tests/Zone-TP/zone02.md)|
|R27|SOA 'retry' lower than 'refresh'                        |[ZONE](../specifications/tests/Zone-TP/zone03.md)|
|R28|SOA 'retry' at least 1 hour                             |[ZONE](../specifications/tests/Zone-TP/zone04.md)|
|R29|SOA 'expire' at least 7 days                            |[ZONE](../specifications/tests/Zone-TP/zone05.md)|
|R31|SOA 'minimum' less than 1 day                           |[ZONE](../specifications/tests/Zone-TP/zone06.md)|
|R32|SOA master is not an alias                              |[ZONE](../specifications/tests/Zone-TP/zone07.md)|
|R33|Coherence of serial number with primary nameserver      |[CONSISTENCY](../specifications/tests/Consistency-TP/consistency01.md)|
|R34|Coherence of administrative contact with primary nameserver |[CONSISTENCY](../specifications/tests/Consistency-TP/consistency02.md)|
|R36|Coherence of SOA with primary nameserver                |[CONSISTENCY](../specifications/tests/Consistency-TP/consistency03.md)|
|R40|Nameserver IP reverse                                   |[ADDRESS](../specifications/tests/Address-TP/address02.md)|
|R41|Nameserver IP reverse matching nameserver name          |[ADDRESS](../specifications/tests/Address-TP/address03.md)|
|R42|Check if server is really recursive                     |[NAMESERVER](../specifications/tests/Nameserver-TP/nameserver01.md)|
|R43|Nameserver doesn't allow recursion                      |[NAMESERVER](../specifications/tests/Nameserver-TP/nameserver01.md)|
|R46|Test if server is recursive                             |[NAMESERVER](../specifications/tests/Nameserver-TP/nameserver01.md)|
|R47|MX record present                                       |[ZONE](../specifications/tests/Zone-TP/zone09.md)|
|R49|MX syntax is valid for an hostname                      |[SYNTAX](../specifications/tests/Syntax-TP/syntax08.md)|
|R50|MX is not an alias                                      |[ZONE](../specifications/tests/Zone-TP/zone08.md)|
|R52|MX can be resolved                                      |[ZONE](../specifications/tests/Zone-TP/zone09.md)|
|R53|Behaviour against AAAA query (RFC 4074)                 |[NAMESERVER](../specifications/tests/Nameserver-TP/nameserver05.md)|
|R54|Nameservers belong all to the same AS                   |[CONNECTIVITY](../specifications/tests/Connectivity-TP/connectivity03.md)|
|R58|Legal values for the DS hash digest algorithm           |[DNSSEC](../specifications/tests/DNSSEC-TP/dnssec01.md)|
|R59|DS must match a DNSKEY in the designated zone           |[DNSSEC](../specifications/tests/DNSSEC-TP/dnssec02.md)|
|R60|Check for too many NSEC3 iterations                     |[DNSSEC](../specifications/tests/DNSSEC-TP/dnssec03.md)|
|R61|Check for too short or too long RRSIG lifetimes         |[DNSSEC](../specifications/tests/DNSSEC-TP/dnssec04.md)|
|R62|Check for invalid DNSKEY algorithms                     |[DNSSEC](../specifications/tests/DNSSEC-TP/dnssec05.md)|
|R63|Verify DNSSEC additional processing                     |[DNSSEC](../specifications/tests/DNSSEC-TP/dnssec06.md)|
|R64|If there exists DNSKEY at child, the parent should have a DS |[DNSSEC](../specifications/tests/DNSSEC-TP/dnssec07.md)|
|R65|RRSIG(DNSKEY) must be valid and created by a valid DNSKEY |[DNSSEC](../specifications/tests/DNSSEC-TP/dnssec08.md)|
|R66|RRSIG(SOA) must be valid and created by a valid DNSKEY  |[DNSSEC](../specifications/tests/DNSSEC-TP/dnssec09.md)|
|R67|There must be NS records for the zone being tested on the parent side |[BASIC](../specifications/tests/Basic-TP/basic01.md)|
|R68|The child domain must have at least one working nameserver |[BASIC](../specifications/tests/Basic-TP/basic02.md)|
|R69|NS records from parent exists, but the child does not have NS but answers for A |[BASIC](../specifications/tests/Basic-TP/basic03.md)|
|R70|Coherence of all other SOA-fields where SOA Serial is the same |[CONSISTENCY](../specifications/tests/Consistency-TP/consistency03.md)|
|R71|Total mismatch between child and parent NS records, delegation works due to same IP |[DELEGATION](../specifications/tests/Delegation-TP/delegation07.md)|
|R72|Test of EDNS0 support                                   |[NAMESERVER](../specifications/tests/Nameserver-TP/nameserver02.md)|
|R73|Test availability of zone transfer (AXFR)               |[NAMESERVER](../specifications/tests/Nameserver-TP/nameserver03.md)|
|R74|Answer from name server came from an IP address other than expected (wrong source IP) |[NAMESERVER](../specifications/tests/Nameserver-TP/nameserver04.md)|
|R76|Zone contains NSEC or NSEC3 records                     |[DNSSEC](../specifications/tests/DNSSEC-TP/dnssec10.md)|
|R77|Perform input validation on the domain name             |[BASIC](../specifications/tests/Basic-TP/basic00.md)|
|R78|All authoritative nameservers reply with same set       |[CONSISTENCY](../specifications/tests/Consistency-TP/consistency04.md)|
|R79|If DS at parent, child zone must be signed              |[DNSSEC](../specifications/tests/DNSSEC-TP/dnssec11.md)|
|R80|Test QNAME case sensitivity                             |[NAMESERVER](../specifications/tests/Nameserver-TP/nameserver09.md)|
|R81|Test Upward referral         			      |[NAMESERVER](../specifications/tests/Nameserver-TP/nameserver07.md)|
|R82|Test QNAME Case insensitivity                            |[NAMESERVER](../specifications/tests/Nameserver-TP/nameserver08.md)|
|R83|Consistency between glue and authoritative data          |[CONSISTENCY](../specifications/tests/Consistency-TP/consistency05.md)|
|R84|Test for DNSSEC Algorithm Completeness (DS->DNSKEY->RRSIG)|[DNSSEC](../specifications/tests/DNSSEC-TP/dnssec12.md)|


Future tests
------------
 * Case insensitivity in a name server, [RFC 4343](https://tools.ietf.org/html/rfc4343).
 * More tests of EDNS(0), [RFC 6891](https://tools.ietf.org/search/rfc6891) and <http://ednscomp.isc.org/>.
 * AXFR is complex, perhaps do more inspection of data coming from AXFR,
   [RFC 5936](https://tools.ietf.org/html/rfc5936).
 * Check for algorithm completeness (DS->DNSKEY->RRSIG) as per section 2.2 of
   [RFC 4035](https://tools.ietf.org/html/rfc4035#section-2.2).
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
 2. The documents must be in 
    [Markdown Syntax](http://daringfireball.net/projects/markdown/syntax).
 3. Keep the columns in the document below 80, preferrably shorter than 74
    columns. (Much easier to see changes in documents using the tools
	available for diffing).
 4. Use 
    [normative language](http://en.wikipedia.org/wiki/Normative#Standards_documents).
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



-------

Copyright (c) 2013-2018, IIS (The Internet Foundation in Sweden)  
Copyright (c) 2013-2018, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <https://creativecommons.org/licenses/by/4.0/>.
