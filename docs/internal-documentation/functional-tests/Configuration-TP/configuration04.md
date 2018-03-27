## CONFIGURATION04: Delegation Inconsistency - Name Server Records 

### Test case identifier

**CONFIGURATION04:** Delegation Inconsistency - Name Server Records

### Objective 

When a parent zone 'P' delegates part of its namespace to a child 'C', P stores
the list of NS records for the authoritative servers of zone 'C'. This list of
NS records are kept both at the parent 'P' and the child zone 'C'. 

Delegation incosistency occurs when changes at the 'C' are not reflected to the NS RRs
at 'P'.

### Inputs

The domain to be tested.

### Ordered description of steps to be taken to execute the test case

1. Configure a live zone with inconsistency in name server records between parent
and child.

```
configuration04-1.zft-root.rd.nic.fr
```

2. The engine should return FAIL atleast once for the configuration defined. If it
returns PASS for all the tests then the engine does not capture delegation
inconsistency in name server records.

### Results
Verifying the zone with zonemaster CLI does provide conclusive errors as
you could see from the appendix

### Appendix
zonemaster-cli configuration04-1.zft-root.rd.nic.fr

Seconds  |Level     |Message
:--------|:---------|--------------------------------------------------------------
20.36    |ERROR     |Nameserver ns2.rd.nic.fr/192.134.4.81 did not return NS
records. RCODE was NOERROR.
20.36    |ERROR     |Nameserver ns2.rd.nic.fr/2001:67c:2218:3::1:7 did not return
NS records. RCODE was NOERROR.
30.39    |NOTICE    |Nameserver ns334987.ip-46-105-116.eu/46.105.116.200 did not
respond to NS query.
31.23    |ERROR     |Nameserver ns334987.ip-46-105-116.eu/46.105.116.200 not
accessible over UDP on port 53.
31.28    |ERROR     |Nameserver ns334987.ip-46-105-116.eu/46.105.116.200 not
accessible over TCP on port 53.
32.37    |WARNING   |All nameservers IPv6 addresses are in the same AS (2485).
32.38    |WARNING   |Nameserver ns334987.ip-46-105-116.eu/46.105.116.200 did not
respond.
32.38    |WARNING   |Nameserver ns334987.ip-46-105-116.eu/46.105.116.200 did not
respond.
32.38    |WARNING   |Nameserver ns334987.ip-46-105-116.eu/46.105.116.200 did not
respond.
32.38    |WARNING   |Nameserver ns334987.ip-46-105-116.eu/46.105.116.200 did not
respond.
32.39    |NOTICE    |176.31.226.223 returned no DS records for configuration04-1.zft-root.rd.nic.fr.
32.40    |WARNING   |Nameserver ns2.rd.nic.fr response is not authoritative on UDP
port 53.
32.40    |WARNING   |Nameserver ns2.rd.nic.fr response is not authoritative on TCP
port 53.
32.40    |WARNING   |Nameserver ns334987.ip-46-105-116.eu response is not
authoritative on UDP port 53.
32.40    |WARNING   |Nameserver ns334987.ip-46-105-116.eu response is not
authoritative on TCP port 53.
32.40    |ERROR     |A SOA query NOERROR response from ns2.rd.nic.fr was received
empty.
32.40    |ERROR     |Parent has nameserver(s) not listed at the child
(ns2.rd.nic.fr;ns324830.ip-178-33-232.eu;ns334987.ip-46-105-116.eu).
32.40    |ERROR     |None of the nameservers listed at the parent are listed at the
child.
62.52    |NOTICE    |Nameserver ns334987.ip-46-105-116.eu/46.105.116.200 dropped
AAAA query.
