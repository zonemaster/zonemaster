### Name server01 - IS_A_RECURSOR - ERROR

"Nameserver {ns} is a recursor."

For security and performance reasons it is customary to keep the roles of 
authoritative name servers and resolving name servers separate. Having a 
authoritative name server also be a resolver will make it more susceptible
to amplification and service degradation attacks. There is also an
increased attack surface for data integrity (cache poisoning) and data
privacy (cache enumeration). See RFC 5358 for further details.
You can contact your name server operator about the issue.
