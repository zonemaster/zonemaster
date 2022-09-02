# Requirements and normalization of domain names in input


## Table of contents

* [Objective](#objective)
* [Overview](#overview)
  * [References](#references)
* [Scope](#scope)
* [Inputs](#inputs)
* [Summary](#summary)
* [Test procedure](#test-procedure)
* [Outcome(s)](#outcomes)
* [Special procedural requirements](#special-procedural-requirements)
* [Detailed requirements]
  * [ASCII domain name](#ascii-domain-name)
  * [IDN name](#idn-name)
  * [Length limitations](#length-limitations)
  * [Root zone](#root-zone)
  * [Creating IDNA2008 compatible format](#creating-idna2008-compatible-format)
* [Terminology](#terminology)


## Objective

This specification defines the requirements for zone name to be tested. The same
requirements are put on name server names in the input, if any. If the
requirements are not met, then Zonemaster will not start any tests.

This specification also defines some normalization that the domain names (zone
name and name server name) will go through. If a domain name is normalized it
means that an updated form of the name will be used. The updated form is
considered to be equal in meaning.

In order to execute the tests of the zone name from the input it must be a
valid domain name. If name servers are provided for the zone in the input, the
names of the name servers must also be valid domain names. Both types of domain
names, zone names and name server names, are tested and normalized by this test
case. The zone name is called *Child Zone* in Zonemaster test case
specifications.


## Overview

To be valid, *Domain Name* must be one of two:

1. a valid ASCII domain name, or
2. a valid IDN name (Internationalized Domain Name) as of
   [IDNA2008][RFC 5890#1.1].

The process defined in this specification will normalize *Domain Name* and output
a normalized form to be used by all Zonemaster test cases. The objectives of the
normalization are

1. Remove leading and trailing white space characters.
2. Convert other dot characters to regular dot (or "FULL STOP").
3. Create legal IDNA 2008 U-labels from convenient alternative forms.
4. Create consistent representation of the same zone name.

The result of the normalization can be a new form of *Domain Name* to be used
by the tests in test cases, the normalized form. If the normalized form is
neither a valid ASCII domain name nor a valid IDN name, then *Domain Name*
cannot be used for Zonemaster testing.

If the outcome (see [Outcome(s)](#outcomes)) is not "fail" then *Domain Name* in
normalized form is returned to be used as input value for Zonemaster test cases.

See the details in the [Detailed requirements] section below.


### References

The following references are consulted for this specification:

* [RFC 1034]
* [RFC 1035]
* [RFC 1123]
* [RFC 2317]
* [RFC 2782]
* [RFC 5890]
* [RFC 5891]
* [RFC 5895]
* [Unicode TR 46]


## Scope

This specification only tests and creates a normalized form of the domain name
(zone name or name server name).

In this specification, ASCII is identical to the first 128 characters in
[Unicode] (0000..007F).

[RFC 1123][RFC 1123#2.1], section 2.1, specifies that a domain name label
may not start or end with a HYPHEN-MINUS ("-"), only digit or letter. This
restriction on HYPHEN-MINUS is disregarded in this specification and is assumed
to be handled in test case [Syntax02].

The use of the SOLIDUS ("/") and the LOW LINE ("_") in domain name is discussed
in the section "[ASCII domain name](#ascii-domain-name)" below. Any restrictions
on where in the domain name or label those could or should be used are
disregarded in this specification, and are assumed to be handled in test cases
[Syntax01] and [Syntax02].


## Inputs

* "Domain Name" - The domain name to be tested and normalized according to this
  specification. It must be a non-empty string of [Unicode] characters.

## Summary

In the specification there are six scenarios that will result in the domain name
not being usable, i.e. it cannot be used for Zonemaster testing. Each scenario
is here listed with a message tag, level (always CRITICAL in this specification),
suitable argument to be used in the same descriptive message and a message that
can be returned to the user.

Message Tag                    | Level    | Arguments    | Message ID for message tag
:------------------------------|:---------|:-------------|:----------------------------------------------------------
AMBIGUOUS_DOWNCASING           | CRITICAL | unicode_name | Ambiguous downcaseing of character "{unicode_name}" in the domain name. Use all lower case instead.
DOMAIN_NAME_TOO_LONG           | CRITICAL |              | Domain name is too long (more than 253 characters with no final dot).
EMPTY_DOMAIN_NAME              | CRITICAL |              | Domain name is empty.
INITIAL_DOT                    | CRITICAL |              | Domain name starts with dot.
INVALID_ASCII                  | CRITICAL | label        | Domain name has an ASCII label ("{label}") with a character not permitted.
INVALID_U_LABEL                | CRITICAL | label        | Domain name has a non-ASCII label ("{label}") which is not a valid U-label.
LABEL_TOO_LONG                 | CRITICAL | label        | Domain name has a label that is too long (more than 63 characters), "{label}".
REPEATED_DOTS                  | CRITICAL |              | Domain name has repeated dots.

The value in the Level column is the default severity level of the message. Also
see the [Severity Level Definitions] document.

The argument names in the Arguments column lists the arguments used in the
message. The argument names are defined in the [argument list].


## Test procedure

Tables 1, 2, 3 and 4 are found in the [Detailed requirements] section below.

1.  Create the following sets
    1. Set of permitted ASCII characters in Table 1 below ("Valid ASCII").
    2. Set of Unicode white space characters in Table 3 below ("White Space")
    3. Set of Unicode full stops (dot characters) in Table 4 below
       ("Unicode Full Stops").

2.  If *Domain Name* starts with one or more of *White Space* then those are
    removed from *Domain Name* before further processing.

3.  If *Domain Name* ends with one or more of *White Space* then those are
    removed from *Domain Name* before further processing.

4.  If *Domain Name* is an empty string then output *[EMPTY_DOMAIN_NAME]* and
    terminate these test procedures.

5.  If *Domain Name* contains [LATIN CAPITAL LETTER I WITH DOT ABOVE] then:
    1. Output *[AMBIGUOUS_DOWNCASING]* and the Unicode name of the code point in
       question.
    2. Terminate these test procedures.

6.  Create an empty, ordered list of labels ("Domain Labels").

7.  Replace all instances of character from *Unicode Full Stops* in *Domain Name*
    with the label separating, regular dot U+002E (see Table 2).

8.  If *Domain Name* is the root zone, i.e. the exact string "." (U+002E), then
    terminate these test procedures with no message tags.

9.  If *Domain Name* starts with dot (".", U+002E) then output
    *[INITIAL_DOT]* and terminate these test procedures.

10. If *Domain Name* has any instance of two or more consecutive dots (".",
    U+002E) then output *[REPEATED_DOTS]* and terminate these test
    procedures.

11. Remove trailing dot (".", U+002E) from *Domain Name*.

12. Split *Domain Name* into labels by dot "." (U+002E) and put them in the same
    order in *Domain Labels*.

13. For each "Label" in *Domain Labels* do:
    1. If all characters in *Label* are ASCII characters, then do:
       1. If any character in *Label* is not listed in *Valid ASCII*, then output
          *[INVALID_ASCII]* and *Label*, and terminate these test procedures.
       2. Else, downcase all upper case characters as specified in section
          "[Upper case](#upper-case)" below.
    2. Else do:
       1. Assume that *Label* is a U-label.
       2. Downcase all upper case characters as specified in section
          "[Upper case](#upper-case)" below.
       3. Normalize *Label* to NFC as specified in [Unicode TR 15]. Also see
          section "[Unicode normalization](#unicode-normalization)" below.
       3. Convert *Label* to an A-label as specified by
          [IDNA2008][RFC 5890#1.1].
          1. If the conversion failed, then output *[INVALID_U_LABEL]*
             and *Label*, and terminate these test procedures.
          2. Else, replace the U-label in *Domain Labels* with the A-label from
             the conversion above.
    3. Go to next label.

14. For each "Label" in *Domain Labels* do:
    1. If the length (number of characters) in *Label* is greater than 63 then
       output *[LABEL_TOO_LONG]* and *Label*, and terminate these test
       procedures.

15. Map the labels in *Domain Labels* back into *Domain Name* with one dot (".",
    U+002E), between the labels (no dots if the there is only one label).

16. If the length of *Domain Name* is longer than 253 characters including the
    dots, then output *[DOMAIN_NAME_TOO_LONG]* and terminate these test
    procedures.


## Outcome(s)

The outcome of the tests in this specification consists of three parts

1. The outcome value as defined below in this section.
2. The message tags, if any, and data connected to the message tags, if any.
3. *Domain Name* in the normalized form to be used as input value for all test
   cases. If the outcome value is "fail" then no *Domain Name* is
   returned.

The outcome value of this specification is "fail" if there is at least one
message outputted. In other cases it is "pass".


## Special procedural requirements

The tests and normalizations defined in this specification must always be run
and evaluated before any Zonemaster test case is run.

If the outcome from this specification is "fail", then no test cases should be
run.


## Detailed requirements

This section describes the requirements on the domain name. Besides ensuring
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
2.3.3). The regular dot, or [FULL STOP] ("."), is used as label separator
([RFC 1034][RFC 1034#3.1], section 3.1). Also see Table 2 below.

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

Unicode code | Character | Comment
:------------|:----------|:--------------------
U+002E       | .         | [FULL STOP] (in this document referred to as "dot")

The fact that "." (U+002E) character is the delimiter between labels puts some
limitations on its use. The first label cannot be en empty label unless that is
the only label, i.e. the root domain name. With that exception (covered below) a
domain name cannot have a "." (dot) initially. Only the last label can be an
empty label (the root label), which means that there cannot be two or more
consecutive "." (dots) in a valid domain name. The domain name, as entered to
Zonemaster, can either have a final dot or not, and will be normalized as
described below.

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

There is a maximum length for the whole domain name and a maximum length for each
label. These limitations are defined for a domain name of ASCII characters only,
which means that any IDN U-label must be converted to the equivalent A-label
before the limitations can be checked.

The maximum total length of a domain name is 253 characters (or octets) if it
has no final dot, 254 with the final dot ([RFC 1035][RFC 1035#2.3.4], section
2.3.4). Note that he RFC defines the limit as 255 octets, but that is the
limitation in the DNS packet, where labels separation is done differently.

The maximum length of a label is 63 characters (or octets),
[RFC 1035][RFC 1035#2.3.4], section 2.3.4. A label must be at least one character
(octet) long unless it is the label representing the root domain name, which is
zero in length and always after the final dot.


### Root zone

If the root zone is to be tested, then it must be represented as a single dot "."
and in no other way. The label that represents the root zone is an empty label
after the dot.


### Creating IDNA2008 compatible format

For a discussion on pre-processing the domain name to achieve IDNA compatible
U-label from convenient alternative forms see [RFC 5895]. Unicode normalization
is covered by [RFC 5891] and [Unicode TR 15]

#### Unicode normalization

For Unicode strings normalization processes have been defined to make convert
different representations into a normalized form. Specifically, it is required
that an IDN label ([IDNA2008]) is in the so called "Normalized Form C" (NFC) as
of [RFC 5891][RFC 5891#5.2], section 5.2.

For ASCII domain names NFC is no issue since they are always in NFC format. For
an IDN name the situation is different. The letter "ö" in the IDN domain name
"malmö.se" can be represented as either the single Unicode code point U+00F6 or
as the Unicode code point sequence "006F 0308". Only the former is in NFC form,
which means that if the domain name is entered with the sequence it must be
preprocessed before entering [IDNA2008] processing, i.e. conversion to A-label
format. See [Unicode TR 15] for a specification of Unicode normalization and more
examples relevant to domain names.

Zonemaster (this specification) requires that any domain name must be converted
to NFC form before conversion to A-label. However, the domain name is entered in
A-label format, this specification does not require that the corresponding
U-label is in NFC format.

#### White space

In the user interface there is a risk that leading or trailing white space
characters are added to the domain name by mistake. The domain name will in this
specification be normalized by removing such characters. In Table 3 it is
specified what counts as white space characters. It should be pointed out that
white space characters within the domain name are not removed, and in the end
count as invalid characters.

*Table 3: White space characters**

Unicode code | Name
:------------|:--------------------
U+0020       | [SPACE]
U+0009       | [CHARACTER TABULATION]
U+00A0       | [NO-BREAK SPACE]
U+2000       | [EN QUAD]
U+2001       | [EM QUAD]
U+2002       | [EN SPACE]
U+2003       | [EM SPACE]
U+2004       | [THREE-PER-EM SPACE]
U+2005       | [FOUR-PER-EM SPACE]
U+2006       | [SIX-PER-EM SPACE]
U+2007       | [FIGURE SPACE]
U+2008       | [PUNCTUATION SPACE]
U+2009       | [THIN SPACE]
U+200A       | [HAIR SPACE]
U+205F       | [MEDIUM MATHEMATICAL SPACE]
U+3000       | [IDEOGRAPHIC SPACE]
U+1680       | [OGHAM SPACE MARK]

#### Full stop

The regular dot "." expected in domain names is a U+002E (FULL STOP), see Table 2
above. There are other characters that may be entered instead due to the script
setting. Table 4 lists full stop characters that are to be mapped into the
ASCII FULL STOP ([Unicode TR 46][Unicode TR 46#Notation], section 2.3). That
mapping must be done before any verification or checks of the dot and before
splitting *Domain Name* into labels.

*Table 4: Non-ASCII dots (Full Stops) using [Unicode] codes*

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

For Zonemaster special rules applies to U+0049 ([LATIN CAPITAL LETTER I]) and
U+0130 ([LATIN CAPITAL LETTER I WITH DOT ABOVE]).

* [LATIN CAPITAL LETTER I] is downcased to U+0069 ([LATIN SMALL LETTER I]) also
  in Turkish and Azeri locale, i.e. not following the special Unicode rule in
  those locale ([Unicode SpecialCasing]).
* Label with [LATIN CAPITAL LETTER I WITH DOT ABOVE] should be rejected since
  normal downcasing gives a sequence not reasonable in a domain name context (see
  "Lowercase Mapping" in [LATIN CAPITAL LETTER I WITH DOT ABOVE]).


#### A-label and U-label

DNS can only handle A-labels, not U-label. In the test core suite of Zonemaster
only A-labels are used. For normalization, all U-labels are converted to
A-labels. Test cases will only handle an ASCII-only *Domain Name*. Conversion
from U-label to A-label should be done as specified for [IDNA2008][RFC 5890#1.1],
not IDNA2003.


## Terminology

No special terminology for this specification.


[AMBIGUOUS_DOWNCASING]:                  #summary
[Argument list]:                         https://github.com/zonemaster/zonemaster-engine/blob/master/docs/logentry_args.md
[CHARACTER TABULATION]:                  https://codepoints.net/U+0009
[DOMAIN_NAME_TOO_LONG]:                  #summary
[Detailed requirements]:                 #detailed-requirements
[EM QUAD]:                               https://codepoints.net/U+2001
[EM SPACE]:                              https://codepoints.net/U+2003
[EMPTY_DOMAIN_NAME]:                     #summary
[EN QUAD]:                               https://codepoints.net/U+2000
[EN SPACE]:                              https://codepoints.net/U+2002
[FIGURE SPACE]:                          https://codepoints.net/U+2007
[FOUR-PER-EM SPACE]:                     https://codepoints.net/U+2005
[FULL STOP]:                             https://codepoints.net/U+002E
[FULLWIDTH FULL STOP]:                   https://codepoints.net/U+FF0E
[HAIR SPACE]:                            https://codepoints.net/U+200A
[HALFWIDTH IDEOGRAPHIC FULL STOP]:       https://codepoints.net/U+FF61
[HYPHEN-MINUS]:                          https://codepoints.net/U+002D
[IDEOGRAPHIC FULL STOP]:                 https://codepoints.net/U+3002
[IDEOGRAPHIC SPACE]:                     https://codepoints.net/U+3000
[INITIAL_DOT]:                           #summary
[INVALID_ASCII]:                         #summary
[INVALID_U_LABEL]:                       #summary
[LABEL_TOO_LONG]:                        #summary
[LATIN CAPITAL LETTER I WITH DOT ABOVE]: https://codepoints.net/U+0130
[LATIN CAPITAL LETTER I]:                https://codepoints.net/U+0049
[LATIN SMALL LETTER DOTLESS I]:          https://codepoints.net/U+0131
[LATIN SMALL LETTER I]:                  https://codepoints.net/U+0069
[LOW LINE]:                              https://codepoints.net/U+005F
[MEDIUM MATHEMATICAL SPACE]:             https://codepoints.net/U+205F
[NO-BREAK SPACE]:                        https://codepoints.net/U+00A0
[OGHAM SPACE MARK]:                      https://codepoints.net/U+1680
[PUNCTUATION SPACE]:                     https://codepoints.net/U+2008
[REPEATED_DOTS]:                         #summary
[RFC 1034#3.1]:                          https://datatracker.ietf.org/doc/html/rfc1034#section-3.1
[RFC 1034]:                              https://datatracker.ietf.org/doc/html/rfc1034
[RFC 1035#2.3.3]:                        https://datatracker.ietf.org/doc/html/rfc1035#section-2.3.3
[RFC 1035#2.3.4]:                        https://datatracker.ietf.org/doc/html/rfc1035#section-2.3.4
[RFC 1035]:                              https://datatracker.ietf.org/doc/html/rfc1035
[RFC 1123#2.1]:                          https://datatracker.ietf.org/doc/html/rfc1123#section-2.1
[RFC 1123]:                              https://datatracker.ietf.org/doc/html/rfc1123
[RFC 2317#4]:                            https://datatracker.ietf.org/doc/html/rfc2317#section-4
[RFC 2317]:                              https://datatracker.ietf.org/doc/html/rfc2317
[RFC 2782]:                              https://datatracker.ietf.org/doc/html/rfc2782
[RFC 5890#1.1]:                          https://datatracker.ietf.org/doc/html/rfc5890#section-1.1
[RFC 5890#2.3.2.1]:                      https://datatracker.ietf.org/doc/html/rfc5890#section-2.3.2.1
[RFC 5890#2.3.2.3]:                      https://datatracker.ietf.org/doc/html/rfc5890#section-2.3.2.3
[RFC 5890]:                              https://datatracker.ietf.org/doc/html/rfc5890
[RFC 5891#5.2]:                          https://www.rfc-editor.org/rfc/rfc5891#section-5.2
[RFC 5891]:                              https://www.rfc-editor.org/rfc/rfc5891
[RFC 5895#2]:                            https://datatracker.ietf.org/doc/html/rfc5895#section-2
[RFC 5895]:                              https://datatracker.ietf.org/doc/html/rfc5895
[SIX-PER-EM SPACE]:                      https://codepoints.net/U+2006
[SOLIDUS]:                               https://codepoints.net/U+002F
[SPACE]:                                 https://codepoints.net/U+0020
[Severity Level Definitions]:            SeverityLevelDefinitions.md
[Syntax01]:                              Syntax-TP/syntax01.md
[Syntax02]:                              Syntax-TP/syntax02.md
[THIN SPACE]:                            https://codepoints.net/U+2009
[THREE-PER-EM SPACE]:                    https://codepoints.net/U+2004
[Unicode SpecialCasing]:                 https://www.unicode.org/Public/UCD/latest/ucd/SpecialCasing.txt
[Unicode TR 15]:                         https://unicode.org/reports/tr15/
[Unicode TR 46#Notation]:                http://unicode.org/reports/tr46/#Notation
[Unicode TR 46]:                         http://unicode.org/reports/tr46
[Unicode]:                               https://unicode.org/main.html
[Zonemaster-Engine profile]:             https://github.com/zonemaster/zonemaster-engine/blob/master/docs/Profiles.md
