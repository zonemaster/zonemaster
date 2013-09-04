# Testing Library

This is the central part of the whole system, that actually performs DNS tests and evaluates the results.

Conceptually, the library is divided into three layers: objects that model the underlying DNS reality we're looking at, objects that look at the DNS information, perform tests on it and evaluate the results, and finally structural objects needed for the first two layers to work.

A certain amount of global state is kept (in order to make sure the zone and nameserver object caches are complete). If more than one test is run in the same process, it may or may not be desirable to clear the cache between tests.

## DNS-Modeling Layer

This layer has two main types of objects.

### Zone Object

A zone is identified by its name. In a running program, there is always at most one object for every zone. A zone object contains, among other things, pointers to its parent zone, its authoritative nameservers (as listed by those nameservers themselves), the nameserves listed for it in the parent zone, and the glue address records the parent zone holds for it.

### Nameserver Object

A nameserver is identified by its name and IP address, and like for zone objects there will only be one object for each such pair. All DNS queries made by the program go through a nameserver object, and the object will cache the response to every unique query, in order to minimize the number of queries sent in total (this caching may be made by IP address alone).

## Testing Layer

This layer holds the main entry point to the testing system, where as the most basic case one can enter a domain name and run all available tests. There is a top-level object for every test run, holding information such as the times when the test was started and ended, as well as the results of all performed tests.

The function of the top-level testing object is:

1. To create the zone object for the zone to be tested.
2. To perform basic tests on the zone to determine if it is possible to perform more complex tests (basically checking that the zone exists and has nameservers).
3. Load all available test modules.
4. Run requested tests in the loaded modules (by default, all tests in all modules).

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