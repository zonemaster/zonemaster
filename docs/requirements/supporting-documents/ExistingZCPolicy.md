# Tests of class "generic"

## Test "dn_sntx" (MANDATORY)
Illegal symbols in domain name

IETF RFC 1034 (p.11): Labels are only composed by letters ([A-Za-z]), digits
([0-9]) or dashes ('-') (not starting or ending with), and should be less than
63 characters; domain name (labels separated by '.') should be less than 255
characters. See also [ref]: IETF RFC 1912 (2.1 Inconsistent, Missing, or Bad
Data).

## Test "dn_orp_hyph" (MANDATORY)
Dash ('-') at start or beginning of domain name

IETF RFC 1034 (p.11): Labels are only composed by letters ([A-Za-z]), digits
([0-9]) or dashes ('-') (not starting or ending with), and should be less than
63 characters; domain name (labels separated by '.') should be less than 255
characters. See also [ref]: IETF RFC 1912 (2.1 Inconsistent, Missing, or Bad
Data).

## Test "dn_dbl_hyph" (OPTIONAL)
Double dash in domain name

IETF IDN project (internationalized domain names). The double dash ('--') will
have a special meaning for the domain name encoding, so it is strongly advised
not to used it. See
http://www.iana.org/cctld/specifications-policies-cctlds-01apr02.htm (4. Tagged
Domain Names.)

## Test "one_ns" (MANDATORY)
One nameserver for the domain

ZoneCheck: To avoid loosing all connectivity with the authoritative DNS in case
of network outage it is advised to host the DNS on different networks. IETF RFC
2182 (Abstract): The Domain Name System requires that multiple servers exist for
every delegated domain (zone). This document discusses the selection of
secondary servers for DNS zones. Both the physical and topological location of
each server are material considerations when selecting secondary servers. The
number of servers appropriate for a zone is also discussed, and some general
secondary server maintenance issues considered.

## Test "several_ns" (MANDATORY)
At least two nameservers for the domain

ZoneCheck: To avoid loosing all connectivity with the authoritative DNS in case
of network outage it is advised to host the DNS on different networks. IETF RFC
2182 (Abstract): The Domain Name System requires that multiple servers exist for
every delegated domain (zone). This document discusses the selection of
secondary servers for DNS zones. Both the physical and topological location of
each server are material considerations when selecting secondary servers. The
number of servers appropriate for a zone is also discussed, and some general
secondary server maintenance issues considered.

## Test "ip_distinct" (MANDATORY)
Identical addresses

ZoneCheck: To avoid loosing all connectivity with the authoritative DNS in case
of network outage it is advised to host the DNS on different networks. IETF RFC
2182 (Abstract): The Domain Name System requires that multiple servers exist for
every delegated domain (zone). This document discusses the selection of
secondary servers for DNS zones. Both the physical and topological location of
each server are material considerations when selecting secondary servers. The
number of servers appropriate for a zone is also discussed, and some general
secondary server maintenance issues considered.

 

## Test "ip_all_same_net" (OPTIONAL)
Nameserver addresses are likely to be all on the same subnet

ZoneCheck: To avoid loosing all connectivity with the authoritative DNS in case
of network outage it is advised to host the DNS on different networks. IETF RFC
2182 (Abstract): The Domain Name System requires that multiple servers exist for
every delegated domain (zone). This document discusses the selection of
secondary servers for DNS zones. Both the physical and topological location of
each server are material considerations when selecting secondary servers. The
number of servers appropriate for a zone is also discussed, and some general
secondary server maintenance issues considered.

# Tests of class "nameserver"
 
## Test "ip_private" (OPTIONAL)
Address in a private network

IETF RFC 1918 (3. Private Address Space). The Internet Assigned Numbers
Authority (IANA) has reserved the following three blocks of the IP address space
for private internets: 10/8, 172.16/12, 192.168/16.

## Test "ip_bogon" (OPTIONAL)
Address shouldn't be part of a bogon prefix

http://www.cymru.com/Bogons/. A bogon prefix is a route that should never appear
in the Internet routing table. A packet routed over the public Internet (not
including over VPN or other tunnels) should never have a source address in a
bogon range. These are commonly found as the source addresses of DDoS attacks.


# Tests of class "address"
 
## Test "icmp" (OPTIONAL)
Icmp answer

 
## Test "udp" (MANDATORY)
Udp connectivity

IETF RFC 1035 (p.32 4.2. Transport): The DNS assumes that messages will be
transmitted as datagrams or in a byte stream carried by a virtual circuit. While
virtual circuits can be used for any DNS activity, datagrams are preferred for
queries due to their lower overhead and better performance.

## Test "tcp" (MANDATORY)
Tcp connectivity

IETF RFC 1035 (p.32 4.2. Transport): The DNS assumes that messages will be
transmitted as datagrams or in a byte stream carried by a virtual circuit. While
virtual circuits can be used for any DNS activity, datagrams are preferred for
queries due to their lower overhead and better performance.

## Test "aaaa" (MANDATORY)
Behaviour against aaaa query

 
## Test "soa" (MANDATORY)
Soa record present

 
## Test "soa_auth" (MANDATORY)
Soa authoritative answer

 
## Test "given_nsprim_vs_soa" (MANDATORY)
Given primary nameserver is primary

## Test "soa_master_fq" (OPTIONAL)
Fully qualified master nameserver in soa

## Test "soa_master_sntx" (MANDATORY)
Illegal characters in soa master nameserver

IETF RFC 1034 (p.11): Labels are only composed by letters ([A-Za-z]), digits
([0-9]) or dashes ('-') (not starting or ending with), and should be less than
63 characters; domain name (labels separated by '.') should be less than 255
characters. See also [ref]: IETF RFC 1912 (2.1 Inconsistent, Missing, or Bad
Data).

## Test "soa_contact_sntx_at" (MANDATORY)
Misused '@' characters in soa contact name

IETF RFC 1034 (p.9), RFC 1912 (p.3) : E-mail addresses are converted by using
the following rule: local-part@mail-domain ==> local-part.mail-domain if
local-part contains a dot in should be backslashed (for 'bind').

## Test "soa_contact_sntx" (MANDATORY)
Illegal characters in soa contact name

IETF RFC 1034 (p.9), RFC 1912 (p.3) : E-mail addresses are converted by using
the following rule: local-part@mail-domain ==> local-part.mail-domain if
local-part contains a dot in should be backslashed (for 'bind').

## Test "soa_serial_fmt_YYYYMMDDnn" (OPTIONAL)
Serial number of the form yyyymmddnn

RFC 1912 (p.3). The recommended syntax is YYYYMMDDnn (YYYY=year, MM=month,
DD=day, nn=revision number).

## Test "soa_expire" (MANDATORY)
Soa 'expire' between 604800 s and 60480000 s

AFNIC registry policy: The registry requires the SOA fields to be inside a
defined range: the 'expire' should be between 604800 s and 60480000 s , the
'minimum' between 180 s and 604800 s , the 'refresh' between 3600 s and 172800 s
, and at last the 'retry' between 900 s and 86400 s .

## Test "soa_minimum" (OPTIONAL)
Soa 'minimum' between 180 s and 604800 s

AFNIC registry policy: The registry requires the SOA fields to be inside a
defined range: the 'expire' should be between 604800 s and 60480000 s , the
'minimum' between 180 s and 604800 s , the 'refresh' between 3600 s and 172800 s
, and at last the 'retry' between 900 s and 86400 s .

## Test "soa_refresh" (OPTIONAL)
Soa 'refresh' between 3600 s and 172800 s

AFNIC registry policy: The registry requires the SOA fields to be inside a
defined range: the 'expire' should be between 604800 s and 60480000 s , the
'minimum' between 180 s and 604800 s , the 'refresh' between 3600 s and 172800 s
, and at last the 'retry' between 900 s and 86400 s .

## Test "soa_retry" (OPTIONAL)
Soa 'retry' between 900 s and 86400 s

AFNIC registry policy : The registry requires the SOA fields to be inside a
defined range: the 'expire' should be between 604800 s and 60480000 s , the
'minimum' between 180 s and 604800 s , the 'refresh' between 3600 s and 172800 s
, and at last the 'retry' between 900 s and 86400 s .

## Test "soa_retry_refresh" (MANDATORY)
Soa 'retry' lower than 'refresh'

IETF RFC 1912 (p.4). The 'retry' value is typically a fraction of the 'refresh'
interval.

## Test "soa_expire_7refresh" (MANDATORY)
Soa 'expire' at least 7 times 'refresh'

## Test "soa_ns_cname" (OPTIONAL)
Soa master is not an alias

IETF RFC 1912 (p.7): Having NS records pointing to a CNAME is bad and may
conflict badly with current BIND servers. In fact, current BIND implementations
will ignore such records, possibly leading to a lame delegation. There is a
certain amount of security checking done in BIND to prevent spoofing DNS NS
records. Also, older BIND servers reportedly will get caught in an infinite
query loop trying to figure out the address for the aliased nameserver, causing
a continuous stream of DNS requests to be sent.

## Test "soa_vs_any" (MANDATORY)
Coherence between soa and any records

## Test "soa_coherence_serial" (MANDATORY)
Coherence of serial number with primary nameserver

## Test "soa_coherence_contact" (MANDATORY)
Coherence of administrative contact with primary nameserver

## Test "soa_coherence_master" (MANDATORY)
Coherence of master with primary nameserver

## Test "soa_coherence" (MANDATORY)
Coherence of soa with primary nameserver

## Test "ns" (MANDATORY)
Ns record present

## Test "ns_auth" (MANDATORY)
Ns authoritative answer

## Test "given_ns_vs_ns" (MANDATORY)
Correctness of given nameserver list

## Test "ns_sntx" (MANDATORY)
Ns name has a valid domain/hostname syntax

IETF RFC 1034 (p.11): Labels are only composed by letters ([A-Za-z]), digits
([0-9]) or dashes ('-') (not starting or ending with), and should be less than
63 characters; domain name (labels separated by '.') should be less than 255
characters. See also [ref]: IETF RFC 1912 (2.1 Inconsistent, Missing, or Bad
Data).

## Test "ns_cname" (MANDATORY)
Ns is not an alias

IETF RFC 1912 (p.7): Having NS records pointing to a CNAME is bad and may
conflict badly with current BIND servers. In fact, current BIND implementations
will ignore such records, possibly leading to a lame delegation. There is a
certain amount of security checking done in BIND to prevent spoofing DNS NS
records. Also, older BIND servers reportedly will get caught in an infinite
query loop trying to figure out the address for the aliased nameserver, causing
a continuous stream of DNS requests to be sent.

## Test "ns_vs_any" (MANDATORY)
Coherence between ns and any records

## Test "ns_ip" (MANDATORY)
Ns can be resolved

## Test "ns_reverse" (OPTIONAL)
Nameserver IP reverse

## Test "ns_matching_reverse" (OPTIONAL)
Nameserver IP reverse matching nameserver name

## (Only if "mail_by_mx_or_a" = "MX") Test "mx" (MANDATORY)
Mx record present

IETF RFC 1912 (p.7). Put MX records even on hosts that aren't intended to send
or receive e-mail. If there is a security problem involving one of these hosts,
some people will mistakenly send mail to postmaster or root at the site without
checking first to see if it is a "real" host or just a terminal or personal
computer that's not set up to accept e-mail.

## (Only if "mail_by_mx_or_a" = "MX") Test "mx_auth" (MANDATORY)
Mx authoritative answer

## (Only if "mail_by_mx_or_a" = "MX") Test "mx_sntx" (MANDATORY)
Mx syntax is valid for a hostname

IETF RFC 1034 (p.11): Labels are only composed by letters ([A-Za-z]), digits
([0-9]) or dashes ('-') (not starting or ending with), and should be less than
63 characters; domain name (labels separated by '.') should be less than 255
characters. See also [ref]: IETF RFC 1912 (2.1 Inconsistent, Missing, or Bad
Data).

## (Only if "mail_by_mx_or_a" = "MX") Test "mx_cname" (MANDATORY)
Mx is not an alias

IETF RFC 974. MX records shall not point to an alias defined by a CNAME.

## (Only if "mail_by_mx_or_a" = "MX") Test "mx_no_wildcard" (UNKNOWN SEVERITY "i")
Absence of wildcard mx

## (Only if "mail_by_mx_or_a" = "MX") Test "mx_ip" (MANDATORY)
Mx can be resolved

## (Only if "mail_by_mx_or_a" = "MX") Test "mx_vs_any" (MANDATORY)
Coherence between mx and any records

## Test "correct_recursive_flag" (MANDATORY)
Check if server is really recursive

## Test "not_recursive" (OPTIONAL)
Nameserver doesn't allow recursion

ZoneCheck. If you configure your nameserver to answer recursive queries, it
means that you allow your nameserver to be used by anyone to resolve any kind of
queries. This allows everyone to use your server as an amplifier for a
Denial-of-Service attack. See
http://www.us-cert.gov/reading_room/DNS-recursion121605.pdf.

## (Only if "recursive_server" = "true") Test "loopback_delegation" (OPTIONAL)
Loopback delegation

IETF RFC 1912 (p.13 4.1. Boot file setup): These are set up to either provide
nameservice for "special" addresses, or to help eliminate accidental queries for
broadcast or local address to be sent off to the root nameservers. All of these
files will contain NS and SOA records just like the other zone files you
maintain.

## (Only if "recursive_server" = "true") Test "loopback_host" (MANDATORY)
Loopback is resolvable

IETF RFC 1912 (p.13 4.1. Boot file setup): These are set up to either provide
nameservice for "special" addresses, or to help eliminate accidental queries for
broadcast or local address to be sent off to the root nameservers. All of these
files will contain NS and SOA records just like the other zone files you
maintain.

## (Only if "recursive_server" = "true") Test "root_servers" (MANDATORY)
Root-servers list present

## (Only if "recursive_server" = "true") Test "root_servers_ns_vs_icann"
(MANDATORY)
Root-servers list identical to ICANN

IETF RFC 2870 (p.1): The Internet Corporation for Assigned Names and Numbers
(ICANN) has become responsible for the operation of the root servers. The ICANN
has appointed a Root Server System Advisory Committee (RSSAC) to give technical
and operational advice to the ICANN board. The ICANN and the RSSAC look to the
IETF to provide engineering standards.

## (Only if "recursive_server" = "true") Test "root_servers_ip_vs_icann" (OPTIONAL)
Root-servers addresses identical to ICANN

IETF RFC 2870 (p.1): The Internet Corporation for Assigned Names and Numbers
(ICANN) has become responsible for the operation of the root servers. The ICANN
has appointed a Root Server System Advisory Committee (RSSAC) to give technical
and operational advice to the ICANN board. The ICANN and the RSSAC look to the
IETF to provide engineering standards.


# Tests of class "extra"
 
## Test "mail_mx_or_addr" (OPTIONAL)
Domain able to receive e-mail (delivery using mx, a, aaaa)

## (Only if "mail_delivery" != "nodelivery") Test "mail_delivery_postmaster"
(OPTIONAL)
Can deliver e-mail to 'postmaster'

IETF RFC 1123 (p.51 5.2.7 RCPT Command: RFC 821 Section 4.1.1). A host that
supports a receiver-SMTP MUST support the reserved mailbox "Postmaster".

## Test "mail_hostmaster_mx_cname" (MANDATORY)
Hostmaster mx is not an alias

IETF RFC 974. MX records shall not point to an alias defined by a CNAME.

##Test "mail_delivery_hostmaster" (MANDATORY)
Can deliver e-mail to hostmaster











