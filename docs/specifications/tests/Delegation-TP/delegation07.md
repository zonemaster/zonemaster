## DELEGATION07: Parent glue name records present in child

### Test case identifier

**DELEGATION07:** Parent glue name records present in child

### Objective

If the list of name servers for a domain obtained from its parent are not
found in its its child zone, then it leads to an inconsistency (section 2.3
of [RIPE-114](http://www.ripe.net/ripe/docs/ripe-114))

### Inputs

The domain name to be tested.

### Ordered description of steps to be taken to execute the test case

1. Obtain the complete set of name servers from the parent using
   [Method2](../Methods.md) and the child using [Method3](../Methods.md).
3. If the set of NS names obtained from [Method2](../Methods.md) are 
   not found in [Method3](../Methods.md), then the test fails.

### Outcome(s)

If the set of glue name records obtained are found in the list of name
servers obtained from the child also, then the test succeeds

### Special procedural requirements

None

### Intercase dependencies

None

-------

Copyright (c) 2013, 2014, 2015, .SE (The Internet Infrastructure Foundation)  
Copyright (c) 2013, 2014, 2015, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <http://creativecommons.org/licenses/by/4.0/>.
