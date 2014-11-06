## CONFIGURATION01: The data for a canonical name and its aliases cannot be
different

### Test case identifier

**CONFIGURATION01:** The data for a canonical name and its aliases cannot be
different

### Objective 
Section 3.6.2 of [RFC 1034](https://tools.ietf.org/html/rfc1034)
mentions that if a CNAME RR is present at a node, no other data should be
present; this ensures that the data for a canonical name and its aliases cannot
be different.  This rule also insures that a cached CNAME can be used without
checking with an authoritative server for other RR types.

The objective of this test is to verify whether the engine conforms to the
specification described above.

### Inputs

The domain to be tested.

### Ordered description of steps to be taken to execute the test case

1. Configure a live zone, wherein the CNAME record coexist with any other data

```
For example (Zone "nic.fr"): 

rd    IN  NS     ns1
      IN  NS     ns2
      IN  CNAME  labs.nic.fr.
labs  IN  A      1.2.3.4
```

```
Another example (Zone "rd.nic.fr"):

      IN  MX    10  mail.rd.nic.fr.
mail  IN  CNAME     labs        
labs  IN  A         1.2.3.4 
```

2. A standard query for the domain is made 
3. If the query don’t receive Error response, the test returns with FAIL

### Outcome(s)

The engine should capture the CNAME collision in a DNS zone as specified in RFC
1034 and return FAIL, if there is a coexistance.

### Results
Current DNS softwares does not allow a zone to be loaded wherein a CNAME coexist
with other RR. The only solution to emulate this behavior is to use an old DNS
software versions or write our own implementation. It has been decided that such
efforts are not necessary at this stage and hence this test is not run.	

