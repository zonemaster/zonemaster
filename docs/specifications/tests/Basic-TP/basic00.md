# BASIC00: The domain name must be a valid name


## Test case identifier
**BASIC00**


## Table of contents

* [Objective](#Objective)
  * [ASCII domain name](#ASCII-domain-name)
  * [IDN name](#IDN-name)
  * [Lenght limitations](#Lenght-limitations)
  * [Root zone](#Root-zone)
  * [Name preparation](#Name-preparation)
* [Scope](#Scope)
* [Inputs](#Inputs)
* [Summary](#Summary)
* [Test procedure](#Test-procedure)
* [Outcome(s)](#Outcomes)
* [Special procedural requirements](#Special-procedural-requirements)
* [Intercase dependencies](#Intercase-dependencies)
* [Terminology](#terminology)


## Objective

In order to execute testing the domain name from the input must be a valid domain
name. The domain name must be one of two:

1. a valid ASCII domain name, or
2. a valid IDN name (Internationalized Domain Name) as of
   [IDNA2008][RFC 5890#1.1].

This test case will, in contrast to all other Zonemaster test cases, normalize
the domain name to be tested (called *Child Zone* below) and output a normalized
*Child Zone* to be used by all other test cases. That normalization is here
called name preparation.

If, after name preparation, the *Child Zone* is neither a valid ASCII domain
name nor a valid IDN name, then the *Child Zone* cannot be used for Zonemaster
testing.

If the outcome of this test case (see [Outcome(s)](#Outcomes)) is not "fail"
then *Child Zone*, possibly normalized, is returned to be used as input value
for subsequent Zonemaster test cases.


### ASCII domain name

An ASCII domain name is valid if follows the rules defined in
[RFC 1123][RFC 1123#2.1], section 2.1, i.e. only consists of the ASCII characters
"a-z", "A-Z", "0-9", "." and "-" with the extension of the following two
characters:

1. The LOW LINE (underscore, "_") character standardized for e.g. SRV records
   ([RFC 2782]) and other record types and special names.
2. The SOLIDUS (forward slash, "/") used in reverse zone names for IPv4 networks
   smaller than /24. See examples in [RFC 2317][RFC 2317#4], section 4.

In ASCII names, upper case A-Z are treated as equal to a-z
([RFC 1034][RFC 1034#3.1], section 3.1 and [RFC 1035][RFC 1035#2.3.3], section
2.3.3). The FULL STOP (".") is used as label separator ([RFC 1034][RFC 1034#3.1],
section 3.1). In this specification "." is excluded from being part of the
label.

*Table 1: A summary of the valid ASCII characters in labels using [Unicode]
codes.*

Unicode code or code range | Character or character range | Comment
:--------------------------|:-----------------------------|:--------------------
0061..007A                 | a-z                          |
0041..005A                 | A-Z                          | Upper case of a-z
0030..0039                 | 0-9                          |
U+002D                     | -                            | [HYPHEN-MINUS]
U+002F                     | /                            | [SOLIDUS] (forward slash)
U+005F                     | _                            | [LOW LINE] (underscore)

*Table 2: A summary of the valid ASCII character between labels using [Unicode]
codes.*

Unicode code or code range | Character or character range | Comment
:--------------------------|:-----------------------------|:--------------------
U+002E                     | .                            | [FULL STOP]

The fact that "." character is the delimiter between labels puts some limitations
on its use. The first label cannot be en empty label unless that is the only
label, i.e. the domain name for the root name. With that exception (that is
covered below) a domain name cannot have a "." initially. Only the last label can
be an empty label (the root label), which means that there cannot be two or more
consecutive "." in a valid domain name. The domain name, as entered to
Zonemaster, can either have a final dot or not, and will normalized as described
below in name preparation.


### IDN name

A valid IDN name is a domain named where one or more labels are valid IDN label
([RFC 5890][RFC 5890#2.3.2.3]) and the remaining labels are valid ASCII labels as
defined above. An IDN label can be an A-label or a U-label
([RFC 5890][RFC 5890#2.3.2.1], section 2.3.2.1).

* A valid IDN name where all IDN labels are A-labels will automatically meet the
ASCII name requirements above given that the non-IDN labels meet them.

* A valid IDN name with one or more U-labels can be converted to a valid IDN name
where all IDN labels are A-labels.

A valid ASCII name is, by definition, encoded in ASCII. A valid IDN name must
either be encoded in ASCII (no U-labels) or in UTF-8 (at least one U-label). If
not, Zonemaster will not be able to process the domain name. Note that ASCII is a
subset of UTF-8.


### Lenght limitations

There is a maximum length of the whole domain name and a maximum lenght of each
label. These limitations are defined for a domain name of ASCII characters only,
which means that any IDN label must be converted to the equivalent A-label before
the limitations can be checked.

The maximum total lenght of a domain name is 253 characters (or octets) if it
has no final dot, 254 with the final dot ([RFC 1035][RFC 1035#2.3.4], section
2.3.4). The RFC defines the limit as 255 octets, but that is the limitation in
the DNS packet, where labels separation is done differently.

The maximum lenght of a label is 63 characters (or octets),
[RFC 1035][RFC 1035#2.3.4], section 2.3.4. A label must be at least one character
(octet) long unless it is the label representing the root, which is zero in
length and always after the final dot.


### Root zone

If the root zone is to be tested, then it must be represented as a single dot "."
and in no other way. The label that represents the root zone is an empty label
after the dot.


### Name preparation

The objectives of the name preparation are

1. Create consistent representation of the same zone name, and
2. Convert other "full stop" characters to FULL STOP, and
3. Create legal IDNA 2008 U-labels from convinient alternative forms.

The result of the name preparation is possibly a new form of the domain name to
be used by the tests in other test cases.

#### Leading or trailing space

It is assumed that the client has removed any leading or trailing space (U+0020)
before entering the domain name (*Child Zone*) to be processed by this test
case. The Zonemaster CLI, Zonemaster GUI or any other client must do that
process.

#### Full stop

The regular dot "." expected in domain names is a U+002E (FULL STOP). There are
other characters that may be entered instead due to the script setting. Table 3
lists full stop characters that are to be mapped into the ASCII FULL STOP
([Unicode TR 46][Unicode TR 46#Notation], section 2.3). That mapping must be done
before any verification or checks of the dot and before separating the
*Child Zone* into labels.

*Table 3: Non-ASCII dots (Full Stops) using [Unicode] codes.*

Unicode code | Character | Name
:------------|:----------|:--------------------
U+FF0E       | ．        | [FULLWIDTH FULL STOP]
U+3002       | 。        | [IDEOGRAPHIC FULL STOP]
U+FF61       | ｡         | [HALFWIDTH IDEOGRAPHIC FULL STOP]

#### Final dot

If the domain name has one final dot it should be removed to create a consistent
representation. The exception is the root zone which is always represented by
the exact string ".".

#### Upper case

If the domain name has any letters tagged as "upper case" by the [Unicode]
database, those should be mapped into the equivalent lower case letter. This
applies to both ASCII (i.e. "A-Z" mapped into "a-z") in both A- and U-labels and
non-ASCII characters found in U-labels. This mapping is done before a U-label is
converted to A-label. A valid U-label must not contain any upper case letters.

Special attention should be put on U+0049 (LATIN CAPITAL LETTER I) and U+0130
(LATIN CAPITAL LETTER I WITH DOT ABOVE). Both must be mapped into U+0069 (LATIN
SMALL LETTER I), also in a Turkish and Azeri locale. (See [Unicode SpecialCasing]
for the special casing of U+0130 etc in Turkish and Azeri locale.) If a U-label
contains a U+0131 (LATIN SMALL LETTER DOTLESS I) it will be tested as such with
no mapping.

#### A-label and U-label

DNS can only handle A-labels, not U-label. In the test core only A-labels are
used. For normalization, all U-labels are converted to A-labels. Remaining test
cases will only handle an ASCII-only *Child Zone*. Conversion from U-label to
A-label should be done as specified for [IDNA2008][RFC 5890#1.1], not IDNA2003.


## Scope

This test case does not test the zone of *Child Zone*. It only tests and
normalizes the name string.

[RFC 1123][RFC 1123#2.1], section 2.1, also specifies that a domain name label
may not start or end with a HYPHEN-MINUS ("-"). The SOLIDUS ("/"), if used, is
also not expected to occure in the start or end of the label. The LOW LINE
("_"), if used, is only expected to occure in the start of the label. Those
restrictions on HYPHEN-MINUS, SOLIDUS and LOW LINE are disregarded in this test
case and are assumed to be handled in test cases [Syntax01] and [Syntax02].


## Inputs

* "Child Zone" - The domain name to be tested.
* "Valid ASCII" - Set of permitted ASCII characters in table 1 above.
* "Full Stops" - Set of Full Stops in table 3 above.
* "Unicode" - The Unicode database.


## Summary

Message Tag outputted    | Level    | Arguments | Description of when message tag is outputted
:------------------------|:---------|:----------|:--------------------------------------------
B00_NOT_UTF-8_ASCII      | CRITICAL |           | Domain name to be tested is encode in unknown character encoding.
B00_INITIAL_DOT          | CRITICAL |           | Domain name starts with dot.
B00_REPEATED_DOTS        | CRITICAL |           | Domain name has repeated dots.
B00_INVALID_ASCII        | CRITICAL | dlabel    | ASCII label has characters not permitted.
B00_INVALID_U_LABEL      | CRITICAL | dlabel    | Label with non-ASCII character is not valid U-label.
B00_LABEL_TOO_LONG       | CRITICAL | dlabel    | Domain name has a label that is too long (more than 63 characters).
B00_DOMAIN_NAME_TOO_LONG | CRITICAL |           | Domain name is too long (more than 253 characters with no final dot).

The value in the Level column is the default severity level of the message. The
severity level can be changed in the [Zonemaster-Engine profile]. Also see the
[Severity Level Definitions] document.

The argument names in the Arguments column lists the arguments used in the
message. The argument names are defined in the [argument list].


## Test procedure

1.  Create an empty, ordered list of labels ("Child Labels").

2.  If *Child Zone* is not encoded in UTF-8 (ASCII is a subset of UTF-8) then
    output *[B00_NOT_UTF-8_ASCII]* and terminate this test case.

3.  Replace all instances of dots from *Full Stops* in *Child Zone* with U+002E
    (dot ".").

4.  If *Child Zone* is the root zone, i.e. the exact string ".", then terminate
    this test case.

5.  If *Child Zone* starts with dot (".") then output *[B00_INITIAL_DOT]* and
    terminate this test case.

6.  If *Child Zone* has any instance of two or more consecutive dots (".") then
    output *[B00_REPEATED_DOTS]* and terminate this test.

7.  Remove trailing dot (".") from *Child Zone*.

8.  Split *Child Zone* into labels by dot "." and put them in the same order in
    *Child Labels*.

9.  For each "Label" in *Child Labels* do:
    1. If all characters in *Label* are ASCII characters, then do:
       1. If any character in *Label* is not listed in *Valid ASCII*, then output
          [B00_INVALID_ASCII] and *Label*, and terminate this test case.
       2. Else, downcase all uppcase characters as described in section
          [Upper case](#Upper-case) above.
    2. Else do:
       1. Assume that *Label* is a U-label.
       2. Downcase all uppcase characters as described in section
          [Upper case](#Upper-case) above.
       3. Convert *Label* to an A-label as specified by
          [IDNA2008][RFC 5890#1.1].
          1. If the conversion failed, then output *[B00_INVALID_U_LABEL]*
             and *Label*, and terminate this test case.
          2. Else, replace the U-label in *Child Labels* with the A-label.
    3. Go to next label.

11. For each "Label" in *Child Labels* do:
    1. If the length (number of character) in *Label* is greater than 63 then
       output *[B00_LABEL_TOO_LONG]* and *Label*, and terminate this test case.

12. Map the labels in *Child Labels* back into *Child Zone* with one dot (".")
    between the labels (no dots if the there is only one label).

13. If the length of *Child Zone* is longer than 253 characters including the
    dots, then output *[B00_DOMAIN_NAME_TOO_LONG]* and terminate this test case.

## Outcome(s)

The outcome of this test case consists of three parts

1. The outcome value as defined below in this section.
2. The message tags, if any, and data connected to the message tags, if any.
3. The possibly updated *Child Zone* to be used as input value for all other test
   cases. If the outcome value is "fail" then an empty *Child Zone* is returned.

The outcome of this Test Case is "fail" if there is at least one message
with the severity level *[ERROR]* or *[CRITICAL]*.

The outcome of this Test Case is "warning" if there is at least one message
with the severity level *[WARNING]*, but no message with severity level
*ERROR* or *CRITICAL*.

In other cases, no message or only messages with severity level
*[INFO]* or *[NOTICE]*, the outcome of this Test Case is "pass".


## Special procedural requirements

This test case must be executed as the first test case, and must always be
executed even if not explicitly selected.

If this test fails, it is impossible to continue and the whole testing process
is aborted.


## Intercase dependencies

None.


## Terminology

No special terminology for this test case.


[Argument list]:                         https://github.com/zonemaster/zonemaster-engine/blob/master/docs/logentry_args.md
[B00_DOMAIN_NAME_TOO_LONG]:              #SUMMARY
[B00_INITIAL_DOT]:                       #SUMMARY
[B00_INVALID_ASCII]:                     #SUMMARY
[B00_INVALID_U_LABEL]:                   #SUMMARY
[B00_LABEL_TOO_LONG]:                    #SUMMARY
[B00_NOT_UTF-8_ASCII]:                   #SUMMARY
[B00_REPEATED_DOTS]:                     #SUMMARY
[CRITICAL]:                              ../SeverityLevelDefinitions.md#critical
[ERROR]:                                 ../SeverityLevelDefinitions.md#error
[FULL STOP]:                             https://codepoints.net/U+002E
[FULLWIDTH FULL STOP]:                   https://codepoints.net/U+FF0E
[HALFWIDTH IDEOGRAPHIC FULL STOP]:       https://codepoints.net/U+FF61
[HYPHEN-MINUS]:                          https://codepoints.net/U+002D
[IDEOGRAPHIC FULL STOP]:                 https://codepoints.net/U+3002
[INFO]:                                  ../SeverityLevelDefinitions.md#info
[LOW LINE]:                              https://codepoints.net/U+005F
[NOTICE]:                                ../SeverityLevelDefinitions.md#notice
[RFC 1034#3.1]:                          https://tools.ietf.org/html/rfc1034#section-3.1
[RFC 1035#2.3.3]:                        https://tools.ietf.org/html/rfc1035#section-2.3.3
[RFC 1035#2.3.4]:                        https://tools.ietf.org/html/rfc1035#section-2.3.4
[RFC 1123#2.1]:                          https://tools.ietf.org/html/rfc1123#section-2.1
[RFC 2317#4]:                            https://tools.ietf.org/html/rfc2317#section-4
[RFC 2782]:                              https://tools.ietf.org/html/rfc2782
[RFC 5890#1.1]:                          https://tools.ietf.org/html/rfc5890#section-1.1
[RFC 5890#2.3.2.1]:                      https://tools.ietf.org/html/rfc5890#section-2.3.2.1
[RFC 5890#2.3.2.3]:                      https://tools.ietf.org/html/rfc5890#section-2.3.2.3
[SOLIDUS]:                               https://codepoints.net/U+002F
[Severity Level Definitions]:            ../SeverityLevelDefinitions.md
[Syntax01]:                              ../Syntax-TP/syntax01.md
[Syntax02]:                              ../Syntax-TP/syntax02.md
[Unicode SpecialCasing]:                 https://www.unicode.org/Public/UCD/latest/ucd/SpecialCasing.txt
[Unicode TR 46#Notation]:                http://unicode.org/reports/tr46/#Notation
[Unicode]:                               https://unicode.org/main.html
[WARNING]:                               ../SeverityLevelDefinitions.md#warning
[Zonemaster-Engine profile]:             https://github.com/zonemaster/zonemaster-engine/blob/master/docs/Profiles.md
