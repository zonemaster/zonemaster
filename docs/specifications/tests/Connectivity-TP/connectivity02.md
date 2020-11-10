# CONNECTIVITY02: TCP connectivity

## Test case identifier

**CONNECTIVITY02**

## Objective

DNS queries are sent using TCP on port 53, as described in
[RFC 1035][RFC 1035#section-4.2.2], section 4.2.2. As specified in
[RFC 7766][RFC 7766#section-1], section 1, support of TCP is mandatory.

The objective for this test is that all the authoritative name servers for
the domain are accessible over TCP on port 53.

## Inputs

The domain to be tested.

## Ordered description of steps to be taken to execute the test case

1. Obtains the IP addresses of the name servers from [Method4] and
   [Method5].
2. A SOA query is sent over TCP to distinct IP address of each name server
   found in step 1.
3. If all queries in step 2 receive a DNS answer (bogus response are not
   checked here) then the test case succeed.

## Outcome(s)

If there is any name server that fails to answer queries over port 53 using
TCP, this test case fails.

## Special procedural requirements

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
on the ignored result.

## Intercase dependencies

None

[Method4]:                                   ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]:                                   ../Methods.md#method-5-obtain-the-name-server-address-records-from-child
[RFC 1035#section-4.2.2]:                    https://tools.ietf.org/html/rfc1035#section-4.2.2
[RFC 7766#section-1]:                        https://tools.ietf.org/html/rfc7766#section-1

