# CONSISTENCY05: Consistency between glue and authoritative data

## Test case identifier

**CONSISTENCY05**

## Objective

For name servers that have IP addresses listed as glue, the IP addresses must
match the authoritative A and AAAA records for that host. This is an IANA 
[name server requirement].

The objective of this test is to verify that the glue address records 
in the delegation are consistent with authoritative data.

## Inputs

* "Child Zone" - The domain name to be tested.

## Ordered description of steps to be taken to execute the test case
1. Obtain the set of name server names from the NS records in the 
   delegation of *Child Zone* using [Method2] and any glue IP addresses
   from the same delegation using [Method4].

   1. Extract the [in-bailiwick] name server names and create the set
      "Delegation Strict Glue", where each name server name 
      is matched with its IP address or addresses, if available. (The 
      set may be empty.)

   2. Extract the [out-of-bailiwick] name server names and create the 
      set "Delegation Extended Glue", where each name server name 
      is matched with its IP address or addresses, if available. (The 
      set may be empty.)

2. Obtain the set of name server names for the *Child Zone* using
   [Method2] and [Method3] and extract the [in-bailiwick] name 
   server names, "IB NS Name Set". (The set may be empty.)

3. Create an empty set of name server name with associated IP address
   or addresses, "Address Records From Child".

4. If *IB NS Name Set* is non-empty, obtain the set of name server IP 
   addresses, "NS IP", for *Child Zone* using [Method4] and [Method5].

5. If *IB NS Name Set* is non-empty, then for each name server name in
   that set do:

   1. Create one A query and one AAAA query with the RD flag unset
      and name server name as owner name.

   2. For each name server in *NS IP* and for each record 
      types (A, AAAA):
      1. Send the address query to the name server.
      2. If there is no DNS response from the server, then
         output *[NO_RESPONSE]*.
      3. Or, if the response is a delegation (referral) to a 
         sub-zone of *Child Zone*, then:
         1. Copy the adress query (A, AAAA) that gave the referral
            response.
         2. Set the RD flag in the copied query (from unset to set).
         3. Do a DNS lookup of the the query using a resolving name server 
            on the public DNS.
            * The lookup must take into account changes that
              undelegated data has created, if any.
         4. If the lookup returns the relevant address record or records,
            A for A record query and AAAA for AAAA record query, and 
            with the same owner name as in the query, then extract those 
            and add to *Address Records From Child* with name and IP 
            address or addresses.
      4. Or, if the response has the AA flag unset, then
         output *[CHILD_NS_FAILED]*. 
      5. Or, if the RCODE of the response is neither NOERROR nor 
         NXDOMAIN, then output *[CHILD_NS_FAILED]*.
      6. Or, if the RCODE is NOERROR (with the AA flag set), then
         extract any address records (A, AAAA) from the answer
         section whose owner name matches the owner name 
         of the query and add that or those to 
         *Address Records From Child* with name and IP.
      7. Else, there is nothing to do (i.e. RCODE is NXDOMAIN).

   3. If all servers outputted *[NO_RESPONSE]* or *[CHILD_NS_FAILED]*, 
      then output *[CHILD_ZONE_LAME]* and completely stop processing 
      this test case.

6. Compare the IP address for the name servers from 
   *Delegation Strict Glue* with *Address Records From Child*
   (i.e. [in-bailiwick] only).

   1. If an IP from *Delegation Strict Glue* is not listed in 
      *Address Records From Child* with that same name server name, 
      then output *[IN_BAILIWICK_ADDR_MISMATCH]*.

   2. If an IP from *Address Records From Child* is not listed in
      *Delegation Strict Glue* with that same name server name, then 
      output *[EXTRA_ADDRESS_CHILD]*.

7. For each name server name in *Delegation Extended Glue* 
   (i.e. [out-of-bailiwick] only) ("DEG Name Server Name") do: 

   1. Do two DNS lookups, one record type A and one record type 
      AAAA, for *DEG Name Server Name* on public DNS and create a
      set of the IP addresses from the A an AAAA records, respectively,
      from the answer sections of the responses. Do not follow any CNAME. 
      (The set will be empty if there are no relevant records in the
      answer sections or if there is no response, e.g. SERVFAIL.)

   2. For each IP address for *DEG Name Server Name* in
      *Delegation Extended Glue* do:
      1. If the address is not member of the IP address set created
         in the previous DNS lookups, output 
         *[OUT_OF_BAILIWICK_ADDR_MISMATCH]*.

8. If none of *[IN_BAILIWICK_ADDR_MISMATCH]*, *[EXTRA_ADDRESS_CHILD]* 
   or *[OUT_OF_BAILIWICK_ADDR_MISMATCH]* has been outputted, output 
   *[ADDRESSES_MATCH]*.


## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

The outcome of this Test case is "pass" in all other cases.

Message                           | Default severity level (when message is outputted)
:---------------------------------|:-----------------------------------
CHILD_NS_FAILED                   | NOTICE
NO_RESPONSE                       | WARNING
CHILD_ZONE_LAME                   | ERROR
IN_BAILIWICK_ADDR_MISMATCH        | ERROR
OUT_OF_BAILIWICK_ADDR_MISMATCH    | ERROR
EXTRA_ADDRESS_CHILD               | NOTICE
ADDRESSES_MATCH                   | INFO

## Special procedural requirements	

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol and log a message reporting
the ignored result.

If the test is an [undelegated test] then [Method2] and [Method4] will 
include the provided input data instead of data from any real delegation
and authoritative data.

For an [undelegated test] it is possible to intentionally insert data
for [out-of-bailiwick] name servers that do not match what is found in
public DNS. This Test Case will then report this as an ERROR which
may not match the users expectation.

It is assumed that the name servers of the parent zone behave the same way 
for the parent zone as when [BASIC01] was run.

## Intercase dependencies

None


## Terminology

The terms "in-bailiwick" and "out-of-bailiwick" are used as defined
in [RFC 7719], section 6, page 15.

The term "glue records" is defined in [RFC 7719], section 6, page 15.
Here we use "glue" in the wider sense.

[name server requirement]: https://www.iana.org/help/nameserver-requirements

[RFC 7719]: https://tools.ietf.org/html/rfc7719

[BASIC01]: ../Basic-TP/basic01.md

[DELEGATION05]: ../Delegation-TP/delegation05.md

[Method2]: ../Methods.md#method-2-delegation-name-servers

[Method3]: ../Methods.md#method-3-in-zone-name-servers

[Method4]: ../Methods.md#method-4-delegation-name-server-addresses

[Method5]: ../Methods.md#method-5-in-zone-addresses-records-of-name-servers

[in-bailiwick]:     #terminology

[out-of-bailiwick]: #terminology

[glue records]: #terminology

[CHILD_NS_FAILED]: #outcomes

[NO_RESPONSE]: #outcomes

[CHILD_ZONE_LAME]: #outcomes

[IN_BAILIWICK_ADDR_MISMATCH]: #outcomes

[OUT_OF_BAILIWICK_ADDR_MISMATCH]: #outcomes

[EXTRA_ADDRESS_CHILD]: #outcomes

[UNDEL_OOB_ADDR_MISMATCH]: #outcomes

[ADDRESSES_MATCH]: #outcomes

[undelegated test]: ../../test-types/undelegated-test.md

