## DELEGATION01: Minimum number of name servers   

### Test case identifier

**DELEGATION01:** Minimum number of name servers

### Objective

Section 4.1 of [RFC 1034] specifies that there must be at least minimum two name servers 
for a domain. This test is done to verify this condition.

The RFC ([RFC 1034]) pre-dates IPv6. Sinces IPv4 and IPv6 work as separate networks, this
test case has been extended to test for for two name servers that resolv into IPv4 addresses
and IPv6 addresses respectively.


### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Obtain the complete set of name servers (distinct NS records) from 
   parent using [Method2](../Methods.md).
2. If the number of name servers from parent is at least two emit the
   message **ENOUGH_NS_PARENT** else emit the message 
   **NOT_ENOUGH_NS_PARENT**.
3. Obtain the IP addresses for the set of the name servers from parent 
   using [Method4](../Methods.md).
4. If the number of name servers from parent resolving to an IPv4 
   address is none then emit the message **NO_IPV4_NS_PARENT**, else 
   if it is one emit **NOT_ENOUGH_IPV4_NS_PARENT** else emit
   **ENOUGH_IPV4_NS_PARENT**.
5. If the number of name servers from parent resolving to an IPv6 
   address is none then emit the message **NO_IPV6_NS_PARENT**, else 
   if it is one emit **NOT_ENOUGH_IPV6_NS_PARENT** else emit
   **ENOUGH_IPV6_NS_PARENT**.
6. Obtain the complete set of name servers from the child using 
   [Method3](../Methods.md).
7. If the number of name servers from child is at least two emit the
   message **ENOUGH_NS_CHILD** else emit the message 
   **NOT_ENOUGH_NS_CHILD**.
8. Obtain the IP addresses for the set of the name servers from child 
   using [Method5](../Methods.md) and, for out-of-bailiwick NS, using
   [Method4](../Methods.md).
9. If the number of name servers from child resolving to an IPv4 
   address is none then emit the message **NO_IPV4_NS_CHILD**, else 
   if it is one emit **NOT_ENOUGH_IPV4_NS_CHILD** else emit
   **ENOUGH_IPV4_NS_CHILD**.
9. If the number of name servers from child resolving to an IPv6 
   address is none then emit the message **NO_IPV6_NS_CHILD**, else 
   if it is one emit **NOT_ENOUGH_IPV6_NS_CHILD** else emit
   **ENOUGH_IPV6_NS_CHILD**.

 
### Outcome(s)

The outcome of the test case depends on the highest level of the messages 
generated.

Message                       | Default level (if message is emitted)
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


### Special procedural requirements

None 

### Intercase dependencies

None


[RFC 1034]: https://tools.ietf.org/html/rfc1034

-------

Copyright (c) 2013-2018, IIS (The Internet Foundation in Sweden )  
Copyright (c) 2013-2018, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <https://creativecommons.org/licenses/by/4.0/>.
