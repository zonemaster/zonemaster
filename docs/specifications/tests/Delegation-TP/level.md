# List of basic DNS tests

This document uses the terminology defined in the [Master Test Plan](../Master%20Test%20Plan.md).

## Mapping from Requirements to Test Case

|Req| Description                                          | Test Case                     |
|:--|:-----------------------------------------------------|:------------------------------|
|R09|Minimum number of name servers                        |[DELEGATION01](delegation01.md)|
|R10|Name servers must have distinct IP addresses          |[DELEGATION02](delegation02.md)|
|R13|No truncation of referrals                            |[DELEGATION03](delegation03.md)|
|R14|No truncation of referrals                            |[DELEGATION03](delegation03.md)|
|R16|Name server is authoritative                          |[DELEGATION04](delegation04.md)|
|R18|NS RR does not point to CNAME alias                   |[DELEGATION05](delegation05.md)|
|R20|Existence of SOA                                      |[DELEGATION06](delegation06.md)|
|R21|Test whether the ANSWER for SOA is authoritative      |[DELEGATION06](delegation06.md)|
|R71|Parent glue name records present in child             |[DELEGATION07](delegation07.md)|

