# Configuring Zonemaster GUI using "config.ts"

The `config.ts` configuration file can be used for *build-time* settings of the
Zonemaster GUI, i.e. the GUI has to be rebuilt.

## Finding "config.ts"

In the source tree the file is found as `config.ts` relative to the root of the
Git tree. It does not exist in the installed GUI, as the values have been built
in

## Rebuilding GUI after update

When `config.ts` has been updated, GUI has to be rebuilt. See [building GUI] for
how to get the source tree and building a new installation zip file.

## Default "config.ts" file

The `config.ts` file is the central configuration file for the Zonemaster GUI
application. It defines various settings that control the behavior and appearance
of the application.

```typescript
const config: Config = {
    defaultLanguage: 'en',
    enabledLanguages: ['da', 'en', 'es', 'fi', 'fr', 'nb', 'sv'],
    apiBaseUrl: import.meta.env.PUBLIC_API_URL || '/api',
    pollingInterval: import.meta.env.PUBLIC_POLLING_INTERVAL || 5000,
    clientInfo: {
        version: packageJson.version,
        id: 'Zonemaster-GUI',
    },
    siteInfo: {
        email: 'contact@zonemaster.net',
        siteName: '',
    },
};
```

## Configuration Options

* **defaultLanguage**: The default language to use when no language is specified.
  * The default language should one of the enabled languages.
* **enabledLanguages**: An array of language codes that are supported by the
  application.
  * That array should match the list of languages in the [Locale setting] in the
    Backend configuration.
* **apiBaseUrl**: The base URL for API requests. This is taken from the
  `PUBLIC_API_URL` environment variable (default empty) or defaults to '/api'.
  * If this value is changed, then [zonemaster.conf-example] must also be
  updated. More information below.
* **pollingInterval**: The interval (in milliseconds) for polling the API. This
  is taken from the `PUBLIC_POLLING_INTERVAL` environment variable (default
  empty) or defaults to 5000 ms.
* **clientInfo**: Information about the client application. Both are best left
  as default.
  * **version**: The version of the application, taken from package.json.
  * **id**: The identifier for the client application.
* **siteInfo**: Information about the site.
  * **email**: The contact email address. To be set in the footer in a mailto
    URL, if non-empty.
  - **siteName**: The name of the site. To be set in the header if non-empty.

### Setting "apiBaseUrl"

If Zonemaster is served by domain, say, `domaintest.xa` then it is by default
served directly on that domain, i.e. `http://domaintest.xa/` (or 
`https://domaintest.xa/`). The `/api` part is only used under the hood. If
requested that Zonemaster is served under, say, 
`http://domaintest.xa/zonemaster/`, `apiBaseURL` can be used to acheive that.

Set `apiBaseUrl: '/zonemaster/api',` to serve Zonemaster under `/zonemaster/` as
in the example URL above.

For this to work, the Apache configuration must be updated too. More below.

### Updating Apache configuration

If `apiBaseUrl` has been updated, then [zonemaster.conf-example] (installed as
`zonemaster.conf` in a default installation) must also be updated, preferably
before building the GUI.

> Incomplete information


[Building GUI]:                                  building-custom-gui.md
[Locale setting]:                                ../backend.md#locale
[Zonemaster.conf-example]:                       https://github.com/zonemaster/zonemaster-gui/blob/master/zonemaster.conf-example
