# Testing Library

This is the central part of the whole system, that actually performs DNS tests and evaluates the results.

Conceptually, the library is divided into three layers: objects that model the underlying DNS reality we're looking at, objects that look at the DNS information, perform tests on it and evaluate the results, and finally structural objects needed for the first two layers to work.

A certain amount of global state is kept (in order to make sure the zone and nameserver object caches are complete). If more than one test is run in the same process, it may or may not be desirable to clear the cache between tests.

## Design Goals

Our experience with earlier designs of tools for testing and verification of DNS leads us to consider the following attributes important in such a system.

1. Accuracy

    The results reported by a testing tool must accurately reflect the reality the tool sees. This may at times make reported results difficult to interpret, and it is tempting to have the system do automated interpretation. It is useful to have a layer that helps a non-technical users understand what is being reported, but such a layer must be a high level and it must be possible for an expert user to get an unfiltered view of the results. For the results to be consistently accurate, it is also important that the tests be well defined and the software well tested.

2. Repeatability

    To the largest extent possible, immediately successive probes of the same target should give the same results. Perfect repeatability cannot be achieved since the reality of the Internet is complex and changes constantly, but no randomness or unpredictability should be added by the testing tool itself.

3. Traceability

    It must be possible to tell exactly what sequence of DNS responses led to a certain result being reported by the tool. The ingenuity of humans is endless, and there will always be excentric, unusual and/or faulty configurations and servers out there that we haven't seen before. When we encounter a new thing for the first time, it should be possible to examine it in detail.

Notably *not* on this list is performance. It is of course important that tests be executed as quickly as possible, but speed must not come at the cost of any of the listed characteristics. Experience also tells us that DNS testing software spends the vast majority of its time waiting for responses from nameservers, and that thus the most useful thing we can do to speed tests up is to reduce the number of questions we send to the absolute minimum. Which, conveniently enough, usually also helps make the results accurate, repeatable and traceable.

## DNS-Modeling Layer

This layer has two main types of objects.

### Zone Object

A zone is identified by its name. In a running program, there is always at most one object for every zone. A zone object contains, among other things, pointers to its parent zone, its authoritative nameservers (as listed by those nameservers themselves), the nameserves listed for it in the parent zone, and the glue address records the parent zone holds for it.

### Nameserver Object

A nameserver is identified by its name and IP address, and like for zone objects there will only be one object for each such pair. All DNS queries made by the program go through a nameserver object, and the object will cache the response to every unique query, in order to minimize the number of queries sent in total (this caching may be made by IP address alone).

## Testing Layer

This layer holds the main entry point to the testing system, where as the most basic case one can enter a domain name and run all available tests. There is a single top-level object for every complete set of tests run, holding information such as the times when the test was started and ended, as well as the results of all performed subtests.

The function of the top-level testing object is:

1. To create the zone object for the zone to be tested.
2. To perform basic tests on the zone to determine if it is possible to perform more complex tests (basically checking that the zone exists and has nameservers).
3. Load all available test modules.
4. Run requested tests in the loaded modules (by default, all tests in all modules).
5. Provide a way for tests in one loaded module to execute tests in other modules if they're available.

The tests themselves are, as indicated above, implemented as plugin modules. The modules must provide some specified methods, providing metadata about their function as well as the ability to have tests executed and their results returned.

## Structural Layer

### DNS Recursor Object

We have our own recursor in order to be able to observe and manipulate the recursion process. The main thing we want to be able to do is to see which domain delegates directly to the zone being tested, and to be able to perform tests on domains which are not yet published into the global DNS tree (undelegated tests).

### Log Entry Object

Object used to record atomic pieces of information from tests.

### Logger Object

Object used to collect Log Entry Objects from a test run, assign severity levels to single Log Entry Objects and translate them into human-readable text in various languages.

### Configuration Object

Read configuration from suitable sources and make it available to the rest of the system.

### Information Object

An object through which a user can read meta-information about the system. This should include (but not necessarily be limited to) information on which tests are available, which messages can be emitted, which translations are available and the message-to-severity mapping policy in effect.