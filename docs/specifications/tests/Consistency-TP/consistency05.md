# CONSISTENCY05: Consistency between glue and authoritative data

## Test case identifier

**CONSISTENCY05**

## Objective

For name servers that have IP addresses listed as glue, the IP addresses must
match the authoritative A and AAAA records for that host. This is an IANA
requirement (https://www.iana.org/help/nameserver-requirements).

The objective of this test is to verify that the glue records are
consistent between glue and authoritative data.

## Inputs

* "Child Zone" - The domain name to be tested.

## Ordered description of steps to be taken to execute the test case
1. Obtain the set of name server names and its IP addresses of the 
   delegation of *Child Zone* using [Method2] and [Method4], respectively.

   1. Extract the [in-bailiwick] name servers names and create a set
      "Delegation Strict Glue" of those, were each name server name 
      is matched with its IP address or addresses, if available. The 
      set might be empty.
   2. Extract the [out-of-bailiwick] name servers names and create a set
      "Delegation Extended Glue" of those, were each name server name 
      is matched with its IP address or addresses, if available. The 
      set might be empty.

2. Obtain the IP addresses of the [in-bailiwick] name servers from the
   *Child Zone*:

   1. Obtain the set of name server names for the *Child Zone* from the
      *Child Zone* itself by using [Method3]. 
   2. Extract the [in-bailiwick] name servers. If there are no such 
      name servers, skip the steps to extract IP address from *Child 
      Zone*.
   3. For each [in-bailiwick] name server names create one A query and 
      one AAAA query.
   3. Obtain the set of "NS IP" for *Child Zone* from [Method4] and
      [Method5].
   4. Send the A and AAAA queries created above to each *NS IP*. 
      1. If there is no response from a server emit 
         *[CHILD_NS_NO_RESPONSE]* and go to next server.
      2. If there is DNS response from the server, but not an 
         authoritative answer with RCODE NOERROR or NXDOMAIN, emit
         *[CHILD_NS_FAILED]* and go to next server.
      3. If all servers emit *[CHILD_NS_NO_RESPONSE]* or 
         *[CHILD_NS_FAILED]*, then emit *[CHILD_ZONE_LAME]* and
         completely stop processing this test case.
      3. If a delegation (referral) to a sub-zone of *Child Zone* is returned, 
         follow that delegation, possibly in several steps, by repeating the
         A and AAAA queries.
      4. Extract the IP addresses from A and AAAA records from responses 
         that have the AA flag set if the owner name matches the that of 
         the of the query
      5. Tag any extracted data (A and AAAA) as 
         "Address Records From Child".

5. Compare the IP address for the name servers from 
   *Delegation Strict Glue* with *Address Records From Child*
   (i.e. [in-bailiwick] only).

   1. If an IP from *Delegation Strict Glue* is not listed in 
      *Address Records From Child* with that same name server name 
      then emit *[IN_BAILIWICK_ADDR_MISMATCH]*.

   2. If an IP from *Address Records From Child* is not listed in
      *Delegation Strict Glue* with that same name server name then 
      emit *[EXTRA_ADDRESS_CHILD]*.

6. For each  name server name in *Delegation Extended Glue* 
   (i.e. [out-of-bailiwick] only) do a DNS lookup, type A or AAAA, 
   on public DNS.

   1. If the IP in *Delegation Extended Glue* does not match any of the 
      listed A or AAAA records listed in the response for the same
      name, or no response with such records, emit 
      *[OUT_OF_BAILIWICK_ADDR_MISMATCH]*.

7. If none of the messages *[IN_BAILIWICK_ADDR_MISMATCH]*, 
   *[EXTRA_ADDRESS_CHILD]* or *[OUT_OF_BAILIWICK_ADDR_MISMATCH]* has 
   been emitted, emit *[ADDRESSES_MATCH]*.


## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

In other cases the outcome of this Test Case is "pass".

Message                           | Default severity level (if message is emitted)
:---------------------------------|:-----------------------------------
CHILD_NS_FAILED                   | NOTICE
CHILD_NS_NO_RESPONSE              | NOTICE
CHILD_ZONE_LAME                   | ERROR
IN_BAILIWICK_ADDR_MISMATCH        | ERROR
OUT_OF_BAILIWICK_ADDR_MISMATCH    | ERROR
EXTRA_ADDRESS_CHILD               | NOTICE
ADDRESSES_MATCH                   | INFO

## Special procedural requirements	

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
on the ignored result.

If the test is an undelegated test then [Method2] and [Method4] will 
include the provided input data instead of data from any real delegation
and authoritative data. 

It is assumed that the name servers of the parent zone behave the same way 
for the parent zone as when [BASIC01] was run.

## Intercase dependencies

None


## Terminology

The terms "in-bailiwick" and "out-of-bailiwick" are used as defined
in [RFC 7719], section 6, page 15.

The term "glue records" is defined in [RFC 7719], section 6, page 15.
Here we use "glue" in the wider sense.

[RFC 7719]: https://tools.ietf.org/html/rfc7719

[BASIC01]: Basic-TP/basic01.md

[DELEGATION05]: Delegation-TP/delegation05.md

[Method2]: #method-2-delegation-name-servers

[Method3]: #method-3-in-zone-name-servers

[Method4]: #method-4-delegation-name-server-addresses

[Method5]: #method-5-in-zone-addresses-records-of-name-servers

[in-bailiwick]:     #terminology

[out-of-bailiwick]: #terminology

[glue records]: #terminology

[CHILD_NS_FAILED]: #outcomes

[CHILD_NS_NO_RESPONSE]: #outcomes

[CHILD_ZONE_LAME]: #outcomes

[IN_BAILIWICK_ADDR_MISMATCH]: #outcomes

[OUT_OF_BAILIWICK_ADDR_MISMATCH]: #outcomes

[EXTRA_ADDRESS_CHILD]: #outcomes

[UNDEL_OOB_ADDR_MISMATCH]: #outcomes

[ADDRESSES_MATCH]: #outcomes

