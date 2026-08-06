### Connectivity02 - CN02_NO_RESPONSE_TCP - WARNING

"Nameserver {ns} does not respond to any queries over TCP."

Name servers will use a lightweight protocol ( usually UDP ) whenever they 
can. However, for large responses, zone transfers, DoT (DNS over TLS) and as 
a fallback when unavailable over UDP, they will switch to using TCP. If the
name server is unavailable over TCP, it may in some cases affect its ability
to answer queries. All name servers should therefore be reachable both over
TCP and UDP. You can contact your name server operator about the issue.


### Connectivity02 - CN02_NO_RESPONSE_NS_QUERY_TCP - WARNING

"Nameserver {ns} does not respond to NS queries over TCP."

Name servers will use a lightweight protocol ( usually UDP ) whenever they 
can. However, for large responses, zone transfers, DoT (DNS over TLS) and as 
a fallback when unavailable over UDP, they will switch to using TCP. If the
name server is unavailable over TCP, it may in some cases affect its ability
to answer queries. All name servers should therefore be reachable both over
TCP and UDP. You can contact your name server operator about the issue.
