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

2. Create a SOA query for the apex of the *Child Zone* with rd flag unset.

3. For each name server in *Name Server IP* do:
   1. Send the SOA query over UDP to the name server.
   2. If the name server does not respond, emit *[NO_RESPONSE]* and go
      to next server.
   3. If the name server responds but does not include a SOA record in 
      the response, emit *[NO_RESPONSE_SOA_QUERY]* and go to next server.
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
      name server. If the lookup does not return a DNS response with
      with either RCODE "NOERROR" or "NXDOMAIN" emit 
      *[RNAME_MAIL_DOMAIN_INVALID]*.
   10. If the lookup in previous step returned MX record or records for 
       the mail domain, then replace the mail domain with the mail 
       exchange or exchanges from RDATA of the MX record or records in
       next step.
   11. Create address querie (A and AAAA) for the mail domain or mail
       exchage in previous steps (multiple queries of there are multiple
       mail exchanges). At least one query must successfully return
       an IP address or else emit *[RNAME_MAIL_DOMAIN_INVALID]*.

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




