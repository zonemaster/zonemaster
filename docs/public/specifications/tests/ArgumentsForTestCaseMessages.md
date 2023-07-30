# Arguments for test case messages


## Introduction

This document defines *arguments*. An *argument* is defined with its name, its
type of value and its usage and formatting. The *arguments* are used in a
Zonemaster-Engine message. The messages, in the form of *msgid* strings, are
primarily defined in the Perl modules for the test cases, e.g. [Basic.pm]. The
*arguments* are also used in the translated messages, in the form of *msgstr*
strings, in the PO files, e.g. [fr.po] and [sv.po]. When an *arguments* is used
in a message (*msgid* or *msgstr*) it is represented by its name which is put
within curly brackets, e.g. as `{ns}`.

When a message is created or updated only *arguments* defined in this document
should be used. If there is not a defined *argument* that can be used for the
message then a new *argument* must be defined and this document is to be updated.


## Multiple instances of the same argument

In a message the same *argument* can only be used once. In case a message needs
more than one instance of an *argument*, the instances need to be disambiguated.
This is done by adding different suffixes to the argument's name. The suffix is
an underscore ("_") followed by a descriptive string of lower case "a-z0-9". The
suffixed *argument name* is not to be listed in this document, it is just an
instance of the *argument name* without the specific suffix.

### Example of multiple instances

If two arguments of type "List of IP addresses" are to be used in a message, then
both *argument names* should be `ns_ip_list` following the list of defined
arguments below. If the relevant suffixes for those are "nsec" (connected to an
NSEC record type) and "nsec3" (connected to an NSEC3 record type) then two
resulting argument names should be `ns_ip_list_nsec` and `ns_ip_list_nsec3`,
respectively.

The following is a message (*msgid* in this case) where this is in use:

> The zone is inconsistent on NSEC and NSEC3. NSEC is fetched from nameservers
> with IP addresses "{ns_ip_list_nsec}". NSEC3 is fetched from nameservers with
> IP addresses "{ns_ip_list_nsec3}".


## Defined arguments

When a suitable *argument* is found in this list, it should also be used in new
and updated messages (*msgids* and *msgstr*).

| Argument name  | Type of value                            | Description and formatting                                              |
|--------------- |------------------------------------------|-------------------------------------------------------------------------|
| algo_descr     | Text                                     | The human readable description of a [DNSSEC algorithm].                 |
| algo_mnemo     | Text                                     | The mnemonic of a [DNSSEC algorithm].                                   |
| algo_num       | Non-negative integer                     | The numeric value for a [DNSSEC algorithm].                             |
| domain         | Domain name                              | A domain name. If "nsname", "mailtarget" or "query_name" is also applicable, use that one instead.      |
| ds_algo_descr  | Text                                     | The human readable description of a [DS Digest algorithm].              |
| ds_algo_mnemo  | Text                                     | The mnemonic of a [DS Digest algorithm].                                |
| ds_algo_num    | Non-negative integer                     | The numeric value for a [DS Digest algorithm].                          |
| int            | integer                                  | An integer. If "algo_num", "ds_also_num", "keytag", "soaserial" or some other specific name is applicale, utse that instead. |
| ip_prefix      | IP prefix                                | An IP prefix (i.e., an IP address with a network mask in CIDR notation).|
| keytag         | Non-negative integer                     | A keytag for a DNSKEY record or a keytag used in a DS or RRSIG record.  |
| label          | Domain name label                        | A single label, i.e. the string between the dots, from a domain name.   |
| mailtarget     | Domain name                              | The domain name of the mailserver in an MX RDATA.                       |
| mailtarget_list| List of domain names                     | A list of name servers, as specified by "mailtarget", separated by ";". |
| module         | A Zonemaster test module, or `all`       | The name of a Zonemaster test module.                                   |
| module_list    | List of Zonemaster test modules          | A list of Zonemaster test modules, separated by ":".                    |
| ns             | Domain name and IP address pair          | The name and IP address of a name server, separated by "/".             |
| ns_ip          | IP address                               | The IP address of a name server.                                        |
| ns_ip_list     | List of IP addresses                     | A list of name servers, as specified by "ns_ip", separated by ";".      |
| ns_list        | List of domain name and IP address pairs | A list of name servers, as specified by "ns", separated by ";".         |
| nsname         | Domain name                              | The domain name of a name server.                                       |
| nsname_list    | List of domain names                     | A list of name servers, as specified by "nsname", separated by ";".     |
| query_name     | Domain name                              | A query domain name (QNAME), as defined in [RFC1035, section 4.1.2].    |
| rcode          | An RCODE Name                            | An RCODE Name (not numeric code) from [DNS RCODEs].                     |
| rrtype         | A Resource Record TYPE Name              | A Resource Record TYPE Name (not numeric code) from [DNS RR TYPEs].     |
| soaserial      | Non-negative integer                     | The numeric value for the SERIAL field in an SOA record. Integer in range 0-4,294,967,295 |
| soaserial_list | List of non-negative integers            | A list of non-negative integers, as specified by "soaserial", separated by ";". |
| string         | Text                                     | The content of the RDATA of a TXT resource record.                      |
| testcase       | A Zonemaster test case, or `all`         | A test case identifier.                                                 |
| unicode_name   | Unicode name of a code point             | The name is a string in ASCII only and in upper case, e.g. "LATIN SMALL LETTER A"|

## Preliminary or proposed arguments

The *arguments* in in this table are not fully defined. If used it should follow
the pattern of defined *arguments*, be fully defined and moved to the list of
defined *arguments*.

| Argument name  | Type of value                      | Description and formatting                                  |
|--------------- |------------------------------------|-------------------------------------------------------------|
|| AS number| An Autonomous Space number for an IP address.|
|| Address record type (A or AAAA)| Used to tell the difference between IPv4 and IPv6.|
|| Count of different SOA RNAMEs.| Total number of different SOA RNAME fields seen.|
|| Count of different SOA serial numbers| Total number of different SOA serial numbers seen.|
|| Count of different sets of NS name/IP seen.| Total number of different sets of nameserver information seen.|
|| Count of different time parameter sets seen| Total number of different sets of SOA time parameters seen.|
|| Count of domain names| A count of domain names.|
|| Count of nameservers| A count of nameservers.|
|| DNS packet size| The size in octets of a DNS packets.|
|| DNSKEY key length| The key length for a DNSKEY. The interpretation of this value various quite a bit with the algorithm. Be careful when using it for algorithms that aren't RSA-based.|
|| DNSSEC delegation verification failure reason| A somewhat human-readable reason why the delegation step between the tested zone and its parent is not secure.|
| dlength (?) | Domain name label length| The length of a domain name label.|
|| Duration in seconds| An integer number of seconds.|
| fqdn (?) | FQDN| A fully qualified domain name (with terminating dot).|
| fqdnlength (?) | FQDN length| The length of an FQDN.|
|| IP address| An IPv4 or IPv6 address.|
|| IP address or nothing| An IPv4 or IPv6 address, or no value.|
|| IP range| An IP range.|
|| IP reserved range description| A brief description what an IP range is reserved for.|
|| Largest SOA serial number seen| The numerically largest SOA serial value seen.|
|| List of AS numbers| A list of Autonomous Space numbers.|
|| List of DNSKEY keytags| A list of keytags from DNSKEY records.|
|| List of DS keytags| A list of keytags from DS records.|
|| List of DS/DNSKEY/RRSIG keytags| A list of keytags from DS, DNSKEY or RRSIG records.|
|| List of IP addresses| A list of IP addresses.|
|| List of MX domain names| A list of domain names from MX records.|
|| List of RR types| A list of RR types, typically from an NSEC or NSEC3 record.|
|| List of SOA RNAMEs| A list of RNAME values from SOA records.|
|| List of SOA serial numbers| A list of serial number values from SOA records.|
|| List of domain names| A list of domain names.|
|| NS names from child| A list of nameserver names taken from a zone's child servers.|
|| NS names from parent| A list of nameserver names taken from a zone's parent servers.|
|| NSEC3 iteration count| An iteration count from an NSEC3PARAM record.|
|| Number of DNSKEY RRs in packet| The number of DNSKEY records found in a packet.|
|| Number of RRSIG RRs in packet| The number of RRSIG records found in a packet.|
|| Number of SOA RRs in packet| The number of SOA records found in a packet.|
|| Protocol (UDP or TCP)| The protocol used for a query.|
|| RFC reference| A reference to an RFC.|
| rrtype (?) | RR type| The type of RR the message pertains to.|
|| RRSIG Expiration date| The time when a signature expires.|
|| RRSIG validation error message| The human-readable reason why the cryptographic validation of a signature failed.|
|| SOA MNAME| The MNAME value from a SOA record.|
|| SOA RNAME| The RNAME value from a SOA record.|
|| SOA expire| The expire value from a SOA record.|
|| SOA expire minimum value| The lowest value considered OK for the SOA expire field.|
|| SOA minimum| The minimum value from a SOA record.|
|| SOA minimum maximum value| The highest value considered OK for the SOA minimum field.|
|| SOA minimum minimum value| The lowest value considered OK for the SOA minimum field.|
|| SOA refresh| The refresh value from a SOA record.|
|| SOA refresh minimum value| The lowest value considered OK for the SOA refresh field.|
|| SOA retry| The retry value from a SOA record.|
|| SOA retry minimum value| The lowest value considered OK for the SOA retry field.|
|| SOA serial number| The serial number value from a SOA record.|
|| Smallest SOA serial number seen| The smallest value seen in a SOA serial field in the tested zone.|
|| TLD| The name of a top-level domain.|
|| `time_t` value when RRSIG validation was attempted| The time when an RRSIG validation was attempted, in Unix `time_t` format.|

Message names maked with a question mark should not be considered stable.


[Basic.pm]:                                  ../lib/Zonemaster/Engine/Test/Basic.pm
[DNS RR TYPEs]:                              https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-4
[DNS RCODEs]:                                https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[DNSSEC algorithm]:                          https://www.iana.org/assignments/dns-sec-alg-numbers/dns-sec-alg-numbers.xhtml
[DS Digest algorithm]:                       https://www.iana.org/assignments/ds-rr-types/ds-rr-types.xhtml
[fr.po]:                                     ../share/fr.po
[RFC1035, section 4.1.2]:                    https://datatracker.ietf.org/doc/html/rfc1035#section-4.1.2
[sv.po]:                                     ../share/sv.po

