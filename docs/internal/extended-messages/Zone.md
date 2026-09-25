### Zone05 - EXPIRE_MINIMUM_VALUE_LOWER - WARNING

"SOA 'expire' value ({expire}) is less than the recommended one "
"({required_expire})."

The DNS SOA (Start of Authority) expire value determines how long a secondary 
DNS server for a zone can continue serving cached zone data if it is unable
to contact the primary server. This value is typically set between 2–4 weeks 
to accommodate for long outages on the primary server. You can contact your 
name server operator about the issue. 

