### Basic02 - B02_NO_DELEGATION - CRITICAL

"There is no delegation (name servers) for \"{domain}\" which means it does "
"not exist as a zone."

DNS delegation, as the name implies, is the process of transferring authority 
for a subdomain (child zone) to a specific set of name servers.
The parent zone contains NS records referring clients to the child's servers. 
If there are no NS records clients cannot locate the child zone in the DNS
tree and any services dependent on the domain name will be unavailable. 
You should contact registrar about the issue.


### Basic02 - B02_NO_WORKING_NS - CRITICAL

"There is no working name server for \"{domain}\" so it is unreachable."

An authoritative name server is the final step in the DNS lookup process,
and holds the actual DNS records for a domain. These servers provide definitive
answers to queries. If the authoritative name servers does not answer queries, 
any services dependent on the domain name will be unavailable. You should 
contact your name server operator about the issue.

### Basic02 - B02_UNEXPECTED_RCODE - ERROR

"Name server \"{ns}\" responds with an unexpected RCODE name (\"{rcode}\") on "
"an SOA query."

DNS return codes are mostly used to indicate what has gone wrong. An RCODE of 
0 (zero), meaning no error, is the expected response. You should contact your 
name server operator about the issue.
