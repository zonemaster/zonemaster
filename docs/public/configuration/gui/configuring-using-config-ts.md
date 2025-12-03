# Simple build-time configuring Zonemaster-GUI using "config.ts"

The `config.ts` configuration file can be used for *build-time* settings of the
Zonemaster-GUI, i.e. the installation package has to be rebuilt.

## Finding "config.ts"

In the source tree the file is found as `config.ts` relative to the root of the
Git tree. It does not exist in the installed GUI, as the values have been built
in

## Rebuilding Zonemaster-GUI after update

When `config.ts` has been updated, Zonemaster-GUI has to be rebuilt. See
[Build a custom Zonemaster-GUI installation package] for how to get the source
tree and building a custom installation package.

## Default "config.ts" file

The `config.ts` file is the central configuration file for the Zonemaster-GUI
application. It defines various settings that control the behavior and appearance
of the application.

```typescript
const config: Config = {
    defaultLanguage: 'en',
    enabledLanguages: ['da', 'en', 'es', 'fi', 'fr', 'nb', 'sl', 'sv'],
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
  * The default language must be one of the enabled languages.
* **enabledLanguages**: An array of language codes that are supported by the
  application.
  * The array should match the list of language codesin the [Locale setting] in
    the Backend configuration.
  * The array must only include language codes also included in
    `project.inlang/settings.json`, but it may be fewer. To add new languages,
    see [Translating Zonemaster-GUI]. `project.inlang/settings.json` must only be
    updated in that process.
* **apiBaseUrl**: The base URL for API requests. This is taken from the
  `PUBLIC_API_URL` environment variable (default empty) or defaults to '/api'.
  * If this value is changed, then [zonemaster.conf-example] must also be
  updated. More information below.
* **pollingInterval**: The interval (in milliseconds) for polling the API. This
  is taken from the `PUBLIC_POLLING_INTERVAL` environment variable (default
  empty) or defaults to 5000 ms.
* **clientInfo**: Information about the client application. These details are
  included in every API request to start tests as (spoofable) indications of
  origin. Both are best left as default.
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
before building the installation package.

> Incomplete information


[Build a custom Zonemaster-GUI installation package]:                    building-custom-gui.md
[Locale setting]:                                                        ../backend.md#locale
[Translating Zonemaster-GUI]:                                            ../../translation/Translating-GUI.md
[Zonemaster.conf-example]:                                               https://github.com/zonemaster/zonemaster-gui/blob/master/zonemaster.conf-example
