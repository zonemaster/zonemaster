# Simple build-time configuring Zonemaster-GUI using "config.ts"

The `config.ts` configuration file can be used for *build-time* settings of
the Zonemaster-GUI. Any changes to this file require a rebuild of the
installation package.

## Finding "config.ts"

In the source tree the file is found as `config.ts` relative to the root of
the Git tree. The installed GUI does not ship with this file, because the
values defined in this file are baked in the GUI’s HTML and JavaScript files.

## Rebuilding Zonemaster-GUI after update

When `config.ts` is updated, Zonemaster-GUI has to be rebuilt. See
[Build a custom Zonemaster-GUI installation package] for how to get the source
tree and building a custom installation package.

## Default "config.ts" file

The `config.ts` file is the central configuration file for the Zonemaster-GUI
application. It defines various settings that control the behavior and appearance
of the application.

```typescript
import type { Config } from '@/types.ts';
import packageJson from './package.json';

const config: Config = {
    defaultLanguage: 'en',
    enabledLanguages: ['da', 'en', 'es', 'fi', 'fr', 'nb', 'sv', 'sl'],
    baseUrl: import.meta.env.PUBLIC_BASE_URL || '/',
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
    setTitle(title: string) {
        return `${title} – Zonemaster`;
    }
};

export default config;
```

## "config.ts" configuration options

* **defaultLanguage**: The default language to use when no language is specified.
  * The default language must be one of the enabled languages.
  * The default value is "en".
  * If this option is updated see [Updating Apache configuration] for required
    matching update of the Apache configuration.
* **enabledLanguages**: An array of language codes that are supported by the
  application.
  * The array should match the list of language codes in the [Locale setting] in
    the Backend configuration.
  * The array must only include language codes also included in
    `project.inlang/settings.json`, but it may be fewer. To add new languages,
    see [Translating Zonemaster-GUI]. `project.inlang/settings.json` must only be
    updated in that process.
* **baseUrl**: The base path Zonemaster-GUI is served on. By default it is "/".
  * If Zonemaster-GUI should be served on e.g. `http:/domaintest.xa/zonemaster`
    instead of just `http://domaintest.xa/` then this option to be set to
    "/zonemaster".
  * If this option is updated see [Updating Apache configuration] for required
    matching update of the Apache configuration.
* **apiBaseUrl**: The base URL for API requests. The default value is `/api`
  and must be kept so if `baseUrl` has its default value.
  * If `baseUrl` is updated, then this option must also be updated so that this
    option is equal to `baseUrl` + '/api', i.e. '/zonemaster/api' in the
    example above.
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

## Updating Apache configuration

Preferably do the updates to the `zonemaster.conf-example` file before building
the installation package. If done so the normal installation instruction can be
followed using the custom installation package.

### Finding "zonemaster.conf-example"

In the source tree the file is found as `zonemaster.conf-example` relative to the
root of the Git tree. It is included in the installation package and is installed
as `/usr/local/etc/apache24/Includes/zonemaster.conf` in a default
installation.

### defaultLanguage
If `defaultLanguage` has been updated in `config.ts` the "DEFAULT_LANGUAGE"
variable must be updated in `zonemaster.conf-example`. The same language code
must be used.

### baseUrl

If `baseUrl` has been set to a non-default value in `config.ts` the "BASE_URL"
variable must be defined with the same value. By default the variable is
undefined (`baseUrl` equal to "/").


[Build a custom Zonemaster-GUI installation package]:                    building-custom-gui.md
[Locale setting]:                                                        ../backend.md#locale
[Translating Zonemaster-GUI]:                                            ../../translation/Translating-GUI.md
[Updating Apache configuration]:                                         #updating-apache-configuration
