# CONNECTIVITY03: AS Diversity

## Test case identifier

**CONNECTIVITY03**

## Objective

The objective in this test is to verify that all IP addresses of the domain's
authoritative name servers are not announced from the same ASN (autonomous system 
number). See [RFC 1930] and [Wikipedia] for an explanation of AS (autonomous 
system).

This test is done separately on IPv4 and IPv6, and both must match the criterion.

[RFC 2182], section 3.1 clearly specifies that distinct authoritative name 
servers for a child domain should be placed in different topological and 
geographical locations. The objective is to minimise the likelihood of a single 
failure disabling all of them. 


## Inputs

* "Child Zone" - The domain name to be tested.
* "ASN Database" - The database of ASN data to be used. Possible values
  are "RIPE" and "Cymru" (the default value).
* "Cymru Base Name" - If the *ASN Database* is "Cymru", the default value 
  is "asnlookup.zonemaster.net".
* "Ris Whois Server" - If the *ASN Database* is "RIPE", the default value 
  is "riswhois.ripe.net".


## Ordered description of steps to be taken to execute the test case

1. Obtain the total set of IP addresses of the name servers for the 
   *Child Zone* using [Method4] and [Method5] and do:
   1. Create a possibly empty set of the IPv4 addresses ("NS IPv4").
   2. Create a possibly empty set of the IPv6 addresses ("NS IPv6").

2. For each IP address in the set *NS IPv4* and *NS IPv6*, respectively, 
   determine the ASN set announcing the IP address using either the 
   *[Cymru database]* or the *[RIPE database]* as described in separate 
   sections below. Create two sets of ASN data ("NS IPv4 ASN" and 
   "NS IPv6 ASN", respectively).

3. For *NS IPv4 ASN* do:
   1. If *NS IPv4 ASN* is empty (no IPv4 address) do nothing.
   2. Else, if all IPv4 addresses are announced from one and the same ASN, output
      *[IPV4_ONE_ASN]*.
   3. Else, if all IPv4 addresses are announced from the same set of multiple 
      ASNs, output *[IPV4_SAME_ASN]*.
   4. Else, output *[IPV4_DIFFERENT_ASN]*.

4. For *NS IPv6 ASN* do:
   1. If *NS IPv6 ASN* is empty (no IPv6 address) do nothing.
   2. Else, if all IPv6 addresses are announced from one and the same ASN, output
      *[IPV6_ONE_ASN]*.
   3. Else, if all IPv6 addresses are announced from the same set of multiple 
      ASNs, output *[IPV6_SAME_ASN]*.
   4. Else, output *[IPV6_DIFFERENT_ASN]*.

## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one 
message with the severity level ERROR or CRITICAL.

The outcome of this Test Case is "warning" if there is at least 
one message with the severity level WARNING, but no message with 
severity level ERROR or CRITICAL.

In other cases the outcome of this Test Case is "pass".

Message            |Default severity level (if message is outputted)
:------------------|:------------
EMPTY_ASN_SET      |ERROR        
ERROR_ASN_DATABASE |ERROR        
IPV4_ONE_ASN       |ERROR        
IPV4_SAME_ASN      |NOTICE       
IPV4_DIFFERENT_ASN |INFO         
IPV6_ONE_ASN       |ERROR        
IPV6_SAME_ASN      |NOTICE       
IPV6_DIFFERENT_ASN |INFO         


## Special procedural requirements

This test case is dependent on one of two possible services that can provide
ASN lookup, RIPE or Cymru. The service must be available over the network.


### Cymru ASN lookup

The Cymru lookup method is described on the Team Cymru [IP to ASN Mapping]
using DNS lookup.

1. Prepend the *Cymru Base Name* with the label "origin" (IPv4) or 
   "origin6" (IPv6). Example of expanded basenames 
   ("expanded base name"):
   
```
origin.asnlookup.zonemaster.net
origin6.asnlookup.zonemaster.net
```

2. Reverse the IP address with the same method as is used for
   reverse lookup. For description see [RFC 1035], section 3.5, for IPv4 
   and [RFC 3596], section 2.5, for IPv6.
 
3. Prepend the *expanded base name* with the reversed IP address. For
   description see [IP to ASN Mapping].

4. Send a DNS query for the TXT record of the full name created in step 3.

5. If either the DNS response has RCODE "NXDOMAIN" or the DNS response 
   has RCODE "NOERROR" but empty answer section, output
   *[EMPTY_ASN_SET]* and end these steps for Cymru look-up of the specific
   IP address.

6. If there is no response (timeout) or the DNS response does not have
   the RCODE "NOERROR", output *[ERROR_ASN_DATABASE]* and 
   end these steps for Cymru look-up of the specific IP address.

8. The expected response is a non-empty string in the TXT record or 
   records. See [IP to ASN Mapping] for examples.

9. Do the following:

   1. Split the string or strings into fields.
   2. If there are multiple strings (TXT records), ignore all strings
      except for the string with the most specific subnet.
   3. Extract the ASN or ASNs.
   4. If it was not possible to extract the ASN or ASNs, output 
      *[ERROR_ASN_DATABASE]* and end these steps for Cymru look-up of 
      the specific IP address (the response was malformed).

10. The ASN or ASNs from step 11 is the ASN set for that IP address
    and is used for the further processing.


### RIPE ASN lookup

The RIPE ASN lookup is described on the RIPE [RISwhois] page.

1. Construct a query string by prepending the IP adress with
   " -F -M ". Using "192.0.2.10" as an example, the query string will
   be the following (the leading space is intentional)
   
   ```
   " -F -M 192.0.2.10" 
   ```
   
2. Send the query string to the *Ris Whois Server* on port
   43 with the nicname (whois) protocol. Example of command
   line command on unix:

```
whois -h riswhois.ripe.net " -F -M 192.0.2.10"
```

3. Do the following:
   1. The non-empty line not prepended with "%" contains the string
      with data (no or one such line).
   2. Check if there is no string with data (empty reply). If so, 
      output *[EMPTY_ASN_SET]* and end these steps for RIPE look-up
      of the specific IP address.
   3. If there is no response from the *Ris Whois Server*, output 
      *[ERROR_ASN_DATABASE]* and end these steps for RIPE look-up
      of the specific IP address.
   4. The first field has the ASN or list of ASNs. Split that into ASNs.
   5. If it was not possible to extrac the ASN or ASNs, output 
      *[ERROR_ASN_DATABASE]* and end these steps (the response was 
      malformed).

8. From the ASN or ASNs from step 6 create the ASN set for the IP
   address and is used for the further processing.

## Intercase dependencies

None

[RFC 1035]:           https://tools.ietf.org/html/rfc1035
[RFC 1930]:           https://tools.ietf.org/html/rfc1930
[RFC 2182]:           https://tools.ietf.org/html/rfc2182#page-4
[RFC 3596]:           https://tools.ietf.org/html/rfc3596#section-2.5

[Wikipedia]:          https://en.wikipedia.org/wiki/Autonomous_system_(Internet)

[IP to ASN Mapping]:  https://team-cymru.org/IP-ASN-mapping.html#dns
[RISwhois]:           https://www.ripe.net/analyse/archived-projects/ris-tools-web-interfaces/riswhois

[Method4]:            ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:            ../Methods.md#method-5-obtain-the-name-server-address-records-from-child

[RIPE database]:      #ripe-asn-lookup
[Cymru database]:     #cymru-asn-lookup

[EMPTY_ASN_SET]:      #outcomes 
[ERROR_ASN_DATABASE]: #outcomes 
[IPV4_ONE_ASN]:       #outcomes 
[IPV4_SAME_ASN]:      #outcomes 
[IPV4_DIFFERENT_ASN]: #outcomes 
[IPV6_ONE_ASN]:       #outcomes 
[IPV6_SAME_ASN]:      #outcomes 
[IPV6_DIFFERENT_ASN]: #outcomes 
