# Specification of the ZoneMaster  JSON output

The JSON output format in all the ZoneMaster applications is generated
by the ZoneMaster Engine. [... is there a developer reference that can
be referred to here?]

The output format is simple, it is an array consisting of a number of
hashes:

    [
     {
       "tag" : "TEST_CASE_TAG",
       "timestamp" : 6.35820984840393,
       "module" : "TEST-MODULE",
       "level" : "MESSAGELEVEL",
       "args" : {
          "ns" : "nameserver.tld",
          "address" : "127.0.0.1"
       }
     },
	 {...}
    ]

The tag key is used for identifiyin each individual message in a
test level, and the level is the unique identifier. Both can be
used in a pair to have a unique identifier of the message, like
this: `MODULE:TEST_CASE_TAG`. This also maps into a
translation for plain English or other languages.

The level key contains the result from the output as one of these
values:

 * CRITICAL
 * ERROR
 * WARNING
 * NOTICE
 * INFO
 * DEBUG
 * DEBUG2
 * DEBUG3

The amount of information included in the output depends on what
level of reporting was wanted from the user. The DEBUG3 option
will include too much information.

The timestamp value is the number of seconds since the test was
initiated.

The args key contains all the arguments to the test as another set of
key-values.
