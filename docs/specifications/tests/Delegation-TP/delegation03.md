# DELEGATION03: No truncation of referrals

## Test case identifier

**DELEGATION03**

## Objective

The Domain Name System defaults to using UDP for queries and answers with a
DNS payload limit of 512 octets (bytes). Larger replies cause an initial 
truncation indication leading to a subsequent handling via TCP with 
substantially higher overhead. EDNS0 is used to allow for larger UDP 
responses thus reducing the need for use of TCP.

But [IANA] still maintains that referrals from the parent zone name servers 
must fit into a non-EDNS0 UDP DNS packet.

## Inputs

* "Child Zone" - The domain name to be tested.

## Ordered description of steps to be taken to execute the test case

1. Create a DNS packet with a maximally long subdomain
   under the *Child Zone* apex (that is, 255 octets including label 
   separators) in the Query section.

2. Obtain the set of name server names from the delegation of 
   the *Child Zone* from the parent using [Method2].

3. For each name server names obtained in the previous step:
   1. Create an NS record with the *Child Zone* apex as owner name
      and the name server name as RDATA.
   2. Add the NS record to the Authority section of the DNS packet
      created above using the message compression schema defined
      in section 4.1.4 of [RFC 1035] where applicable.

4. Using [Method1], get the parent zone of *Child Zone*.

5. Obtain the name server IP addresses per name server names for
   the delegation using [Method4].

6. Make a set of the name server names that resolve into at least one
   IPv4 address ("IPv4 Name Server Set").

7. If the *IPv4 Name Server Set* is not empty and all name server 
   names in it are [In-Bailiwick of Parent] then:
   1. Create an A record using one of the name server names and any 
      IPv4 address.
   2. Add the A record to the Additional section of the DNS packet 
      created above using the message compression schema defined in 
      section 4.1.4 of [RFC 1035].

8. Make a set of the name server names that resolve into at least one
   IPv6 address ("IPv6 Name Server Set").

9. If the *IPv6 Name Server Set* is not empty and all name server 
   names in it are [In-Bailiwick of Parent] then:
   1. Create a AAAA record using one of the name server names and any 
      IPv6 address.
   2. Add the AAAA record to the Additional section of the DNS packet 
      created above using the message compression schema defined in 
      section 4.1.4 of [RFC 1035].

10. If size of the DNS packet after encoding is larger than 512 octets 
    then output *[REFERRAL_SIZE_TOO_LARGE]* else output 
    *[REFERRAL_SIZE_OK]*.


## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

In other cases the outcome of this Test Case is "pass".

Message                           | Default severity level of message
:---------------------------------|:-----------------------------------
REFERRAL_SIZE_TOO_LARGE           | WARNING
REFERRAL_SIZE_OK                  | INFO


## Special procedural requirements

None

## Intercase dependencies

None

## Terminology

The terms "in-bailiwick" and "out-of-bailiwick" are used as defined
in [RFC 7719], section 6, page 15.

## In-Bailiwick of Parent

A name server name is *In-Bailiwick of Parent* if the name is a or 
below the zone cut of the parent zone. If "example.com" is the parent 
zone of "foofoo.example.com" then name server "ns1.barbar.example.com" 
is *In-Bailiwick of Parent* for "foofoo.example.com".

All name servers of a TLD are *In-Bailiwick of Parent* since all
names are below the root apex '.'.



[RFC 7719]: https://tools.ietf.org/html/rfc7719

[RFC 1035]: https://tools.ietf.org/html/rfc1035

[IANA]: https://www.iana.org/help/nameserver-requirements

[in-bailiwick]:     #terminology

[In-Bailiwick of Parent]: #in-bailiwick-of-parent


[Method1]: ../Methods.md#method-1-obtain-the-parent-domain


[Method2]: ../Methods.md#method-2-obtain-glue-name-records-from-parent


[Method4]: ../Methods.md#method-4-obtain-glue-address-records-from-parent



[REFERRAL_SIZE_TOO_LARGE]: #outcomes

[REFERRAL_SIZE_OK]: #outcomes


