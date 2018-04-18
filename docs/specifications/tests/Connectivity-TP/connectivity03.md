# CONNECTIVITY03: AS Diversity

## Test case identifier

**CONNECTIVITY03:** AS Diversity

## Objective

The objective in this test is to verify that all IP addresses of the domain's
authoritative name servers are not announced from the same [ASN]. 

This test is done separately on IPv4 and IPv6, and both must match the criterion.

[RFC 2182], section 3.1 clearly specifies that distinct authoritative name 
servers for a child domain should be placed in different topological and 
geographical locations. The objective is to minimise the likelihood of a single 
failure disabling all of them. 


## Inputs

* The domain name to be tested ("child zone");
* The ASN database to be used (RIPE or Cymru).
* The base name (Cymru) or Whois server (RIPE) to be used.


## Ordered description of steps to be taken to execute the test case

1. Obtain the total set of IP addresses of the name servers for the 
   *child zone* using [Method4] and [Method5].

2. For each IP address in the set from step 1 above, determine the ASN set
   announcing the IP address using either the Cymru database or the RIPE
   database as described in separate sections below. 

3. For each IP protokoll (IPv4, IPv6) do:
   1. If all addresses are announced from one and the same ASN emit
      *[IPV4_ONLY_ONE_ASN]* or *[IPV6_ONLY_ONE_ASN]*.
   2. If all addresses are announced from the same ASN set but from more than 
      one ASN emit *[IPV4_SAME_ASN]* or *[IPV6_SAME_ASN]*.
   3. If the addresses are announced from overlapping ASN sets, i.e. 
      every set is either a subset, identical or superset of all other sets, 
      but there are at least two IP addresses with non-identical ASN sets,
      emit *[IPV4_OVERLAP_ASN]* or *[IPV6_OVERLAP_ASN]*.
   4. If there are at least two IP addresses for which the ASN sets are 
      neither a subset, identical or superset of the other emit
      *[IPV4_DIFFERENT_ASN]* or *[IPV6_DIFFERENT_ASN]*.


## Outcome(s)

The outcome of the test case depends on the highest level of the messages
generated.

Message            |Default severity level (if message is emitted)
:------------------|:------------
EMPTY_ASN_SET      |ERROR        
ERROR_ASN_DATABASE |ERROR        
IPV4_ONLY_ONE_ASN  |ERROR        
IPV4_SAME_ASN      |NOTICE       
IPV4_OVERLAP_ASN   |NOTICE       
IPV4_DIFFERENT_ASN |INFO         
IPV6_ONLY_ONE_ASN  |ERROR        
IPV6_SAME_ASN      |NOTICE       
IPV6_OVERLAP_ASN   |NOTICE       
IPV6_DIFFERENT_ASN |INFO         


## Special procedural requirements

This test case is dependent on one of two possible services that can provide
ASN lookup, RIPE or Cymru. The service must be available over the network.


### Cymru ASN lookup

The Cymru lookup method is described on the Team Cymru [IP to ASN Mapping]
using DNS lookup.

1. Prepend the basename (from input) with the label "origin" (IPv4) or 
   "origin6" (IPv6). If basename is "asnlookup.zonemaster.net" we get 
   the following expanded basenames:
   
```
origin.asnlookup.zonemaster.net
origin6.asnlookup.zonemaster.net
```

2. Reverse the IP address with the same method as is used for
   reverse lookup. For description see [RFC 1035] (IPv4) and 
   [RFC 3596] (IPv6)
 
3. Prepend the expanded basename with the reversed IP address. For
   description see [IP to ASN Mapping].

4. Send a DNS query for the TXT record of the full name created in step 3.

5. If the response is empty, i.e. dns response with RCODE NXDOMAIN
   or a response with RCODE NOERROR but empty answer section emit
   *[EMPTY_ASN_SET]* and end these steps.

6. If there is no response (timeout) or responds with any other 
   RCODE (unknown status of service) emit *[ERROR_ASN_DATABASE]* and 
   end these steps.

8. The expected response is a non-empty string in the TXT record or 
   records. See [IP to ASN Mapping] for examples.

9. Split the string or strings into fields.

10. If there are multiple strings (TXT records), ignore all strings
    except for the string with the most specific subnet.

11. Extract the ASN or ASNs.

12. If steps 8-10 could not be processed emit *[ERROR_ASN_DATABASE]*
    and end these steps (the response was malformed).

13. The ASN or ASNs from step 11 is the ASN set for that IP address.


### RIPE ASN lookup

The RIPE ASN lookup is described on the RIPE [RISwhois] page.

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

3. The non-empty line not prepended with "%" contains the string
   with data (no or one such line).

4. Check if there is no string with data (empty reply). If so, 
   emit *[EMPTY_ASN_SET]* and end these steps.

5. If there is no response from the Whois server emit 
   *[ERROR_ASN_DATABASE]* and end these steps.

6. The first field has the ASN or list of ASNs. Split that into ASNs.

7. If steps 3-6 could not be processed emit *[ERROR_ASN_DATABASE]*
   and end these steps (the response was malformed).

8. From the ASN or ASNs from step 6 create the ASN set for the IP
   address.


## Intercase dependencies

None

[RFC 2182]: https://tools.ietf.org/html/rfc2182

[ASN]:      https://tools.ietf.org/html/rfc1930

[RFC 1035]: https://tools.ietf.org/html/rfc1035

[RFC 3596]: https://tools.ietf.org/html/rfc3596

[IP to ASN Mapping]: https://team-cymru.org/IP-ASN-mapping.html#dns

[RISwhois]: http://www.ripe.net/ris/riswhois.html


[Method2]:  ../Methods.md#method-2-obtain-glue-name-records-from-parent

[Method3]:  ../Methods.md#method-3-obtain-name-servers-from-child

[Method4]:  ../Methods.md#method-4-obtain-glue-address-records-from-parent

[Method5]:  ../Methods.md#method-5-obtain-the-name-server-address-records-from-child



#outcomes


[EMPTY_ASN_SET]: #outcomes 
[ERROR_ASN_DATABASE]: #outcomes 
[IPV4_ONLY_ONE_ASN]: #outcomes 
[IPV4_SAME_ASN]: #outcomes 
[IPV4_OVERLAP_ASN]: #outcomes 
[IPV4_DIFFERENT_ASN]: #outcomes 
[IPV6_ONLY_ONE_ASN]: #outcomes 
[IPV6_SAME_ASN]: #outcomes 
[IPV6_OVERLAP_ASN]: #outcomes 
[IPV6_DIFFERENT_ASN]: #outcomes 