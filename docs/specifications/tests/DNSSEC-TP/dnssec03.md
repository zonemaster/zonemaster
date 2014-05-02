## DNSSEC03: Check for too many NSEC3 iterations

### Test case identifier
**DNSSEC03** Check for too many NSEC3 iterations

### Objective

For an authoritative name server an increased number of NSEC3 iterations
have a negative impact on performance.

Section 10.3 in [RFC 5155](https://tools.ietf.org/html/rfc5155#section-10.3)
sets a maximum number of iterations depending on the DNSSEC key size -
regardless of which algorithm is used.

> A zone owner MUST NOT use a value higher than shown in the table
> below for iterations for the given key size.  A resolver MAY treat a
> response with a higher value as insecure, after the validator has
> verified that the signature over the NSEC3 RR is correct.

|Key Size |Iterations |
|:--------|:----------|
|1024     |150        |
|2048     |500        |
|4096     |2,500      |

Section 5.3.2 in [RFC 6781](https://tools.ietf.org/html/rfc6781#section-5.3.2)
describes the consequences for an authoritative name server in more detail, and
references the [NSEC Hash Performance](http://www.nlnetlabs.nl/downloads/publications/nsec3_hash_performance.pdf)
study from NLNet Labs.

> Choosing a value of 100 iterations is deemed to be a
> sufficiently costly, yet not excessive, value: In the worst-case
> scenario, the performance of name servers would be halved, regardless
> of key size.

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Query the NSEC3PARAM RR from the child zone.
2. If there is not use of NSEC3 there is no NSEC3PARAM RR in the child zone,
   and this test case ends here.
3. The iterations value is extracted from the NSEC3PARAM RR.
4. If the number of iterations is higher than 100, this test case emits
   at least a warning.
5. Query the DNSKEY RR, and extract the smallest key from the zone.
6. Depending on the key sizes listed in section 10.3 of RFC 5155, if the
   number of iterations is larger than the corresponding key size of
   the smallest key, this test case fails.

### Outcome(s)

If the NSEC3 iterations value is higher than 100, this test case gives
a warning. If it is higher than the number recommended for the corresponding
key size, this test case fails.

### Special procedural requirements

This test is only fully performed if the zone uses NSEC3 (has the
NSEC3PARAM RR in the zone).

### Intercase dependencies

None.
