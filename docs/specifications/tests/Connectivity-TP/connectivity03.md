## CONNECTIVITY03: AS Diversity

### Test case identifier

**CONNECTIVITY03:** AS Diversity

### Objective

[RFC 2182](https://tools.ietf.org/html/rfc2182), section 3.1
clearly specifies that distinct authoritative name servers for a child
domain should be placed in different topological and geographical locations.
The objective is to minimise the likelihood of a single failure disabling
all of them. 

The objective in this test is to verify that all IP addresses of the domain's
authoritative name servers are not announced from the same 
[ASN](https://tools.ietf.org/html/rfc1930). This test is done separtly on IPv4 
and IPv6, and both must match the criterion.

### Inputs

* The domain name to be tested.
* The test method (RIPE or Cymru).
* The base name (Cymru) or Whois server (RIPE) to be used.

### Ordered description of steps to be taken to execute the test case

1. Obtain the total set of IP addresses of the name servers using 
   [Method4](../Methods.md) and [Method5](../Methods.md).
2. From configuration determine if the Cymru or RIPE database is to be queried,
   and what the base name of service is.
3. For each IP address in the set from step 1 above, determine the set of ASNs
   announcing the IP address using either the Cymru database or the RIPE
   database as described in separate sections below. 
4. For each IP protokoll (IPv4, IPv6) do:
   1. Compare the ASN sets for all IP addresses.
   2. Verify if all addresses are announced from one and the same ASN.
   3. Verify if all addresses are announced from ASN set but from more than one ASN.
   4. Verify if the addresses are announced from overlapping ASN sets, i.e. every set is either a subset, identical or superset of all other sets, but there are at least two IPv4 addresses with non-identical ASN sets.
   5. Verify if the IPv4 addresses are announced from overlapping ASN sets, i.e. every set is either a subset, identical or superset of all other sets, but there are at least two IPv4 addresses with non-identical ASN sets.
   6. Verify if there are at least two IPv4 addresses for which the ASN sets are neither a subset, identical or superset of the other.


### Outcome(s)

The outcome of the test case depends on the highest level of the messages
generated.

Message            |Default level|Criteria
:------------------|:------------|:-----------------------------------------------------------------
NO_ASN             |FAIL         |The ASN database replies with empty reply.
ERROR_ASN_DATABASE |FAIL         |The ASN database does not reply, replies with unexpected status or with a malformed message.
IPV4_ONLY_ONE_ASN  |FAIL         |All IPv4 addresses are announced from one and the same ASN.
IPV4_SAME_ASN      |NOTICE       |All IPv4 addresses are announced from the one ASN set but from more than one ASN.
IPV4_OVERLAP_ASN   |NOTICE       |The IPv4 addresses are announced from overlapping ASN sets, i.e. every set is either a subset, identical or superset of all other sets, but there are at least two IPv4 addresses with non-identical ASN sets.
IPV4_DIFFERENT_ASN |INFO         |There are at least two IPv4 addresses for which the ASN sets are neither a subset, identical or superset of the other.
IPV6_ONLY_ONE_ASN  |FAIL         |All IPv6 addresses are announced from one and the same ASN.
IPV6_SAME_ASN      |NOTICE       |All IPv6 addresses are announced from the one ASN set but from more than one ASN.
IPV6_OVERLAP_ASN   |NOTICE       |The IPv6 addresses are announced from overlapping ASN sets, i.e. every set is either a subset, identical or superset of all other sets, but there are at least two IPv6 addresses with non-identical ASN sets.
IPV6_DIFFERENT_ASN |INFO         |There are at least two IPv6 addresses for which the ASN sets are neither a subset, identical or superset of the other.


### Special procedural requirements

This test case is dependent on one of two possible services that can provide
ASN lookup, RIPE or Cymru. The service must be available over the network.

### Intercase dependencies

None

## Cymru ASN lookup

The Cymru lookup method is described on the Team Cymru 
[IP to ASN Mappin](https://team-cymru.org/IP-ASN-mapping.html#dns)
using DNS lookup.

1. Prepend the basename (from input) with the label "origin" (IPv4) or 
   "origin6" (IPv6). If basename is "asn.cymru.com" we get 
   "origin.asn.cymru.com" and "origin6.asn.cymru.com", respectively.
2. Reverse the IP address with the same method as is used for
   reverse lookup. E.g.: 
 
 ```
 "192.0.2.10" => "10.2.0.192"
 "2001:db8::10" => "0.1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.8.b.d.0.1.0.0.2"
 ```
 
3. Prepend the expanded basename with the reversed IP address, using
   the examples above: 

```
10.2.0.192.origin.asn.cymru.com
0.1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.8.b.d.0.1.0.0.2.origin6.asn.cymru.com
```

4. Send a DNS query for the TXT record of the full name created in step 3.
5. Verify if the response is empty, i.e. dns response with RCODE NXDOMAIN
   or a response with RCODE NOERROR but empty answer section. If so, end
   these steps.
6. Verify if there is no response or responds with any other RCODE. If so,
   end these steps.
8. The expected response is a string in the TXT record or records. Remove 
   any leading and terminal `"` or leading and terminal `'`.
9. Split the string or strings into fields with `|` as field separator.
10. If there are multiple strings (TXT records), ignore all strings
    except for the string with the most specific subnet in field two 
    (ignoring any leading and trailing space characters).
11. The ASN or ASNs are found in field 1 (ignoring any leading and 
    trailing space) as a space separated list of ASNs.
12. Verify if steps 8-11 could be processed. If not, end these steps 
    (the response was malformed).
13. The ASN or ASNs from step 11 is the ASN set for that IP address.
    
 

## RIPE ASN lookup

The RIPE ASN lookup is described on the RIPE 
[RISwhois](http://www.ripe.net/ris/riswhois.html) page.

1. Construct a query string by prepending the IP adress with
   " -F -M ". Using "192.0.2.10" as an example, the query string will
   be the following (the leading space is intentional)
   
   ```
   " -F -M 192.0.2.10" 
   ```
   
2. Send the query string to the Whois server (from input) on port
   43 with the nicname (whois) protocol. If the server is 
   "riswhois.ripe.net" (default) then the command line command on
   unix will normally be

```
whois -h riswhois.ripe.net " -F -M 192.0.2.10"
```

3. In the non-empty line not prepended with "%" contains the string
   with data (none or one such line).
4. Verify if there is no string with data (empty reply). If so, 
   end these steps.
5. Verify if there is no response from the Whois server. If so,
   end these steps.
6. Split the string with data into two fields with horizontal tab
   as field separator. The first field has the ASN or list of ASNs.
7. Split the ASN fields into ASNs with `/` as field separator.
8. Verify if steps 3-7 could be processed. If not, end these steps 
   (the response was malformed).
9. From the ASN or ASNs from step 7 create the ASN set for the IP
   address.

-------

Copyright (c) 2013-2018, IIS (The Internet Foundation in Sweden)  
Copyright (c) 2013-2018, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <https://creativecommons.org/licenses/by/4.0/>.
