# Style Guide

## Scope

The following style guide applies to document text and certain file names
specified below.

## Guidelines

* Zonemaster is always written as **Zonemaster**, never shortened (e.g. "ZM") or
  uncapitalized (e.g. "zonemaster").
* Case-insensitive regexes are always written out with the ignore-case flag
  (e.g. `/[a-z]/i`).
* For variable names in test case specifications each word is capitalized (e.g.
  "Domain Part"). If a word is an abbreviation, it is usually written with all
  capitals, e.g. "DNS".
* When writing Markdown documents, use lower case fragments when referring to
  internal headings' anchors, i.e. use `#objective` not `#Objective` to create
  a link to the "Objective" section.
* When linking to other documents and including the URL in the rendered text,
  put angle brackets around the URL, i.e. use the [CommonMark autolink] syntax.
  I.e. write as `<https://example.com/>` not just as `https://example.com/`.

  If the angle brackets are not included the URL is still rendered as a link on
  GitHub (per [GFM autolink] syntax), but other tools may not recognize it as a
  link.

[CommonMark autolink]: https://spec.commonmark.org/0.30/#autolinks
[GFM autolink]: https://github.github.com/gfm/#autolinks-extension-
