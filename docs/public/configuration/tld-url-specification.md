# TLD URL Specification

## Table of contents

* [Introduction](#introduction)
* [Given Domain Name]
* [Preconditions](#preconditions)
* [Limitations](#limitations)
* [Determination of URL](#determination-of-url)
* [Blocking policy](#blocking-policy)
* [URL string or blocking policy]
  * [Terminology](#terminology)
  * [Backend configuration](#backend-configuration)
  * [TXT record]
  * [Examples](#examples)
* [URL from IANA RDAP database]


## Introduction

The TLD URL feature provides a way to determine a URL to the TLD closest to a given
domain name. Zonemaster GUI makes use of this feature on its test result pages.

How the GUI gets the URL is defined in [Backend RPC API].

How Backend can override public values is defined in [Backend configuration].

This document specifies how the URL or its absence is determined.
The URL is determined based on one or more of:

* The given domain name,
* Backend configuration,
* DNS data published by the relevant TLD, and
* RDAP data published by IANA.


## Given Domain Name

In this document it is referred to the `given domain name`. The given domain name
is usually the domain name tested by Zonemaster, but the mechanisms specified
here can be executed on any domain name whether or not a Zonemaster test is
In this document the term `given domain name` is used. The given domain name
is usually the domain name tested by Zonemaster, but the mechanisms specified
here can be used on any domain name whether or not a Zonemaster test is
executed on the domain name.


## Preconditions

If the [given domain name][#given-domain-name] has one or more IDN labels
submitted in U-label format, then those must be converted to
[A-label][RFC 5890#2.3.2.1] format before the steps below can be run. This also
applies to the TLD label.

The given domain name must be submitted in lower case, i.e. `A-Z` must be
downcased to `a-z` before submission.


## Limitations

The only types of [URLs][URL] that the mechanisms specified in this document can
result in are `http` and `https`, i.e. URLs where the scheme is `http` or
`https`. There are also restrictions on allowed characters in that URL in section
[URL string or blocking policy]. In the same section the term `URL string` is
used, and it is defined at the start of that section.

The URL used is based on the [given domain name][#given-domain-name]. If the
given domain name matches one of the following conditions then no URL will be
provided, and that can not be overridden by Backend configuration.

* The given domain name is illegal, i.e. it contains illegal character(s) that
  [prevents it from being tested by Zonemaster][Requirements]
* The given domain name is the root zone (`.`).
* The given domain name is a TLD, e.g. `se` or `fr`.

In all other cases, a URL will be provided, if available and permitted by policy
configuration.


## Determination of URL

The URL is determined based on public information, configuration and the TLD of
the given domain name. The determination order is as follows:

1. [Backend configuration] may set a specific URL for the given TLD.
2. A specific DNS record may be published by the given TLD, as specified below in
   section [TXT record], with the URL to be used.
3. The URL for registration services found in the IANA RDAP database as specified
   below in section [URL from IANA RDAP database].
5. The fallback is to return the absense of a URL.

Both in the [Backend configuration] and the [TXT record] there may be a blocking
policy to prevent any URL from being returned. See details in the sections below.


## Blocking policy

A blocking policy can be defined to prevent an URL from being shown.
If a blocking policy is found then an empty URL is returned, as if no URL was found for the TLD.

The following priority applies for blocking policies:
* Highest priority is in the global policy in the [Backend configuration].
  If the global policy is set to block, then no URLs will be used for
  any domain name of any TLD, i.e. turning the feature off.
* The second priority is also set in the [Backend configuration], but this time
  per TLD. If it is set to block then no URL will be used for that TLD,
  independently of the availability of the URL from any source.
* The last priority can be set by the TLD manager in a TXT record where the URL
  string can be provided. The format and requirements are specified below in
  section [TXT record].
  * If a blocking policy is found then no URL is fetched from the IANA RDAP
    database. However, this blocking policy has no affect on a TLD string
    specified in [Backend configuration].


## URL string or blocking policy

### Terminology

The term `URL string` used in this section stands for a string from which a URL can
be derived using the steps in [TXT record]. Specifically, a `URL string` may
contain the literal string `[DOMAIN]` which is to be replaced by the given domain name
when the URL is derived. A URL derived from a `URL string` is also a valid
`URL string`.

### Backend configuration

How to configure global blocking policy, TLD specific blocking policy or URL
string is defined in [Backend configuration].

### TXT record

If [Backend configuration] has neither global blocking policy, TLD blocking
policy or an URL string, then a specific DNS TXT record can be read from which
an URL string or a blocking policy can be extracted.

The owner name of the TXT record must be `_url._zonemaster.<TLD>` where `<TLD>` is
replaced by the TLD in question. There must only be a single TXT record, or else
all TXT records are ignored.

If RDATA of the TXT record consists of several strings they are concatenated into
one text string.
The following procedure is defined for parsing the TXT record:
* If the text string is identical to the literal `[BLOCK]` it means a blocking
  policy resulting in no URL from the IANA RDAP database being used.
* If the text string consists of the following parts then a URL is created and
  that URL is used for the TLD:
  * The URL string must consist of the following parts in that order:
    * a literal `https://` or `http://`,
    * a domain name,
    * a path string.
  * The domain name string may contain characters `a-z0-9.-` where
    * full stop (dot) `.` must not be the first or last character,
    * there must not be a sequence of two or more full stops `.`,
    * hyphen-minus `-` must not start or end a label,
    * IDN labels must be represented in the A-label form.
  * The path string may be empty or must start with a solidus (slash) `/` and
      may contain characters `a-zA-Z0-9/=?%_.&-`.
      * The path string may also contain the literal string `[DOMAIN]` somewhere
        after the first solidus `/`.
      * If the literal string `[DOMAIN]` is found in the path string it will be
        replaced by the given domain name. If the given domain name contains
        solidus (slash) `/` then that will be encoded as `%2F`.
      * An empty path string will be replaced by the string `/`.
* If the text string is neither a blocking policy (literal string `[BLOCK]`) or a
  valid URL string, then the DNS TXT record is ignored.

### Examples

Invalid domain names:

* `green.xa.` (must not have trailing full stop `.`)
* `green-.xa` (label must not end with a hyphen-minus `-`)
* `grön.xa` (U-label not permitted, use A-label instead)
* `green_apple.xa` (low line (underscore) `_` is not permitted)

Invalid path strings:

* `/domän` (invalid character `ä`, use ASCII only)
* `/domain=<domain>` (`<domain>` is invalid, use `[DOMAIN]` instead)
* `/domain/search=$` (`$` is invalid)

Valid domain name strings:

* `green.xa`
* `xn--grn-tna.xa` (valid with A-label)
* `green-apple.xa`

Valid path strings:

* `/domain/&search=true`
* `/domain/[DOMAIN]`
* `/registry/&domain=[DOMAIN]`

URL from URL string in a TXT record:

```
Given domain: green.xa
TLD: xa
URL string: https://domain.nic.xa/search/[DOMAIN]
URL: https://domain.nic.xa/search/green.xa
```

```
Given domain: green.xb
TLD: xb
URL string: https://domain.nic.xa/search/
URL: https://domain.nic.xa/search/
```

```
Given domain: green.xc
TLD: xc
URL string: https://domain.nic.xa
URL: https://domain.nic.xa/
```


## URL from IANA RDAP database

If the publication of the URL was not blocked in the steps above and no URL
was determined from the steps above, then a lookup of the URL for the TLD
will be done from the IANA RDAP database.

The base URL for the IANA RDAP database is `https://rdap.iana.org/domain/`,
to which the appropriate TLD is appended. From a lookup of the resulting RDAP
URL, the URL for the registration service for the given TLD can be found, if
defined.

For example, use the following command where `na` is used as an example TLD:

> [!NOTE]
> Both `curl` and `jq` must be installed

```sh
curl -s https://rdap.iana.org/domain/na | jq -r '.links[] | select(.rel=="related") | .href'
```

* The fetched URL must consist of the following parts, in that order:
  * a literal `https://` or `http://`,
  * a domain name,
  * a path string.
 * The domain name string may contain characters `a-z0-9.-` where
   * full stop (dot) `.` must not be the first or last character,
   * there must not be a sequence of two or more full stops `.`,
   * hyphen-minus `-` must not start or end a label,
   * IDN labels must be represented in the A-label form.
 * The path string may be empty or must start with a solidus (slash) `/` and
      may contain characters `a-zA-Z0-9/=?%_.&-`.
      * An empty path string will be replaced by the string `/`.

This process will extract the same URL as the one for "URL for registration
services" found in the [IANA Root Zone Database] after selecting the relevant
TLD.

If no URL was found or no URL matched the requirements, then no URL is
returned (empty URL).



[Backend RPC API]:                                          ../using/backend/rpcapi-reference.md
[Backend configuration]:                                    backend.md
[IANA Root Zone Database]:                                  https://www.iana.org/domains/root/db
[Given Domain Name]:                                        #given-domain-name
[Requirements]:                                             ../specifications/tests/RequirementsAndNormalizationOfDomainNames.md
[TXT record]:                                               #txt-record
[URL]:                                                      https://en.wikipedia.org/wiki/URL
[URL from IANA RDAP database]:                              #url-from-iana-rdap-database
[URL string or blocking policy]:                            #url-string-or-blocking-policy
[RFC 5890#2.3.2.1]:                                         https://datatracker.ietf.org/doc/html/rfc5890#section-2.3.2.1
