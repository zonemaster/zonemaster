# TLD URL for GUI

> The feature specified in this accompanying document is a work in progress.
> It must first be implemented in Backend before it can be used in GUI. It is
> described here as if it is already in production.


## Table of contents

* [Introduction](#introduction)
* [Limitations](#limitations)
* [IDN names](#idn-names)
* [Source of URL](#source-of-url)
* [Blocking policy](#blocking-policy)
* [URL string or blocking policy]
  * [Backend configuration](#backend-configuration)
  * [TXT record]
  * [Examples](#examples)
* [URL from IANA RDAP database]


## Introduction

To facilitate redirection of a GUI user to the responsible party for the operation
of a tested domain name, an URL to the relevant TLD is presented with the test
result. This document defines how the URL is set based on public information, and
where in Zonemaster that URL can be changed to another value on a specific
Zonemaster installation.

How the GUI gets the URL is defined in [Backend RPC API].

How Backend can override public values is defined in [Backend configuration].

In this document the only types of [URLs][URL] that are considered are `http`
and `https`, i.e. URLs where the scheme is `http` or `https`. There are also
restrictions on allowed characters in that URL. In section
[URL string or blocking policy] are defined. In the same section the term
`URL string` is used, and it is defined at the start of that section.


## Limitations

The URL used is based on the tested domain name. If the tested domain name
matches one of the following conditions then no URL will be provided, and that can
not be overridden by Backend configuration.

* The tested domain name is illegal, i.e. it contains illegal character(s) that
  prevents it from being tested by Zonemaster.
* The tested domain name is the root zone (`.`).
* The tested domain name is a TLD, e.g. `se` or `fr`.

In all other cases, a URL will be provided, if available and permitted by policy configuration.


## IDN names

If the tested domain name has one or more IDN labels submitted in U-label
format, then those must be converted to A-label format before the steps below can
be run. This includes the TLD label.


## Source of URL

The URL is specifically set on a per TLD basis.

The following priority applies for determining the source of the URL:
* Highest priority is [Backend configuration] if it is configured with
  a specific URL for that TLD. See [Backend configuration] for how to
  configure the TLD specific URL.
* Second priority is a specific DNS record as specified below in section [TXT record].
* The fallback is to fetch the URL for registration services found in the IANA
  RDAP database as specified below in section [URL from IANA RDAP database].


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

The term `URL string` in used in this section for a string from which a URL can
be derived using the steps in [TXT record]. Specifically an `URL string` may
contain the literal string `[DOMAIN]` which is replaced by the tested domain name
when the URL is derived. A `URL` derived from a `URL string` is also a valid
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
        replaced by the tested domain name. If the tested domain name contains
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

* `/domain\&search=true`
* `/domain/[DOMAIN]`
* `/registry\&domain=[DOMAIN]`

URL from URL string in a TXT record:

```
Tested domain: green.xa
TLD: xa
URL string: https://domain.nic.xa/search/[DOMAIN]
URL: https://domain.nic.xa/search/green.xa
```

```
Tested domain: green.xb
TLD: xb
URL string: https://domain.nic.xa/search/
URL: https://domain.nic.xa/search/
```

```
Tested domain: green.xc
TLD: xc
URL string: https://domain.nic.xa
URL: https://domain.nic.xa/
```


## URL from IANA RDAP database

If the following conditions are true, then a lookup of the URL for the TLD will be done from the
IANA RDAP database:

* [Backend configuration] has no global blocking policy.
* [Backend configuration] has no TLD blocking policy.
* [Backend configuration] does not configure a TLD specific URL.
* There is no valid TLD specific TXT record with blocking policy (see
  [URL string or blocking policy]).
* There is no valid TLD specific TXT record that configures a URL (see
  [URL string or blocking policy]).

The base URL for the IANA RDAP database is `https://rdap.iana.org/domain/` to
which the TLD in question is appended, and from which the relevant string can be
extracted using the command below (both `curl` and `jq` must be installed) where
`na` is used as an example TLD:

```sh
curl -s https://rdap.iana.org/domain/na | jq -r '.links[] | select(.rel=="related") | .href'
```

* The URL fetched must consist of the following parts in that order:
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

This process will extract the same URL as the one for 
"URL for registration services" found in the [IANA Root Zone Database] after
selecting the relevant TLD.


[Backend RPC API]:                                  ../using/backend/rpcapi-reference.md
[Backend configuration]:                            backend.md
[IANA Root Zone Database]:                          https://www.iana.org/domains/root/db
[TXT record]:                                       #txt-record
[URL]:                                              https://en.wikipedia.org/wiki/URL
[URL from IANA RDAP database]:                      #url-from-iana-rdap-database
[URL string or blocking policy]:                    #url-string-or-blocking-policy
