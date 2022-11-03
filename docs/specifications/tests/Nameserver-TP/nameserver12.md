# NAMESERVER12: Test for unknown EDNS flags

## Test case identifier
**NAMESERVER12** 

## Objective

EDNS is a mechanism to announce capabilities of a dns implementation,
and is now basically required by any new functionality in dns such as
DNSSEC ([RFC 6891]).

[RFC 6891][RCF 6891#section-6.1.4], section 6.1.4, states that "Z"
flag bits must be set to zero by senders and ignored by receiver.

[IANA] lists the flags in the [EDNS Header Flags] assignment list.

In this test case, the query will have an unknown EDNS flag set, i.e.
one of the Z flag bits set to "1", and it is expected that all "Z" 
bits to be clear in the response (set to "0").

## Scope

It is assumed that *Child Zone* is also tested by [Connectivity01]. This test
case will set DEBUG level on messages for non-responsive name servers.

## Inputs

"Child Zone" - The domain name to be tested.

## Ordered description of steps to be taken to execute the test case

1. Create a SOA query for the *Child Zone* with an OPT record with 
   one of the EDNS flag "Z" bits set to "1" and no other EDNS options or 
   flags set.

2. Obtain the set of name server IP addresses using [Method4] and [Method5]
   ("Name Server IP").

3. For each name server in *Name Server IP* do:
   1. Send the SOA query to the name server and collect the response.
   2. If there is no DNS response, output *[NO_RESPONSE]* and go to
      next server.
   3. Else, if the DNS response has the RCODE "FORMERR" then output
      *[NO_EDNS_SUPPORT]*.
   4. Else, if the pseudo-section has an OPT record with one or more Z 
      flag bits being set to "1", then output [Z_FLAGS_NOTCLEAR]. 
   5. Else, if the DNS response meet the following four criteria,
      then just go to the next name server (no error):
      1. The SOA is obtained as response in the ANSWER section.
      2. If the DNS response has the RCODE "NOERROR".
      3. The pseudo-section response has an OPT record with version set to 0.
      4. The "Z" bits are clear in the response
   6. Else output *[NS_ERROR]*.
 
## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

The outcome of this Test case is "pass" in all other cases.

Message                           | Default severity level
:---------------------------------|:----------------------------
NO_RESPONSE                       | DEBUG
NO_EDNS_SUPPORT                   | WARNING
NS_ERROR                          | WARNING     
Z_FLAGS_NOTCLEAR                  | WARNING

## Special procedural requirements

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol and log a message reporting
the ignored result.

## Intercase dependencies

None.


[Connectivity01]:               ../Connectivity-TP/connectivity01.md
[EDNS Header Flags]:            https://www.iana.org/assignments/dns-parameters/dns-parameters.xhtml#dns-parameters-13
[IANA]:                         https://www.iana.org/
[Method4]:                      ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                      ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[NO_EDNS_SUPPORT]:              #outcomes
[NO_RESPONSE]:                  #outcomes
[NS_ERROR]:                     #outcomes
[RCF 6891#section-6.1.4]:       https://tools.ietf.org/html/rfc6891#section-6.1.4
[RFC 6891]:                     https://tools.ietf.org/html/rfc6891
[Z_FLAGS_NOTCLEAR]:             #outcomes

