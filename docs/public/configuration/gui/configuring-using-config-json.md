# Run-time configuring Zonemaster-GUI using "config.json"

The `config.json` configuration file can be used for *run-time* settings of the
Zonemaster-GUI, i.e. no rebuild of the installation package is needed.

Currently, the only supported setting is creating, updating or removing a message
banner. Other types of configuration require a rebuild of the GUI, and are covered
in sibling documents of this document.

## Finding "config.json"

In the source tree the file is found as `static/config.json` relative to the
root of the Git tree.

In a default installation, the file is found as
`/var/www/html/zonemaster-web-gui/dist/config.json`.

## Reloading GUI after update

When the Web browser reloads the GUI, e.g. after running a new test, the
changes are displayed by the GUI.

## Default "config.json" file

The `config.json` file contains configuration that is loaded at runtime.
Currently, it includes settings for displaying banner messages in different
languages:

```json
{
    "msgBanner": {
        "en": "",
        "sv": "",
        "da": "",
        "es": "",
        "fi": "",
        "fr": "",
        "nb": ""
    }
}
```

### Configuration Options

* **msgBanner**: An object containing message banner text for each supported
  language. These messages can be used to display important announcements or
  notifications to users in their preferred language.

The message banner is shown just below the top menu on all pages.
  
The string is set for each language, and may contain HTML code such as `<br>` or
even `<a href>` if necessary. Take note not to break quoting as JSON requires
quoting with `""` around the string.

To display a message banner, simply add the message text to the corresponding
language key. E.g.:

```json
{
    "msgBanner": {
        "en": "Scheduled system maintenance on 2025-12-09 from 10:00 to 12:00 UTC.",
        "sv": "Planerat systemunderhåll den 9 december 2025 kl. 10.00–12.00 UTC."
    }
}
```

