# List of basic DNS tests

This document uses the terminology defined in the [Master Test Plan](../Master%20Test%20Plan.md).

## Mapping from Requirements to Test Case

|Req| Description                                                          | Test Case |
|:--|:---------------------------------------------------------------------|:----------|
|R08|Test the presence of atleast one name server (*basic02.md does the same*)                  |[BASIC02](../Basic-TP/basic02.md)|
|R09|Test the presence of a minimum two name servers                                            |[DELEGATION01](delegation01.md)|
|R10|Verify that the nameservers delegated has distinct IP addresses                            |[DELEGATION02](delegation02.md)|
|R13|Test whether referral response at the authoritative section fit into a 512 byte UDP packet |[DELEGATION03](delegation03.md)|
|R14|Test whether the referrals response at the authoritative and additional section fit into 512 byte UDP packet |[DELEGATION03](delegation03.md)|
|R16|Test whether there is an authoritative response for the nameserver                         |[DELEGATION04](delegation04.md)|
|R18|Test that the NS record is not pointing to a CNAME alias                                   |[DELEGATION05](delegation05.md)|
|R19|Test whether the nameserver can be resolved                                                |[CONNECTIVITY01](../Connectivity-TP/connectivity01.md)|
|R20|Test the existence of SOA record in the zone                                               |[DELEGATION06](delegation06.md)|
|R21|Test whether the ANSWER for SOA is authoritative                                           |[DELEGATION06](delegation06.md)|
|R71|Total mismatch between child and parent NS records, delegation works due to same IP        |[DELEGATION07](delegation07.md)|

