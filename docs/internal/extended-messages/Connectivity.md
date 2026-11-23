### Connectivity02 - CN02_NO_RESPONSE_TCP - WARNING

"Nameserver {ns} does not respond to any queries over TCP."

(What does this message mean?) All name servers communicate of the two
communicate protocols UDP and TCP. Both are needed for robust operation.
In this case one of the name servers for the domain name does not support
TCP.

(Why is it important to pay attention to this message?) Failing to communicate
over TCP can give degraded operation of the name server and thereby the
operation of the domain name.

(What can I do about it?) Contact the DNS operator for the domain name. If the
domain name is directly under a top-level domain, then the registrar can often
help with this issue.


### Connectivity02 - CN02_NO_RESPONSE_NS_QUERY_TCP - WARNING

"Nameserver {ns} does not respond to NS queries over TCP."

Name servers will use a lightweight protocol ( usually UDP ) whenever they 
can. However, for large responses, zone transfers, DoT (DNS over TLS) and as 
a fallback when unavailable over UDP, they will switch to using TCP. If the
name server is unavailable over TCP, it may in some cases affect its ability
to answer queries. All name servers should therefore be reachable both over
TCP and UDP. You can contact your name server operator about the issue.
