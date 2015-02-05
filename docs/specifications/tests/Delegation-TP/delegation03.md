## DELEGATION03: No truncation of referrals

### Test case identifier

**DELEGATION03:** No truncation of referrals

### Objective

The Domain Name System defaults to using UDP for queries and answers with a
DNS payload limit of 512 bytes. Larger replies cause an initial truncation
indication leading to a subsequent handling via TCP with substantially
higher overhead. EDNS0 is used to allow for larger UDP responses thus
reducing the need for use of TCP.

But [IANA](https://www.iana.org/help/nameserver-requirements) still
maintains that referrals from the parent zone name servers must fit into
a non-EDNS0 UDP DNS packet.

In this test, the authoritative and additional section of the referral
response from the domain must fit into a 512 byte UDP packet.

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Obtain the complete set of name servers from the parent using
   [Method2](../Methods.md) and the child using [Method3](../Methods.md).
2. Obtains the IP addresss of the name servers from the parent using
   [Method4](../Methods.md) and the child using [Method5](../Methods.md).
3. Create a DNS packet holding a query for a maximally long name in the relevant
   zone (that is, 255 octets including label separators).
4. Add all unique NS records for the zone obtained from step1 to the Authority section.
5. If there is at least one in-zone NS that has an IPv4 address, take the
   one with the shortest name and add an A record for it to the Additional
   section.
6. If there is at least one in-zone NS that has an IPv6 address, take the
   one with the shortest name and add an AAAA record for it to the Additional
   section.
7. If the DNS packet after encoding is more than 512 octets then the test
   fails.

### Outcome(s)

If the created packet fits into 512 octet, then the test succeeds.

### Special procedural requirements

None

### Intercase dependencies

None

-------

Copyright (c) 2013, 2014, 2015, .SE (The Internet Infrastructure Foundation)  
Copyright (c) 2013, 2014, 2015, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <http://creativecommons.org/licenses/by/4.0/>.
