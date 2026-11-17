### DNSSEC03 - DS03_ILLEGAL_SALT_LENGTH - WARNING

"The following servers respond with a non-empty salt in NSEC3 ({int} octets). "
"The recommended practice is to use an empty salt. Fetched from name servers "
"\"{ns_list}\"."

Salt is random data used by hashing algorithms to increase protection against
attacks using pre-computed data. DNS-data by its nature already has a random
element to it considered sufficient to render additional salt unnecessary.
As of RFC 9276 the use of salt has been deprecated. Contact your namer server
operator about this issue.


### DNSSEC03 - DS03_ILLEGAL_ITERATION_VALUE - WARNING

"The following servers respond with the NSEC3 iteration value {int}. The "
"recommended practice is to set this value to 0. Fetched from name servers "
"\"{ns_list}\"."

The iteration value determines how many times the name for NSEC3 record should
be run through the hashing algorithm. The first iteration typically provides a
good enough protection. Repeated hashing increases the load on resolvers while
offering next to no benefit. Using values other then 0 has been deprecated as
of RFC 9276. You can contact your name server operator about the issue.


### DNSSEC07 - DS07_NOT_SIGNED - WARNING

"The zone is not signed."

Domains can be signed (DNSSEC) to protect users against manipulated translation
to rogue internet addresses. An attacker could secretly manipulate the IP 
address and divert e-mails addressed to you to their own mail server. To 
protect your domain against this type of attack, you can contact your name
server operator and/or your registrar about enabling DNSSEC.


### DNSSEC07 - DS07_NOT_SIGNED_ON_SERVER - WARNING

"The following name servers respond with no DNSKEY (unsigned child zone). "
"Name servers: \"{ns_list}\"."

A signed zone requires that the authoritative name servers have a DNSKEY rrset
published. This key is used to verify the signatures for all other rrsets. 
All authoritative name servers for the domain need to have the same DNSKEY 
rrset published. If one or more name servers publishes different keys, or 
no keys at all, it may cause problems resolving the domain. Contact your 
name server operator about the issue.

 
### DNSSEC07 - DS07_NO_DS_ON_PARENT_SERVER - WARNING

"The following parent name servers respond without DS record for the child "
"zone. Name servers: \"{ns_list}\"."

DS (Delegation Signer) is a resource record in the parent zone of the domain.
It contains a hash of the DNSKEY (KSK/CSK) used as secure entry point for the
domain, which is a part of the chain of trust. If one or more name servers
for the parent zone does not have a valid DS published, it may cause problems
resolving the domain. Contact your registrar and/or name server operator about 
the issue.


### DNSSEC07 - DS07_NO_DS_FOR_SIGNED_ZONE - WARNING

"The parent zone has no DS record for the signed child zone."

DS (Delegation Signer) is a resource record in the parent zone of the domain.
It contains a hash of the DNSKEY (KSK/CSK) used as secure entry point for the
domain, which is a part of the chain of trust. To get the protection DNSSEC 
offers, a correct DS record has to be published in the parent zone. You can 
contact your name server operator and/or your registrar about publishing a DS 
record.


### DNSSEC14 - DNSKEY_SMALLER_THAN_REC - WARNING

"DNSKEY with tag {keytag} and using algorithm {algo_num} ({algo_descr}) has a "
"size ({keysize}) smaller than the recommended one ({keysizerec})."

The size of a DNSKEY affects how secure it is. The impact of key size varies
with different algorithms. DNSKEYs based on RSA have a recommended minimum,
as well as maximum key size. To small size will make it less secure and too
large may negatively affect performance. You can contact your name server
operator about the issue.
