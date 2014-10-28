## BEHAVIOR07: Check whether timestamps on the test being run are being
displayed

### Test case identifier

**BEHAVIOR07:** Timestamps on the tests being run

### Objective 

Current DNSCheck displays the current test being run with timestamp. This has
been one of the requirements for Zonemaster. 

The objective of this test is to verify that Zonemaster displays timestamp as
the tests are being run.

### Inputs

The domain to be tested.

### Ordered description of steps to be taken to execute the test case

1. A standard query for the domain is made (zonemaster-cli afnic.fr)
2. If the output from the CLI does not have timestamps, for each test being run,
then the test fails 

### Outcome(s)

If the test returns FAIL, then the engine does not capture the expected behavior

### Results in comparison to ZC/DC	
``` 
zonemaster-cli --show_module iis.se

Seconds Level     Module       Message
======= ========= ============ =======
   5.38 NOTICE    SYNTAX       No illegal characters in the domain name
(iis.se).
  38.87 WARNING   ADDRESS      Nameserver i.ns.se has an IP address
(194.146.106.22) with mismatched PTR result (se1.dnsnode.net.).
  38.87 WARNING   ADDRESS      Nameserver i.ns.se has an IP address
(2001:67c:1010:5::53) with mismatched PTR result (se1.dnsnode.net.).
  38.87 WARNING   ADDRESS      Nameserver ns.nic.se has an IP address
(212.247.7.228) without PTR configured.
  38.87 WARNING   ADDRESS      Nameserver ns3.nic.se has an IP address
(212.247.8.152) without PTR configured.
  40.81 WARNING   ZONE         SOA 'refresh' value (10800) is less than the
recommended one (14400).
```
-------------------
```
dnscheck iis.se

  0.000: iis.se INFO Begin testing zone iis.se with version 1.6.6.
  0.001: iis.se INFO Begin testing delegation for iis.se.
  3.669: iis.se INFO Name servers listed at parent: i.ns.se,ns.nic.se,ns3.nic.se
  4.690: iis.se INFO Name servers listed at child: i.ns.se,ns.nic.se,ns3.nic.se
  4.747: iis.se INFO Parent glue for iis.se found: i.ns.se (194.146.106.22)
  4.796: iis.se INFO Parent glue for iis.se found: i.ns.se
(2001:67c:1010:5:0:0:0:53)
  4.850: iis.se INFO Parent glue for iis.se found: ns.nic.se (212.247.7.228)
  4.901: iis.se INFO Parent glue for iis.se found: ns.nic.se
(2a00:801:f0:53:0:0:0:53)
  4.907: iis.se INFO Parent glue for iis.se found: ns3.nic.se (212.247.8.152)
  4.927: iis.se INFO Parent glue for iis.se found: ns3.nic.se
(2a00:801:f0:211:0:0:0:152)
  4.928: iis.se INFO Checking glue for i.ns.se (194.146.106.22).
  4.928: iis.se INFO Checking glue for i.ns.se (2001:67c:1010:5:0:0:0:53).
  4.928: iis.se INFO Checking glue for ns.nic.se (212.247.7.228).
  4.928: iis.se INFO Checking glue for ns.nic.se (2a00:801:f0:53:0:0:0:53).
  4.929: iis.se INFO Checking glue for ns3.nic.se (212.247.8.152).
  4.929: iis.se INFO Checking glue for ns3.nic.se (2a00:801:f0:211:0:0:0:152).
  4.929: iis.se INFO Parent glue for iis.se found: i.ns.se (194.146.106.22)
  4.930: iis.se INFO Parent glue for iis.se found: i.ns.se
(2001:67c:1010:5:0:0:0:53)
  4.930: iis.se INFO Parent glue for iis.se found: ns.nic.se (212.247.7.228)
  4.931: iis.se INFO Parent glue for iis.se found: ns.nic.se
(2a00:801:f0:53:0:0:0:53)
  4.931: iis.se INFO Parent glue for iis.se found: ns3.nic.se (212.247.8.152)
  4.931: iis.se INFO Parent glue for iis.se found: ns3.nic.se
(2a00:801:f0:211:0:0:0:152)
  5.279: iis.se INFO It is possible to build a referral packet for iis.se that
works without EDNS0.
  5.279: iis.se INFO Done testing delegation for iis.se.
  5.280: iis.se INFO Begin testing name server i.ns.se.
  5.280: iis.se INFO Begin testing host i.ns.se.
  5.281: iis.se INFO Begin testing address 194.146.106.22.
  8.439: iis.se INFO Done testing address 194.146.106.22.
  8.439: iis.se INFO Begin testing address 2001:67c:1010:5:0:0:0:53.
  9.098: iis.se INFO Done testing address 2001:67c:1010:5:0:0:0:53.
  9.098: iis.se INFO Done testing host i.ns.se.
  9.105: iis.se INFO Name server i.ns.se (194.146.106.22) answers queries over
UDP.
  9.111: iis.se INFO Name server i.ns.se (194.146.106.22) answers queries over
TCP.
  9.114: iis.se INFO Name server i.ns.se (194.146.106.22) is not recursive.
  9.132: iis.se INFO Name server i.ns.se (194.146.106.22) authoritative for
iis.se.
  9.137: iis.se INFO Name server i.ns.se (194.146.106.22) closed for zone
transfer of iis.se.                                                                               
  9.141: iis.se INFO Legacy name server ID for i.ns.se (194.146.106.22):
hostname.bind = s2.par
  9.145: iis.se INFO Legacy name server ID for i.ns.se (194.146.106.22):
version.bind = contact info@netnod.se
  9.149: iis.se INFO Legacy name server ID for i.ns.se (194.146.106.22):
id.server = s2.par
  9.152: iis.se NOTICE No answer received from 194.146.106.22 when querying for
version.server/CH/TXT.
  9.153: iis.se INFO IPv6 disabled - will not test name server at
2001:67c:1010:5:0:0:0:53
  9.153: iis.se INFO Done testing name server i.ns.se.
  9.153: iis.se INFO Begin testing name server ns.nic.se.
  9.153: iis.se INFO Begin testing host ns.nic.se.
  9.153: iis.se INFO Begin testing address 212.247.7.228.
 13.630: iis.se INFO Done testing address 212.247.7.228.
 13.630: iis.se INFO Begin testing address 2a00:801:f0:53:0:0:0:53.
 15.206: iis.se INFO Done testing address 2a00:801:f0:53:0:0:0:53.
 15.206: iis.se INFO Done testing host ns.nic.se.
 15.251: iis.se INFO Name server ns.nic.se (212.247.7.228) answers queries over
UDP.
 15.335: iis.se INFO Name server ns.nic.se (212.247.7.228) answers queries over
TCP.
 15.376: iis.se INFO Name server ns.nic.se (212.247.7.228) is not recursive.
 15.543: iis.se INFO Name server ns.nic.se (212.247.7.228) authoritative for
iis.se.
 15.659: iis.se INFO Name server ns.nic.se (212.247.7.228) closed for zone
transfer of iis.se.
 15.700: iis.se INFO Legacy name server ID for ns.nic.se (212.247.7.228):
hostname.bind = mail01
 15.743: iis.se INFO Legacy name server ID for ns.nic.se (212.247.7.228):
version.bind = 9.4.2-P2.1
 15.821: iis.se NOTICE No answer received from 212.247.7.228 when querying for
version.server/CH/TXT.
 15.822: iis.se INFO IPv6 disabled - will not test name server at
2a00:801:f0:53:0:0:0:53
 15.822: iis.se INFO Done testing name server ns.nic.se.
 15.823: iis.se INFO Begin testing name server ns3.nic.se.
 15.823: iis.se INFO Begin testing host ns3.nic.se.
 15.824: iis.se INFO Begin testing address 212.247.8.152.
 16.871: iis.se INFO Done testing address 212.247.8.152.
 16.871: iis.se INFO Begin testing address 2a00:801:f0:211:0:0:0:152.
 17.309: iis.se INFO Done testing address 2a00:801:f0:211:0:0:0:152.
 17.309: iis.se INFO Done testing host ns3.nic.se.
 17.352: iis.se INFO Name server ns3.nic.se (212.247.8.152) answers queries over
UDP.
 17.435: iis.se INFO Name server ns3.nic.se (212.247.8.152) answers queries over
TCP.
 17.477: iis.se INFO Name server ns3.nic.se (212.247.8.152) is not recursive.
 17.646: iis.se INFO Name server ns3.nic.se (212.247.8.152) authoritative for
iis.se.
 17.759: iis.se INFO Name server ns3.nic.se (212.247.8.152) closed for zone
transfer of iis.se.
 17.801: iis.se INFO Legacy name server ID for ns3.nic.se (212.247.8.152):
hostname.bind = ns3
 17.841: iis.se INFO Legacy name server ID for ns3.nic.se (212.247.8.152):
version.bind = 9.7.0-P1
 17.921: iis.se NOTICE No answer received from 212.247.8.152 when querying for
version.server/CH/TXT.
 17.921: iis.se INFO IPv6 disabled - will not test name server at
2a00:801:f0:211:0:0:0:152
 17.921: iis.se INFO Done testing name server ns3.nic.se.
 17.921: iis.se INFO Begin testing zone consistency for iis.se.
 17.935: iis.se INFO SOA at address 194.146.106.22 has serial 1414412701.
 17.981: iis.se INFO SOA at address 212.247.8.152 has serial 1414412701.
 18.029: iis.se INFO SOA at address 212.247.7.228 has serial 1414412701.
 18.029: iis.se INFO All SOA records have consistent serial numbers.
 18.030: iis.se INFO All other fields in the SOA record are consistent among all
name servers.
 18.125: iis.se NOTICE The listed nameservers for iis.se all report the same set
of nameservers.
 18.125: iis.se INFO Done testing zone consistency for iis.se.
 18.126: iis.se INFO Begin testing SOA parameters for iis.se.
 18.168: iis.se INFO Found SOA record for iis.se.
 18.168: iis.se INFO Begin testing host ns.nic.se.
 18.169: iis.se INFO Begin testing address 212.247.7.228.
 18.322: iis.se INFO Done testing address 212.247.7.228.
 18.323: iis.se INFO Begin testing address 2a00:801:f0:53:0:0:0:53.
 18.323: iis.se INFO Done testing address 2a00:801:f0:53:0:0:0:53.
 18.323: iis.se INFO Done testing host ns.nic.se.
 18.323: iis.se INFO SOA MNAME for iis.se valid (ns.nic.se).
 18.324: iis.se INFO SOA MNAME for iis.se (ns.nic.se) listed as NS.
 18.365: iis.se INFO SOA MNAME for iis.se (ns.nic.se) is authoritative.
 18.366: iis.se INFO IPv6 disabled - will not query SOA MNAME at
2a00:801:f0:53:0:0:0:53
 18.366: iis.se INFO Begin testing email address hostmaster@iis.se.
 18.591: iis.se INFO Mail exchangers for hostmaster@iis.se found
mx2.iis.se,mx1.iis.se.
 18.591: iis.se INFO All mail servers for hostmaster@iis.se are in zone iis.se.
 18.592: iis.se INFO Begin testing host mx2.iis.se.
 19.025: iis.se INFO Begin testing address 212.247.8.148.
 20.323: iis.se INFO Done testing address 212.247.8.148.
 20.323: iis.se INFO Begin testing address 2a00:801:f0:211:0:0:0:148.
 20.800: iis.se INFO Done testing address 2a00:801:f0:211:0:0:0:148.
 20.800: iis.se INFO Done testing host mx2.iis.se.
 20.801: iis.se INFO Begin testing host mx1.iis.se.
 21.138: iis.se INFO Begin testing address 91.226.36.39.
 22.014: iis.se INFO Done testing address 91.226.36.39.
 22.014: iis.se INFO Begin testing address 2a00:801:f0:106:0:0:0:39.
 22.356: iis.se INFO Done testing address 2a00:801:f0:106:0:0:0:39.
 22.356: iis.se INFO Done testing host mx1.iis.se.
 22.357: iis.se INFO Done testing email address hostmaster@iis.se.
 22.357: iis.se INFO Successful attempt to deliver email for SOA RNAME of iis.se
(hostmaster.iis.se) using hostmaster@iis.se.
 22.357: iis.se INFO SOA TTL for iis.se OK (3600) - recommended >= 3600.
 22.357: iis.se NOTICE SOA refresh for iis.se too small (10800) - recommended >=
14400.
 22.357: iis.se INFO SOA retry for iis.se OK (3600) - recommended >= 3600.
 22.358: iis.se INFO SOA expire for iis.se OK (1814400) - recommended >= 604800.
 22.358: iis.se INFO SOA minimum for iis.se OK (14400) - recommended between 300
and 86400.
 22.358: iis.se INFO Done testing SOA parameters for iis.se.
 22.358: iis.se INFO Begin testing connectivity for iis.se.
 23.067: iis.se INFO Zone announced by more than one ASN.
 23.854: iis.se INFO Zone announced by more than one IPv6 ASN.
 23.855: iis.se INFO Done testing connectivity for iis.se.
 23.855: iis.se INFO Begin testing DNSSEC for iis.se.
 23.936: iis.se INFO Found DS record for iis.se at parent.
 24.022: iis.se INFO Nameserver 212.247.7.228 does DNSSEC extra processing.
 24.103: iis.se INFO Nameserver 212.247.8.152 does DNSSEC extra processing.
 24.110: iis.se INFO Nameserver 194.146.106.22 does DNSSEC extra processing.
 24.110: iis.se INFO Servers for iis.se have consistent extra processing status.
 24.193: iis.se INFO Authenticated denial records found for iis.se, of type
NSEC.
 24.232: iis.se INFO Found DNSKEY record for iis.se at child.
 24.232: iis.se INFO Consistent security for iis.se.
 24.232: iis.se INFO Checking DNSSEC at child (iis.se).
 24.232: iis.se INFO iis.se's key with tag 18937 uses algorithm number 5
(RSA/SHA-1).
 24.232: iis.se INFO Algorithm number 5 is OK.
 24.232: iis.se INFO DNSKEY iis.se (tag 18937) is marked as a secure entry point
(SEP).
 24.232: iis.se INFO iis.se's key with tag 52823 uses algorithm number 5
(RSA/SHA-1).
 24.232: iis.se INFO Algorithm number 5 is OK.
 24.233: iis.se INFO DNSSEC signature expires at: Thu Nov  6 11:25:01 2014
 24.233: iis.se INFO Duration for RRSIG(iis.se/IN/DNSKEY/18937) is OK (864000
seconds).
 24.233: iis.se INFO DNSSEC signature RRSIG(iis.se/IN/DNSKEY/18937) matches
records.
 24.233: iis.se INFO DNSSEC signature valid: RRSIG(iis.se/IN/DNSKEY/18937)
 24.233: iis.se INFO DNSSEC signature expires at: Thu Nov  6 11:25:01 2014
 24.233: iis.se INFO Duration for RRSIG(iis.se/IN/DNSKEY/52823) is OK (864000
seconds).
 24.234: iis.se INFO DNSSEC signature RRSIG(iis.se/IN/DNSKEY/52823) matches
records.
 24.234: iis.se INFO DNSSEC signature valid: RRSIG(iis.se/IN/DNSKEY/52823)
 24.234: iis.se INFO Enough valid signatures found for iis.se.
 24.314: iis.se INFO DNSSEC signature expires at: Thu Nov  6 11:25:01 2014
 24.314: iis.se INFO Duration for RRSIG(iis.se/IN/SOA/52823) is OK (864000
seconds).
 24.314: iis.se INFO DNSSEC signature RRSIG(iis.se/IN/SOA/52823) matches
records.
 24.315: iis.se INFO DNSSEC signature valid: RRSIG(iis.se/IN/SOA/52823)
 24.315: iis.se INFO Enough valid signatures over SOA RRset found for iis.se.
 24.315: iis.se INFO DNSSEC child checks for iis.se complete.
 24.315: iis.se INFO Checking DNSSEC at parent of iis.se.
 24.315: iis.se INFO iis.se's key with tag 18937 uses algorithm number 5
(RSA/SHA-1).
 24.315: iis.se INFO Algorithm number 5 is OK.
 24.315: iis.se INFO Parent DS(iis.se/5/2/18937) refers to valid key at child:
DNSKEY(iis.se/5/18937)
 24.315: iis.se INFO Parent DS(iis.se) refers to secure entry point (SEP) at
child: DS(iis.se/5/2/18937)
 24.315: iis.se INFO iis.se's key with tag 18937 uses algorithm number 5
(RSA/SHA-1).
 24.315: iis.se INFO Algorithm number 5 is OK.
 24.315: iis.se INFO Parent DS(iis.se/5/1/18937) refers to valid key at child:
DNSKEY(iis.se/5/18937)
 24.315: iis.se INFO Parent DS(iis.se) refers to secure entry point (SEP) at
child: DS(iis.se/5/1/18937)
 24.316: iis.se INFO DNSSEC parent checks for iis.se complete.
 24.316: iis.se INFO Done testing DNSSEC for iis.se.
 24.316: iis.se INFO Test completed for zone iis.se.
```
