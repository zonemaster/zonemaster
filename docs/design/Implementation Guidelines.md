# Guidelines to implementing tests with Giraffa

Giraffa is a Perl framework meant to aid the implementation of DNS tests. The design of the framework is based primarily on .SE's experiences with the DNSCheck tool and the top-level-domain Pre-Delegation Testing platform. This document aims to present the rationales for the various design decisions in Giraffa.

## Goals of the system as a whole

All design decisions are intended to contribute toward one or more of a number of overall goals. These are, in rough order of descending importance:

1. Correctness

First and foremost, the results produced by tests must be _correct_. By correct here we mean that they accurately implement the specification for a given test, and that they can be verified to do so by a competent observer.

2. Predictability

Given an identical view of the outside world, the test must always give the exact same result. There must be nothing random or arbitrary in the implementation (or the specification).

3. Transparency

We should be able to tell after the fact why a test produced the result it did. It is acceptable for this to require re-running a test with settings that record more detailed (and thus voluminous) information, but in the extreme case it should be possible to go back and look at the details of every single incoming DNS packet in order to figure out why something strange happened.

4. Modifiability

We should be able to modify the test's view of the outside world. The must common use for this is to test zones that have not yet been delegated from their intended parents.

## Looking at Giraffa with the goals in mind

In the Giraffa framework, tests are implemented in plugin modules. These modules must have a method called `all`, which takes a _zone object_ as its single argument. This object represents the entire outside world for the tests. Test code must never communicate with the outside world (like for example nameservers) except via the methods in the zone object.

### The zone object is the world

By forcing all communication to pass through a single chokepoint, we serve all of the goals listed above. For example, the `query_one` method makes sure to always send queries to the same child-side server (the first one in lexicographic order by stringified name). The query methods also have the ability to transparently store incoming packets for future inspection, and it will have the ability to answer queries with pre-loaded information instead of sending them out into the world. And by having all this functionality hidden away in another object, the test code itself can be written in a more straightforward way, which in turn makes it easier to determine if it is correct.

### Giraffa packet and record objects have helpers

The less code there is, the easier it is to determine if it actually does what it should. When writing DNS tests, there are certain actions that come up often. In order to reduce the amount of code implementing the tests themselves, we extract such actions into helper methods in the objects representing DNS packets and (possibly in the future) resource records.

The intention is that as often occuring patterns are found, they will be extracted out into surrounding objects. As a rule of thumb, I'd suggest that once a certain structure has been needed in three or more places, extracting it out should be considered.

(to be continued)