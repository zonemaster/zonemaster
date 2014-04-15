## CONSISTENCY03: The MNAME (i.e. the primary source of data for the zone) field in the SOA RDATA must be consistent between authoritative name servers 

### Test case identifier

**CONSISTENCY03:** The MNAME (i.e. the primary source of data for the zone) field in the SOA RDATA must be consistent between authoritative name servers 

### Reason to discard this test

It is also wrong to assume that it is an error if the domain name in the MNAME is not identical across all content DNS servers for a given "zone". This is because:

In multiple-master database replication schemes where Dynamic DNS update is supported, all of the content DNS servers are peers and are masters. Dynamic DNS update requests may be sent to any of the content DNS servers. Where such database replication schemes are used, therefore, one can find each content DNS server listing itself in the MNAME field of the SOA resource record that it is publishing. This is not a problem. It doesn't matter which SOA resource record a Dynamic DNS update client happens to receive when it performs its SOA lookup. And it doesn't matter that two different update requests might be sent to two different content DNS servers because of this. Every content DNS server is a "master", and capable of processing the update request by updating the DNS database. So the fact that the field content varies, from content DNS server to content DNS server, is insignificant.



### Inputs


### Ordered description of steps to be taken to execute the test case


### Outcome(s)

### Special procedural requirements	


### Intercase dependencies

None
