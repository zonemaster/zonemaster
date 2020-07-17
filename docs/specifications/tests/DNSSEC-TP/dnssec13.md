# DNSSEC13: All DNSKEY algorithms used to sign the zone

## Test case identifier
**DNSSEC13**

## Objective

From [RFC 6840][RFC 6840#section-5.11], section 5.11:

> The DS RRset and DNSKEY RRset are used to signal which
> algorithms are used to sign a zone. [...] The zone MUST
> also be signed with each algorithm (though not each key)
> present in the DNSKEY RRset. [...]

To verify the complete zone is signed with all algorithms require
access to the complete zone. This test case is limited to three
RRsets that must be present in a signed zone, the SOA RRset, the
NS RRset and the DNSKEY RRset.

This test case will verify that for each DNSKEY algorithm, there
is a RRSIG of that algorithm for the three selected RRsets.
Furtermore, it is verified that the RRSIG of those RRsets have
been created by a DNSKEY from the zone's DNSKEY RRset.

## Scope

It is assumed that *Child Zone* has been tested by [Basic04]. This test
case will set DEBUG level on messages for non-responsive name servers.

## Inputs

* "Child Zone" - The domain name to be tested.

## Ordered description of steps to be taken to execute the test case

1. Create a DNSKEY query with DO flag set for the apex of the
   *Child Zone*.

2. Create a SOA query with DO flag set for the apex of the
   *Child Zone*.

3. Create a NS query with DO flag set for the apex of the
   *Child Zone*.

4. Retrieve all name server IP addresses for the
   *Child Zone* using [Method4] and [Method5] ("NS IP").

5. Create an empty set of DNSKEY key tag and algorithm number,
   "Unsupported Algorithm".

6. Repeat the following steps for each name server IP address in *NS IP*:

   1. Send the DNSKEY query over UDP.
      1. If no DNS response is returned, then go to next name
         server IP address.
      2. Else, if the DNS response contains no DNSKEY record in the
         answer section, then go to the next name server IP address.
      3. Else, do:
         1. Extract all DNSKEY records ("DNSKEY Records").
         2. Extract the algorithm numbers from each DNSKEY record
            ("DNSKEY Algorithms").
         3. Calculate the key ID for each DNSKEY record
            ("DNSKEY Key ID").
         4. Extract all RRSIG records from the response.
         5. If there is no RRSIG for DNSKEY, then output
            *[RRSET_NOT_SIGNED]* and go to next name server IP
            address.
         6. For each algorithm in *DNSKEY Algorithm* do:
            1. If there is no RRSIG for the DNSKEY RRset created by
               the algorithm then output *[ALGO_NOT_SIGNED_RRSET]*.
         7. For each RRSIG do:
            1. If the key ID from the RRSIG is not a member of the
               set *DNSKEY Key ID*, then output
               *[RRSIG_NOT_MATCH_DNSKEY]* and go to next RRSIG.
            2. If the Zonemaster installation does not have support for
               the algorithm that created the RRSIG, then add the
               DNSKEY key tag and algorithm to the
               *Unsupported Algorithm* set.
            3. If the RRSIG cannot be verified by the DNSKEY from
               *DNSKEY Record* with the matching RRSIG key ID, then
               output *[RRSIG_BROKEN]*.
   2. Send the SOA query over UDP.
      1. If no DNS response is returned go to the next name server
         IP address.
      2. Else, if the DNS response contains no SOA record in the
         answer section, then go to the next name server IP address.
      3. Else, do:
         1. Extract all RRSIG records from the response.
         2. If there is no RRSIG for SOA, then output
            *[RRSET_NOT_SIGNED]* and go to next name server IP
            address.
         3. For each algorithm in *DNSKEY Algorithm* do:
            1. If there is no RRSIG for the SOA RRset created by
               the algorithm then output *[ALGO_NOT_SIGNED_RRSET]*.
         4. For each RRSIG do:
            1. If the key ID from the RRSIG is not a member of the
               set *DNSKEY Key ID*, then output
               *[RRSIG_NOT_MATCH_DNSKEY]* and go to next RRSIG.
            2. If the Zonemaster installation does not have support for
               the algorithm that created the RRSIG, then add the
               DNSKEY key tag and algorithm to the
               *Unsupported Algorithm* set.
            3. If the RRSIG cannot be verified by the DNSKEY from
               *DNSKEY Record* with the matching RRSIG key ID, then
               output *[RRSIG_BROKEN]*.
   3. Send the NS query over UDP.
      1. If no DNS response is returned, then go to next name server
         IP address.
      2. Else, if the DNS response contains no NS record in the
         answer section, then go to next name server IP address.
      3. Else, do:
         1. Extract all RRSIG records from the response.
         2. If there is no RRSIG for NS, then output
            *[RRSET_NOT_SIGNED]* and go to next name server IP
            address.
         3. For each algorithm in *DNSKEY Algorithm* do:
            1. If there is no RRSIG for the NS RRset created by
               the algorithm then output *[ALGO_NOT_SIGNED_RRSET]*.
         4. For each RRSIG do:
            1. If the key ID from the RRSIG is not a member of the
               set *DNSKEY Key ID*, then output
               *[RRSIG_NOT_MATCH_DNSKEY]* and go to next RRSIG.
            2. If the Zonemaster installation does not have support for
               the algorithm that created the RRSIG, then add the
               DNSKEY key tag and algorithm to the
               *Unsupported Algorithm* set.
            3. If the RRSIG cannot be verified by the DNSKEY from
               *DNSKEY Record* with the matching RRSIG key ID, then
               output *[RRSIG_BROKEN]*.

7. If the *Unsupported Algorithm* set is non-empty, then for each
   DNSKEY key tag output *[DS13_ALGO_NOT_SUPPORTED_BY_ZM]* and print
   algorithm and DNSKEY key tag.

## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the [severity level] *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the [severity level] *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

In other cases the outcome of this Test Case is "pass".

Message                       | Default [severity level]
:-----------------------------|:-----------------------------------
ALGO_NOT_SIGNED_RRSET         | WARNING


ALL_ALGO_SIGNED               | INFO
NO_RESPONSE                   | DEBUG
NO_RESPONSE_RRSET             | ERROR

DS13_ALGO_NOT_SUPPORTED_BY_ZM | NOTICE

RRSET_NOT_SIGNED              | ERROR
RRSIG_BROKEN                  | ERROR
RRSIG_NOT_MATCH_DNSKEY        | ERROR


## Special procedural requirements

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
on the ignored result.

See the [DNSSEC README] document about DNSSEC algorithms.

Test case is only performed if DNSKEY records are found.

It is assumed that [DNSSEC08] and [DNSSEC09] have reported on any
unexpected errors on retreiving the DNSKEY records and SOA record,
respectively, from *Child Zone*.

It is assumed that there are no unexpected errors on retreiving the
NS records from *Child Zone* that have not been reported by
[Basic04], [DNSSEC08] and [DNSSEC08].

## Intercase dependencies

None.


[6840]:    https://tools.ietf.org/html/rfc6840#section-5.11
[Method4]: ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]: ../Methods.md#method-5-obtain-the-name-server-address-records-from-child

[ALGO_NOT_SIGNED_RRSET]:      #outcomes
[ALL_ALGO_SIGNED]:            #outcomes
[Basic04]:                    ../Basic-TP/basic04.md
[DNSSEC README]:              ./README.md
[NO_RESPONSE]:                #outcomes
[NO_RESPONSE_RRSET]:          #outcomes
[RRSET_NOT_SIGNED]:           #outcomes
[RRSIG_BROKEN]:               #outcomes
[RRSIG_NOT_MATCH_DNSKEY]:     #outcomes

[ALGO_NOT_SIGNED_RRSET]:                      #outcomes
[Basic04]:                                    ../Basic-TP/basic014.md
[DNSSEC README]:                              README.md
[DNSSEC08]:                                   dnssec08.md
[DNSSEC09]:                                   dnssec09.md
[DS13_ALGO_NOT_SUPPORTED_BY_ZM]:              #outcomes
[Method4]:                                    ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                                    ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[RFC 6840#section-5.11]:                      https://tools.ietf.org/html/rfc6840#section-5.11
[RRSET_NOT_SIGNED]:                           #outcomes
[RRSIG_BROKEN]:                               #outcomes
[RRSIG_NOT_MATCH_DNSKEY]:                     #outcomes
[Severity Level]:                             ../SeverityLevelDefinitions.md


