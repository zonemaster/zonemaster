## BASIC01: The domain must have a parent domain

### Test case identifier
**BASIC01** The domain must have a parent domain

### Objective

In order for a domain to work, it must be delegated to from a domain higher
up in the DNS hierarchy (a pernt domain). However, note that this
requirement does not concern the root domain.

### Inputs

The label of the domain name to be tested.

### Ordered description of steps to be taken to execute the test case

A recursive NS-record lookup for the child domain name starting at the
root domain should be done, and the steps of the process recorded.

1. If the recursion reaches a name server that responds with a redirect
   directly to the requested domain, including functional glue, the test
   succeeds. The domain through which the name server was found is
   considered the parent domain.
2. If the recursion reaches a name server that authoritatively responds
   with NXDOMAIN for the child domain, the test succeeds. The domain
   through which the name server was found is considered the parent domain.
3. If the recursion reaches a point where the recursion for some reason
   cannot continue before either case 1 or 2 happens, the test fails. 

### Outcome(s)

If the recursive lookup of the domain is successful, this test cases passes.
If the cannot continue (step 3), this test case fails.

### Special procedural requirements

If this test fails, it's impossible to continue and the whole testing process
is aborted.

### Intercase dependencies

None.
