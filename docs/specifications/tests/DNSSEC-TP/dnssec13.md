# DNSSEC13: All DNSKEY algorithms used to sign the zone

## Test case identifier
**DNSSEC13**

## Objective

From RFC [6840], section 5.11:

> The DS RRset and DNSKEY RRset are used to signal which 
> algorithms are used to sign a zone. (...) The zone MUST 
> also be signed with each algorithm (though not each key) 
> present in the DNSKEY RRset.

To verify the complete zone is signed with all algorithms require
access to the complete zone. This test case is limited to three
RRsets that must be present in a signed zone, the SOA RRset, the
NS RRset and the DNSKEY RRset.

This test case will verify that for each DNSKEY algorithm, there
is a RRsig of that algorithm for the three selcted RRsets.

## Inputs

* "Child Zone" - The domain name to be tested.

## Ordered description of steps to be taken to execute the test case

1. Create a DNSKEY query with DO flag set for the apex of the
   *Child Zone*.

2. Create a SOA query with DO flag set for the apex of the
   *Child Zone*.

3. Create a NS query with DO flag set for the apex of the
   *Child Zone*.

4. Retrieve all name server IP addresses for the
   *Child Zone* using [Method4] and [Method5] ("NS IP").

5. Repeat the following steps for each name server IP address in *NS IP*:

   1. Send the DNSKEY query over UDP.
      1. If no DNS response is returned, then output 
         *[NO_RESPONSE]* and go to next name server IP address.
      2. Else if the DNS response does not contain an DNSKEY RRset,
         then output *[NO_RESPONSE_DNSKEY]* and go to next name 
         server IP address.
      3. Else do:
         1. Extract the algorithm numbers from each DNSKEY record
            ("DNSKEY Algorithms").
         2. If there is no RRsig for DNSKEY, then output 
            *[DNSKEY_NOT_SIGNED]* and go to next name server IP 
            address.
         3. If there is a algorithm in *DNSKEY Algorithm* not used
            by any DNSKEY RRsig, then output 
            *[ALGORITHM_NOT_SIGNED_DNSKEY]*.
   2. Send the SOA query over UDP.
      1. If no DNS response is returned, then output 
         *[NO_RESPONSE]* and go to next name server IP address.
      2. Else if the DNS response does not contain an SOA RRset,
         then output *[NO_RESPONSE_SOA]* and go to next name server 
         IP address.
      3. Else do:
         1. If there is no RRsig for SOA, then output 
            *[SOA_NOT_SIGNED]* and go to next name server IP 
            address.
         2. If there is a algorithm in *DNSKEY Algorithm* not used
            by any SOA RRsig, then output 
            *[ALGORITHM_NOT_SIGNED_SOA]*.
   3. Send the NS query over UDP.
      1. If no DNS response is returned, then output 
         *[NO_RESPONSE]* and go to next name server IP address.
      2. Else if the DNS response does not contain an SOA RRset,
         then output *[NO_RESPONSE_NS]* and go to next name server 
         IP address.
      3. Else do:
         1. If there is no RRsig for NS, then output 
            *[NS_NOT_SIGNED]* and go to next name server IP 
            address.
         2. If there is a algorithm in *DNSKEY Algorithm* not used
            by any NS RRsig, then output 
            *[ALGORITHM_NOT_SIGNED_NS]*.

6. If none of *[NO_RESPONSE_DNSKEY]*, *[DNSKEY_NOT_SIGNED]*,
   *[ALGORITHM_NOT_SIGNED_DNSKEY]*, *[NO_RESPONSE_SOA]*, 
   *[SOA_NOT_SIGNED]*, *[ALGORITHM_NOT_SIGNED_SOA]*, *[NO_RESPONSE_NS]*,
   *[NS_NOT_SIGNED]* and *[ALGORITHM_NOT_SIGNED_NS]* was outputted and
   *DNSKEY Algorithm* was non-empty for at least some name server IP 
   addresses in *NS IP* then output *[ALL_ALGORITHM_SIGNED]*.

## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

In other cases the outcome of this Test Case is "pass".

Message                       | Default severity level
:-----------------------------|:-----------------------------------
NO_RESPONSE                   | WARNING
NO_RESPONSE_DNSKEY            | ERROR
DNSKEY_NOT_SIGNED             | ERROR
ALGORITHM_NOT_SIGNED_DNSKEY   | ERROR
NO_RESPONSE_SOA               | ERROR
SOA_NOT_SIGNED                | ERROR
ALGORITHM_NOT_SIGNED_SOA      | ERROR
NO_RESPONSE_NS                | ERROR
NS_NOT_SIGNED                 | ERROR
ALGORITHM_NOT_SIGNED_NS       | ERROR
ALL_ALGORITHM_SIGNED          | INFO


## Special procedural requirements

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
on the ignored result.

See the [DNSSEC README] document about DNSSEC algorithms.

Test case is only performed if DNSKEY records are found.

## Intercase dependencies

None.

[6840]:    https://tools.ietf.org/html/rfc6840#section-5.11
[Method4]: ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]: ../Methods.md#method-5-obtain-the-name-server-address-records-from-child

[DNSSEC README]:             ./README.md
NO_RESPONSE:                 #outcomes
NO_RESPONSE_DNSKEY:          #outcomes
DNSKEY_NOT_SIGNED:           #outcomes
ALGORITHM_NOT_SIGNED_DNSKEY: #outcomes
NO_RESPONSE_SOA:             #outcomes
SOA_NOT_SIGNED:              #outcomes
ALGORITHM_NOT_SIGNED_SOA:    #outcomes
NO_RESPONSE_NS:              #outcomes
NS_NOT_SIGNED:               #outcomes
ALGORITHM_NOT_SIGNED_NS:     #outcomes
ALL_ALGORITHM_SIGNED:        #outcomes

