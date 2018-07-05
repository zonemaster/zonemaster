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

2. Create a SOA query for the apex of the *Child Zone* with "rd" flag unset.

3. For each name server in *Name Server IP* do:
   1. Send the SOA query over UDP to the name server.
   2. If the name server does not respond with a DNS response, then:
      1. Emit *[NO_RESPONSE]*.
      2. Go to next server.
   3. If the DNS response does not include a SOA record in the 
      answer section, then:
      1. Emit *[NO_RESPONSE_SOA_QUERY]*.
      2. Go to next server.
   4. Extract the RNAME from the SOA record.
   5. Convert the first "." without backslash quoting to an "@" in 
      the RNAME.
   6. Convert any backslash quoted "." to a single "." without quoting
      (see section 5.1, 5.3 and 8 in [RFC1035] for the use of backslash).
   7. If the converted string (mail address) does not meet the 
      specification in [RFC 5322, section 3.4.1], then emit 
      *[RNAME_RFC822_INVALID]* and go to next server.
   8. Extract the domain part (to the right of "@") from the mail 
      address.
   9. Create an MX query for the domain part and send it to a resolving
       name server. 
   10. If the MX lookup does not return a DNS response with with RCODE 
       "NOERROR" emit *[RNAME_MAIL_DOMAIN_INVALID]*.
   11. If the MX lookup returned a CNAME or a chain of CNAMEs then
       use the final name instead of the domain part in the steps below.
   12. If the MX lookup returned no MX record, then 
       1. Create address queries (A and AAAA) for the domain part and
          send it to a resolving name server.
       2. If the domain part is "localhost" then consider all A and
          AAAA lookups as failing.
       3. Disregard any A record with 127.0.0.1 or AAAA with ::1.
       4. Disregard any A or AAAA records outside the Answer section.
       5. If no A or AAAA was returned then emit 
          *[RNAME_MAIL_DOMAIN_INVALID]*.
   13. If the MX lookup returned one or more MX records, then for each
       mail exchange (domain name in RDATA of the MX record) do:
       1. Create address queries (A and AAAA) and send it to a 
          resolving name server.
       2. If the mail exchange name is "localhost" then consider all 
          A and AAAA lookups as failing.
       3. Disregard all A and AAAA records that do not have the same
          owner name as the mail exchange name (i.e. do not follow
          any CNAME).
       4. Disregard any A record with 127.0.0.1 or AAAA with ::1.
       5. Disregard any A or AAAA records outside the Answer section.
       6. If all MX have been processed and neither A or AAAA record 
          was returned for any mail exchange then emit 
          *[RNAME_MAIL_DOMAIN_INVALID]*.

4. If at least one RNAME has been fully validated and no 
   *[RNAME_RFC822_INVALID]* or *[RNAME_MAIL_DOMAIN_INVALID]*
   has not been emitted, then emit *[RNAME_RFC822_VALID]*.


## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

In other cases the outcome of this Test Case is "pass".

Message                       | Default severity level (if message is emitted)
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


[Method4]: ../Methods.md#method-4-obtain-glue-address-records-from-parent

[Method5]: ../Methods.md#method-5-obtain-the-name-server-address-records-from-child

[RFC 1035]: https://tools.ietf.org/html/rfc1035

[RFC 1912]: https://tools.ietf.org/html/rfc1912

[RFC 5322, section 3.4.1]: https://tools.ietf.org/html/rfc5322#section-3.4

[NO_RESPONSE]: #outcomes

[NO_RESPONSE_SOA_QUERY]: #outcomes

[RNAME_RFC822_INVALID]: #outcomes

[RNAME_MAIL_DOMAIN_INVALID]: #outcomes

[RNAME_RFC822_VALID]: #outcomes




