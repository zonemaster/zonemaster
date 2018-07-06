# DELEGATION03: No truncation of referrals

## Test case identifier

**DELEGATION03**

## Objective

The Domain Name System defaults to using UDP for queries and answers with a
DNS payload limit of 512 bytes. Larger replies cause an initial truncation
indication leading to a subsequent handling via TCP with substantially
higher overhead. EDNS0 is used to allow for larger UDP responses thus
reducing the need for use of TCP.

But [IANA] still maintains that referrals from the parent zone name servers 
must fit into a non-EDNS0 UDP DNS packet.

In this test the referral response for the domain must fit into a 512 
byte UDP packet. The test is executed in two ways. In the first way only
[in-bailiwick] name servers are used as glue (strict definition). In the
second way any name server can be used as glue. The latter is the
test performed for the delegation of top-level domains by [IANA].

## Inputs

* The domain name to be tested ("Child Zone").

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

4. The test case will test packet size twice in two different ways, 
   and the packet created above (without the A and AAAA records) will 
   be used for both tests.

5. Create packet using [in-bailiwick] name server names only for
   glue:

   1. Obtain the name server IP addresses per name server names for
      the delegation using [Method4].

   2. For the [in-bailiwick] name server names for which IPv4 address
      or addresses were obtained, take the shortest name and add the 
      IPv4 address or one of the IPv4 addresses to a complete A record.

   3. For the [in-bailiwick] name server names for which IPv6 address
      or addresses were obtained, take the shortest name and add the 
      IPv6 address or one of the IPv6 addresses to a complete AAAA record.

   4. Add the A record and the AAAA record from the previous two steps, if
      any, to the Additional section of the DNS packet created above 
      using the message compression schema defined in section 4.1.4 of 
      [RFC 1035] where applicable.

   5. If size of the DNS packet after encoding is larger than 512 octets 
      then emit *[REFERRAL_TYPE1_SIZE_LARGE]*.

6. Create packet using [in-bailiwick] or [out-of-bailiwick] name server 
   names for glue:

   1. Obtain the name server IP addresses per name server names for
      the delegation -- both for [in-bailiwick] and [out-of-bailiwick] 
      name server names) -- using [Method4].

   2. For the [in-bailiwick] or [out-of-bailiwick] name server names 
      for which IPv4 address or addresses were obtained, take the 
      shortest name and add the IPv4 address or one of the IPv4 
      addresses to a complete A record.

   3. For the [in-bailiwick] or [out-of-bailiwick] name server names 
      for which IPv6 address or addresses were obtained, take the 
      shortest name and add the IPv6 address or one of the IPv6 
      addresses to a complete AAAA record.

   4. Add the A record and the AAAA record, if any, from the previous 
      two steps to the Additional section of the DNS packet created above 
      using the message compression schema defined in section 4.1.4 of 
      [RFC 1035] where applicable.

   5. If size of the DNS packet after encoding is larger than 512 octets 
      then emit *[REFERRAL_TYPE2_SIZE_LARGE]*.

7. If if neither *[REFERRAL_TYPE1_SIZE_LARGE]* nor 
   *[REFERRAL_TYPE2_SIZE_LARGE]* was emitted, emit 
   *[REFERRAL_SIZE_OK]*.

8. If *[REFERRAL_TYPE1_SIZE_LARGE]* was not emitted, then emit 
   *[REFERRAL_TYPE1_SIZE_OK]*.

8. If *[REFERRAL_TYPE2_SIZE_LARGE]* was not emitted, then emit 
   *[REFERRAL_TYPE2_SIZE_OK]*.



## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

In other cases the outcome of this Test Case is "pass".

Message                           | Default severity level (if message is emitted)
:---------------------------------|:-----------------------------------
REFERRAL_TYPE1_SIZE_LARGE         | WARNING
REFERRAL_TYPE2_SIZE_LARGE         | WARNING
REFERRAL_TYPE1_SIZE_OK            | DEBUG
REFERRAL_TYPE2_SIZE_OK            | DEBUG
REFERRAL_SIZE_OK                  | INFO


## Special procedural requirements

None

## Intercase dependencies

None

## Terminology

The terms "in-bailiwick" and "out-of-bailiwick" are used as defined
in [RFC 7719], section 6, page 15.


[RFC 7719]: https://tools.ietf.org/html/rfc7719

[RFC 1035]: https://tools.ietf.org/html/rfc1035

[IANA]: https://www.iana.org/help/nameserver-requirements

[in-bailiwick]:     #terminology

[out-of-bailiwick]: #terminology

[Method2]: #method-2-delegation-name-servers

[Method4]: #method-4-delegation-name-server-addresses

[REFERRAL_TYPE1_SIZE_LARGE]: #outcomes

[REFERRAL_TYPE2_SIZE_LARGE]: #outcomes

[REFERRAL_SIZE_OK]: #outcomes


