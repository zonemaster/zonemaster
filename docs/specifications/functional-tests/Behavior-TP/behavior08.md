## BEHAVIOR08: Display of verbose information

### Test case identifier

**BEHAVIOR08:** Display of verbose information 

### Objective 

The objective of this test is to verify whether it is possible to obtain
different levels of information for a zone that is being tested

### Inputs

The  domain to be tested.

### Ordered description of steps to be taken to execute the test case


1. A valid domain is verified using Zonemaster CLI with appropriate options as
seen in the appendix. The options --level (CRITICAL, ERROR, WARNING, NOTICE, INFO, 
DEBUG, DEBUG2 or DEBUG3) provides different levels of information for the zone being tested

2. If the query doesn't have results with level to the verbose option then the
test return FAIL.

### Results
The engine passes the test as can be verified from the appendix

### Appendix
```
zonemaster-cli --level CRITICAL iis.se
Seconds Level     Message
======= ========= =======
Looks OK.

```
```
zonemaster-cli --level INFO iis.se    
Seconds Level     Message
======= ========= =======
   1.86 INFO      Nameserver for zone se replies when trying to fetch glue.
   1.86 INFO      Nameserver for zone se listed these nameservers as glue:
i.ns.se.,ns.nic.se.,ns3.nic.se..
   2.34 INFO      IPv4 is enabled, can send "NS" query to
i.ns.se/194.146.106.22.
   2.35 INFO      Nameserver i.ns.se/194.146.106.22 listed these servers as
glue: i.ns.se.,ns.nic.se.,ns3.nic.se..
   2.35 INFO      IPv6 is enabled, can send "NS" query to
i.ns.se/2001:67c:1010:5::53.
   2.37 INFO      Nameserver i.ns.se/2001:67c:1010:5::53 listed these servers as
glue: i.ns.se.,ns.nic.se.,ns3.nic.se..
   2.37 INFO      IPv4 is enabled, can send "NS" query to
ns.nic.se/212.247.7.228.
   2.42 INFO      Nameserver ns.nic.se/212.247.7.228 listed these servers as
glue: i.ns.se.,ns.nic.se.,ns3.nic.se..
   2.42 INFO      IPv6 is enabled, can send "NS" query to
ns.nic.se/2a00:801:f0:53::53.
   2.46 INFO      Nameserver ns.nic.se/2a00:801:f0:53::53 listed these servers
as glue: i.ns.se.,ns.nic.se.,ns3.nic.se..
   2.46 INFO      IPv4 is enabled, can send "NS" query to
ns3.nic.se/212.247.8.152.
   2.50 INFO      Nameserver ns3.nic.se/212.247.8.152 listed these servers as
glue: i.ns.se.,ns.nic.se.,ns3.nic.se..
   2.50 INFO      IPv6 is enabled, can send "NS" query to
ns3.nic.se/2a00:801:f0:211::152.
   2.54 INFO      Nameserver ns3.nic.se/2a00:801:f0:211::152 listed these
servers as glue: i.ns.se.,ns.nic.se.,ns3.nic.se..
   2.54 INFO      Functional nameserver found. "A" query for www.iis.se test
aborted.
   2.75 INFO      All Nameserver addresses are in the routable public addressing
space.
   6.84 WARNING   Nameserver ns3.nic.se has an IP address (212.247.8.152)
without PTR configured.
   8.78 INFO      None of the 3 nameserver(s) with IPv6 addresses is part of a
bogon prefix.
   8.78 INFO      Nameserver i.ns.se/194.146.106.22 accessible over UDP on port
53.
   8.81 INFO      Nameserver i.ns.se/2001:67c:1010:5::53 accessible over UDP on
port 53.
   8.85 INFO      Nameserver ns.nic.se/212.247.7.228 accessible over UDP on port
53.
   8.89 INFO      Nameserver ns.nic.se/2a00:801:f0:53::53 accessible over UDP on
port 53.
   8.93 INFO      Nameserver ns3.nic.se/212.247.8.152 accessible over UDP on
port 53.
   8.93 INFO      Nameserver ns3.nic.se/2a00:801:f0:211::152 accessible over UDP
on port 53.
   8.94 INFO      Nameserver i.ns.se/194.146.106.22 accessible over TCP on port
53.
   8.98 INFO      Nameserver i.ns.se/2001:67c:1010:5::53 accessible over TCP on
port 53.
   9.06 INFO      Nameserver ns.nic.se/212.247.7.228 accessible over TCP on port
53.
   9.15 INFO      Nameserver ns.nic.se/2a00:801:f0:53::53 accessible over TCP on
port 53.
   9.23 INFO      Nameserver ns3.nic.se/212.247.8.152 accessible over TCP on
port 53.
   9.31 INFO      Nameserver ns3.nic.se/2a00:801:f0:211::152 accessible over TCP
on port 53.
  11.06 INFO      Domain's authoritative nameservers do not belong to the same
AS.
  11.06 INFO      A single SOA serial number was seen (1415096701).
  11.06 INFO      A single SOA rname value was seen (hostmaster.iis.se.)
  11.07 INFO      A single SOA time parameter set was seen
(REFRESH=10800,RETRY=3600,EXPIRE=1814400,MINIMUM=14400).
  11.08 INFO      A unique NS set was seen (i.ns.se.,ns.nic.se.,ns3.nic.se.).
  11.12 INFO      Found DS records with tags 18937.
  11.13 INFO      There are both DS and DNSKEY records with key tags 18937.
  11.13 INFO      DS record with keytag 18937 matches the DNSKEY with the same
tag.
  11.13 INFO      At least one DS record with a matching DNSKEY record was
found.
  11.14 INFO      The DNSKEY with tag 18937 uses algorithm number 5/(RSA/SHA1),
which is OK.
  11.14 INFO      The DNSKEY with tag 52823 uses algorithm number 5/(RSA/SHA1),
which is OK.
  11.34 INFO      The zone has NSEC records.
  11.34 INFO      Parent lists enough nameservers
(i.ns.se;ns.nic.se;ns3.nic.se). Lower limit set to 2.
  11.34 INFO      Child lists enough nameservers (i.ns.se;ns.nic.se;ns3.nic.se).
Lower limit set to 2.
  11.35 INFO      Parent and child list enough nameservers
(i.ns.se;ns.nic.se;ns3.nic.se). Lower limit set to 2.
  11.35 INFO      All the IP addresses used by the nameservers are unique
  11.35 INFO      The smallest possible legal referral packet is smaller than
513 octets (it is 357).
  11.36 INFO      All the nameservers are authoritative.
  11.38 INFO      No nameserver point to CNAME alias.
  11.38 INFO      All the nameservers have SOA record.
  11.39 INFO      All of the nameserver names are listed both at parent and
child.
  11.39 INFO      The module Example was disabled by the policy.
  11.58 INFO      None of the following nameservers is a recursor :
i.ns.se,ns.nic.se,ns3.nic.se.
  11.78 INFO      The following nameservers support EDNS0 :
ns.nic.se/212.247.7.228,i.ns.se/2001:67c:1010:5::53,ns3.nic.se/212.247.8.152,ns.nic.se/2a00:801:f0:53::53,ns3.nic.se/2a00:801:f0:211::152,i.ns.se/194.146.106.22.
  11.78 INFO      AXFR not available on nameserver i.ns.se/194.146.106.22.
  11.82 INFO      AXFR not available on nameserver i.ns.se/2001:67c:1010:5::53.
  11.89 INFO      AXFR not available on nameserver ns.nic.se/212.247.7.228.
  11.97 INFO      AXFR not available on nameserver ns.nic.se/2a00:801:f0:53::53.
  12.05 INFO      AXFR not available on nameserver ns3.nic.se/212.247.8.152.
  12.13 INFO      AXFR not available on nameserver
ns3.nic.se/2a00:801:f0:211::152.
  12.14 INFO      All nameservers reply with same IP used to query them.
  12.33 INFO      The following nameservers answer AAAA queries without problems
:
ns.nic.se/2a00:801:f0:53::53,ns3.nic.se/212.247.8.152,i.ns.se/2001:67c:1010:5::53,ns.nic.se/212.247.7.228,i.ns.se/194.146.106.22,ns3.nic.se/2a00:801:f0:211::152.
  12.33 INFO      All nameservers succeeded to resolve to an IP address.
  12.34 INFO      No illegal characters in the domain name (iis.se).
  12.34 INFO      Both ends of all labels of the domain name (iis.se) have no
hyphens.
  12.34 INFO      Domain name (iis.se) has no label with a double hyphen ('--')
in position 3 and 4 (with a prefix which is not 'xn--').
  12.34 INFO      Nameserver (i.ns.se) syntax is valid.
  12.34 INFO      Nameserver (ns.nic.se) syntax is valid.
  12.34 INFO      Nameserver (ns3.nic.se) syntax is valid.
  12.34 INFO      There is no misused '@' character in the SOA RNAME field
(hostmaster.iis.se.).
  12.35 INFO      The SOA RNAME field (hostmaster@iis.se) is compliant with
RFC2822.
  12.35 INFO      SOA MNAME (ns.nic.se) syntax is valid.
  12.35 INFO      Domain name MX (mx1.iis.se) syntax is valid.
  12.35 INFO      Domain name MX (mx2.iis.se) syntax is valid.
  12.42 INFO      SOA 'mname' nameserver (ns.nic.se) is authoritative for
'iis.se' zone.
  12.42 NOTICE    SOA 'refresh' value (10800) is less than the recommended one
(14400).
  12.42 INFO      SOA 'refresh' value (10800) is higher than the SOA 'retry'
value (3600).
  12.43 INFO      SOA 'expire' value (1814400) is higher than the minimum
recommended value (604800) and lower than 'refresh' value.
  12.43 INFO      SOA 'minimum' value (14400) is between the recommended ones
(300/86400).
  12.46 INFO      SOA 'mname' value (ns.nic.se) refers to a NS which is not an
alias (CNAME).
  12.48 INFO      SOA 'mname' value (ns.nic.se) refers to a NS which is not an
alias (CNAME).
  12.49 INFO      Target (MX=mx2.iis.se/MX=mx1.iis.se) found to deliver e-mail
for the domain name.

```

