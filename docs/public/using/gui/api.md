# API


The Zonemaster GUI provides an API to access specific resource and perform
specific tasks by adding a path to the Zonemaster GUI base URL, e.g.
`https://zonemaster.net/`.

For the paths the following keys are used:

* `<lang>`: A [Language Code][Language Codes]
* `<test-id>`: A string of 16 characters in `0-9a-f` (hexadecimal)
* `<domain>`: A domain name to be tested (temporarily not supported)


The supported paths are the following:

* `/<lang>/result/<test-id>`: access the result page with results for the test
  with `<test-id>` in the selected language, e.g.
  `https://zonemaster.net/en/result/7e363fb606343397`.
* `/<lang>/faq`: access the FAQ in the selected language, e.g.
  `https://zonemaster.net/en/faq`.
* `/api`: With JSON RPC call access the Zonemaster [Backend RPC-API], e.g.
  `https://zonemaster.net/api`.

The GUI will redirect from `<path>` (e.g. `https://zonemaster.net/`) to
`<lang>/<path>` (`https://zonemaster.net/en/`) automatically using the
user browser language, if supported and configured by the installation.
Else it uses the default language defined in Zonemaster-GUI.

The following paths are temporarily not supported:

* `<lang>/run-test`: access the input form.
* `<lang>/run-test/<domain>`: populate the input form with `<domain>`.

## Language Codes

Zonemaster uses [ISO 639-1] two-letter language codes, in lower case. A defult
installation of Zonemaster-GUI currently has support for the following language
codes and languages:

* `da` for Danish language
* `en` for English language, the default language in a default installation
* `es` for Spanish language
* `fi` for Finnish language
* `fr` for French language
* `nb` for Norwegian language
* `sl` for Slovenian language
* `sv` for Swedish language

A non-default installation may have support for only some of the languages or
maybe other languages.


[ISO 639-1]:                                   https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes
[Language Codes]:                              #language-codes
[Backend RPC-API]:                             ../backend/rpcapi-reference.md
