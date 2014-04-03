The objective of this document is to group in all feedback with respect to
the test specifications.<br/>
When there are multiple authors for the same test case,number them. For
example, if there are two comments for the same test case by different
authors, number the comments as 1. and 2., and in the author column add your
three letter acronym  for example such as 1: PWA and 2: SBA <br/>
Ext - Refers to external review <br/>

| Test   | Category change | Discard | Review/comments                    | Author |
|:-------|:---------|:--------|:------------------------------------------|:-------|
| [BASIC01](Basic-TP/basic01.md) |   No     |   No    | 1. Refer to "Method 1" <br/> 2. step 2 is not clear enough, please update. | 1. SBA <br/> 2. Ext |
| [BASIC02](Basic-TP/basic02.md) | No | No | 1. Better to have the input as domain name. Retrieval of the name servers and the IP address moved to the section "ordered description" and referred to the methods <br/> 2. Step 2 failure explicitly refferd as "SERVFAIL"  | 1. SBA <br/> 2. Ext | 
| [BASIC03](Basic-TP/basic03.md) | No | No | 1. Similar to the comments in BASIC02 <br/> 2. Rational behind the test  | 1. SBA <br/> 2. Ext |    
| Nameserver | No | No | 1. Modify all test cases from ns* -> nameserver*  | 1. SBA |
| [NS01](Nameserver-TP/ns01.md) | No | No | 1.a Reference to an RFC or another accepted document <br/> 1.b Write a method to retrieve the names of al name servers <br/> 1.c Why DNSSEC flags set for this test <br/> 2.  might want to split this between looking at a referral to the root zone with tests that looks for any referrals. create a new test case? | 1. SBA <br/> 2. Ext |
| [NS02](Nameserver-TP/ns02.md) | No | No | 1. fail or warn? there might be necessary to test more EDNS things. EDNS should be in the answer. | 1. Ext |
| [NS03](Nameserver-TP/ns03.md) | No | No | 1.  policy issue - fail is not an ERROR - we should have an explicit policy discussion in the Master Test Plan to explain the difference between pass and fail, with any error message levels that comes from a policy defining the error levels. This should probably also be part of the Master Test Plan or somewhere else in the document structure. | 1. Ext |
| [SYNTAX01](Syntax-TP/syntax01.md) | No | No | 1. Step 2 in "Ordered description" -> IDNs <br/> 2. symbols - is this correct terminology? | 1. SBA <br/> 2. Ext |
| [SYNTAX04](Syntax-TP/syntax04.md) | No | No | 1. generalize the validation of names (we have discussed this already) (same comment for 07 & 08)| 1. Ext |
| Zone | No | No | 1. maybe change category name to SOA to make it more clear?| 1. Ext |
| [Zone01](Zone-TP/zone01.md) | No | No | 1. Write and point to a method how the SOA record is retrieved| 1. SBA |
| [Zone01](Zone-TP/zone08.md) | Maybe | No | 1. Maybe move zone 08 & 09 to a new category Mail| 1. SBA |




