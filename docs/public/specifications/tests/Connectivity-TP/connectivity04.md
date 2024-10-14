# CONNECTIVITY04: IP Prefix Diversity

## Test case identifier
**CONNECTIVITY04**

## Table of contents

* [Objective](#objective)
* [Scope](#scope)
* [Inputs](#inputs)
* [Summary](#summary)
* [Test procedure](#test-procedure)
* [Outcome(s)](#outcomes)
* [Special procedural requirements](#special-procedural-requirements)
* [Prefix lookup methods](#prefix-lookup-methods)
  * [Cymru prefix lookup](#cymru-prefix-lookup)
  * [RIPE prefix lookup](#ripe-prefix-lookup)
* [Intercase dependencies](#intercase-dependencies)
* [Terminology](#terminology)

## Objective

The objective in this Test Case is to verify that all IP addresses of the
domain's authoritative name servers are not announced from the same IP prefix.

[RFC 2182, section 3.1][RFC 2182#3.1], clearly specifies that distinct authoritative
name servers for a child domain should be placed in different topological and 
geographical locations. The objective is to minimise the likelihood of a single 
failure disabling all of them.

## Scope

It is assumed that *Child Zone* is also tested and reported by [Connectivity01].
This Test Case will just ignore non-responsive name servers or name servers not
giving a correct DNS response for an authoritative name server.

## Inputs

* "Child Zone" - The domain name to be tested.
* "Prefix Database" - The database of IP Prefix data to be used. Possible values
  are "RIPE" and "Cymru" (the default value).
* "Cymru Base Name" - If the *Prefix Database* is "Cymru", the default value 
  is "asnlookup.zonemaster.net".
* "RIS Whois Server" - If the *Prefix Database* is "RIPE", the default value 
  is "riswhois.ripe.net".

## Summary

Message Tag                 | Level   | Arguments                   | Message ID for message tag
:---------------------------|:--------|:----------------------------|:------------------------------------------------------------------------------------------------
CN04_EMPTY_PREFIX_SET       | NOTICE  | ns_ip                       | Prefix database returned no information for IP address {ns_ip}.
CN04_ERROR_PREFIX_DATABASE  | NOTICE  | ns_ip                       | Prefix database error for IP address {ns_ip}.
CN04_IPV4_DIFFERENT_PREFIX  | INFO    | ns_list                     | The following name server(s) are announced in unique IPv4 prefix(es): "{ns_list}"
CN04_IPV4_SAME_PREFIX       | NOTICE  | ns_list, ip_prefix          | The following name server(s) are announced in the same IPv4 prefix ({ip_prefix}): "{ns_list}"
CN04_IPV4_SINGLE_PREFIX     | WARNING |                             | All name server(s) (IPv4) are announced in the same IPv4 prefix.
CN04_IPV6_DIFFERENT_PREFIX  | INFO    | ns_list                     | The following name server(s) are announced in unique IPv6 prefix(es): "{ns_list}"
CN04_IPV6_SAME_PREFIX       | NOTICE  | ns_list, ip_prefix          | The following name server(s) are announced in the same IPv6 prefix ({ip_prefix}): "{ns_list}"
CN04_IPV6_SINGLE_PREFIX     | WARNING |                             | All name server(s) (IPv6) are announced in the same IPv6 prefix.

The value in the Level column is the default severity level of the message. The
severity level can be changed in the [Zonemaster-Engine Profile]. Also see the
[Severity Level Definitions] document.

The argument names in the Arguments column lists the arguments used in the
message. The argument names are defined in the [Argument List].

## Test procedure

1. Create the following empty sets:
   1. IP prefix, name server name and IP address ("IPv4 Prefix")
   2. IP prefix, name server name and IP address ("IPv6 Prefix")

2. Obtain the set of name server names and IP addresses using
   [Get-Del-NS-Names-and-IPs] and [Get-Zone-NS-Names-and-IPs] in [MethodsV2] and
   split those into IPv4 and IPv6 ("NS IPv4" and "NS IPv6", respectively).

3. For each IP address in *NS IPv4* and *NS IPv6* ("NS IP Address"),
   respectively, do:
   1. Determine the IP prefix in which *NS IP Address* is announced
      using *Prefix Database*. Go to [Prefix Lookup Methods] section below
      with the IP address as input.
   2. Add found IP prefix, if any, with *NS IP Address* and name server name
      to the *IPv4 Prefix* and *IPv6 Prefix* sets, respectively.

4. If the *IPv4 Prefix* set is non-empty, then do:
   1. For each IP prefix in the set that has two or more members, output
      *[CN04_IPV4_SAME_PREFIX]* with the prefix and list of all members (name
      server names and IP addresses) for that prefix.
   2. For each IP prefix in the set that have exactly one member, output
      *[CN04_IPV4_DIFFERENT_PREFIX]* with the combined set of their associated
      members (name server names and IP addresses).
   3. If all members of *NS IPv4* are members of the same IP prefix in
      *IPv4 Prefix* then output *[CN04_IPV4_SINGLE_PREFIX]*.

5. If the *IPv6 Prefix* set is non-empty, then do:
   1. For each IP prefix in the set that has two or more members, output
      *[CN04_IPV6_SAME_PREFIX]* with the prefix and list of all members (name
      server names and IP addresses) for that prefix.
   2. For each IP prefix in the set that have exactly one member, output
      *[CN04_IPV6_DIFFERENT_PREFIX]* with the combined set of their associated
      members (name server names and IP addresses).
   3. If all members of *NS IPv6* are members of the same IP prefix in
      *IPv6 Prefix* then output *[CN04_IPV6_SINGLE_PREFIX]*.

## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *[ERROR]* or *[CRITICAL]*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *[WARNING]*, but no message with severity level
*ERROR* or *CRITICAL*.

In other cases, no message or only messages with severity level
*[INFO]* or *[NOTICE]*, the outcome of this Test Case is "pass".

## Special procedural requirements

This Test Case is dependent on one of two possible services that can provide
ASN lookup (Cymru or RIPE RIS). The service must be available over the network.

The *Child Zone* must be a valid name meeting
"[Requirements and normalization of domain names in input]".

## Prefix lookup methods

Use the prefix method set in *Prefix Database* and the IP address in the call to
this section. Refer to the appropriate section below with the IP address as
input.

### Cymru prefix lookup

The Cymru prefix lookup is described on the Team Cymru [IP to ASN Mapping]
using DNS lookup, but the default data comes from [bgp.tools] (Port 179 Ltd
in England and Wales) and is continuously being mapped into
`asnlookup.zonemaster.net` by the Zonemaster project. Data is fetched from
<https://bgp.tools/table.txt>. The Cymru source can also be used, if
requested.

1. Input is the IP address in the call to this section ("Input IP").

2. Prepend the *Cymru Base Name* with the label "origin" (IPv4) or
   "origin6" (IPv6) ("Expanded Base Name"). Example of expanded basenames :
   
```
origin.asnlookup.zonemaster.net
origin6.asnlookup.zonemaster.net
```

3. Reverse *Input IP* with the same method as is used for reverse lookup
   ("Reverse IP"). For description see [RFC 1035][RFC 1035#3.5], section 3.5, for
   IPv4 and [RFC 3596][RFC 3596#2.5], section 2.5, for IPv6.
 
4. Prepend the *Expanded Base Name* with *Reverse IP* ("Query Name").
   See [IP to ASN Mapping] for details.

5. Create a [DNS Query] with query type TXT and query name *Query Name*.
   ("TXT Query").

6. Do [DNS Lookup] of *TXT Query*.

7. If at least one of the following criteria is met, output
   *[CN04_EMPTY_PREFIX_SET]* and exit this lookup:
   1. The [DNS Response] has the [RCODE Name] NXDomain.
   2. The [DNS Response] has the [RCODE Name] NoError and an empty answer section.

8. If at least one of the following criteria is met, output
   *[CN04_ERROR_PREFIX_DATABASE]* and exit this lookup:
   1. There is no DNS response.
   2. The [DNS Response] does not have the [RCODE Name] NoError.
   3. The answer section has no TXT record.

9. Extract the TXT record(s) from the answer section (see [IP to ASN Mapping]
   for examples). Do for each TXT record:
   1. If the TXT record consists of multiple strings in RDATA, then [concatenate]
      the strings into one string.
   2. Using the format of such string parse the string into its parts and
      extract the subnet specification.
      1. If it was not possible to parse the string, output
         *[CN04_ERROR_PREFIX_DATABASE]* and go to next TXT record.
   4. If *Input IP* does not match the subnet output
      *[CN04_ERROR_PREFIX_DATABASE]* and go to next TXT record.
   5. Store the extracted prefix.

10. If more than one IP prefix was stored from the loop above, keep the most
    specific and discard the rest.

11. Return the IP prefix, or an empty string if no IP prefix was extracted.


### RIPE prefix lookup

The RIPE Prefix lookup is described on the RIPE [RISwhois] page.

1. Create a query string by prepending the IP address with 
   " -F -M " ("WHOIS String"). E.g., using IP address "192.0.2.10":
   
   ```
   " -F -M 192.0.2.10" 
   ```

2. Create a WHOIS query (port 43 with the nicname ((whois)) protocol)
   using the *WHOIS String* ("WHOIS Query"). E.g., on Linux:

```
whois -h riswhois.ripe.net " -F -M 192.0.2.10"
```

3. [Send] *WHOIS Query* to the *RIS Whois Server*.

4. If there is no response, output *[CN04_ERROR_PREFIX_DATABASE]* and exit this lookup.

5. Extract the string (non-empty line not prepended with "%") from the response, and do:
   1. If there is no such string, output *[CN04_EMPTY_PREFIX_SET]* and exit this lookup.
   2. Extract the IP prefix from the second field of the string.
   3. If it was not possible to extract the IP prefix (i.e., malformed response),
      output *[CN04_ERROR_PREFIX_DATABASE]* and exit this lookup.

6. Return the IP prefix.

## Intercase dependencies

None

## Terminology

* "Concatenate" - The term is used to refer to the conversion of a TXT
  resource record’s data to a single contiguous string, as specified in [RFC
  7208, section 3.3][RFC7208#3.3].

* "DNS Lookup" - The term is used when a recursive lookup is used, though
  any changes to the DNS tree introduced by an [undelegated test] must be
  respected. Compare with "[Send]".

* "Send" - The term "send" (to an IP address) is used when a DNS query is sent to
  a specific name server IP address. Compare with "[DNS Lookup]".



[Argument List]:                                                ../ArgumentsForTestCaseMessages.md
[Bgp.tools]:                                                    https://bgp.tools/
[CN04_EMPTY_PREFIX_SET]:                                        #outcomes
[CN04_ERROR_PREFIX_DATABASE]:                                   #outcomes
[CN04_IPV4_DIFFERENT_PREFIX]:                                   #outcomes
[CN04_IPV4_SAME_PREFIX]:                                        #outcomes
[CN04_IPV4_SINGLE_PREFIX]:                                      #outcomes
[CN04_IPV6_DIFFERENT_PREFIX]:                                   #outcomes
[CN04_IPV6_SAME_PREFIX]:                                        #outcomes
[CN04_IPV6_SINGLE_PREFIX]:                                      #outcomes
[Concatenate]:                                                  #terminology
[Connectivity01]:                                               connectivity01.md
[CRITICAL]:                                                     ../SeverityLevelDefinitions.md#critical
[Cymru Database]:                                               #cymru-prefix-lookup
[DEBUG]:                                                        ../SeverityLevelDefinitions.md#notice
[DNS Lookup]:                                                   #terminology
[DNS Query and Response Defaults]:                              ../DNSQueryAndResponseDefaults.md
[DNS Query]:                                                    ../DNSQueryAndResponseDefaults.md#default-setting-in-dns-query
[DNS Response]:                                                 ../DNSQueryAndResponseDefaults.md#default-handling-of-a-dns-response
[ERROR]:                                                        ../SeverityLevelDefinitions.md#error
[Get-Del-NS-Names-and-IPs]:                                     ../MethodsV2.md#method-get-delegation-ns-names-and-ip-addresses
[Get-Zone-NS-Names-and-IPs]:                                    ../MethodsV2.md#method-get-zone-ns-names-and-ip-addresses
[INFO]:                                                         ../SeverityLevelDefinitions.md#info
[IP to ASN Mapping]:                                            https://www.team-cymru.com/ip-asn-mapping
[MethodsV2]:                                                    ../MethodsV2.md
[NOTICE]:                                                       ../SeverityLevelDefinitions.md#notice
[Prefix Lookup Methods]:                                        #prefix-lookup-methods
[RCODE Name]:                                                   https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-6
[Requirements and normalization of domain names in input]:      ../RequirementsAndNormalizationOfDomainNames.md
[RFC 1035#3.5]:                                                 https://datatracker.ietf.org/doc/html/rfc1035#section-3.5
[RFC 2182#3.1]:                                                 https://datatracker.ietf.org/doc/html/rfc2182#section-3.1
[RFC 3596#2.5]:                                                 https://datatracker.ietf.org/doc/html/rfc3596#section-2.5
[RFC7208#3.3]:                                                  https://datatracker.ietf.org/doc/html/rfc7208#section-3.3
[RIPE Database]:                                                #ripe-prefix-lookup
[RISwhois]:                                                     https://www.ripe.net/analyse/archived-projects/ris-tools-web-interfaces/riswhois
[Send]:                                                         #terminology
[Severity Level Definitions]:                                   ../SeverityLevelDefinitions.md
[WARNING]:                                                      ../SeverityLevelDefinitions.md#warning
[Zonemaster-Engine Profile]:                                    ../../../configuration/profiles.md
