The DNSCheck tests can be found in the [DNSCheck::Test](http://github.com/dotse/dnscheck/tree/master/engine/lib/DNSCheck/Test/) namespace. The following tests are implemented:

## Address
Tests for valid (and resonable) IP addresses.

The following tests are made:

* Addresses must be syntactically correct.
* Private IPv4 Addresses (RFC 1918) must not be used.
* Special-Use IPv4 Addresses (RFC 3330) must not be used.
* Special-Use IPv6 Addresses must not be used.
* There should exist a PTR record for the address.
* The hostname(s) pointed to by the PTR record(s) should exist.
* This test is implemented by [DNSCheck::Test::Address](http://github.com/dotse/dnscheck/blob/master/engine/lib/DNSCheck/Test/Address.pm).

## Connectivity
Test zone connectivity.

The following tests are made:

 * A name server should not be announced by more than one AS.
 * A name server must be announced.
 * Domain name servers should live in more than one AS.
 * This test is implemented by [DNSCheck::Test::Connectivity](http://github.com/dotse/dnscheck/blob/master/engine/lib/DNSCheck/Test/Connectivity.pm).

## Consistency
Test the zone for consistency.

The following tests are made:

 * The serial number of the zone must be the same at all listed name servers.

This test is implemented by [DNSCheck::Test::Consistency](http://github.com/dotse/dnscheck/blob/master/engine/lib/DNSCheck/Test/Consistency.pm).

## DNSSEC
Test DNSSEC.

The following tests are made:

 * If there exists DS at parent, the child must use DNSSEC.
 * If there exists DNSKEY at child, the parent should have a DS.
 * A DNSSEC key should not be of type RSA/MD5.
 * At least one DNSKEY should be of type RSA/SHA1.
 * There may exist a SEP at the child.
 * RRSIG(DNSKEY) must be valid and created by a valid DNSKEY.
 * RRSIG(SOA) must be valid and created by a valid DNSKEY.
 * The DS must point to a DNSKEY signing the child's DNSKEY RRset.
 * The DS may point to a SEP at the child.
 * At least one DS algorithm should be of type RSA/SHA1.
 * Verify DNSSEC additional processing.
 
This test is implemented by [DNSCheck::Test::DNSSEC](http://github.com/dotse/dnscheck/blob/master/engine/lib/DNSCheck/Test/DNSSEC.pm).

## Delegation
The following tests are made:

 * All nameservers at parent must exist at child.
 * Nameservers at child may exist at parent.
 * At least two NS records at parent.
 * Check for inconsistent glue.

This test is implemented by [DNSCheck::Test::Delegation](http://github.com/dotse/dnscheck/blob/master/engine/lib/DNSCheck/Test/Delegation.pm).

## Host
Test host names and addresses.

The following tests are made:

 * Hostnames may contain the characters a-z, 0-9 and -.
 * Last character of hostname must not be a minus sign.
 * Host address must exist.
 * Hostname must not point to a CNAME.
 * All host addresses (IPv4 and IPv6) must be valid.

This test is implemented by [DNSCheck::Test::Host](http://github.com/dotse/dnscheck/blob/master/engine/lib/DNSCheck/Test/Host.pm).

## Mail
Test email addresses.

The following tests are made:

 * An MX or A record must exist for the domain name of the email address.
 * The MX record must point to a valid hostname.
 * The mail exchanger should be reachable by IPv4.
 * Mail for the email address must be deliverable via SMTP.

This test is implemented by [DNSCheck::Test::Mail](http://github.com/dotse/dnscheck/blob/master/engine/lib/DNSCheck/Test/Mail.pm).

## Nameserver
Test a single name server for a specific zone.

The following tests are made:

 * The nameserver must be a valid hostname.
 * The nameserver should not be recursive.
 * The nameserver must be authoritative for the zone.
 * The SOA record for the zone must be fetchable over both UDP and TCP.
 * The nameserver may provide AXFR for the zone.

This test is implemented by [DNSCheck::Test::Nameserver](http://github.com/dotse/dnscheck/blob/master/engine/lib/DNSCheck/Test/Nameserver.pm).

## SMTP
Test if an email address is deliverable using SMTP.

This test is implemented by [DNSCheck::Test::SMTP](http://github.com/dotse/dnscheck/blob/master/engine/lib/DNSCheck/Test/SMTP.pm).

## SOA
Test zone connectivity.

The following tests are made:

 * The SOA record must exist.
 * Only ONE SOA record may exist.
 * SOA MNAME must exist as a valid hostname.
 * SOA MNAME does not have to be in the list of nameservers.
 * SOA MNAME does not have to be reachable.
 * SOA MNAME must be authoritative for the zone.
 * SOA RNAME must have a valid syntax .
 * SOA RNAME address should be deliverable.
 * SOA TTL should be at least 1 hour.
 * SOA 'refresh' should be at least 4 hours.
 * SOA 'retry' should be lower than SOA 'refresh'.
 * SOA 'retry' should be at least 1 hour.
 * SOA 'expire' should be at least 7 days.
 * SOA 'expire' should be at least 7 times SOA 'refresh'.
 * SOA 'minimum' should be less than 1 day.

This test is implemented by [DNSCheck::Test::SOA](http://github.com/dotse/dnscheck/blob/master/engine/lib/DNSCheck/Test/SOA.pm).

## Zone
Test a zone using all DNSCheck modules.

This test is implemented by [DNSCheck::Test::Zone](http://github.com/dotse/dnscheck/blob/master/engine/lib/DNSCheck/Test/Zone.pm).

## Details

* [Detailed list of all possible DNSCheck messages](Detailed-list-of-all-possible-dnscheck-messages.md).
* [Algorithms used by DNSCheck](Algorithms-used-by-dnscheck.md).
