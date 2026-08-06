### Delegation01 - NOT_ENOUGH_IPV6_NS_DEL - ERROR

"Delegation does not list enough ({count}) nameservers that resolve to IPv6 "
"addresses. Lower limit set to {minimum}. Name servers: {ns_list}"

To ensure that a zone is available, in spite of communication disruptions on a 
host and/or network level, it should be served from at least two separate name 
servers. Furthermore, these name servers should be able to serve the zone over
IPv6 as well as IPv4. You should contact your registrar and/or name server 
operator about the issue.


### Delegation01 - NOT_ENOUGH_IPV6_NS_CHILD - ERROR

"Child does not list enough ({count}) nameservers that resolve to IPv6 "
"addresses. Lower limit set to {minimum}. Name servers: {ns_list}"

To ensure that a zone is available, in spite of communication disruptions on a 
host and/or network level, it should be served from at least two separate name 
servers. Furthermore, these name servers should be able to serve the zone over
IPv6 as well as IPv4. You should contact your registrar and/or name server 
operator about the issue.


### Delegation02 - DEL_NS_SAME_IP - ERROR

"IP {ns_ip} in parent refers to multiple nameservers ({nsname_list})."

To ensure that a zone is available, in spite of communication disruptions on a 
host and/or network level, it should be served from at least two separate name 
servers. Having two or more name servers with separate names but sharing an IP 
address does not satisfy this criteria. You should contact your name server 
operator about the issue.


### Delegation07 - EXTRA_NAME_PARENT - ERROR

"Parent has nameserver(s) not listed at the child ({extra})."

If the parent zone lists a name server in the delegation NS set that is not
present in the child zone NS set, some queries may be directed to a name
server that is no longer an authoritative name server for the domain, or 
that exists (lame delegation). The NS sets of delegation and authoritative 
name server should be in sync. You should contact your registrar and/or 
name server operator about the issue.
