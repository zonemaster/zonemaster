### Address02 - NAMESERVER_IP_WITHOUT_REVERSE - WARNING

"Nameserver {nsname} has an IP address ({ns_ip}) without PTR configured."

(What does this message mean?) Reverse records (PTR) is a way to indicate what an IP
address is used for, by mapping the name to it. In this case there is no such name
mapping to the IP address of one of the name servers of the domain name.

(Why is it important to pay attention to this message?) Having a reverse record for the
name servers IP address lends them legitimacy and it is recommended for name servers
to have one. It makes operation easier.

(What can I do about it?) You can contact your name server operator about the issue.  
