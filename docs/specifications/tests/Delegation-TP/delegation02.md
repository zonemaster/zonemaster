# DELEGATION02: Name servers must have distinct IP addresses

## Test case identifier

**DELEGATION02:** Name servers must have distinct IP addresses

## Objective

If the domain have several different name server names used, they can all
be using the same IP address. This may be due to a configuration error, or
a workaround to a certain policy restriction. This test case checks that
the name servers used does not resolve to reuse the same IP addresses.

Section 4.1 of [RFC 1034] says at least
to name servers must be used for a delegation.

## Inputs

The domain name to be tested.

## Ordered description of steps to be taken to execute the test case

1. Obtain the complete set of name servers (distinct NS records) from 
   parent using [Method2].
2. Obtain the IP addresses for the set of the name servers from parent 
   using [Method4]. (This should include all IP address
   for both in-bailiwick and out-of-bailiwick name servers.)
3. If the same IP address is found for two or more name servers then 
   emit *PARENT_NS_SAME_IP_ADDRESS* and the IP address.
4. Repeat step 3 for all IP addresses obtained in step 2.
5. Obtain the complete set of name servers from the child using 
   [Method3].
6. Obtain the IP addresses for the set of the name servers from child 
   using [Method5] and, for out-of-bailiwick NS, using
   [Method4].
7. If the same IP address is found for two or more name servers then 
   emit *CHILD_NS_SAME_IP_ADDRESS* and the IP address.
8. Repeat step 7 for all IP addresses obtained in step 6.

## Outcome(s)

The outcome of the test case depends on the highest level of the messages 
generated.

Message                       | Default level (if message is emitted)
:-----------------------------|:-----------------------------------
PARENT_NS_SAME_IP_ADDRESS     | ERROR
CHILD_NS_SAME_IP_ADDRESS      | ERROR


## Special procedural requirements

None 

## Intercase dependencies

None


[RFC 1034]: https://tools.ietf.org/html/rfc1034

[Method2]:  ../Methods.md#method-2-obtain-glue-name-records-from-parent

[Method3]:  ../Methods.md#method-3-obtain-name-servers-from-child

[Method4]:  ../Methods.md#method-4-obtain-glue-address-records-from-parent

[Method5]:  ../Methods.md#method-5-obtain-the-name-server-address-records-from-child

-------

Copyright (c) 2013-2018, IIS (The Internet Foundation in Sweden)  
Copyright (c) 2013-2018, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <https://creativecommons.org/licenses/by/4.0/>.
