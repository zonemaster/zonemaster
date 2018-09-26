# CONSISTENCY07: CDS record consistency

## Test case identifier

**CONSISTENCY07**

## Objective

To be able to participate on the automation of DNSSEC delegation trust
maintenance ([RFC 7344]), a zone must have the same CDS record content
between all the authoritative servers.

The objective of this test is to verify that the CDS record RDATA value
is consistent between different authoritative name servers.

For reference purposes, [RFC 7344] explains the CDS record and consistency 
requirements, and section 5.1 of [RFC 4034] explains the format
of the DS format RDATA, from which CDS is derived.

>
> Should test for CDNSKEY be included in this Test Case?
> If so, should verification that CDS and CDNSKEY match be included here
> or in another Test Case?
> Should it be verified that the CDS record set is signed as specified
> in section 4.1 in the RFC be included, here or in another Test Case?
>

## Inputs

* "Child Zone" - The domain name to be tested.

## Ordered description of steps to be taken to execute the test case

1. Obtain the set of name server IP addresses for *Child Zone* using 
   [Method4] and [Method5] ("Name Server IP").

3. Create a CDS query for the apex of the *Child Zone* with the RD
   flag unset.

4. Create an empty, ordered list of unique CDS record sets, 
   "CDS List". Each set is represented by a unique identifier.

5. Create an empty set of pairs of name server IP and set of CDS, 
   "Name Server CDS".

6. Create an empty set of name servers IPs without CDS, "Name Servers 
   With No CDS".

7. For each *Name Server IP* do:

     1. Send the CDS query to the name server using TCP.

     2. If there is no DNS response from the server then
        output *[NO_RESPONSE]*.
     3. Or, if the RCODE is not NOERROR then output 
        *[NO_RESPONSE_CDS_QUERY]*.
     4. Or, if the answer section is empty or the answer section contains
        a DNAME record, then add the IP to *Name Servers With No CDS*.
     5. Or, if the answer section contains a CDS RR set, then
        1. Add the set of CDS RRs to *CDS List* unless it is already present
           in the list.
        2. Retrieve the identifer of the CDS RR set from *Name Server CDS*
           that this name server returned.

8. If *Name Server CDS* is empty (no name server reports CDS) and
   *Name Servers With No CDS* is non-empty then output *[NO_CDS]*.

9. Or, if both *Name Server CDS* and *Name Servers With No CDS* then
   output *[MISSING_CDS]* with the IPs from *Name Servers With No CDS*.

10. If the number of sets in *CDS List* is exactly one, then output
    *[ONE_CDS_RRSET]*.

11. If the number of sets in *CDS List* is greater than one, then output
    *[MULTIPLE_CDS_RRSET]*.

> The RFC does not require TCP. Should this Test Case use TCP? UDP is used
> in the Test Cases unless there is a reason for TCP.


## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

The outcome of this Test case is "pass" in all other cases.

Message                           | Default severity level (when message is outputted)
:---------------------------------|:-----------------------------------
NO_RESPONSE                       | WARNING
NO_RESPONSE_CDS_QUERY             | WARNING
NO_CDS                            | INFO
MISSING_CDS                       | WARNING
ONE_CDS_RRSET                     | INFO
MULTIPLE_CDS_RRSETS               | WARNING


## Special procedural requirements	

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
on the ignored result.

If there's no CDS record in the zone, we consider such absence as a normal
answer, so it should be consistent between all the authoritative
nameservers to pass the test.

When bootstraping a new CDS key for setting up a DNSSEC delegation for
the first time, there's a need to have extra security defenses against
UDP injection attacks. Therefore, the transport for the query should be
forced to TCP. If there's no TCP response from any nameserver, the test
should fail.

> There is no requirement or recommendation of using TCP. The standard alone
> is not meant for bootstrapping DS at parent.

## Intercase dependencies

None

[RFC 7344]: https://tools.ietf.org/html/rfc7344
[RFC 4034]: https://tools.ietf.org/html/rfc4034
[Method4]: ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]: ../Methods.md#method-5-obtain-the-name-server-address-records-from-child




