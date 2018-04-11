# DELEGATION01: Minimum number of name servers   

## Test case identifier

**DELEGATION01:** Minimum number of name servers

## Objective

Section 4.1 of [RFC 1034] specifies that there must be at least minimum two name servers 
for a domain. This test is done to verify this condition.

The RFC ([RFC 1034]) pre-dates IPv6. Sinces IPv4 and IPv6 work as separate networks, this
test case has been extended to test for for two name servers that resolv into IPv4 addresses
and IPv6 addresses respectively.


## Inputs

The domain name to be tested ("child zone").

## Ordered description of steps to be taken to execute the test case

1. Obtain the complete set of the names of the name servers for the *child 
   zone* (distinct NS records) from parent using [Method2].
2. If the number of name servers from parent is at least two, emit the
   *ENOUGH_NS_PARENT*, else emit *NOT_ENOUGH_NS_PARENT*.
3. Obtain the IP addresses for the set of the name servers from parent 
   using [Method4].
4. If there are no name servers from parent resolving to an IPv4 
   address then emit *NO_IPV4_NS_PARENT*.
5. If the number of name servers from parent resolving to an IPv4 
   address is one then emit *NOT_ENOUGH_IPV4_NS_PARENT*.
6. If the number of name servers from parent resolving to an IPv4 
   address is at least two then emit *ENOUGH_IPV4_NS_PARENT*.
7. If there are no name servers from parent resolving to an IPv6 
   address then emit *NO_IPV6_NS_PARENT*.
8. If the number of name servers from parent resolving to an IPv6 
   address is one then emit *NOT_ENOUGH_IPV6_NS_PARENT*.
9. If the number of name servers from parent resolving to an IPv6 
   address is at least two then emit *ENOUGH_IPV6_NS_PARENT*.
10. Obtain the complete set of the names of the name servers for the 
    *child zone* from the *child zone* using [Method3].
11. If the number of name servers from child is at least two emit the
   *ENOUGH_NS_CHILD*, else emit *NOT_ENOUGH_NS_CHILD*.
12. Obtain the IP addresses for the set of the name servers from 
    *child zone* using [Method5] and, for 
    out-of-bailiwick NS, using [Method4].
13. If there are no name servers from child resolving to an IPv4 
   address then emit *NO_IPV4_NS_CHILD*.
14. If the number of name servers from child resolving to an IPv4 
   address is one then emit *NOT_ENOUGH_IPV4_NS_CHILD*.
15. If the number of name servers from child resolving to an IPv4 
   address is two then emit *ENOUGH_IPV4_NS_CHILD*.
16. If there are no name servers from child resolving to an IPv6 
   address then emit *NO_IPV6_NS_CHILD*.
17. If the number of name servers from child resolving to an IPv6 
   address is one then emit *NOT_ENOUGH_IPV6_NS_CHILD*.
18. If the number of name servers from child resolving to an IPv6 
   address is two then emit *ENOUGH_IPV6_NS_CHILD*.

 
## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

In other cases the outcome of this Test Case is "pass".

Message                       | Default severity level (if message is emitted)
:-----------------------------|:-----------------------------------
NOT_ENOUGH_NS_PARENT          | ERROR
ENOUGH_NS_PARENT              | INFO
NO_IPV4_NS_PARENT             | ERROR
NOT_ENOUGH_IPV4_NS_PARENT     | ERROR
ENOUGH_IPV4_NS_PARENT         | INFO
NO_IPV6_NS_PARENT             | NOTICE
NOT_ENOUGH_IPV6_NS_PARENT     | NOTICE
ENOUGH_IPV6_NS_PARENT         | INFO
NOT_ENOUGH_NS_CHILD           | ERROR
ENOUGH_NS_CHILD               | INFO
NO_IPV4_NS_CHILD              | ERROR
NOT_ENOUGH_IPV4_NS_CHILD      | ERROR
ENOUGH_IPV4_NS_CHILD          | INFO
NO_IPV6_NS_CHILD              | NOTICE
NOT_ENOUGH_IPV6_NS_CHILD      | NOTICE
ENOUGH_IPV6_NS_CHILD          | INFO


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

Copyright (c) 2013-2018, IIS (The Internet Foundation in Sweden )  
Copyright (c) 2013-2018, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <https://creativecommons.org/licenses/by/4.0/>.
