# Run-time configuring Zonemaster-GUI using "config.json"

The `config.json` configuration file can be used for *run-time* settings of the
Zonemaster-GUI, i.e. no rebuild of the installation package is needed.

Currently only setting message banner is supported. Other types of configuration
requires rebuilt of the GUI, and is covered in sibbling documents of this
document.

## Finding "config.json"

In the source tree the file is found as `static/config.json` relative to the
root of the Git tree.

In a default installation, the file is found as
`/var/www/html/zonemaster-web-gui/dist/config.json`.

## Reloading GUI after update

When web browser reloads the GUI, e.g. after running a new test, the changes
are displayed by the GUI.

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
even `<a href>` if requested. Take note not to break quoting as JSON requires
quoting with `""` around the string.

To display a message banner, simply add the message text to the corresponding
language key. E.g.:

```json
{
    "msgBanner": {
        "en": "System maintenance scheduled for tomorrow at 10:00 UTC",
        "sv": "Systemunderhåll planerat till imorgon kl 10:00 UTC"
    }
}
```

