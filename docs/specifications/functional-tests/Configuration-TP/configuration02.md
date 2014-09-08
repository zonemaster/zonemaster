## CONFIGURATION02: Cyclic Zone Dependency
different

### Test case identifier

**CONFIGURATION02:** Cyclic Zone Dependency

### Objective 
A cyclic zone dependency happens when two or more zones DNS service depends on
each other in a circular way. This scenario is possible due to configuration
errors in either or both of the zones, however in some cases it is also possible
when none of the involved zones has any noticeable configuration error. Thus the
combination of two or more correctly configured zones may also result in cyclic
zone dependency.

The objective here is to verify whether the engine idenitifes such dependency.


### Inputs

The domain to be tested.

### Ordered description of steps to be taken to execute the test case

1. Configure a live zone in such a manner wherein a partial failure may stop
accessing the domain

```
For example (Zone "nic.fr") (with missing glue A RR): 

      IN  NS     ns1
      IN  NS     ns2
      IN  NS     ns3
ns1   IN  A      1.2.3.4
ns2   IN  A      1.2.3.5
```
```
Another example with two zones depending on each other

(Zone "nic.fr"):
      IN  NS     ns1
      IN  NS     ns2
      IN  NS     dns1.nic.com.
      IN  NS     dns2.nic.com.
ns1   IN  A      1.2.3.4
ns2   IN  A      1.2.3.5

(Zone "nic.com")
      IN  NS    ns1.nic.fr.
      IN  NS    ns2.nic.fr.
```
2. A standard query for the domain is made 
3. ToDo : How to test it? 

### Outcome(s)

ToDo

### Special procedural requirements	

None

### Intercase dependencies

None
