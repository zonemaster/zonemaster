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

 1. Using [Method2], obtain the complete set of the names of the name servers 
    from parent for the *child zone* (distinct NS records).

 2. Count the name server names:
    1. If zero or one, emit *NOT_ENOUGH_NS_PARENT*.
    2. If two or more, emit *ENOUGH_NS_PARENT*.

 3. Obtain the IP addresses for the set of the name servers from parent for the 
    *child zone*.

 4. Count the number of name server names that resolve into at least one IPv4 
    addresse:
    1. If zero, emit *NO_IPV4_NS_PARENT*.
    2. If one, emit *NOT_ENOUGH_IPV4_NS_PARENT*.
    3. If two or more, emit *ENOUGH_IPV4_NS_PARENT*.

 5. Count the number of name server names that resolve into at least one IPv6 
    addresse:
    1. If zero, emit *NO_IPV6_NS_PARENT*.
    2. If one, emit *NOT_ENOUGH_IPV6_NS_PARENT*.
    3. If two or more, emit *ENOUGH_IPV6_NS_PARENT*.

 6. Using [Method3], obtain the complete set of the names of the name servers
    from the *child zone* for the *child zone*.

 7. Count the name server names:
    1. If zero or one, emit *NOT_ENOUGH_NS_CHILD*.
    2. If two or more, emit *ENOUGH_NS_CHILD*.

 8. Using [Method4], obtain the IP addresses for the in-bailiwick name servers 
    from the *child zone* for the *child zone*. 

 9. Using [Method5], obtain the IP addresses for the out-of-bailiwick name 
    servers for the *child zone*.

10. Count the number of name server names that resolve into at least one IPv4 
    addresse:
    1. If zero, emit *NO_IPV4_NS_CHILD*.
    2. If one, emit *NOT_ENOUGH_IPV4_NS_CHILD*.
    3. If two or more, emit *ENOUGH_IPV4_NS_CHILD*.

11. Count the number of name server names that resolve into at least one IPv6 
    addresse:
    1. If zero, emit *NO_IPV6_NS_CHILD*.
    2. If one, emit *NOT_ENOUGH_IPV6_NS_CHILD*.
    3. If two or more, emit *ENOUGH_IPV6_NS_CHILD*.

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
