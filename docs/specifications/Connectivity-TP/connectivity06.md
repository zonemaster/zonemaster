## CONNECTIVITY06: All IP addresses of the domain's authoritative name server should not be part of same AS


### Test case identifier

**CONNECTIVITY06:** All IP addresses of the domain's authoritative name server should not be part of same AS 

### Objective
[RFC 2182](http://tools.ietf.org/html/rfc2182), section 3.1 clearly specifies that distinct authoritative name servers for a child domain should be placed in different topological and geographical locations. The objective is to minimise the likelihood of a single failure disabling all of them. 

The objective in this test is to check that all IP addresses of the domain's authoritative name servers does not belong to the same AS


### Inputs

1. The domain name to be tested

### Ordered description of steps to be taken to execute the test case

1. Find the list of all the name servers used by the domain. This list MUST contain all name servers from the parent delegation for the domain, and all name servers in the apex of the domain's zone itself
2. Find the IP addresses corresponding to the name servers in step1. In order to do that: <br/>
2.1. Collect all glue records from the parent for the domain <br/>
2.2. Collect all IP addresses of the name servers, authoritative for the domain from the domain's zone (i.e. the domain being tested) <br/>
2.3. Collect all the IP addresses used by out-of-bailwick name servers <br/>
3. Make the AS (name) list for each IP address obtained from step2
4. If all the retrieved AS (obtained from step3) are same, then the test fails

### Outcome(s)

If there is a AS which is different from the other retrieved AS, then the test succeeds

### Special procedural requirements

None

### Intercase dependencies

None
