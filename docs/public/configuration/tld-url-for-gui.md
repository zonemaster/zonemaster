# TLD URL for GUI

> The feature specified in this an accompanying documents is work in progress.
> It must first be running in Backend before it can be used in GUI. It is here
> described as if it is already in production.


## Table of contents

* [Introduction](#introduction)
* [Limitations](#limitations)
* [IDN names](#idn-names)
* [Source of URL and priority](#source-of-url-and-priority)
* [Blocking policy](#blocking-policy)
* [URL string or blocking policy](#url-string-or-blocking-policy)
  * [Backend configuration](#backend-configuration)
  * [TXT record](#txt-record)
  * [Examples](#examples)
* [URL from IANA RDAP database](#url-from-iana-rdap-database)


## Introduction

To facilitate direction of the GUI user to responsible party for the operation
of a tested domain name, a URL to the closest TLD is presented with the test
result. This document defines how that URL is set from public information, and
where in Zonemaster the URL can be reset to some other value by the decision of
the maintainer of the specific Zonemaster installation.

How the GUI gets the URL is defined in [Backend RPC API].

How Backend can override public values is defined in [Backend configuration].


## Limitations

The URL used is based on the tested domain name. If the tested domain name
matches one of the following no URL will be provide, and that can not be
overridden by Backend configuration.

* The domain name to be tested is illegal, e.i. it contains some character that
  prevents it from being tested by Zonemaster.
* The tested domain name is the root zone (`.`).
* The tested domain name is a TLD, e.g. `se` or `fr`.

In all other cases a URL will be provided if available, and unless there is a
policy configuration that blocks that or all URLs to be shown.


## IDN names

If the domain name to be tested has one or more IDN labels submitted in U-label
format, then those must be converted to A-label format before the steps below are
run. That includes the TLD string.

## Source of URL and priority

The URL is always per TLD.

* Highest priority of source is [Backend configuration] if it is configured with
  a specific URL string for that TLD. See [Backend configuration] for how to
  configure the TLD specific URL.
* Second highest priority of source is in a specific DNS record as specified
  below.
* The fallback is to fetch the URL for registration services found in the IANA
  RDAP database as specified below.


## Blocking policy

If a blocking policy is found then an empty URL is return, as if no URL is found
for the TLD.

* Highest priority of blocking policy is in the global policy in the
  [Backend configuration]. If the the global policy is set to block, then no
  URLs will be used for any domain name (for any TLD), i.e. turning the feature
  off.
* The second highest blocking policy is also set in the [Backend configuration]
  but per TLD. If that is set to "block" then no URL will be used for that TLD
  independent of the availabilty of URL or URL string from any source.
* The lowest level blocking policy can be set by the TLD manager in the TXT
  record where the URL string can be provided. The format and requirements are
  specified below.
  * If a blocking policy is found, then no URL is fetched from the IANA RDAP
    database. However, this blocking policy has no affect on a TLD string
    specified in [Backend configuration].


## URL string or blocking policy

### Backend configuration

How to configure global blocking policy, TLD specific blocking policy or URL
string is defined in [Backend configuration].


### TXT record

If [Backend configuration] has neither global blocking policy, TLD blocking
policy or a URL string, then a specific TXT record is read, and from that DNS
record a URL string or a blocking policy is extracted, if possible.

The owner name of the TXT record is `_url._zonemaster.<TLD>` where `<TLD>` is
replaced by the TLD in question. It must be a single TXT record under that name
or else all TXT records are ignored.

If RDATA of the TXT record consists of several strings they are concatenated into
one text string.

* If the text string is identical to the literal `-` it means a blocking policy
  resulting in no URL from the IANA RDAP database being used.
* If the text string consists of the following parts then a URL is created and
  that URL is used for the TLD:
  * The URL string should consist of literal `https://` + a domain name string +
    a path string.
    * The literal `https://` may be replaced by `http://`.
    * The domain name string may contain characters `a-z0-9.-` where
      * full stop (dot) `.` must not be the first or last character,
      * there must not be a sequence of two or more full stops `.`,
      * hyphen-minus `-` must not start or end a label,
      * IDN labels must be represented by the A-labels.
    * The path string may be empty or must start with a solidus (slash) `/` and
      may contain characters `a-zA-Z0-9/=?_\&-`. The path string may also contain
      the literal string `<DOM>` somewhere after the first solidus `/`.
      * If the literal string `<DOM>` is found in the path string it will be
        replaced by the tested domain name.
      * An empty path string will be replaced by the string `/`.
* If the text string is neither a blocking policy (literal string `-`) or a valid
  URL string, then the DNS TXT record is ignored.

### Examples

Invalid domain name strings:

* `green.xa.` (must not have trailing full stop `.`)
* `green-.xa` (label must not end with a hyphen-minus `-`)
* `grön.xa` (U-label not permitted, use A-label instead)
* `green_apple.xa` (Low line (underscore) `_` is not permitted)

Invalid path strings:

* `/domän` (invalid character `ä`, use ASCII only)
* `/domain=<domain>` (`<domain>` is invalid, use `<DOM>` instead)
* `/domain/search=$` (`$` is invalid)

Valid domain name strings:

* `green.xa`
* `xn--grn-tna.xa` (valid with A-label)
* `green-apple.xa`

Valid path strings:

* `/domain\&search=true`
* `/domain/<DOM>`
* `/registry\&domain=<DOM>`

URL from URL string in a TXT record:

```
Tested domain: green.xa
TLD: xa
URL string: https://domain.nic.xa/search/<DOM>
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

If the following is true, then an lookup-up of URL for the TLD in the IANA RDAP
database will be done:

* [Backend configuration] has no global blocking policy.
* [Backend configuration] has no TLD blocking policy.
* [Backend configuration] has no TLD specific URL string.
* There is no valid TLD specific TXT record with blocking policy (see above).
* There is no valid TLD specific TXT record with a valid URL string (see above).

The base URL for the IANA RDAP database is `https://rdap.iana.org/domain/` and
the TLD in question is appended to that, and the relevant string can be extracted
using command below (both `curl` and `jq` must be installed) with `na` as an
example TLD.

```sh
curl -s https://rdap.iana.org/domain/na | jq -r '.links[] | select(.rel=="related") | .href'
```

* The URL string should consist of literal `https://` + a domain name string +
  a path string.
  * The literal `https://` may be replaced by `http://`.
  * The domain name string may contain characters `a-z0-9.-` where
    * full stop (dot) `.` must not be the first or last character,
    * there must not be a sequence of two or more full stops `.`,
    * hyphen-minus `-` must not start or end a label,
    * IDN labels must be represented by the A-labels.
  * The path string may be empty or must start with a solidus (slash) `/` and
    may contain characters `a-zA-Z0-9/=?_\&-`.
  * An empty path string will be replaced by the string `/`.

This process will extract the same URL as the one for 
"URL for registration services" found in the [IANA Root Zone Database] and
selecting the relevant TLD.


[Backend RPC API]:                                  ../public/using/backend/rpcapi-reference.md
[Backend configuration]:                            ../backend.md
[IANA Root Zone Database]:                          https://www.iana.org/domains/root/db



