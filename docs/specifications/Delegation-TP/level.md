# List of basic DNS tests

This document uses the terminology defined in the [Master Test Plan](../Master%20Test%20Plan.md).

There is [an example implementation of these tests](https://github.com/dotse/new-dnscheck/blob/master/Giraffa/lib/Giraffa/Test/Basic.pm).

## Mapping from Requirements to Test Case

|Req| Description                                                          | Test Case |
|:--|:---------------------------------------------------------------------|:----------|
|R08|Test the presence of atleast one name server |[DELEGATION01](./delegation01.md)|
|R09|Test the presence of a minimum two name servers |[DELEGATION02](./delegation02.md)|
|R10|Verify that the nameservers delegated has distinct IP addresses |[DELEGATION03](./delegation03.md)|
|R13|Test whether the referrals response from the parent zone's name servers does not exceed 512 byte UDP packet |[DELEGATION04](./delegation04.md)|
|R14|Test whether the referrals response from the parent zone's name servers with additional flag does not exceed 512 byte UDP packet |[DELEGATION05](./delegation05.md)|
|R16|Test whether there is an authoritative response for the nameserver |[DELEGATION06](./delegation06.md)|
|R18|Test that the NS resource record is not an alias|[DELEGATION07](./delegation07.md)|
|R19|Test whether the nameserver can be resolved |[DELEGATION08](./delegation08.md)|
|R20|Test the existence of SOA record in the zone |[DELEGATION09](./delegation09.md)|
|R21|Test whether the ANSWER for SOA is authoritative |[DELEGATION010](./delegation10.md)|
