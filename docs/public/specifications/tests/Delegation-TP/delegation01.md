# DELEGATION01: Minimum number of name servers   

## Test case identifier

**DELEGATION01**

## Objective

Section 4.1 of [RFC 1034] specifies that there must be a minimum of two name servers 
for a domain. This test is done to verify this condition.

The RFC ([RFC 1034]) predates IPv6. Since IPv4 and IPv6 work as separate networks, this
test case has been extended to test for two name servers that resolve into IPv4 addresses
and IPv6 addresses respectively.

Both [RFC 3901] (section 3) and [RFC 4472] (section 1.3) states that a domain 
(zone) should be available over IPv4 for the time being. Therefore, it is by the 
default level in this test case considered to be more problematic not being available 
over IPv4 than not being available over IPv6.

## Inputs

"Child Zone" - The domain name to be tested

## Ordered description of steps to be taken to execute the test case

 1. Using [Method2], obtain the complete set of names of the name servers 
    from the delegation of the *Child Zone*.

 2. Count the name server names:
    1. If zero or one, emit *[NOT_ENOUGH_NS_DEL]*.
    2. If two or more, emit *[ENOUGH_NS_DEL]*.

 3. Using [Method4], obtain the IP addresses for the name servers of the 
    delegation of the *Child Zone*.

 4. Count the number of name server names that resolve into at least one IPv4 
    address:
    1. If zero, emit *[NO_IPV4_NS_DEL]*.
    2. If one, emit *[NOT_ENOUGH_IPV4_NS_DEL]*.
    3. If two or more, emit *[ENOUGH_IPV4_NS_DEL]*.

 5. Count the number of name server names that resolve into at least one IPv6 
    address:
    1. If zero, emit *[NO_IPV6_NS_DEL]*.
    2. If one, emit *[NOT_ENOUGH_IPV6_NS_DEL]*.
    3. If two or more, emit *[ENOUGH_IPV6_NS_DEL]*.

 6. Using [Method3], obtain the complete set of names of the name servers
    from the *Child Zone* for the *Child Zone*. 

 7. Count the name server names:
    1. If zero or one, emit *[NOT_ENOUGH_NS_CHILD]*.
    2. If two or more, emit *[ENOUGH_NS_CHILD]*.

 8. Using [Method5], obtain the IP addresses for the name servers from 
    the *Child Zone* for the *Child Zone*.

 9. Count the number of name server names that resolve into at least one IPv4 
    address:
    1. If zero, emit *[NO_IPV4_NS_CHILD]*.
    2. If one, emit *[NOT_ENOUGH_IPV4_NS_CHILD]*.
    3. If two or more, emit *[ENOUGH_IPV4_NS_CHILD]*.

10. Count the number of name server names that resolve into at least one IPv6 
    address:
    1. If zero, emit *[NO_IPV6_NS_CHILD]*.
    2. If one, emit *[NOT_ENOUGH_IPV6_NS_CHILD]*.
    3. If two or more, emit *[ENOUGH_IPV6_NS_CHILD]*.

## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

Else the outcome of this Test Case is "pass".

Message                       | Default severity level
:-----------------------------|:-----------------------------------
ENOUGH_IPV4_NS_CHILD          | INFO
ENOUGH_IPV4_NS_DEL            | INFO
ENOUGH_IPV6_NS_CHILD          | INFO
ENOUGH_IPV6_NS_DEL            | INFO
ENOUGH_NS_CHILD               | INFO
ENOUGH_NS_DEL                 | INFO
NOT_ENOUGH_IPV4_NS_CHILD      | ERROR
NOT_ENOUGH_IPV4_NS_DEL        | ERROR
NOT_ENOUGH_IPV6_NS_CHILD      | ERROR
NOT_ENOUGH_IPV6_NS_DEL        | ERROR
NOT_ENOUGH_NS_CHILD           | ERROR
NOT_ENOUGH_NS_DEL             | ERROR
NO_IPV4_NS_CHILD              | WARNING
NO_IPV4_NS_DEL                | WARNING
NO_IPV6_NS_CHILD              | NOTICE
NO_IPV6_NS_DEL                | NOTICE


## Special procedural requirements

None 

## Intercase dependencies

None

[RFC 1034]: https://datatracker.ietf.org/doc/html/rfc1034
[RFC 3901]: https://datatracker.ietf.org/doc/html/rfc3901
[RFC 4472]: https://datatracker.ietf.org/doc/html/rfc4472

[Method2]:  ../Methods.md#method-2-obtain-glue-name-records-from-parent
[Method3]:  ../Methods.md#method-3-obtain-name-servers-from-child
[Method4]:  ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:  ../Methods.md#method-5-obtain-the-name-server-address-records-from-child

[ENOUGH_IPV4_NS_CHILD]: #outcomes
[ENOUGH_IPV4_NS_DEL]: #outcomes
[ENOUGH_IPV6_NS_CHILD]: #outcomes
[ENOUGH_IPV6_NS_DEL]: #outcomes
[ENOUGH_NS_CHILD]: #outcomes
[ENOUGH_NS_DEL]: #outcomes
[NOT_ENOUGH_IPV4_NS_CHILD]: #outcomes
[NOT_ENOUGH_IPV4_NS_DEL]: #outcomes
[NOT_ENOUGH_IPV6_NS_CHILD]: #outcomes
[NOT_ENOUGH_IPV6_NS_DEL]: #outcomes
[NOT_ENOUGH_NS_CHILD]: #outcomes
[NOT_ENOUGH_NS_DEL]: #outcomes
[NO_IPV4_NS_CHILD]: #outcomes
[NO_IPV4_NS_DEL]: #outcomes
[NO_IPV6_NS_CHILD]: #outcomes
[NO_IPV6_NS_DEL]: #outcomes

