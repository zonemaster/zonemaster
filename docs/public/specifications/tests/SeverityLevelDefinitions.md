# Severity Level Definitions

The following severity levels are defined to be assigned to test result messages, one
at a time, and below it is specified what they intend to mean.

* CRITICAL
* ERROR
* WARNING
* NOTICE
* INFO
* DEBUG
* DEBUG2
* DEBUG3


## CRITICAL

A result at level CRITICAL means that the zone being tested has one or more problems
that are so severe that it is not possible to even test it. Examples can be that the
name requested is not syntactically possible, that it's situated under a domain that
does not exist, or that none of its nameservers are responding.
    
A zone with one or more CRITICAL errors can reasonably be said not to exist.


## ERROR

A result at level ERROR means a problem that is very likely (or possibly certain) to
negatively affect the function of the zone being tested, but not so severe that the
entire zone becomes unresolvable. Examples of ERROR level problems are nameservers
that do not respond to queries over TCP, only having a single nameserver and using a
reserved algorithm for DNSKEY records.


## WARNING

A result at level WARNING means something that will under some circumstances be a
problem, but that is unlikely to be noticed by a casual user. Problems at this level
may be an extra nameserver listed at the parent side, or unsuitable time values in a
SOA record.


## NOTICE

A result at level NOTICE means something that should be known by the zone's
administrator but that need not necessarily be a problem at all. An example of this
can be that different name servers for the zone reports slightly different SOA serial
numbers, which is a perfectly natural consequence of propagation delays but that the
admin should be aware of.


## INFO

A result at level INFO is something that may be of interest to the zone's administrator
but that definitely does not indicate a problem. Examples of this can be name server
software versions, the fact that the zone uses DNSCurve encryption or that a name server
does not recurse.


## DEBUG

Results at level DEBUG are related to the zone being tested, but not normally of
interest to anyone. Implementors of tests are encouraged to be generous with the
production of these messages. Examples can be that a test section started running, that
an ordinary action performed as expected or that a value was inside its normal range.


## DEBUG2

Results at level DEBUG2 are produced by the testing framework itself, and are intended
to only be displayed when trying to identify and diagnose unusual and hard to understand
problems in a zone. This level includes at least one line of information for every DNS
query sent and response received.


## DEBUG3

Results at level DEBUG3 have all the same attributes as those for DEBUG2, and are
even more voluminous. At this level, full string representations of all received
DNS packets will be included. At the time of writing, a test run for the same domain
produces about fifty times as much output on level DEBUG3 as it does on level DEBUG
and a thousand times as much as on the default NOTICE level.
