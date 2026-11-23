### Basic02 - B02_NO_DELEGATION - CRITICAL

"There is no delegation (name servers) for \"{domain}\" which means it does "
"not exist as a zone."

(What does this message mean?) The tested domain name is not active in any
sense on Internet. It can still be registered, but it is not in use. But check the
spelling of the name.

(Why is it important to pay attention to this message?) If the domain name is
used for anything (mail, web or other services) those services are not working.

(What can I do about it?) In most cases you should contact your registrar to
find out the status of the domain name. I might be that it has been deactivated
or removed due to non-payment or other issues. If the domain name is not
directly below a top-level domain (such as .com), contact the administrator
of the domain name (or rather DNS zone) just above it.


### Basic02 - B02_NO_WORKING_NS - CRITICAL

"There is no working name server for \"{domain}\" so it is unreachable."

(What does this message mean?) The name servers are needed for the domain
name to be working, and none of the name servers are correctly serving the
domain name. The result is the same as if the domain name is removed.

(Why is it important to pay attention to this message?) If the domain name is
used for anything (mail, web or other services) those services are not working.

(What can I do about it?) Contact the DNS operator for the domain name. If the
domain name is directly under a top-level domain, then the registrar can often
help with this issue.

### Basic02 - B02_UNEXPECTED_RCODE - ERROR

"Name server \"{ns}\" responds with an unexpected RCODE name (\"{rcode}\") on "
"an SOA query."

(What does this message mean?) The name servers are needed for the domain
name to be working, and the given name server does not respond correctly to
queries.

(Why is it important to pay attention to this message?) All name servers for a
domain name are important to give redundancy for the operation of the domain
name.

(What can I do about it?) Contact the DNS operator for the domain name. If the
domain name is directly under a top-level domain, then the registrar can often
help with this issue.
