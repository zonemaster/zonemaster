# SYNTAX06: No illegal characters in the SOA RNAME field

## Test case identifier
**SYNTAX06**

## Objective

The SOA RNAME field is a mailbox address. The SOA RNAME field is defined
in section 3.3.13 of [RFC 1035] and section 2.2 of [RFC 1912]. The RNAME
field should follow the rules of an e-mail address also defined in 
[RFC 5322, section 3.4.1].

## Inputs

* "Child Zone" - The domain name to be tested.

## Ordered description of steps to be taken to execute the test case

1. Obtain the set of name server IP addresses using [Method4] and [Method5]
   ("Name Server IP").

2. Create a SOA query for the apex of the *Child Zone* with RD flag unset.

3. For each name server in *Name Server IP* do:
   1. Send the SOA query over UDP to the name server.
   2. If the name server does not respond with a DNS response, then:
      1. Output *[NO_RESPONSE]*.
      2. Go to next server.
   3. If the DNS response does not include a SOA record in the 
      answer section, then:
      1. Output *[NO_RESPONSE_SOA_QUERY]*.
      2. Go to next server.
   4. Extract the RNAME from the SOA record.
   5. Convert the first "." without backslash quoting to an "@" in 
      the RNAME.
   6. Convert any backslash quoted "." to a single "." without quoting
      (see section 5.1, 5.3 and 8 in [RFC1035] for the use of backslash).
   7. If the converted string ("Mail address") does not meet the 
      mail address specification in [RFC 5322, section 3.4.1], then 
      1. Output *[RNAME_RFC822_INVALID]*.
      2. Go to next server.
   8. Extract the domain part (to the right of "@") from the *Mail 
      address* ("Domain Part").
   9. Create an MX query for the *Domain Part* and do a [DNS Lookup]
      of that query. 
   10. If the lookup of MX does not return a DNS response with RCODE 
       "NOERROR", then:
       1. Output *[RNAME_MAIL_DOMAIN_INVALID]*.
       2. Go to next server.
   11. If the MX lookup returned a CNAME or a chain of CNAMEs then
       set *Domain Part* to be the the final name instead of the
       domain from the email address.
   12. If the MX lookup returned a NO DATA response (no MX record), 
       then:
       1. Create address queries (A and AAAA) for the *Domain Part*
          and do [DNS Lookups][DNS Lookup] of those queries. 
       2. Disregard any A record with 127.0.0.1 or AAAA with ::1.
       3. If no A or AAAA records with the same owner name as *Domain
          Part* were found in the responses 
          then output *[RNAME_MAIL_DOMAIN_INVALID]*.
   13. If the MX lookup returned one or more MX records, then for each 
       domain name in RDATA of the MX record ("Mail Exchange") do:
       1. Create address queries (A and AAAA) and do 
          [DNS Lookups][DNS Lookup] of those queries. 
       2. Disregard all A and AAAA records that do not have the same
          owner name as *Mail Exchange* (i.e. do not follow
          any CNAME).
       3. Disregard all A and AAAA records outside the answer section.
       4. Disregard any A record with 127.0.0.1 or AAAA with ::1.
       5. If all MX have been processed and neither A or AAAA record 
          was returned for any mail exchange, then output 
          *[RNAME_MAIL_DOMAIN_INVALID]*.
   14. If no *[RNAME_MAIL_DOMAIN_INVALID]* has been outputted, 
       then output *[RNAME_RFC822_VALID]* for that RNAME.


## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

In other cases the outcome of this Test Case is "pass".

Message                       | Default severity level of message
:-----------------------------|:-----------------------------------
NO_RESPONSE                   | WARNING
NO_RESPONSE_SOA_QUERY         | DEBUG
RNAME_RFC822_INVALID          | WARNING
RNAME_MAIL_DOMAIN_INVALID     | NOTICE
RNAME_RFC822_VALID            | INFO


## Special procedural requirements

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
on the ignored result.

## Intercase dependencies

None.

## Terminology

When the term "using Method" is used, names and IP addresses are fetched
using the defined [Methods].

The term "send" (to an IP address) is used when a DNS query is sent to
a specific name server.

The term "DNS Lookup" is used when a recursive lookup is used, though
any changes to the DNS tree introduced by an [undelegated test] must be
respected.


[Methods]:                 ../Methods.md
[Method4]:                 ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                 ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[RFC 1035]:                https://tools.ietf.org/html/rfc1035
[RFC 1912]:                https://tools.ietf.org/html/rfc1912
[RFC 5322, section 3.4.1]: https://tools.ietf.org/html/rfc5322#section-3.4

[NO_RESPONSE]:               #outcomes
[NO_RESPONSE_SOA_QUERY]:     #outcomes
[RNAME_MAIL_DOMAIN_INVALID]: #outcomes
[RNAME_RFC822_INVALID]:      #outcomes
[RNAME_RFC822_VALID]:        #outcomes



