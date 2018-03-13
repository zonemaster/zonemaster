# Algorithms

These are attempts to describe a handful of algorithms that are used by a lot of DNSCheck tests. Since the descriptions are reverse-engineered from the code, the descriptions may sometimes be vagues and/or not match what was originally intended.

## Finding the parent zone

This algorithm is used at least up to DNSCheck version 1.2.5. An alternate algorithm exists as a branch, and will probably be merged into the main branch in the future, that works by keeping track of the steps taken while recursing down from the root to the given zone.

### Find a SOA record for a name

This sub-algorithm is used repeatedly by the larger algorithm, so we descibe it separately.

1. A global recursive SOA query is made for the name being asked for.

2. If no response packet is recieved, the undefined value is returned.

3. Iterate over all records in the Answer section of the return packet. If the record is a SOA record, return its name field. If the record is a CNAME record, return the name being asked for.

4. Iterate over all records in the Authority section. If one is a SOA record, return its name field.

5. Return the undefined value.

### Find parent for a zone name

1. Execute the SOA-finding algorithm for the zone name. If no name is returned by it, return the undefined value.

2. Generate a shorter name by removing the leftmost label.

3. Execute the SOA-finding algorithm for the shortened name. If a name is returned and it is the same as the shortened name, return the shortened name as being the name of the parent zone. If no name is returned, or the name that is returned is not the same as the shortened name, remove another label and try again.

4. If the final label of the original name is removed and there still is no equality, return the root zone name (".").

## Querying the parent-side servers

1. Find the parent zone, using the above alorithm. Fail if no parent is found.

2. Initialize nameservers for the zone found.

   1. Do a global recursive NS query for the zone name.
  
   2. For every NS record in the Answer section of the response, add the nameserver name to the cached list of nameservers for the zone name.
  
   3. For every cached name, sorted in standard lexicographic order, so global recursive A and AAAA queries. For all A and AAAA records in the Answer sections of the responses, add the addresses to the cache in hash-key order (that is, essentially random order). 

3. Get nameservers IPv4

   1. Initialize nameservers for the zone found
  
   2. Return nameserver addresses from cache

4. Get nameservers IPv6

   1. Initialize nameservers for the zone found
  
   2. Return nameserver addresses from cache.

5. Randomize the order of the combined list of addresses.

6. Send the query.

   1. Go through the servers in the given order. Send the given query to each one.
  
   2. If there is no response due to a timeout, increase a counter. If there is an answer and it does not have rcode SERVFAIL, exit the loop.
  
   3. Outside the loop, no matter if it exited due to a response or ran out of servers, if the timeout counter is larger than zero, log a DNS timeout message.
  
   4. Return the response (or undef if there wasn't one) to the caller.

## Querying the child-side servers

This works exactly the same as for the parent side, except the zone name itself is used instead of the parent zone name.
