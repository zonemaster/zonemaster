# SYSTEM messages

## Current status

This report is based on the current develop branch ([80773bc]) at the time of
writing. 42 system messages have been found in either profiles.json or in the
code. The messages can be devided into the following groups

* 3 message tag not used
  * Should just be removed.

* 1 message tag has a message ID that is not a msgid but an argument
  * Should be turned into a normal message.

* 16 message tags have message ID and consistent arguments
  * Should these be defined in a document or database in
    Zonemaster/Zonemaster and maintained as the test case messages?
    
* 3 message tags have message ID, but consistent arguments
  * Arguments should be consistent between msgid and output.
  * Should these be defined in a document or database in
    Zonemaster/Zonemaster and maintained as the test case messages?

* 19 message tags have no msgid.
  * Should these be defined in the same way as other messages, or should they
    maintained directly in the code as today?
    
In all groups there is a consistency how the messages are outputted. Most
messages are outputted through method `info()`, but many of the system messages
are outputted through method `add()`. It should be consistent.


### Messages tag not used (3)

Message Tag                   | Level in profile| Message ID for message tag                                           | Defined | Comments
:-----------------------------|:----------------|:---------------------------------------------------------------------|---------|:--------
NS_FETCHED                    | DEBUG3          | -                                                                    | -       | Handled in [PR 1142]
PROFILE_FILE                  | INFO            | -                                                                    | -       | Handled in [PR 1142]
QUERY                         | DEBUG2          | -                                                                    | -       | Handled in [PR 1142]


### Message is not msgid, but an argument (1)

Method `add()` is used to output the message, not the common method `info()`.

Message Tag                   | Level in profile  | Message (ín an argument, not as msgid)                                        | Defined        | Used          
:-----------------------------|:------------------|:------------------------------------------------------------------------------|----------------|---------------
IS_BLACKLISTED                | DEBUG             | Server transport has been blacklisted due to previous failure                 | -              | Nameserver.pm 


### Has msgid for the tag and consistent arguments (16)

If it says "add-not-info" in the comment column, then method `add()` is used to
output the message, not the common method `info()`.

Message Tag                   |Level in profile| Message ID (msgid)                                                                                                          | Defined        | Used                | Comments
:-----------------------------|:---------------|:----------------------------------------------------------------------------------------------------------------------------|----------------|---------------------|----------------------------------
CANNOT_CONTINUE               | CRITICAL       | Not enough data about {domain} was found to be able to run tests.                                                           | Translator.pm  | Test.pm             |
DEPENDENCY_VERSION            | DEBUG          | Using prerequisite module {name} version {version}.                                                                         | Translator.pm  | Test.pm             |
FAKE_DELEGATION_IN_ZONE_NO_IP | ERROR          | The fake delegation of domain {domain} includes an in-zone name server {nsname} without mandatory glue (without IP address).| Translator.pm  | Engine.pm           | add-not-info
FAKE_DELEGATION_NO_IP         | ERROR          | The fake delegation of domain {domain} includes a name server {nsname} that cannot be resolved to any IP address.           | Translator.pm  | Engine.pm           | add-not-info
GLOBAL_VERSION                | INFO           | Using version {version} of the Zonemaster engine.                                                                           | Translator.pm  | Test.pm             |
LOGGER_CALLBACK_ERROR         | DEBUG          | Logger callback died with error: {exception}                                                                                | Translator.pm  | Logger.pm           | add-not-info
LOOKUP_ERROR                  | DEBUG          | DNS query to {ns} for {domain}/{type}/{class} failed with error: {message}                                                  | Translator.pm  | Nameserver.pm       | add-not-info
MODULE_END                    | DEBUG          | Module {module} finished running.                                                                                           | Translator.pm  | Test.pm             |
MODULE_ERROR                  | CRITICAL       | Fatal error in {module}: {msg}                                                                                              | Translator.pm  | Test.pm             |
MODULE_VERSION                | DEBUG          | Using module {module} version {version}.                                                                                    | Translator.pm  | Test.pm             |
NO_NETWORK                    | CRITICAL       | Both IPv4 and IPv6 are disabled.                                                                                            | Translator.pm  | Test.pm             |
PACKET_BIG                    | DEBUG          | Big packet size ({size}) (try with \"{command}\").                                                                          | Translator.pm  | Nameserver.pm       | add-not-info
SKIP_IPV4_DISABLED            | DEBUG          | IPv4 is disabled, not sending \"{rrtype}\" query to {ns}.                                                                   | Translator.pm  |Test/Zone.pm, Zone.pm| add-not-info
SKIP_IPV6_DISABLED            | DEBUG          | IPv6 is disabled, not sending \"{rrtype}\" query to {ns}.                                                                   | Translator.pm  |Test/Zone.pm, Zone.pm| add-not-info
UNKNOWN_METHOD                | CRITICAL       | Request to run unknown method {testcase} in module {module}.                                                                | Translator.pm  | Test.pm             |
UNKNOWN_MODULE                | CRITICAL       | Request to run {testcase} in unknown module {module}. Known modules: {module_list}.                                         | Translator.pm  | Test.pm             |


### Has msgid for the tag but inconsistent arguments in msgid and output (3)

If it says "add-not-info" in the comment column, then method `add()` is used to
output the message, not the common method `info()`.

If it says "not-in-profile" in the comments column, then the tag is not listed in
the profile.json file.

Message Tag                   | Level in profile | Message ID (msgid)                                                            | Defined in     | Used in             | Comments
:-----------------------------|:-----------------|:------------------------------------------------------------------------------|----------------|---------------------|----------------------------------
ADDED_FAKE_DELEGATION         | DEBUG            | Added a fake delegation for domain {domain} to name server {ns}.              | Translator.pm  | Nameserver.pm       | add-not-info, not-in-profile (handled in [PR 1142])
FAKE_DELEGATION               | DEBUG2           | Followed a fake delegation.                                                   | Translator.pm  | Nameserver.pm       | add-not-info
FAKE_DELEGATION_TO_SELF       | DEBUG            | Name server {ns} not adding fake delegation for domain {domain} to itself.    | Translator.pm  | Nameserver.pm       | add-not-info, not-in-profile (handled in [PR 1142])


### Has no msgid for the tag (19)

If it says "add-not-info" in the comment column, then method `add()` is used to
output the message, not the common method `info()`.

Message Tag                   | Level  | Defined in     | Used in                  | Comments
:-----------------------------|:-------|----------------|--------------------------|----------------------------------
RECURSE                       | DEBUG2 | -              |Nameserver.pm, Recurser.pm| add-not-info
CACHED_RETURN                 | DEBUG3 | -              | Nameserver.pm            | add-not-info
CACHE_CREATED                 | DEBUG2 | -              | Nameserver/Cache.pm      | add-not-info
CACHE_FETCHED                 | DEBUG2 | -              | Nameserver/Cache.pm      | add-not-info
EMPTY_RETURN                  | DEBUG3 | -              | Nameserver.pm            | add-not-info
EXTERNAL_RESPONSE             | DEBUG3 | -              | Nameserver.pm            | add-not-info
FAKED_RETURN                  | DEBUG2 | -              | Nameserver.pm            | add-not-info
IPV4_BLOCKED                  | DEBUG2 | -              | Nameserver.pm            | add-not-info
IPV6_BLOCKED                  | DEBUG2 | -              | Nameserver.pm            | add-not-info
IS_REDIRECT                   | DEBUG2 | -              | Packet.pm                | add-not-info
NO_SUCH_NAME                  | DEBUG2 | -              | Packet.pm                |
NO_SUCH_RECORD                | DEBUG2 | -              | Packet.pm                |
NS_CREATED                    | DEBUG2 | -              | Nameserver.pm            | add-not-info
RECURSE_QUERY                 | DEBUG2 | -              | Recurser.pm              | add-not-info
RESTORED_NS_CACHE             | DEBUG2 | -              | Nameserver.pm            | add-not-info
SAVED_NS_CACHE                | DEBUG2 | -              | Nameserver.pm            | add-not-info
START_TIME                    | DEBUG  | -              | Test.pm                  |
TEST_ARGS                     | DEBUG  | -              | Test.pm                  |
TEST_TARGET                   | DEBUG  | -              | Test.pm                  |


[80773bc]: https://github.com/zonemaster/zonemaster-engine/commit/80773bc9802ed91d718e169b82f4840d401a1106

[PR 1142]: https://github.com/zonemaster/zonemaster-engine/pull/1142
