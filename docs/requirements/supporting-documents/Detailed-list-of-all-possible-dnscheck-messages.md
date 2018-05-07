# All DNSCheck Messages

The list is in alphabetical order.

## Address module

* ADDRESS:INVALID

    The provided string was not a syntactically correct IPv4 or IPv6 address. 

* ADDRESS:PRIVATE_IPV4

    The provided address was in one of the blocks marked "Private" in RFC 1918.

* ADDRESS:PTR_HOSTNAME_NOT_FOUND

    A reverse lookup for the provided address returned a hostname where queries 
    for A and AAAA records both either did not return a reply packet or 
    returned reply packets with empty ANSWER sections.

* ADDRESS:PTR_NOT_FOUND

    A reverse lookup for the provided address either did not return a reply packet at 
    all, or returned a reply packet with an empty ANSWER section.

* ADDRESS:RESERVED_IPV4

    The provided address was in one of the blocks marked as "Reserved" in RFC 
    3330 or RFC 5735. 

* ADDRESS:RESERVED_IPV6

    The provided address was in one of the blocks marked as "Reserved" in RFC 
    5156.

* ADDRESS:UNSUITABLE_IPV4

    The provided address was considered unsuitable for use in NS and MX records. An example of an unsuitable address (and at the time of
    writing the only one tested for) is the anycast range for 6to4 gateways, 192.88.99.0/24.

* ADDRESS:UNSUITABLE_IPV6

    As for UNSUITABLE_IPV4, but for IPv6 addresses. Example is 2001::/32, the range assigned to the Teredo system.

## Connectivity module

* CONNECTIVITY:ANNOUNCED_BY_ASN

    Team Cymru has the provided IPv4 address listed as announced by these ASNs. 
    The list may be empty.

* CONNECTIVITY:ASN_COUNT_OK

    The total number of ASNs in which the nameservers for the zone being tested 
    has listed IPv4 addresses is greater than one.

* CONNECTIVITY:ASN_LIST

	These are the ASNs in which the zone being tested has nameserver IPv4 
	addresses.

* CONNECTIVITY:MULTIPLE_ASN

    The provided IPv4 address is announced in more than one ASN (this message 
    does not exist in DNSCheck version 1.1 and later).

* CONNECTIVITY:NOT_ANNOUNCED

    Team Cymru does not list the provided IPv4 address in any ASN.

* CONNECTIVITY:TOO_FEW_ASN

    The total number of ASNs in which the nameservers for the zone being tested 
    has listed IPv4 addresses is zero or one.

* CONNECTIVITY:V6_ANNOUNCED_BY_ASN

    Team Cymru has the provided IPv6 address listed as announced by these ASNs. 
    The list may be empty.

* CONNECTIVITY:V6_ASN_COUNT_OK

    The total number of ASNs in which the nameservers for the zone being tested 
    has listed IPv6 addresses is either zero or larger than one (that is, there 
    is not exactly one ASN).

* CONNECTIVITY:V6_ASN_LIST

    These are the ASNs in which the zone being tested as nameserver IPv6 
    addresses.

* CONNECTIVITY:V6_MULTIPLE_ASN

    The provided IPv6 address is announced in more than one ASN (this message 
    does not exist in DNSCheck version 1.1 and later).

* CONNECTIVITY:V6_NOT_ANNOUNCED

    Team Cymru does not list the provided IPv6 address in any ASN.

* CONNECTIVITY:V6_TOO_FEW_ASN

    The total number of ASNs in which the nameservers for the zone being tested 
    has listed IPv6 addresses is exactly one.

## Consistency module

* CONSISTENCY:MULTIPLE_NS_SETS

    All child-side nameservers do not respond with the same set of records to an NS query for the zone.

* CONSISTENCY:NS_SETS_OK

    All child-side nameservers do respond with the same set of records to an NS query for the domain.

* CONSISTENCY:NS_SET_AT

    The nameserver with the given address responded with the listed records to an NS query for the zone being tested.

* CONSISTENCY:SOA_DIGEST_AT_ADDRESS

    The hexadecimal SHA-1 digest of the MNAME, RNAME, REFRESH, RETRY, EXPIRE 
    and MINIMUM values from a SOA record concatenated with ':' characters. The 
    SOA record was fetched from the nameserver at the given address for the 
    zone being tested.

* CONSISTENCY:SOA_DIGEST_CONSISTENT

    The digests calculated from the SOA records returned from all listed 
    nameservers, both in the zone itself and its parent, were all the same.

* CONSISTENCY:SOA_DIGEST_DIFFERENT

    The digests calculated from the SOA records returned from all listed 
    nameservers, both in the zone itself and its parent, were not all the same. 
    The number of different digests seen is included in this message.

* CONSISTENCY:SOA_SERIAL_AT_ADDRESS

    The SOA serial number from the record fetched from the given address for 
    the zone being tested.

* CONSISTENCY:SOA_SERIAL_CONSISTENT

    The SOA serial numbers fetched from all the listed nameservers, both in the 
    zone and its parent, were the same.

* CONSISTENCY:SOA_SERIAL_DIFFERENT

    The SOA serial numbers fetched from all the listed nameservers, both in the 
    zone itself and its parent, were not all the same. The number of different 
    serial numbers seen is included in this message.

## Delegation module

* DELEGATION:BROKEN_UNDELEGATED

    We tried to run an undelegated test without any fake glue. That does not 
    make sense.

* DELEGATION:EXTRA_NS_CHILD

    This name appeared in the list of nameservers taken from the child side, 
    but not in the list taken from the parent side.


* DELEGATION:EXTRA_NS_PARENT

    This name appeared in the list of nameservers taken from the parent side, 
    but not in the list taken from the child side.

* DELEGATION:GLUE_FOUND_AT_CHILD

    A nameserver listed at the parent side had an A or AAAA record on at least 
    one of the parent-side nameservers, and an identical record was also found 
    on at least one of the child-side nameservers.

* DELEGATION:GLUE_FOUND_AT_PARENT

    An A or AAAA record for a nameserver listed at the parent side was found on 
    at least one of the parent-side nameservers.

* DELEGATION:GLUE_MISSING_AT_CHILD

    A query to a child-side nameserver for a glue record found at the parent 
    side resulted in either an empty response or an unexpected result.

* DELEGATION:INCONSISTENT_GLUE

    A nameserver listed at the parent side had an A or AAAA record on at least 
    one of the parent-side nameservers, and a record with the same name but 
    different content was found on at least one of the child-side nameservers.

* DELEGATION:INZONE_NS_WITHOUT_GLUE

    An NS record with a name in the zone being tested and for the zone being 
    tested was found on the parent side, but no corresponding A or AAAA record 
    was found.

* DELEGATION:IPV6_ONLY_AT_CHILD

    This message only exists in DNSCheck version 1.2.2 and 1.2.3.

* DELEGATION:IPV6_ONLY_AT_PARENT

    This message only exists in DNSCheck version 1.2.2 and 1.2.3.

* DELEGATION:MATCHING_GLUE

    This name was given as a nameserver for the zone being tested on at least 
    one parent nameserver, and the name had an A or AAAA record on at least one 
    parent nameserver.

* DELEGATION:CHILD_GLUE_NOT_AUTH

    When asked for an address record for the name of one of the zone's nameservers, a child-side nameserver gave a response that did not have the
    AA flag set.

* DELEGATION:CHILD_GLUE_CNAME

    When asked for an address record for the name of one of the zone's nameservers, a child-side nameserver gave a response that contained a
    CNAME record in the answer section.

* DELEGATION:CHILD_GLUE_DNAME

    When asked for an address record for the name of one of the zone's nameservers, a child-side nameserver gave a response that contained a
    DNAME record in the answer section.

* DELEGATION:REFERRAL_FOLLOWED

    When asked for an address record for the name of one of the zone's nameservers, a child-side nameserver gave a response that was a referral,
    which DNSCheck followed.

* DELEGATION:GLUE_BROKEN_REFERRAL

    When asked for an address record for the name of one of the zone's nameservers, a child-side nameserver gave a response that was a referral
    that did not eventually lead to a proper answer.

* DELEGATION:GLUE_ERROR_AT_CHILD

    When asked for an address record for the name of one of the zone's nameservers, a child-side nameserver either did not respond at all or gave
    a response that had an RCODE of SERVFAIL or REFUSED.

* DELEGATION:MIN_REFERRAL_SIZE_OK

    Given the NS RRset from a randomly chosen child-side nameserver, and A and AAAA records for those name from global recursive queries,
    it was possible to construct a referral packet of 512 octets or less containing a QUERY section with a maximum-length name, an
    AUTHORITY section with NS records for all nameservers and an ADDITIONAL holding an A record for an in-zone nameserver (if any) and an
    AAAA record for an in-zone nameserver (if any).
    
    More simply put, we could build a referral packet usable by resolvers that do not understand EDNS0.

* DELEGATION:MIN_REFERRAL_SIZE_TOO_BIG

    Given the same constraints as for MIN_REFERRAL_SIZE_OK, we could _not_ build a packet of 512 octets or less. That is, this zone will
    not be resolvable without EDNS0.

* DELEGATION:NOT_FOUND_AT_CHILD

    No NS records for the zone being tested were found on the child side.

* DELEGATION:NOT_FOUND_AT_PARENT

    No NS records for the zone being tested were found on the parent side.

* DELEGATION:NO_COMMON_NS_NAMES

    The set of NS names on the parent side and the set of NS names on the child 
    side are disjoint. One or more of the addresses associated with parent-side 
    NS records do lead to at least one child-side nameserver, though, so 
    delegation to the zone does work.

* DELEGATION:NO_NS_IPV4

    In the set of NS records for the zone being tested that was returned from a 
    recursive query to the global DNS tree, no IPv4 addresses were returned 
    from similarly global recursive A queries.

* DELEGATION:NO_NS_IPV6

    In the set of NS records for the zone being tested that was returned from a 
    recursive query to the global DNS tree, no IPv6 addresses were returned 
    from similarly global recursive AAAA queries.

* DELEGATION:NS_AT_CHILD

    This is the list of nameservers retrieved from the child side.

* DELEGATION:NS_AT_PARENT

    This is the list of nameservers retrieved from the parent side.

* DELEGATION:NS_HISTORY

    This is a list of known previous nameservers for the tested zone. Empty 
    unless DNSCheck is configured to use MySQL.

* DELEGATION:NS_IS_CNAME

    While asking the child-side nameservers for A and AAAA records for all 
    nameservers listed at the child side, a CNAME record was returned for at 
    least one of them.

* DELEGATION:POSSIBLE_EXTRA_NS_PARENT

    This message was only used for undelegated tests prior to DNSCheck version 
    0.90.

* DELEGATION:STILL_AUTH

    A server stored in MySQL as a previous nameserver for the zone being tested 
    answered with the AA flag set to a SOA query for the zone.

* DELEGATION:TOO_FEW_NS

    The lists of nameservers on the parent and child side only had one name in 
    common.

* DELEGATION:TOO_FEW_NS_IPV4

    In the set of NS records for the zone being tested that was returned from a 
    recursive query to the global DNS tree, only one IPv4 addresse was returned 
    from similarly global recursive A queries.

* DELEGATION:TOO_FEW_NS_IPV6

    In the set of NS records for the zone being tested that was returned from a 
    recursive query to the global DNS tree, only one IPv6 addresse was returned 
    from similarly global recursive AAAA queries.

* DELEGATION:BROKEN_BUT_FUNCTIONAL

    The zone was judged to be untestable by the rest of the Delegation tests,
    but we could still get an answer to an A query for either the zone name itself
    or the zone name with "www." prepended. That is, it is probably possible to
    access a web site at the zone, even though it does not properly exist.

## DNS Lookup module

* DNS:LOOKUP_ERROR

    A DNS query sent resulted in either no response at all, a response with 
    rcode FORMERR, or a response with rcode SERVFAIL that was not caused by a 
    server timeout.

* DNS:NO_ANSWER

    A DNS query sent resulted in something that...
    
    * Did not have rcode NOERROR.
    * Did not have rcode SERVFAIL and was a query for a SOA record.
    * Did not have rcode FORMERR.
    * Was a return packet.
    * Was not a timeout.

* DNS:NO_CHILD_NS

    The method to query child-side nameservers didn't find any child-side 
    nameservers.

* DNS:NO_EDNS

    A response with rcode FORMERR was recieved for a query with the bufsize or 
    DNSSEC flags turned on.

* DNS:NO_PARENT

    The method for finding the parent zone of a DNS name failed.

* DNS:NO_PARENT_NS

    The method to query parent-side nameservers didn't find any parent-side 
    nameservers.

* DNS:NXDOMAIN

    The method for finding the parent zone of a DNS name did not produce a 
    result.

* DNS:SOA_SERVFAIL

    A query for a SOA record gave a response with a SERVFAIL rcode.

* DNS:UNQUERIBLE_ADDRESS

    The Net::IP module did not consider the address to be of type "PUBLIC" or 
    "GLOBAL-UNICAST".

## DNSSEC module

* DNSSEC:ADDITIONAL_PROCESSING_BROKEN

    A query for DNSKEY with the DNSSEC flag set returned a packet without any 
    RRSIG records, but a direct RRSIG query to a randomly chosen child-side 
    server did return one or more RRSIG records.

* DNSSEC:ALGORITHM_OK

    The algorithm id used in a DNSKEY or DS record was one of RSA/MD5, 
    Diffie-Hellman, DSA/SHA1, RSA/SHA-1, DSA-NSEC3-SHA1, RSA-NSEC3-SHA1, 
    RSA/SHA-256, RSA/SHA-512 or GOST R 34.10-2001.

* DNSSEC:ALGORITHM_PRIVATE

    The algorithm id used in a DNSKEY or DS record was one marked private.

* DNSSEC:ALGORITHM_RESERVED

    The algorithm id used in a DNSKEY or DS record was one marked reserved.

* DNSSEC:ALGORITHM_UNASSIGNED

    The algorithm id used in a DNSKEY or DS record was unassigned.

* DNSSEC:CHECKING_CHILD

    DNSCheck is starting to check the child side DNSSEC of the zone.

* DNSSEC:CHECKING_PARENT

    DNSCheck is starting to check the parent side DNSSEC of the zone.

* DNSSEC:CHILD_CHECKED

    DNSCheck child-side DNSSEC checking concluded.

* DNSSEC:CHILD_CHECK_ABORTED

    DNSCheck child-side checking aborted since no RRSIG records were found.

* DNSSEC:CONSISTENT_EXTRA_PROCESSING

    All the child-side nameservers have extra processing turned on, or all of 
    them have it turned off.

* DNSSEC:CONSISTENT_SECURITY

    A DS record for the zone was found at the parent side, and at least one 
    DNSKEY record on the child side.

* DNSSEC:DNSKEY_ALGORITHM

    The specified DNSKEY uses the stated algorithm.

* DNSSEC:DNSKEY_FOUND

    At least one child-side nameserver returned at least one DNSKEY record.

* DNSSEC:DNSKEY_MANDATORY_FOUND

    This message was removed in DNSCheck version 1.2.

* DNSSEC:DNSKEY_MANDATORY_NOT_FOUND

    This message was removed in DNSCheck version 1.2.

* DNSSEC:DNSKEY_NOT_FOUND

    None of the child-side nameservers returned any DNSKEY records.

* DNSSEC:DNSKEY_NO_VALID_SIGNATURES

    The DNSKEY RRset does not contain a key that signs the set.

* DNSSEC:DNSKEY_SEP

    The DNSKEY record with the given keytag has the Secure Entry Point flag set.

* DNSSEC:DNSKEY_SIGNER_UNPUBLISHED

    The DNSKEY RRset was signed with an RRSIG having a keytag that was not 
    found on any of the DNSKEY records.

* DNSSEC:DNSKEY_SKIP_PROTOCOL

    The indicated DNSKEY record had a protocol field that was not set to 3.

* DNSSEC:DNSKEY_SKIP_TYPE

    The indicated DNSKEY record did not have the zone key flag bit set.

* DNSSEC:DNSKEY_VALID_SIGNATURES

    At least one valid signature was found for the zone DNSKEY RRset.

* DNSSEC:DS_ALGORITHM

    The DS record for the zone being tested uses this algorithm.

* DNSSEC:DS_FOUND

    At least one of the parent-side nameservers returned a DS record for the 
    zone being tested.

* DNSSEC:DS_KEYREF_INVALID

    The DS record for the zone returned by the parent-side nameservers does not 
    correctly sign any of the DNSKEY records returned by the child-side 
    nameservers.

* DNSSEC:DS_KEYREF_OK

    The DS record for the zone returned by the parent-side nameservers 
    correctly signs a valid DNSKEY record existing on at least one of the 
    child-side nameservers.

* DNSSEC:DS_MANDATORY_FOUND

    This message was removed in DNSCheck version 1.2.

* DNSSEC:DS_MANDATORY_NOT_FOUND

    This message was removed in DNSCheck version 1.2.

* DNSSEC:DS_TO_NONSEP

    The DNSKEY records received from the child-side nameservers contain at 
    least one with the Secure Entry Point flag set, but the DS record on the 
    parent side does not sign a DNSKEY record with that flag set.

* DNSSEC:DS_TO_SEP

    The DS record for the zone found on the parent-side nameservers correctly 
    signs a DNSKEY record from the child-side nameservers that has the SEP flag 
    set.

* DNSSEC:EXTRA_PROCESSING

    When asked for DNSKEY records for the zone being tested with the DNSSEC 
    flag set in the query, the stated nameserver included RRSIG records with 
    the answer.

* DNSSEC:INCONSISTENT_EXTRA_PROCESSING

    Some of the child-side nameservers included RRSIG records with the answer 
    when queried for DNSKEY records for the zone being tested with the DNSSEC 
    flag set in the query, and some did not.

* DNSSEC:INCONSISTENT_SECURITY

    A DS record for the zone being tested was found at the parent nameservers, 
    but no DNSKEY records were returned by the child-side servers.

* DNSSEC:MISSING_DS

    At least one of the child-side nameservers returned at least one DNSKEY 
    record for the zone being tested, but no DS record was found on the 
    parent-side servers.

* DNSSEC:NO_DS_FOUND

    A DS query to the parent-side servers did not return any such records.

* DNSSEC:NO_EXTRA_PROCESSING

    When asked for DNSKEY records for the zone being tested with the DNSSEC 
    flag set in the query, the stated nameserver did not include RRSIG records 
    with the answer.

* DNSSEC:NO_SIGNATURES

    An RRSIG query to the child-side nameservers did not return any such 
    records.

* DNSSEC:NO_VALID_DS

    Either no DS record was found, or none of those that were found did 
    correctly sign a valid DNSKEY on the child side.

* DNSSEC:PARENT_CHECKED

    DNSSEC checking of the parent side has concluded.

* DNSSEC:RRSIG_EXPIRED

    The specified RRSIG's validity period is expired according to the local 
    machine clock.

* DNSSEC:RRSIG_EXPIRES_AT

    The RRSIG being looked at is inside its validity period according to the 
    system clock, and it will expire at the stated time.

* DNSSEC:RRSIG_FAILS_VERIFY

    Cryptographic verification of the given RRSIG over the specified RRset and 
    DNSKEY failed.

* DNSSEC:RRSIG_NOT_YET_VALID

    The validity period for the specified RRSIG has not yet arrived, according 
    to the system clock.

* DNSSEC:RRSIG_VALID

    The RRSIG in question is inside its validity period and does 
    cryptographically sign its intended RRset and DNSKEY.

* DNSSEC:RRSIG_VERIFIES

    Cryptographic verification of the given RRSIG over the specified RRset and 
    DNSKEY succeeded.

* DNSSEC:SKIPPED_NO_KEYS

    DNSSEC checking aborted, since no child-side nameserver returned any DNSKEY 
    records.

* DNSSEC:SOA_NO_VALID_SIGNATURES

    Either the SOA RRset did not come with RRSIG records, or none of the RRSIGs 
    that accompanied it were valid and cryptographically sound.

* DNSSEC:SOA_SIGNER_UNPUBLISHED

    The SOA RRset came accompanied with RRSIG records, but the RRSIG records 
    were signed with a key that was not found in the zone's DNSKEY RRset.

* DNSSEC:SOA_VALID_SIGNATURES

    The SOA RRset for the zone being tested was accompanied by suitable RRSIG 
    records, at least one of which was within its validity period and 
    cryptographically matched the correct DNSKEY.

## Host module

* HOST:CNAME_FOUND

    Global recursive A and AAAA lookups for the given name returned at least 
    one CNAME record.

* HOST:ILLEGAL_NAME

    The name in question does not meet all the requirements spelled out in RFCs 
    952, 1123, 2181 and 3696. That is, one or more of the following are true:
    
    * The total length of the name is greater than 255 octets.

    * The rightmost label consists entirely of digits.

    * One or more labels in the name is longer than 63 octets.

    * One or more labels in the name contains characters that are not 
      letters, digits or - according to ASCII.

    * One or more labels in the name starts or ends with a character that is 
      not a letter or digit according to ASCII.

* HOST:NOT_FOUND

    Global recursive A and AAAA queries for the given name did not return any 
    records in the ANSWER sections of the responses.

## Mail module

* MAIL:ADDRESS_SYNTAX

    The given email address is not syntactically valid according to RFC822.

* MAIL:ALL_MX_IN_ZONE

    All the suitable names for mail delivery are inside the zone being tested. 
    Suitable names are those listed in MX records, if any. If there are no MX 
    records, it is the name of the zone itself if it has an A record or an AAAA 
    record.

* MAIL:DELIVERY_IPV4_NOT_OK

    SMTP tests over IPv4 on all potential mailhosts failed.

* MAIL:DELIVERY_IPV4_OK

    SMTP tests over IPv4 succeeded on at least one potential mailhost.

* MAIL:DELIVERY_IPV6_NOT_OK

    SMTP tests over IPv6 on all potential mailhosts failed.

* MAIL:DELIVERY_IPV6_OK

    SMTP tests over IPv6 succeeded on at least one potential mailhost.

* MAIL:DOMAIN_NOT_FOUND

    There were no MX records with names that could be resolved to A or AAAA 
    records, nor where there A or AAAA records for the zone name itself.

* MAIL:HOST_ERROR

    The indicated potential mailhost name did not pass the DNSCheck hostname 
    tests.

* MAIL:IPV6_ONLY

    The indicated potential mailhost is only reachable over IPv6.

* MAIL:MAIL_EXCHANGER

    This message lists all the potential mailhosts found.

## Nameserver module

* NAMESERVER:AUTH

    A SOA query for the zone being tested sent to the specified nameserver got 
    a response with the AA header flag set.

* NAMESERVER:AXFR_CLOSED

    An AXFR request for the zone being tested sent to the specified nameserver 
    did not return any records.

* NAMESERVER:AXFR_OPEN

    An AXFR request for the zone being tested sent to the specified nameserver 
    returned at least one record.

* NAMESERVER:AXFR_SKIP

    The specified nameserver failed the TCP connection test, so the AXFR test 
    was not attempted.

* NAMESERVER:HOST_ERROR

    The specified nameserver name failed the hostname test.

* NAMESERVER:LEGACY_ID

    The specified nameserver returned one or more TXT records when sent a TXT 
    CH query for the name of the zone being tested.

* NAMESERVER:LEGACY_ID_SKIP

    Both the TCP and UDP connection tests have failed for the specified 
    nameserver, so the ID test is skipped.

* NAMESERVER:NOT_AUTH

    A SOA query for the zone being tested sent to the specified nameserver did 
    not get a response with the AA header flag set.

* NAMESERVER:NOT_RECURSIVE

    A SOA query for an almost certainly nonexistent name sent to the indicated 
    server, with the recursion request and DNSSEC flags set, resulted in no 
    response at all, or a response with the recursion available flag unset, a 
    return code of SERVFAIL or REFUSED, or containing a referral to other 
    servers.

* NAMESERVER:NOT_SAME_SOURCE

    A query sent to this IP address got a response sent from a different IP address.

* NAMESERVER:NO_TCP

    A SOA query for the zone being tested sent to the indicated nameserver over 
    TCP did not return a response packet.

* NAMESERVER:NO_UDP

    A SOA query for the zone being tested sent to the indicated nameserver over 
    UDP did not return a response packet.

* NAMESERVER:NSID

    While this message exists in the policy and localization files, it can not 
    be issued by the testing code.

* NAMESERVER:NSID_SKIP

    While this message exists in the policy and localization files, it can not 
    be issued by the testing code.

* NAMESERVER:RECURSIVE

    A SOA query for an almost certainly nonexistent name sent to the indicated 
    server, with the recursion request and DNSSEC flags set, resulted in a 
    response with the recursion available flag set, an rcode other than 
    SERVFAIL or REFUSED and not referring to other servers.

* NAMESERVER:SAME_SOURCE

    A query sent to this IP address got a response sent from the same IP address.

* NAMESERVER:SKIPPED_IPV4

    IPv4 has been disabled in the DNSCheck configuration.

* NAMESERVER:SKIPPED_IPV6

    IPv6 has been disabled in the DNSCheck configuration.

* NAMESERVER:TCP_OK

    A SOA query for the zone being tested sent to the indicated nameserver over 
    TCP did return a response packet

* NAMESERVER:UDP_OK

    A SOA query for the zone being tested sent to the indicated nameserver over 
    UDP did return a response packet

## SMTP module

* SMTP:BANNER

    This message gives the HELO or EHLO banner message from the mail server 
    connected to, and (for EHLO) the list of announced extensions.

* SMTP:CONNECT_FAILED

    The new() method in the Net::SMTP module returned the undefined value.

* SMTP:HELLO_FAILED

    The SMTP HELO/EHLO command did not get a return code in the 200 series. 
    It's unclear if this message can ever be issued, since in the case of 
    HELO/EHLO failing the underlying Net::SMTP object creation will fail, 
    resulting in DNSCheck issuing CONNECT_FAILED instead. It is the case that 
    over the course of almost ten million DNSCheck runs, this message has never 
    been seen.

* SMTP:MAIL_FROM_REJECTED

    Initiating a mail transfer with sender address "<>" did not get a 
    200-series response code.

* SMTP:OK

    The SMTP transaction concluded without errors.

* SMTP:RECIPIENT_REJECTED

    Giving the specified email address as the recipient did not get a 200- or 
    400-series response code.

* SMTP:TIMEOUT

    An SMTP command timed out rather than get an answer.

## SOA module

* SOA:EXPIRE_OK

    The expire value in the SOA record is greater than or equal to the 
    SOA:MIN_EXPIRE configuration setting.

* SOA:EXPIRE_SMALL

    The expire value in the SOA record is smaller than the SOA:MIN_EXPIRE 
    configuration setting.

* SOA:EXPIRE_VS_REFRESH

    The expire value in the SOA record is at least as many times greater than 
    the refresh value as the SOA:EXPIRE_VS_REFRESH configuration setting.

* SOA:FOUND

    At least one child-side nameserver returned at least one SOA record when 
    sent a SOA query for the domain being tested.

* SOA:MINIMUM_LARGE

    The minimum value in the SOA record is greater than the SOA:MAX_MINIMUM 
    configuration value.

* SOA:MINIMUM_OK

    The SOA minimum value is smaller than or equal to the SOA:MAX_MINIMUM 
    configuration value, and it is greater than or equal to the SOA:MIN_MINIMUM 
    value.

* SOA:MINIMUM_SMALL

    The SOA minimum value is smaller than the SOA:MIN_MINIMUM configuration 
    value.

* SOA:MNAME_ERROR

    The DNSCheck Host test reported an error for the SOA mname.

* SOA:MNAME_IS_AUTH

    A SOA query for the zone being tested gave either no response at all or a 
    response with the AA flag set from the indicated nameserver.

* SOA:MNAME_IS_CNAME

    At least one of the records in the answer section of the reply to a global 
    recursive NS query for the zone being tested was a CNAME, and this record 
    happened to be earlier in the section than any NS records matching the name 
    in the SOA record's mname field.

* SOA:MNAME_NOT_AUTH

    A SOA query for the zone being tested gave a response without the AA flag 
    set from the indicated nameserver.

* SOA:MNAME_PUBLIC

    The name in the mname field in the SOA record was found in the nsdname 
    field of an NS record in the response from a global recursive NS query for 
    the zone being tested, and none of the preceeding records in the same 
    answer section were CNAMEs.

* SOA:MNAME_STEALTH

    The requirements for SOA:MNAME_PUBLIC were not met.

* SOA:MNAME_VALID

    The mname field in the SOA record passes the DNSCheck hostname test.

* SOA:MULTIPLE_SOA

    When sent a SOA query for the zone being tested, one of the child-side 
    nameservers gave a reply with more than one record in the answer section.

* SOA:NOT_FOUND

    Either none of the child-side nameservers gave a response to a SOA query 
    for the zone being tested, or the first of them to do so gave a response 
    that either had an empty answer section or an answer section where the 
    first record was not a SOA record.

* SOA:NS_NOT_FOUND

    A global recursive NS query for the zone being tested either did not return 
    a reply at all, or returned a reply with an empty answer section.

* SOA:REFRESH_OK

    The SOA refresh value is equal to or greater than the SOA:MIN_REFRESH 
    configuration value.

* SOA:REFRESH_SMALL

    The SOA refresh value is smaller than the SOA:MIN_REFRESH configuration 
    value.

* SOA:RETRY_OK

    The SOA retry value is equal to or greater than the SOA:MIN_RETRY 
    configuration value.

* SOA:RETRY_SMALL

    The SOA retry value is smaller than the SOA:MIN_RETRY configuration value.

* SOA:RETRY_VS_REFRESH

    The SOA retry value is equal to or greater than the SOA refresh value.

* SOA:RNAME_DELIVERABLE

    The rname value in the SOA record has at least one unescaped "." character 
    in it, and with the first such character replaced by an "@" the resulting 
    address passes the DNSCheck Mail tests.

* SOA:RNAME_SYNTAX

    The SOA rname value does not have at least one unescaped "." character.

* SOA:RNAME_UNDELIVERABLE

    The rname value in the SOA record has at least one unescaped "." character 
    in it, and with the first such character replaced by an "@" the resulting 
    address fails the DNSCheck Mail tests.    

* SOA:SERIAL_IS_ZERO

    The SOA serial value is zero.

* SOA:SKIPPED_IPV4

    Testing of the specified IPv4 address is skipped since DNSCheck was 
    configured not to use IPv4.

* SOA:SKIPPED_IPV6

    Testing of the specified IPv4 address is skipped since DNSCheck was 
    configured not to use IPv6.

* SOA:TTL_OK

    The SOA ttl value is equal to or greated than the SOA:MIN_TTL configuration 
    parameter.

* SOA:TTL_SMALL

    The SOA ttl value is smaller than the SOA:MIN_TTL configuration parameter.

## Zone module

* ZONE:FATAL_DELEGATION

    The DNSCheck Delegation test reported that the zone is not testable.

* ZONE:FATAL_NO_CHILD_NS

    This message can not be issued, since in the case it would be the 
    Delegation test would already have failed.

* ZONE:INVALID_NAME

    The name of the zone to the be tested did not pass the DNSCheck hostname 
    syntax tests.

## Messages not included in the policy file

*  ASN:ANNOUNCE_BY

    The specified IP address was announced by the given ASN(s), according to 
    Team Cymru.

*  ASN:INVALID_ADDRESS

    The address could not be parsed as an IPv4 or IPv6 address.

*  ASN:LOOKUP

    ANS lookup will be attempted for the specified address.

*  ASN:LOOKUP_ERROR

    The lookup request to the cymru-style server failed.

*  ASN:NOT_ANNOUNCE

    The specified IP address was not announced by any ASN, according to Team 
    Cymru.

*  DELEGATION:GLUE_SKIPPED

    The specified glue data was not included in further testing since it was 
    out of zone, or it came in a response packet that was a referral or had 
    rcode SERVFAIL or REFUSED.

*  DNS:ADDRESS_BLACKLISTED

    The specified nameserver address has been blacklisted and will not be queried.

*  DNS:ADDRESS_BLACKLIST_ADD

    The specified address has been added to the blacklist.

*  DNS:ANSWER_DUMP

    String representation of one RR in a response packet to an explitly sent query.

*  DNS:CHILD_RESPONSE

    A child-side query got a response packet, which was cached and returned to 
    the application.

*  DNS:DNSSEC_DESIRED

    Message no longer generated since DNSCheck version 0.90

*  DNS:DNSSEC_DISABLED

    Message no longer generated since DNSCheck version 0.90

*  DNS:EXPLICIT_RESPONSE

    A response packet was recieved from a specified nameserver, and that packet 
    was not a FORMERR response, not a SERVFAIL response to a SOA query, or the 
    packet did not have the AA flag set but the query was flagged aaonly.

*  DNS:FIND_ADDRESSES

    The find_addresses() method has been called for the specified name.

*  DNS:FIND_ADDRESSES_RESULT

    Global recursive queries for the A and AAAA records for the specified name 
    resulted in these IP addresses.

*  DNS:FIND_MX_BEGIN

    The find_mx() method has been called for the specified domain name.

*  DNS:FIND_MX_RESULT

    The listed names are the mail exchangers for the specified zone in 
    preference order, or the zone name itself if a global recursive query for 
    MX records did not return any, but global recursive queries for A and AAAA 
    records for the zone name did.

*  DNS:FIND_PARENT

    The method to send a query to a randomly chosen parent-side nameserver is 
    about to call the method to find the parent zone.

*  DNS:FIND_PARENT_BEGIN

    The method _find_parent_helper() has started running.

*  DNS:FIND_PARENT_DOMAIN

    A global recursive SOA query for the zone being tested returned a packet 
    that has either a SOA or a CNAME record in the answer section, or has a SOA 
    record in the authority section.

*  DNS:FIND_PARENT_RESULT

    The process of removing the leftmost label of the zone name and making a 
    global recursive SOA query for the modified name, then comparing the name 
    field in the returned record with the one that was earlier returned by a 
    similar query for the unmodified name, ended by both names being the same 
    or by the name running out of labels.

*  DNS:FIND_PARENT_TRY

    The name resulting from removing the leftmost label of an earlier name.

*  DNS:FIND_PARENT_UPPER

    The name that was returned by the recursive global SOA query for the 
    modified name.

*  DNS:GET_NS_AT_CHILD

    About to send an NS query for the specified zone to a randomly chosen 
    child-side server.

*  DNS:GET_NS_AT_PARENT

    About to send an NS query for the specified zone to a randomly chosen 
    parent-side server.

*  DNS:INITIALIZING_NAMESERVERS

    About to try to fill the nameserver cache with data about the specified 
    zone.

*  DNS:MALFORMED_FAKE_IP

    The IP address given for a nameserver in the data for an undelegated test 
    could not be successfully parsed as an IPv4 or IPv6 address.

*  DNS:NAMESERVERS_INITIALIZED

    An attempt to fill the nameserver cache has been made.

*  DNS:NAMESERVER_FOUND

    An IP address was found for a nameserver name.

*  DNS:NOT_AUTH

    A response to a query explicitly sent to a particular server was received, 
    but it was discarded since it did not have the AA flag set and the caller 
    of the query_explicit() method had requested to only get authoritative 
    responses.

*  DNS:PARENT_OF

    The specified name was returned from the find_parent() method as the parent 
    zone for the also specified zone.

*  DNS:PARENT_RESPONSE

    A query sent to a randomly chosen parent-side nameserver returned a response.

*  DNS:QUERY_CHILD

    A query is about to be sent to the child-side nameservers or fetched from 
    the cache of previous queries.

*  DNS:QUERY_CHILD_NOCACHE

    A query is about to be sent to the child-side nameservers.

*  DNS:QUERY_EXPLICIT

    A query is about to possibly be sent to a specific nameserver.

*  DNS:QUERY_PARENT

    A query is about to be sent to the parent-side nameservers or fetched from 
    the cache of previous queries.

*  DNS:QUERY_PARENT_NOCACHE

    A query is about to be sent to the parent-side nameservers.

*  DNS:QUERY_RESOLVER

    A lookup in the cache or a global recursive query is about to be done.

*  DNS:QUERY_TIMEOUT

    A query sent to one or more nameservers timed out.

*  DNS:RECURSION_DESIRED

    Message no longer generated since DNSCheck version 0.90

*  DNS:RECURSION_DISABLED

    Message no longer generated since DNSCheck version 0.90

*  DNS:RESOLVER_QUERY_TIMEOUT

    A global recursive query timed out.

*  DNS:RESOLVER_RESPONSE

    A global recursive query received a response packet.

*  DNS:SETUP_RESOLVER

    About to configure and return a resolver object according to given flags.

*  DNS:SET_BUFSIZE

    The UDP packet size for a particular resolver object has been set to the 
    specified size.

*  DNS:TRANSPORT_TCP

    The resolver object that has just been created is using TCP transport for 
    queries.

*  DNS:TRANSPORT_UDP

    The resolver object that has just been created is using UDP transport for 
    queries.

*  DNSSEC:CHECKING_DNSKEY_AT_CHILD

    About to go through all child-side nameservers, ask for DNSKEY RRsets and 
    remember the last one returned for later use.

*  DNSSEC:CHECKING_DS_AT_PARENT

    About to query a randomly chosen parent-side nameserver for a DS record for 
    the zone being tested.

*  DNSSEC:DETERMINE_SECURITY_STATUS

    About to do a comparison of the existence or not of DS and DNSKEY.

*  DNSSEC:DNSKEY_SIGNATURE_OK

    The DNSKEY RRset with the specified keytag is correctly signed.

*  DNSSEC:DS_ALGORITHM_MD5

    The DS record found for the zone being tested used the algorithm RSA/MD5.

*  DNSSEC:PARENT_DS

    The specified DS record was found for the zone being tested.

*  DNSSEC:SOA_SIGNATURE_OK

    The SOA RRset was correctly signed by a key with the specified keytag.

*  FAKEGLUE:BROKEN_INFO

    The resolver object did not accept the specified name and IP address as 
    fake glue.

* FAKEGLUE:MALFORMED_DS

    The DS record given for an undelegated test could not be parsed by Net::DNS::RR::DS.

*  FAKEGLUE:NO_ADDRESS

    Only a nameserver name was given for fake glue, and no IP addresses were 
    returned from global recursive A and AAAA queries.

*  NAMESERVER:CHECKING_AUTH

    About to check if the specified nameserver is authoritative.

*  NAMESERVER:CHECKING_LEGACY_ID

    About to check the legacy ID of the specified nameserver.

*  NAMESERVER:CHECKING_RECURSION

    About to check if the specified nameserver is recursive.

*  NAMESERVER:TESTING_AXFR

    About to check if the specified nameserver allows AXFR of the zone being 
    tested.

*  NAMESERVER:TESTING_TCP

    About to check if the specified nameserver responds to queries sent via TCP.

*  NAMESERVER:TESTING_UDP

    About to check if the specified nameserver responds to queries sent via UDP.

*  NSTIME:AVERAGE

    Summary of response times for the specified nameserver over all queries 
    sent to it during the use of a particular resolver object. The values are, 
    in order, the number of queries, the average time taken, the minimum time 
    take, the maximum time taken and the standard deviation of times.

*  SMTP:MAIL_FROM

    Doing the "MAIL FROM" step of an SMTP transaction with the specified name.

*  SMTP:QUIT

    Doing the QUIT step of an SMTP transaction.

*  SMTP:RAW

    A message received from the other end of an SMTP transaction.

*  SMTP:RCPT_TO

    Doing the "RCPT TO" step of an SMTP transaction with the specified name.    

*  SMTP:RSET

    Doing the RESET step of an SMTP transaction.

*  SMTP:SKIPPED

    SMTP tests are disabled in the DNSCheck configuration.
