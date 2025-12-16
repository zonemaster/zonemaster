# Advanced build-time configuring Zonemaster-GUI using "tsconfig.json"

The `tsconfig.json` configuration file can be used for *build-time* settings of
Zonemaster-GUI. Any changes to this file require a rebuild of the installation
package.

## Finding "tsconfig.json"

In the source tree the file is found as `tsconfig.json` relative to the root of
the Git tree. It does not exist in the installed Zonemaster-GUI, as the values
have been built-in.

## Rebuilding Zonemaster-GUI after update

When `tsconfig.json` has been updated, Zonemaster-GUI has to be rebuilt. See
[building installation package] for how to get the source tree and building a new
installation package.

## Default "tsconfig`.json"

The `tsconfig.json` file is a TypeScript configuration file that includes path
aliases like `@theme/*` to simplify imports and make theming more manageable.


```json
{
  "extends": "astro/tsconfigs/strict",
  "include": [".astro/types.d.ts", "**/*"],
  "exclude": ["dist"],
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "@/*": ["./src/*"],
      "@theme/*": ["./src/themes/default/*"]
    },
    "resolveJsonModule": true,
    "esModuleInterop": true
  }
}
```

## @theme/* Alias in "tsconfig.json"

The path alias configuration allows importing from the default theme directory
using the `@theme` prefix, which makes it possible to create a customize the
look-and-feel of the Zonemaster-GUI, e.g. set other colors and type faces.

```json
{
  "paths": {
    "@/*": ["./src/*"],
    "@theme/*": ["./src/themes/default/*"]
  }
}
```

This alias makes it easier to import theme-specific components and styles
in your code. For example, instead of writing:

```typescript
import Button from '../../themes/default/components/Button';
```

You can use:

```typescript
import Button from '@theme/components/Button';
```

This approach simplifies imports and makes it easier to switch between different
themes by changing the alias path.


## Theming

In the [Theming Zonemaster-GUI] document you will find instructions how to add
custom theming to Zonemaster-GUI.


[Building installation package]:                 building-custom-gui.md
[Theming Zonemaster-GUI]:                        https://github.com/zonemaster/zonemaster-gui/blob/master/docs/theming-zonemaster-gui.md
