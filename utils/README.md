# Description of help utilities

## testcase.pl

This tool extracts all implemented test cases and prints the header of
each.

Example use:

```
./testcase.pl -d ../docs/specifications/tests/
Level Zone-TP
## ZONE07: SOA master is not an alias
## ZONE06: SOA 'minimum' maximum value
## ZONE03: SOA 'retry' lower than 'refresh'
## ZONE01: Fully qualified master nameserver in SOA
## ZONE02: SOA 'refresh' minimum value
...
```

## maprequirement.pl

This tools creates a map between the Zonemaster requirements and
implemented test case. It is used in the Makefile in
docs/specifications/tests to create the [Report](https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/Report.md)
on implemented test requirements.


## maptestmessages.pl

This tools creates a map between the Zonemaster log message
identifiers and the test specification that implements the test code
for that message. Also used in the Makefile in
docs/specifications/tests to create the [TestMessages.md](https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/TestMessages.md)
file.


## ztester.sh

A simple tool to test all the TLDs using zonemaster. It creates
a directory "results" that have the JSON result for each TLD.
There are better ways to do this.
