# BASIC00: The domain name must be a valid name


## Test case identifier
**BASIC00**


## Table of contents

* [Objective](#Objective)
* [Scope](#Scope)
* [Inputs](#Inputs)
* [Outputs](#Outputs)
* [Summary](#Summary)
* [Test procedure](#Test-procedure)
* [Outcome(s)](#Outcomes)
* [Special procedural requirements](#Special-procedural-requirements)
* [Intercase dependencies](#Intercase-dependencies)
* [Detailed test case requirements]
  * [ASCII domain name](#ASCII-domain-name)
  * [IDN name](#IDN-name)
  * [Length limitations](#Length-limitations)
  * [Root zone](#Root-zone)
  * [Creating normalized form](#Creating-normalized-form)
* [Terminology](#terminology)


## Objective

In order to execute the tests of the zone name from the input it must be a
valid domain name. If name servers are provided for the zone in the input, the
names of the name servers must also be valid domain names. Both types of domain
names, zone names and name server names, are tested and normalized by this test
case. The zone name is called *Child Zone* in other Zonemaster test case
specifications.

To be valid, *Domain Name* must be one of two:

1. a valid ASCII domain name, or
2. a valid IDN name (Internationalized Domain Name) as of
   [IDNA2008][RFC 5890#1.1].

This test case will, in contrast to all other Zonemaster test cases, normalize
*Domain Name* and output a normalized form to be used by all other test cases.
The objectives of the normalization are

1. Convert other "full stop" characters to FULL STOP, and
2. Create legal IDNA 2008 U-labels from convenient alternative forms, and
3. Create consistent representation of the same zone name.

The result of the normalization can be a new form of *Domain Name* to be used
by the tests in other test cases, the normalized form. If the normalized form is
neither a valid ASCII domain name nor a valid IDN name, then *Domain Name*
cannot be used for Zonemaster testing.

If the outcome of this test case (see [Outcome(s)](#Outcomes)) is not "fail" then
*Domain Name* in normalized form is returned to be used as input value for
subsequent Zonemaster test cases.

The following references are consulted for this test case:

* [RFC 1034]
* [RFC 1035]
* [RFC 1123]
* [RFC 2317]
* [RFC 2782]
* [RFC 5890]
* [RFC 5895]
* [Unicode TR 46]

See the details in the [Detailed test case requirements] section below.


## Scope

This test case only tests and create a normalized form of the domain name (zone
name or name server name).

This test case assumes that the domain name neither starts nor ends with space
(U+0020). The Zonemaster CLI, the Zonemaster GUI or any other client must ensure
that before entering the domain name to this test case, or else this test case
will fail.

In this test case, ASCII is identical to the first 128 characters in [Unicode]
(0000..007F).

[RFC 1123][RFC 1123#2.1], section 2.1, also specifies that a domain name label
may not start or end with a HYPHEN-MINUS ("-"). The SOLIDUS ("/"), if used, is
not expected to occure in the start or end of the label. The LOW LINE ("_"), if
used, is only expected to occure in the start of the label. Those restrictions on
HYPHEN-MINUS, SOLIDUS and LOW LINE are disregarded in this test case and are
assumed to be handled in test cases [Syntax01] and [Syntax02].


## Inputs

* "Domain Name" - The domain name to be tested and normalized. It must be
  a non-empty string of [Unicode] characters.
* "Valid ASCII" - Set of permitted ASCII characters in table 1 below.
* "Label Separator" - Set of valid label separtors in table 2 below.
* "Full Stops" - Set of full stops in table 3 below.
* "Unicode" - The Unicode database.

Tables 1, 2 and 3 are found in the [Detailed test case requirements] section
below.


## Outputs

See the [Outcome(s)](#Outcomes)) section below.


## Summary

Message Tag outputted    | Level    | Arguments | Description of when message tag is outputted
:------------------------|:---------|:----------|:--------------------------------------------
B00_INITIAL_DOT          | CRITICAL |           | Domain name starts with dot.
B00_REPEATED_DOTS        | CRITICAL |           | Domain name has repeated dots.
B00_INVALID_ASCII        | CRITICAL | dlabel    | Domain name has an ASCII label with a character not permitted.
B00_INVALID_U_LABEL      | CRITICAL | dlabel    | Domain name has a non-ASCII label which is not a valid U-label.
B00_LABEL_TOO_LONG       | CRITICAL | dlabel    | Domain name has a label that is too long (more than 63 characters).
B00_DOMAIN_NAME_TOO_LONG | CRITICAL |           | Domain name is too long (more than 253 characters with no final dot).

The value in the Level column is the default severity level of the message. The
severity level can be changed in the [Zonemaster-Engine profile]. Also see the
[Severity Level Definitions] document. If the default level is *[CRITICAL]* it is
never meaningful to set another level.

The argument names in the Arguments column lists the arguments used in the
message. The argument names are defined in the [argument list].


## Test procedure

1.  If the input *Domain Name* is not a non-empty string of [Unicode] characters
    this test cas cannot be run.

2.  Create an empty, ordered list of labels ("Domain Labels").

3.  Replace all instances of dots from *Full Stops* in *Domain Name* with U+002E
    (see *Label Separator*).

4.  If *Domain Name* is the root zone, i.e. the exact string "." (U+002E), then
    terminate this test case with no message tags.

5.  If *Domain Name* starts with dot (".", U+002E) then output
    *[B00_INITIAL_DOT]* and terminate this test case.

6.  If *Domain Name* has any instance of two or more consecutive dots (".",
    U+002E) then output *[B00_REPEATED_DOTS]* and terminate this test.

7.  Remove trailing dot (".", U+002E) from *Domain Name*.

8.  Split *Domain Name* into labels by dot "." (U+002E) and put them in the same
    order in *Domain Labels*.

9.  For each "Label" in *Domain Labels* do:
    1. If all characters in *Label* are ASCII characters, then do:
       1. If any character in *Label* is not listed in *Valid ASCII*, then output
          [B00_INVALID_ASCII] and *Label*, and terminate this test case.
       2. Else, downcase all upper case characters as described in section
          [Upper case](#Upper-case) below.
    2. Else do:
       1. Assume that *Label* is a U-label.
       2. Downcase all upper case characters as described in section
          [Upper case](#Upper-case) below.
       3. Convert *Label* to an A-label as specified by
          [IDNA2008][RFC 5890#1.1].
          1. If the conversion failed, then output *[B00_INVALID_U_LABEL]*
             and *Label*, and terminate this test case.
          2. Else, replace the U-label in *Domain Labels* with the A-label from
             the conversion above.
    3. Go to next label.

10. For each "Label" in *Domain Labels* do:
    1. If the length (number of characters) in *Label* is greater than 63 then
       output *[B00_LABEL_TOO_LONG]* and *Label*, and terminate this test case.

11. Map the labels in *Domain Labels* back into *Domain Name* with one dot (".",
    U+002E), between the labels (no dots if the there is only one label).

12. If the length of *Domain Name* is longer than 253 characters including the
    dots, then output *[B00_DOMAIN_NAME_TOO_LONG]* and terminate this test case.

## Outcome(s)

The outcome of this test case consists of three parts

1. The outcome value as defined below in this section.
2. The message tags, if any, and data connected to the message tags, if any.
3. *Domain Name* in the normalized form to be used as input value for all
   other test cases. If the outcome value is "fail" then no *Domain Name* is
   returned.

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


## Detailed test case requirements

This section describes the requirements on the domain name. Besides the ensuring
that the domain name is valid, these requirements also ensure that the domain
name is used in a normalized form.

### ASCII domain name

An ASCII domain name is valid if it follows the rules defined in
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
section 3.1).

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

The fact that "." (U+002E) character is the delimiter between labels puts some
limitations on its use. The first label cannot be en empty label unless that is
the only label, i.e. the domain name for the root name. With that exception (that
is covered below) a domain name cannot have a "." initially. Only the last label
can be an empty label (the root label), which means that there cannot be two or
more consecutive "." in a valid domain name. The domain name, as entered to
Zonemaster, can either have a final dot or not, and will normalized as described
below.


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

A valid ASCII name consists, by definition, of only ASCII characters. A valid IDN
name must either consists of only ASCII characters (no U-labels, only A-labels)
or consist of at least one non-ASCII Unicode character in at least one label,
i.e. at least one U-label. U-labels and A-labels can be mixed, and IDN labels can
be mixed with non-IDN labels.


### Length limitations

There is a maximum length of the whole domain name and a maximum length of each
label. These limitations are defined for a domain name of ASCII characters only,
which means that any IDN U-label must be converted to the equivalent A-label
before the limitations can be checked.

The maximum total length of a domain name is 253 characters (or octets) if it
has no final dot, 254 with the final dot ([RFC 1035][RFC 1035#2.3.4], section
2.3.4). The RFC defines the limit as 255 octets, but that is the limitation in
the DNS packet, where labels separation is done differently.

The maximum length of a label is 63 characters (or octets),
[RFC 1035][RFC 1035#2.3.4], section 2.3.4. A label must be at least one character
(octet) long unless it is the label representing the root, which is zero in
length and always after the final dot.


### Root zone

If the root zone is to be tested, then it must be represented as a single dot "."
and in no other way. The label that represents the root zone is an empty label
after the dot.


### Creating normalized form

For a discussion of pre-processing the domain name to achieve a normalized form,
see [RFC 5895].

#### Full stop

The regular dot "." expected in domain names is a U+002E (FULL STOP), see table 2
above. There are other characters that may be entered instead due to the script
setting. Table 3 lists full stop characters that are to be mapped into the
ASCII FULL STOP ([Unicode TR 46][Unicode TR 46#Notation], section 2.3). That
mapping must be done before any verification or checks of the dot and before
splitting *Domain Name* into labels.

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
non-ASCII characters found in U-labels ([RFC 5895][RFC 5895#2], section 2). This
mapping is done before a U-label is converted to A-label. A valid U-label must
not contain any upper case letters.

Special attention should be put on U+0049 (LATIN CAPITAL LETTER I) and U+0130
(LATIN CAPITAL LETTER I WITH DOT ABOVE). Both must be mapped into U+0069 (LATIN
SMALL LETTER I), also in a Turkish and Azeri locale. (See [Unicode SpecialCasing]
for the special casing of U+0130 etc in Turkish and Azeri locale.) If a U-label
contains a U+0131 (LATIN SMALL LETTER DOTLESS I) it will be tested as such with
no mapping.

#### A-label and U-label

DNS can only handle A-labels, not U-label. In the test core only A-labels are
used. For normalization, all U-labels are converted to A-labels. Remaining test
cases will only handle an ASCII-only *Domain Name*. Conversion from U-label to
A-label should be done as specified for [IDNA2008][RFC 5890#1.1], not IDNA2003.


## Terminology

No special terminology for this test case.


[Argument list]:                         https://github.com/zonemaster/zonemaster-engine/blob/master/docs/logentry_args.md
[B00_DOMAIN_NAME_TOO_LONG]:              #SUMMARY
[B00_INITIAL_DOT]:                       #SUMMARY
[B00_INVALID_ASCII]:                     #SUMMARY
[B00_INVALID_U_LABEL]:                   #SUMMARY
[B00_LABEL_TOO_LONG]:                    #SUMMARY
[B00_REPEATED_DOTS]:                     #SUMMARY
[CRITICAL]:                              ../SeverityLevelDefinitions.md#critical
[Detailed test case requirements]:       #Detailed-test-case-requirements
[ERROR]:                                 ../SeverityLevelDefinitions.md#error
[FULL STOP]:                             https://codepoints.net/U+002E
[FULLWIDTH FULL STOP]:                   https://codepoints.net/U+FF0E
[HALFWIDTH IDEOGRAPHIC FULL STOP]:       https://codepoints.net/U+FF61
[HYPHEN-MINUS]:                          https://codepoints.net/U+002D
[IDEOGRAPHIC FULL STOP]:                 https://codepoints.net/U+3002
[INFO]:                                  ../SeverityLevelDefinitions.md#info
[LOW LINE]:                              https://codepoints.net/U+005F
[NOTICE]:                                ../SeverityLevelDefinitions.md#notice
[RFC 1034]:                              https://datatracker.ietf.org/doc/html/rfc1034
[RFC 1034#3.1]:                          https://datatracker.ietf.org/doc/html/rfc1034#section-3.1
[RFC 1035]:                              https://datatracker.ietf.org/doc/html/rfc1035
[RFC 1035#2.3.3]:                        https://datatracker.ietf.org/doc/html/rfc1035#section-2.3.3
[RFC 1035#2.3.4]:                        https://datatracker.ietf.org/doc/html/rfc1035#section-2.3.4
[RFC 1123]:                              https://datatracker.ietf.org/doc/html/rfc1123
[RFC 1123#2.1]:                          https://datatracker.ietf.org/doc/html/rfc1123#section-2.1
[RFC 2317]:                              https://datatracker.ietf.org/doc/html/rfc2317
[RFC 2317#4]:                            https://datatracker.ietf.org/doc/html/rfc2317#section-4
[RFC 2782]:                              https://datatracker.ietf.org/doc/html/rfc2782
[RFC 5890]:                              https://datatracker.ietf.org/doc/html/rfc5890
[RFC 5890#1.1]:                          https://datatracker.ietf.org/doc/html/rfc5890#section-1.1
[RFC 5890#2.3.2.1]:                      https://datatracker.ietf.org/doc/html/rfc5890#section-2.3.2.1
[RFC 5890#2.3.2.3]:                      https://datatracker.ietf.org/doc/html/rfc5890#section-2.3.2.3
[RFC 5895]:                              https://datatracker.ietf.org/doc/html/rfc5895
[RFC 5895#2]:                            https://datatracker.ietf.org/doc/html/rfc5895#section-2
[SOLIDUS]:                               https://codepoints.net/U+002F
[Severity Level Definitions]:            ../SeverityLevelDefinitions.md
[Syntax01]:                              ../Syntax-TP/syntax01.md
[Syntax02]:                              ../Syntax-TP/syntax02.md
[Unicode SpecialCasing]:                 https://www.unicode.org/Public/UCD/latest/ucd/SpecialCasing.txt
[Unicode TR 46]:                         http://unicode.org/reports/tr46
[Unicode TR 46#Notation]:                http://unicode.org/reports/tr46/#Notation
[Unicode]:                               https://unicode.org/main.html
[WARNING]:                               ../SeverityLevelDefinitions.md#warning
[Zonemaster-Engine profile]:             https://github.com/zonemaster/zonemaster-engine/blob/master/docs/Profiles.md
