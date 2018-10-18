# CDS05: Compare inception time and serial with previous CDS/CDNSKEY

## Test case identifier

**CDS05**

## Objective

To be able to participate on the automation of DNSSEC delegation trust
maintenance ([RFC 7344]), we must ensure that previous versions of the
CDS/CDNSKEY RRset do not overwrite more recent versions. This can be
accomplished by checking that the signature inception in the RRSIG for
CDS/CDNSKEY RRset is later than the previous CDS/CDNSKEY's RRSIG, and
that the serial number on the child's SOA is greater than the SOA
from the previous CDS/CDNSKEY zone (section 6.2).

For reference purposes, [RFC 7344] explains the CDS/CDNSKEY records
requirements, and section 5.1 of [RFC 4034] explains the format
of the DS/DNSKEY format RDATA, from which CDS/CDNSKEY are derived.


## Inputs

* "Child Zone" - The domain name to be tested.
* "Previous inception" - The "inception time" in presentation format
  (section 3.1.5 of [RFC 4034]) from the previous CDS/CDNSKEY's RRSIG
  processed for the domain name.
* "Previous SOA serial" - The serial field of the SOA resource (section
  3.3.13 of [RFC 1035]) from the previous CDS/CDNSKEY processed for
  the domain name.


## Ordered description of steps to be taken to execute the test case

1. Retrieve the CDS and CDNSKEY rrsets from the child zone along with
   their corresponding RRSIGs (DO bit set).

2. If there're no CDS nor CDNSKEY rrsets, output [NO_CDS_CDNSKEY] and
   exit.

3. Compare the inception time from the RRSIGs for the CDS/CDNSKEY
   rrsets (in case of several RRSIGs take the minimal one) with the
   *Previous inception*. If it's less than, output [INCEPTION_ERROR]
   and exit. If it's greater than, output [INCEPTION_OK].

4. Retrieve the SOA record from the child zone and obtain the "serial"
   field.

5. Compare the serial from the current zone with the *Previous SOA
   serial* value. If it's less than, output [SERIAL_ERROR] and exit.
   If it's greater than, output [SERIAL_OK].


## Outcome(s)

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *ERROR* or *CRITICAL*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *WARNING*, but no message with severity level
*ERROR* or *CRITICAL*.

The outcome of this Test case is "pass" in all other cases.

Message          | Default severity level (when message is outputted)
:----------------|:-----------------------------------
NO_CDS_CDNSKEY   | INFO
INCEPTION_ERROR  | ERROR
INCEPTION_OK     | INFO
SERIAL_ERROR     | ERROR
SERIAL_OK        | INFO


## Special procedural requirements	

If either IPv4 or IPv6 transport is disabled, ignore the evaluation of the
result of any test using this transport protocol. Log a message reporting
on the ignored result.

If there's no CDS record in the zone, we consider such absence as a normal
answer.


## Intercase dependencies

None.


[RFC 7344]: https://tools.ietf.org/html/rfc7344
[RFC 4034]: https://tools.ietf.org/html/rfc4034
[RFC 1035]: https://tools.ietf.org/html/rfc1035
[Method4]: ../Methods.md#method-4-obtain-glue-address-records-from-parent
[Method5]: ../Methods.md#method-5-obtain-the-name-server-address-records-from-child

