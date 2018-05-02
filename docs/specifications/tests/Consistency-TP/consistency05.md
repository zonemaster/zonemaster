# CONSISTENCY05: Consistency between glue and authoritative data

## Test case identifier

**CONSISTENCY05:**

## Objective

For name servers that have IP addresses listed as glue, the IP addresses must
match the authoritative A and AAAA records for that host. This is an IANA
requirement (https://www.iana.org/help/nameserver-requirements).

The objective of this test is to verify that the glue records are
consistent between glue and authoritative data.

## Inputs

* The domain name to be tested ("child zone").
* The test type, "undelegate test" or "normal test".
* If *normal test*, the name servers to the parent zone as found 
  in [BASIC01] ("parent NS").
* If *undelegated test*, the submitted delegation data, name server names
  and IP addresses for *child zone* ("undelegated data").

## Ordered description of steps to be taken to execute the test case
1. Obtain the IP addresses provided in the additional section in the 
   delegation ("[glue records]" in the wide sense) using step 2 or 3.

2. If the test is a *normal test*:
   1. These steps assume that the servers of *parent NS* behave the
      same way as when [BASIC01] was run.
   2. Create an NS query for the *child zone* and send that all servers
      of *parent NS* with RD flag unset.
   3. If the response response contains a referral to the child zone:
      1. Extract the name server names from the RDATA in the NS record in
         the authority section.
      2. Extract all A and AAAA records from the additional section.
      3. Go to next server (see above).
   4. If the response is authoritative (AA bit set) and the answer section
      contains the NS record of the child zone:
      1. Remember this fact (server is authoritative for *child zone*).
      2. Go to next server (see 2 above).
   5. If there is no response from the server emit 
      *[PARENT_NS_NO_RESPONSE]* and go to next server (see above).
   6. If there is response from the server, but not expect response, emit
      *[PARENT_NS_FAILED]* and go to next server (see above).
   7. If all servers from *parent NS* have been queried and all servers
      that returned a valid answer were authorititative for the *child
      zone* then emit *[DELEGATION_NOT_DETERMINED]* and exit these steps.
   8. Tag the data as "NS IP from parent".

3. If the test is an *undelegated test*:

   1. Collect IPv4 and IPv6 address for the name servers in input data
      ("NS IP from parent").

4. Obtain the IP addresses of the [in-bailiwick] name servers from the
   *child zone*:

   1. Obtain the set of name server names for the *child zone* from the
      *child zone* itself by using [Method3]. From that extract the
      [in-bailiwick] name servers. If there are no such name servers,
      go to step 5.
   2. Obtain the set of NS IP for *child zone* from [Method4].
   3. For each NS IP query the *child zone* for the [in-bailiwick] 
      name server names for A and AAAA.
   4. If there is no response from the server emit 
      *[CHILD_NS_NO_RESPONSE]* and go to next server (see above).
   5. If there is response from the server, but not expect response, emit
      *[CHILD_NS_FAILED]* and go to next server (see above).
   6. Tag the data as "NS IP from child".

5. Compare the IP address for the [in-bailiwick] name servers from 
   *NS IP from parent* with *NS IP from child*

   1. If an IP from *NS IP from parent* is not listed in 
      *NS IP from child* with that same name server name then emit
      *[PARENT_ADDRESS_MISMATCH]*.

   2. If an IP from *NS IP from child* is not listed in
      *NS IP from parent* with that same name server name then emit
      *[EXTRA_ADDRESS_CHILD]*.

6. For each [out-of-bailiwick] name server IP in *NS IP from parent* 
   do a DNS lookup (type A or AAA) of the name server name on public 
   DNS.

   1. If the IP in *NS IP from parent* does not match any of the 
      listed A or AAAA records listed in the response, or no response
      with such records, emit *[PARENT_ADDRESS_MISMATCH]* (if a *normal 
      test*) or *[UNDEL_PAR_ADDR_MISMATCH]* (if an *undelegated test*).

## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

In other cases the outcome of this Test Case is "pass".

Message                       | Default severity level (if message is emitted)
:-----------------------------|:-----------------------------------
DELEGATION_NOT_DETERMINED     | INFO
PARENT_NS_FAILED              | NOTICE
PARENT_NS_NO_RESPONSE         | NOTICE
CHILD_NS_FAILED               | NOTICE
CHILD_NS_NO_RESPONSE          | NOTICE
PARENT_ADDRESS_MISMATCH       | ERROR
EXTRA_ADDRESS_CHILD           | NOTICE
UNDEL_PAR_ADDR_MISMATCH       | NOTICE  


## Special procedural requirements	

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
on the ignored result.

## Intercase dependencies

None


## Terminology

The terms "in-bailiwick" and "out-of-bailiwick" are used as defined
in [RFC 7719], section 6, page 15.

The term "glue records" is defined in [RFC 7719], section 6, page 15.
Here we use "glue" in the wider sence.

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

[DELEGATION_NOT_DETERMINED]: #outcomes

[PARENT_NS_FAILED]: #outcomes

[PARENT_NS_NO_RESPONSE]: #outcomes

[CHILD_NS_FAILED]: #outcomes

[CHILD_NS_NO_RESPONSE]: #outcomes

[PARENT_ADDRESS_MISMATCH]: #outcomes

[EXTRA_ADDRESS_CHILD]: #outcomes

[UNDEL_PAR_ADDR_MISMATCH]: #outcomes
