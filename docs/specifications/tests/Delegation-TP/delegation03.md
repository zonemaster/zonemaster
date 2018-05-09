# DELEGATION03: No truncation of referrals

## Test case identifier

**DELEGATION03:**

## Objective

The Domain Name System defaults to using UDP for queries and answers with a
DNS payload limit of 512 bytes. Larger replies cause an initial truncation
indication leading to a subsequent handling via TCP with substantially
higher overhead. EDNS0 is used to allow for larger UDP responses thus
reducing the need for use of TCP.

But [IANA] still
maintains that referrals from the parent zone name servers must fit into
a non-EDNS0 UDP DNS packet.

In this test, the authoritative and additional section of the referral
response from the domain must fit into a 512 byte UDP packet.

## Inputs

* The domain name to be tested ("Child Zone").

## Ordered description of steps to be taken to execute the test case

1. Create a DNS packet holding a query for a maximally long subdomain
   under the *Child Zone* apex (that is, 255 octets including label 
   separators).

2. Obtain the name server names from the delegation from the parent 
   using [Method2].

3. Add all unique NS records for the *Child Zone* using the name server
   names fetched.

4. Obtains the name server IP addresses per name server names from 
   the delegation from the parent using [Method4]. Discard any
   [out-of-bailiwick] name servers.

5. For each [in-bailiwick] name server name and for all IP addresses 
   for the name, add the name server as A or AAAA record in the
   Additional section of the DNS packet.

6. If size the DNS packet after encoding is larger than 512 octets 
   then emit *[REFERRAL_SIZE_LARGE]*, otherwise emit 
   *[REFERRAL_SIZE_OK]*.

## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

In other cases the outcome of this Test Case is "pass".

Message                           | Default severity level (if message is emitted)
:---------------------------------|:-----------------------------------
REFERRAL_SIZE_LARGE               | WARNING
REFERRAL_SIZE_OK                  | INFO


## Special procedural requirements

None

## Intercase dependencies

None

## Terminology

The terms "in-bailiwick" and "out-of-bailiwick" are used as defined
in [RFC 7719], section 6, page 15.


[RFC 7719]: https://tools.ietf.org/html/rfc7719

[IANA]: https://www.iana.org/help/nameserver-requirements

[in-bailiwick]:     #terminology

[out-of-bailiwick]: #terminology

[Method2]: #method-2-delegation-name-servers

[Method4]: #method-4-delegation-name-server-addresses

[REFERRAL_SIZE_LARGE]: #outcomes

[REFERRAL_SIZE_OK]: #outcomes


