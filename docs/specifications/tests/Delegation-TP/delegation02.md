# DELEGATION02: Name servers must have distinct IP addresses

## Test case identifier

**DELEGATION02:** Name servers must have distinct IP addresses

## Objective

If the domain's name servers use several different names, they can all
be using the same IP address. This may be due to a configuration error, or
a workaround for a certain policy restriction. This test case checks that
the name servers used do not reuse the same IP addresses.

Section 4.1 of [RFC 1034] says at least
two name servers must be used for a delegation.

## Inputs

The domain name to be tested.

## Ordered description of steps to be taken to execute the test case

1. Obtain the complete set of name server names from parent using 
   [Method2] and the IP addresses for each name using [Method4].

2. If the same IP address is found for two or more name server names, 
   emit *DEL_NS_SAME_IP* for each repeated address, else emit
   *DEL_DISTINCT_NS_IP*.

3. Obtain the complete set of name server names from the child using 
   [Method3] and the IP addresses for each name using [Method5] for
   [in-bailiwick] names and using [Method4] for [out-of-bailiwick] 
   names only. 

4. If the same IP address is found for two or more name server names, 
   emit *CHILD_NS_SAME_IP* for each repeated address, else emit
   *CHILD_DISTINCT_NS_IP*.

## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

In other cases the outcome of this Test Case is "pass".

Message               | Default severity level (if message is emitted)
:---------------------|:-----------------------------------
DEL_NS_SAME_IP        | ERROR
CHILD_NS_SAME_IP      | ERROR
DEL_DISTINCT_NS_IP    | INFO
CHILD_DISTINCT_NS_IP  | INFO

## Special procedural requirements

None 

## Intercase dependencies

None


## Terminology

The terms "in-bailiwick" and "out-of-bailiwick" are used as defined
in [RFC 7719], section 6, page 15.

[RFC 7719]: https://tools.ietf.org/html/rfc7719

[RFC 1034]: https://tools.ietf.org/html/rfc1034

[Method2]:  ../Methods.md#method-2-obtain-glue-name-records-from-parent

[Method3]:  ../Methods.md#method-3-obtain-name-servers-from-child

[Method4]:  ../Methods.md#method-4-obtain-glue-address-records-from-parent

[Method5]:  ../Methods.md#method-5-obtain-the-name-server-address-records-from-child

[in-bailiwick]:     #terminology

[out-of-bailiwick]: #terminology

