## CONFIGURATION04: Delegation Inconsistency - Name Server Records 

### Test case identifier

**CONFIGURATION04:** Delegation Inconsistency - Name Server Records

### Objective 

When a parent zone 'P' delegates part of its namespace to a child 'C', P stores
the list of NS records for the authoritative servers of zone 'C'. This list of
NS records are kept both at the parent 'P' and the child zone 'C'. 

Delegation incosistency occurs when changes at the 'C' are not reflected to the NS RRs
at 'P'.

### Inputs

The domain to be tested.

### Ordered description of steps to be taken to execute the test case

1. Configure a live zone with inconsistency in name server records between parent
and child.

```
For example ('P' Zone "nic.fr") : 

rd    IN  NS     ns1
rd    IN  NS     ns2
rd    IN  NS     ns3

In Zone 'C' ("rd.nic.fr"):

      IN  NS     ns1
      IN  NS     ns2

```
2. Obtain the complete set of name servers from the parent using
[Method2](../../tests/Methods.md) and the child using [Method3]
(../../tests/Methods.md).
3. Query for the SOA record.
4. If there is an answer with NOERROR and there is no content in the answer
section, this test case fails.


### Outcome(s)

The engine should return FAIL atleast once for the configuration defined. If it
returns PASS for all the tests then the engine does not capture delegation
inconsistency in name server records.

### Special procedural requirements	

None

### Intercase dependencies

None
