# DELEGATION05: Name server must not point at CNAME alias

## Test case identifier

**DELEGATION05**

## Objective

Name servers for a zone are defined in NS records. An NS record points
at a name, i.e. the RDATA for an NS record is a domain name. That
name is the name of the name server. [RFC 2181][RFC 2181#10.3], section
10.3, states that the name of the name server must not itself point at
a CNAME.

The objective of this test is to verify that name servers of the tested
domain (zone) do not point at CNAME records.

## Inputs

"Child Zone" - The domain name to be tested.

## Ordered description of steps to be taken to execute the test case

1. Obtain the set of name server names using [Method2] and [Method3]
   ("NS Name").

2. Obtain the set of name server IP addresses using [Method4] and
   [Method5] ("NS IP").

3. For each name server name in *NS Name* do:

   1. Create a query for A record (A query) with the name server
      name as owner name.

   2. If the name server name is [in-domain] (sub-type of
      [in-bailiwick]) then for each name server IP in
      *NS IP* do:
      1. Send the A query to the name server IP with the RD flag unset.
      2. If the name server does not respond with a DNS response, then
         output *[NO_RESPONSE]*.
      3. Else, if the RCODE is not NOERROR, then output
         *[UNEXPECTED_RCODE]*.
      4. Else, if the answer section of the response includes a CNAME
         record then output *[NS_IS_CNAME]*.
      5. Else, if the response is a delegation (referral) to a
         sub-zone of *Child Zone*, then:
         1. Do a [DNS Lookup] of the A query with the RD
            flag set.
         2. If the answer section of the response includes a CNAME
            record then output *[NS_IS_CNAME]*.

   3. Else (the name server name is either [sibling domain]
      or [out-of-bailiwick]) then do:
      1. Do a [DNS Lookup] of the the A query with the RD
         flag set.
      2. If the answer section of the response includes a CNAME
         record then output *[NS_IS_CNAME]*.

4. If no *[NS_IS_CNAME]* was outputted, then output *[NO_NS_CNAME]*.

## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

In other cases the outcome of this Test Case is "pass".

Message               | Default severity level
:---------------------|:-----------------------------------
NO_RESPONSE           | WARNING
UNEXPECTED_RCODE      | WARNING
NS_IS_CNAME           | ERROR
NO_NS_CNAME           | INFO


## Special procedural requirements

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
on the ignored result.


## Intercase dependencies

None

## Terminology

The terms "in-domain", "sibling domain", "in-bailiwick" and
"out-of-bailiwick" are used as defined in [RFC 8499][RFC 8499#7], section 7
(p 25), where "in-domain" and "sibling domain" are defined as a sub-types
of "in-bailiwick".

The term "DNS Lookup" is used when a recursive lookup is used, though
any changes to the DNS tree introduced by an [undelegated test] must be
respected.


[DNS Lookup]:            #terminology
[Method2]:               ../Methods.md#method-2-obtain-glue-name-records-from-parent
[Method3]:               ../Methods.md#method-3-obtain-name-servers-from-child
[Method4]:               ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:               ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[NO_NS_CNAME]:           #outcomes
[NO_RESPONSE]:           #outcomes
[NS_IS_CNAME]:           #outcomes
[RFC 2181#10.3]:         https://tools.ietf.org/html/rfc2181#section-10.3
[RFC 8499#7]:            https://tools.ietf.org/html/rfc8499#section-7
[UNEXPECTED_RCODE]:      #outcomes
[in-bailiwick]:          #terminology
[in-domain]:             #terminology
[out-of-bailiwick]:      #terminology
[sibling domain]:        #terminology
[terminology]:           #terminology
[undelegated test]:      ../../test-types/undelegated-test.md




