
## Example of request using all options, plus a bit of results
 
```JSON
 {
     "name": "räksmörgås.se",

     "request": {
         "ds": [
             {
                 "keytag": 4711,
                 "algorithm": 5,
                 "type": 2,
                 "digest": "40079DDF8D09E7F10BB248A69B6630478A28EF969DDE399F95BC3B39F8CBACD7"
             },
             {
                 "keytag": 4711,
                 "algorithm": 5,
                 "type": 1,
                 "digest": "EF5D421412A5EAF1230071AFFD4F585E3B2B1A60"
             }             
         ],
         "ns": {
             "ns.nic.se.":  ["212.247.7.228", "2a00:801:f0:53::53"],
             "ns3.nic.se.": ["212.247.8.152", "2a00:801:f0:211::152"]
         },
         "ipv4": true,
         "ipv6": true,
         "lang": "tech",
         "module": "basic",
         "method": "basic01"
     },

     "results": [
         {
             "ulabel": "räksmörgås.se",
             "alabel": "xn--rksmrgs-5wao1o.se",
             "node": "localhost",
             "start_time": 1407493858.48475,
             "end_time": 1407493873.59711,
             "messages": [
                 {
                     "tag": "HAS_NAMESERVERS",
                     "timestamp": 0.451181888580322,
                     "args": {
                         "source": "ns3.nic.se/2a00:801:f0:211::152",
                         "ns": "i.ns.se.,ns.nic.se.,ns3.nic.se."
                     }
                 }
             ]
         }
     ]
 }
```

## Example request using no options

```JSON
{
    "name": "räksmörgås.se",
    "request": {}
}
```

## Sequences (scanning node PoV)

### No competing nodes, or winner PoV

1. Request appears.

2. Scanner adds "results" list with one hash entry. In the hash are the "ulabel", "alabel", "node" and "start_time" entries.

3. Scan is run. Takes anything from one to hundreds of seconds. Check for conflict is done every five seconds or so.

4. "Messages" and "end_time" keys are added to the hash entry in the "results" list.

### Fast-competing node (losing node PoV)

1. Request appears.

2. Scanner adds "results" list with one hash entry. In the hash are the "ulabel", "alabel", "node" and "start_time" entries.

3. Entry is replicated out.

4. Scan starts running.

5. Conflicting entry is replicated in.

6. Regular conflict detection sees the conflict.

7. Scan is terminated.

8. Local copy of request is deleted.