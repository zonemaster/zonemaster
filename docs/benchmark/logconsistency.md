# Consistency in args from log output

There exist a number of different ways to log entries for IP addresses,
hostnames, name servers, and the name of the tested domain. This below
tries to highlight the differences.

The output below is only from the "args" part of the log. This information
is very useful when doing analysis. But what is hard is that the output
is not consistent. It is very hard to find information on a name server,
a specific IP address and so on, in order to find a number of errors common
to a certain host. As an example, you would like to retrieve all errors
for a host among a lot of domains you have run Zonemaster tests on. To
find the errors for "ns.example.com" you have to look for hostnames in
these arguments: nss, ns, source, names, extra or mname. And they don't
only contain the hostname, they can contain a range of hostnames, with
or without IP addresses.

## Summary:

IP addresses can come from these args:
from, parent, child, address, source, server, names

Hostnames can come from these args:
nss, ns, source, names, extra, mname

Nameserver set can come from these args:
nss, ns, glue, child, names, extra

Name of tested domain can come from:
zone, name

## A lot of examples

**Examples on names and IP addresses**

```
HAS_GLUE: 'ns' => 'ns.communique.se.,ns2.communique.se.', 'parent' => 'se'
ENOUGH_NS_GLUE: 'glue' => 'ns.communique.se;ns2.communique.se', 'count' => 2, 'minimum' => 2
ENOUGH_NS: 'ns' => 'ns.communique.se;ns2.communique.se', 'count' => 2, 'minimum' => 2,
ENOUGH_NS_TOTAL: 'ns' => 'ns.communique.se;ns2.communique.se', 'count' => 2, 'minimum' => 2

IPV4_ENABLED: 'ns' => 'ns.communique.se/194.117.171.2', 'type' => 'NS'

HAS_NAMESERVERS: 'source' => 'ns.communique.se/194.117.171.2', 'ns' => 'ns.communique.se.,ns2.communique.se.'

HAS_NAMESERVER_NO_WWW_A_TEST: 'name' => 'hyrhusbilinorr.se'

NAMESERVER_HAS_UDP_53: 'address' => '194.117.171.2', 'ns' => 'ns.communique.se'
NAMESERVER_HAS_TCP_53: 'address' => '194.117.171.2', 'ns' => 'ns.communique.se'

NO_DS: 'from' => '192.36.144.107', 'zone' => 'pernehed.se'

ONE_NS_SET: 'nsset' => 'ns.communique.se.,ns2.communique.se.'

DNSKEY_BUT_NOT_DS: 'parent' => '192.36.144.107', 'child' => '93.188.0.20'

SAME_IP_ADDRESS: 'nss' => 'ns1.b-one.nu;ns01.one.com', 'address' => '195.206.121.10'

TOTAL_NAME_MISMATCH: ns1.b-one.nu;ns2.b-one.nu', 'ns01.one.com;ns02.one.com'

MNAME_NOT_IN_GLUE: 'mname' => 'ns01.one.com', 'ns' => 'ns1.b-one.nu;ns2.b-one.nu'

EDNS0_BAD_ANSWER: 'ns' => 'ns1.surf-town.net', 'address' => '212.97.132.11'

NAMESERVER_IP_PTR_MISMATCH: 'names' => 'obelix.wikinggruppen.se.', 'address' => '91.201.63.43', 'ns' => 'ns1.wikinggruppen.se'

NAMESERVER_IP_WITHOUT_REVERSE: 'address' => '141.8.224.169', 'ns' => 'ns27.rookdns.com'

NAMESERVER_NO_TCP_53: 'address' => '141.8.224.170', 'ns' => 'ns28.rookdns.com'

IS_NOT_AUTHORITATIVE: 'ns' => 'ns28.rookdns.com', 'proto' => 'TCP'

AXFR_AVAILABLE: 'address' => '195.249.40.60', 'ns' => 'ns1.cliche.se'

NS_FAILED: 'source' => 'ns1.loopia.se/93.188.0.20', 'rcode' => 'NOERROR'

NAMESERVER_NO_UDP_53: 'ns' => 'ns3.binero.se', 'address' => '156.154.64.58'

ANSWER_BAD_RCODE: 'address' => '156.154.64.58', 'ns' => 'ns3.binero.se', 'rcode' => 'SERVFAIL'

IS_A_RECURSOR: 'ns' => 'odin.intra.itera.no', 'address' => '193.19.64.66', 'dname' => 'xx--domain-cannot-exist.xx--illegal-syntax-tld'

MNAME_NO_RESPONSE: 'ns' => 'ds1s12grid.ptj.se', 'address' => '193.14.150.40'

NO_RESPONSE: 'address' => '217.70.46.49', 'ns' => 'ns2.binero.se'

NS_FAILED: 'rcode' => 'NOERROR', 'source' => 'ns1.loopia.se/93.188.0.20'

NS_NO_RESPONSE: 'source' => 'nshost1.st2.lyceu.net/209.202.254.10'

NO_A_RECORDS: 'name' => 'www.elegitimationsnamnden.se', 'source' => 'ns1.loopia.se/93.188.0.20'

NOT_ENOUGH_NS_TOTAL: 'minimum' => 2, 'count' => 1, 'ns' => 'a.ns.nordsvenskasthlm.se'

NAMES_MATCH: 'names' => 'ns.communique.se;ns2.communique.se'

SOA_NOT_EXISTS: 'ns' => 'ns1.svenska-domaner.se'

QUERY_DROPPED: 'ns' => 'nic.pal.pp.se', 'address' => '192.121.239.124'

HAS_A_RECORDS: 'source' => 'ns1.svenska-domaner.se/46.22.119.39', 'name' => 'www.visitdevelopment.se'

CAN_NOT_BE_RESOLVED: 'names' => 'ns2.swedhost.net,ns.swedhost.net'

NAMESERVER_IP_WITHOUT_REVERSE: 'ns' => 'ns27.rookdns.com', 'address' => '141.8.224.169'

EDNS0_BAD_QUERY: 'address' => '213.115.165.33', 'ns' => 'sol.eastpoint.se'

IS_NOT_AUTHORITATIVE: 'proto' => 'TCP', 'ns' => 'ns28.rookdns.com'

DS_BUT_NOT_DNSKEY: 'parent' => '192.36.144.107', 'child' => '195.238.76.18'

MX_NUMERIC_TLD: 'name' => '23.227.172.88', 'tld' => '88'

NAMESERVER_NUMERIC_TLD: 'name' => '192.168.90.3', 'tld' => '3'

NO_NSEC3PARAM: 'server' => '194.117.171.2'

EXTRA_PROCESSING_BROKEN: 'keys' => 0, 'server' => '130.242.124.20', 'sigs' => 0

NAMESERVER_IP_PRIVATE_NETWORK: 'prefix' => '192.168/16', 'ns' => 'offdmz01.officeweb.se', 'address' => '192.168.2.70', 'reference' => 'RFC 1918', 'name' => 'Private-Use'

NEITHER_DNSKEY_NOR_DS: 'parent' => '192.36.144.107', 'child' => '194.117.171.2'

EDNS0_SUPPORT: 'names' => 'ns2.communique.se/213.88.239.2,ns.communique.se/194.117.171.2'

AAAA_WELL_PROCESSED: 'names' => 'ns2.communique.se/213.88.239.2,ns.communique.se/194.117.171.2'

NAMESERVER_IP_PTR_MISMATCH: 'ns' => 'ns1.3dg.se', 'address' => '83.233.72.68', 'names' => 'c-83-233-72-68.cust.bredband2.com.'

IPV6_ENABLED: 'ns' => 'ns3.binero.se/2001:502:4612::13', 'type' => 'NS'


MNAME_SYNTAX_OK: 'name' => 'ns.communique.se'
MX_SYNTAX_OK: 'name' => 'smtpgw02.communique.se'
MNAME_IS_AUTHORITATIVE: 'mname' => 'ns.communique.se', 'zone' => 'hyrhusbilinorr.se'
MNAME_NOT_AUTHORITATIVE: 'address' => '2001:16d8:10:8::2', 'ns' => 'ns01.com', 'zone' => 'butiktingeling.se'
MNAME_NO_RESPONSE: 'ns' => 'nsmaster.forss.net', 'address' => '95.128.113.10'


EXTRA_NAME_PARENT: 'extra' => 'ns1.b-one.nu;ns2.b-one.nu'
EXTRA_NAME_CHILD: 'extra' => 'ns01.one.com;ns02.one.com'
TOTAL_NAME_MISMATCH: 'glue' => 'ns1.b-one.nu;ns2.b-one.nu', 'child' => 'ns01.one.com;ns02.one.com'

MNAME_NOT_IN_GLUE: 'ns' => 'ns1.b-one.nu;ns2.b-one.nu', 'mname' => 'ns01.one.com'

MNAME_IS_NOT_CNAME: 'mname' => 'ns.communique.se'
MX_RECORD_IS_NOT_CNAME: {}
MX_RECORD_EXISTS: 'info' => 'MX=smtpgw02.communique.se/MX=smtpgw04.communique.se'
```

**Examples on formatting on AS numbers:**

```
IPV4_ASN: 'asn' => '3292,3301'
IPV6_ASN: 'asn' => ''
NAMESERVERS_IPV4_WITH_MULTIPLE_AS: 'asn' => '3292;3301'
NAMESERVERS_IPV6_NO_AS: {}
NAMESERVERS_WITH_MULTIPLE_AS: 'asn' => '3292;3301'
```

**DS records:**

```
DS_FOUND: 'keytags' => '41182'
COMMON_KEYTAGS: 'keytags' => '41182'
DS_MATCHES_DNSKEY: 'keytag' => 41182
DS_MATCH_FOUND: {}
```


**From DNSSEC10: name should be qname?**

    INVALID_NAME_RCODE: 'rcode' => 'SERVFAIL', 'name' => 'xx--example.pms.se'

**Reason?**

    DELEGATION_NOT_SIGNED: 'reason' => 'no_ds', 'keytag' => 'info'


    CANNOT_CONTINUE: 'zone' => 'johangreus.se'

**NSEC3**

    HAS_NSEC3: {}
    NSEC3_SIGNED: {}
    NSEC3_COVERS: 'name' => 'xx--example.elbilar24.se'

**Empty args**

```
DISTINCT_IP_ADDRESS: {}
ARE_AUTHORITATIVE: {}
NS_RR_NO_CNAME: {}
CAN_BE_RESOLVED: {}
SOA_EXISTS: {}
NO_DNSKEY: {}
SOA_NOT_SIGNED: {}
NO_IP_PRIVATE_NETWORK: {}
NAMESERVERS_IP_WITH_REVERSE: {}
NAMESERVER_IP_PTR_MATCH: {}
ADDITIONAL_DNSKEY_SKIPPED: {}
NO_GLUE_PREVENTS_NAMESERVER_TESTS: {}
```


**Other examples:**

```
SOA_SIGNATURE_NOT_OK: 'signature' => 44766, 'error' => 'Bogus DNSSEC signature'

MULTIPLE_SOA_SERIALS: 'count' => 2

SOA_SERIAL_VARIATION: 'serial_min' => '1426118400', 'max_variation' => 0, 'serial_max' => '1426428674'

MULTIPLE_SOA_TIME_PARAMETER_SET: 'count' => 2
```
