# SYNTAX06: No illegal characters in the SOA RNAME field

## Test case identifier
**SYNTAX06**

## Objective

The SOA RNAME field is a mailbox address. The SOA RNAME field is defined
in [RFC 1035][RFC 1035#3.3.13], section 3.3.13 and in
[RFC 1912][RFC 1912#2.2], section 2.2. The RNAME
field should follow the rules of an e-mail address also defined in
[RFC 5322][RFC 5322#3.4.1], section 3.4.1.

## Scope

It is assumed that *Child Zone* is also tested by [Connectivity01]. This test
case will set DEBUG level on messages for non-responsive name servers.

## Inputs

* "Child Zone" - The domain name to be tested.

## Ordered description of steps to be taken to execute the test case

1. Obtain the set of name server IP addresses using [Method4] and [Method5]
   ("NS IP").

2. Create a SOA query for the apex of the *Child Zone* with RD flag unset.

3. For each name server IP in *NS IP* do:
   1. Send the SOA query over UDP to the name server IP.
   2. If the name server does not respond with a DNS response, then:
      1. Output *[NO_RESPONSE]*.
      2. Go to next name server IP.
   3. If the DNS response does not include an SOA record in the
      answer section, then:
      1. Output *[NO_RESPONSE_SOA_QUERY]*.
      2. Go to next name server IP.
   4. Extract the RNAME from the SOA record (from the first SOA record if
      multiple) and convert it to an email address ("Email Address" below)
      using the following steps:
      1. Convert the first "." without backslash quoting to an "@" in
         the RNAME.
      2. Convert any backslash quoted "." to a single "." without quoting
         (see [RFC 1035], section [5.1][RFC 1035#5.1], [5.3][RFC 1035#5.3] and
         [8][RFC 1035#8] for the use of backslash).
   7. If *Email Address* does not meet the
      mail address specification in [RFC 5322][RFC 5322#3.4.1],
      section 3.4.1, then
      1. Output *[RNAME_RFC822_INVALID]*.
      2. Go to next name server IP.
   8. Extract the domain part (to the right of "@") from the *Mail
      address* ("Domain Part" below).
   9. Create an MX query for the *Domain Part* and do a
      [DNS Lookup][terminology] of that query.
   10. If the lookup of MX does not return a DNS response with RCODE
       "NOERROR", then:
       1. Output *[RNAME_MAIL_DOMAIN_INVALID]*.
       2. Go to next name server IP.
   11. When doing the MX lookup, CNAME or a chain of CNAMEs are followed, if
       any. If an MX record or records are found via CNAME, then
       set *Domain Part* to be equal to the owner name of that MX record
       (instead of being equal to the domain part of *Email Address*).
   12. If the MX lookup returned a NO DATA response (no MX record),
       then:
       1. Create address queries (A and AAAA) for the *Domain Part* and
          do:
          1. Do [DNS Lookups][terminology] of those queries.
          2. If the answer section contains a CNAME record output
             *[RNAME_MAIL_ILLEGAL_CNAME]*.
          3. Else, extract any A and AAAA records from the answer
             sections of the DNS responses with *Domain Part* as owner
             name.
       2. If any A or AAAA record points at 127.0.0.1 or ::1 (localhost),
          respectively, then output *[RNAME_MAIL_DOMAIN_LOCALHOST]*.
       3. If no A or AAAA are extracted or any records points at
          127.0.0.1 or ::1, then output *[RNAME_MAIL_DOMAIN_INVALID]*.
   13. If the MX lookup returns one or more MX records, then for each
       MX record extract the domain name in RDATA ("Mail Exchange")
       and do:
       1. Create address queries (A and AAAA) of *Mail Exchange* and do:
          1. Do [DNS Lookups][terminology] of those queries.
          2. If the answer section contains a CNAME record output
             *[RNAME_MAIL_ILLEGAL_CNAME]*.
          3. Else, extract any A and AAAA records from the answer
             sections of the DNS responses with *Mail Exchange* as owner
             name.
       2. If any A or AAAA record points at 127.0.0.1 or ::1 (localhost),
          respectively, then output *[RNAME_MAIL_DOMAIN_LOCALHOST]*.
       3. If no A or AAAA are are extracted or any records points at
          127.0.0.1 or ::1, then output *[RNAME_MAIL_DOMAIN_INVALID]*.

4. If at least one name server IP has neither outputted *[NO_RESPONSE]*
   nor *[NO_RESPONSE_SOA_QUERY]* and *[RNAME_MAIL_DOMAIN_INVALID]* has not
   been outputted for any name server IP, then output *[RNAME_RFC822_VALID]*.


## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

In other cases the outcome of this Test Case is "pass".

Message                       | Default severity level
:-----------------------------|:-----------------------------------
NO_RESPONSE                   | DEBUG
NO_RESPONSE_SOA_QUERY         | DEBUG
RNAME_RFC822_INVALID          | WARNING
RNAME_MAIL_DOMAIN_INVALID     | WARNING
RNAME_MAIL_DOMAIN_LOCALHOST   | WARNING
RNAME_MAIL_ILLEGAL_CNAME      | WARNING
RNAME_RFC822_VALID            | INFO



## Special procedural requirements

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
on the ignored result.

## Intercase dependencies

None.

## Terminology

* "Using Method" - When the term is used, names and IP addresses are fetched
using the defined [Methods].

* "Send" (to an IP address) - The term is used when a DNS query is sent to
a specific name server.

* "DNS Lookup" - The term is used when a recursive lookup is used, though
any changes to the DNS tree introduced by an [undelegated test] must be
respected.

[Connectivity01]:             ../Connectivity-TP/connectivity01.md
[Method4]:                    ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                    ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[Methods]:                    ../Methods.md
[NO_RESPONSE]:                #outcomes
[NO_RESPONSE_SOA_QUERY]:      #outcomes
[RFC 1035#3.3.13]:            https://datatracker.ietf.org/doc/html/rfc1035#section-3.3.13
[RFC 1035#5.1]:               https://datatracker.ietf.org/doc/html/rfc1035#section-5.1
[RFC 1035#5.3]:               https://datatracker.ietf.org/doc/html/rfc1035#section-5.3
[RFC 1035#8]:                 https://datatracker.ietf.org/doc/html/rfc1035#section-8
[RFC 1035]:                   https://datatracker.ietf.org/doc/html/rfc1035
[RFC 1912#2.2]:               https://datatracker.ietf.org/doc/html/rfc1912#section-2.2
[RFC 5322#3.4.1]:             https://datatracker.ietf.org/doc/html/rfc5322#section-3.4.1
[RNAME_MAIL_DOMAIN_INVALID]:  #outcomes
[RNAME_MAIL_DOMAIN_LOCALHOST]:#outcomes
[RNAME_MAIL_ILLEGAL_CNAME]:   #outcomes
[RNAME_RFC822_INVALID]:       #outcomes
[RNAME_RFC822_VALID]:         #outcomes
[terminology]:                #terminology
[undelegated test]:           ../../test-types/undelegated-test.md

