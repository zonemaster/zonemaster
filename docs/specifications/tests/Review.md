The objective of this document is to group in all feedback with respect to
the test specifications.<br/>
When there are multiple authors for the same test case,number them. For
example, if there are two comments for the same test case by different
authors, number the comments as 1. and 2., and in the author column add your
three letter acronym  for example such as 1: PWA and 2: SBA <br/>
Ext - Refers to external review <br/>

| Test   | Category change | Discard | Review/comments                  | Author   |
|:-------|:---------|:--------|:----------------------------------------|:---------|
| [SYNTAX04](Syntax-TP/syntax04.md) | No | No | 1. generalize the validation of names (we have discussed this already) (same comment for 07 & 08)| 1. Ext |
| Zone | No | No | 1. maybe change category name to SOA to make it more clear?| 1. Ext |
| [Zone01](Zone-TP/zone01.md) | No | No | 1. Write and point to a method how the SOA record is retrieved| 1. SBA |
| [Zone01](Zone-TP/zone08.md) | Maybe | No | 1. Maybe move zone 08 & 09 to a new category Mail| 1. SBA |
| Address | No | No | 1. Change names to address0x.md in order to have the same naming for all levels| 1.PWA |
| [Address1](Address-TP/addr01.md) | No | No | 1. Not all netblocks are being tested for. See the PDT_DNS_TC_Delegation.pdf section 11.8 from the ICANN PDT specifications for a complete list. It also lists the RFCs <br/> 2. Follow same pattern as in other tests for referring to RFC | 1.PWA <br/> 2. SBA |
| [Address2](Address-TP/addr02.md) | No | No | 1.a Missing reference <br/> 1.b Shouldn't the answer also include a PTR record? <br/> 1.c Warning or Error is a superflous discussion in here, defer to another document. | 1.PWA |
| [Address3](Address-TP/addr03.md) | No | No | 1. Same issue as addr02 | 1.PWA |
| [Address4](Address-TP/addr04.md) | No | No | 1. More details on exactly what query is sent, and what answer is received - and its evaluation. What are the RCODEs, and what are the DNS packets contents? Cannot parse the first sentence in step 2. | 1.PWA |
| [Address5](Address-TP/addr05.md) | No | No | 1. Missing reference | 1.PWA |
| [Consistency1](Consistency-TP/consistency01.md) | No | No | 1. Missing reference | 1.SBA |
| [Consistency3](Consistency-TP/consistency03.md) | No | yes | 1. Explanation in the test case | 1.SBA |
| [Delegation6](Delegation-TP/delegation06.md) | No | No | 1. 05 & 06 only relevant if it is actually a glue record? | 1.Ext |



