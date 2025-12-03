# Configuring Zonemaster-GUI using Theming

## Background

The Zonemaster-GUI is built to be cloned and customized. You have full control
over the styling and layout. That said, to avoid headaches when syncing with
the original repository, we recommend following a few simple guidelines:

- Start by customizing the **theme variables** — this is enough for most use cases.
- If that's not enough, apply **custom CSS** targeting specific elements.
- For large framework changes, **create a new theme** and update `tsconfig.json`.
- For interactive components, **keep changes minimal** to avoid breaking functionality.
- Use **headless mode** for major customizations or when building your own GUI.

## Related documents

For how to use `tsconfig.json` in connection to theming, see
[Advanced build-time configuring Zonemaster-GUI using "tsconfig.json"]. Theming
requires rebuilding Zonemater-GUI, see
[Build a custom Zonemaster-GUI installation package].

## Basic customization

The Zonemaster-GUI is built around a global theme based on CSS variables
(`./src/themes/default/styles/theme.css`). The easiest way to make your own theme
is to override theme variables in the `./src/themes/default/styles/custom.css` file.
You can tweak colors, fonts, spacing, and more. You'll get surprisingly far by
just updating the theme variables. All class names are prefixed with `zm-` to
avoid conflicts with other styles. This makes it easy to apply custom CSS on top
of the theme to target specific elements.

### Available theme variables

The theme includes variables for:
- **Font sizes and families**: `--font-xxs` through
  `--font-supersize`, `--font-body-family`, etc.
- **Spacing**: `--spacing-xxs` through `--spacing-xxl`
- **Colors**: Various color palettes including main, secondary, black, danger,
  success, info, warning, and error
- **GUI elements**: Background, text, borders, etc.
- **Buttons**: Size, color, padding
- **Layout**: Width, gaps, header height
- **Breakpoints**: For responsive design

### Example customization

Here's a simple example of customizing the main color and font in `custom.css`:

```css
:root {
  /* Change the primary color */
  --color-palette-main-50: #4285f4;
  --color-palette-main-70: #1a73e8;

  /* Change the font */
  --font-body-family: 'Roboto', sans-serif;
}
```

### CSS loading order

The CSS files are loaded in the following order (defined in `styles.css`):
1. theme.css (base theme variables)
2. foundation.css and other core styles
3. Component-specific CSS files
4. custom.css (your customizations)

This ensures that your custom styles will override the default styles.

## Modifying structure and layout

There are two layers of the GUI.

### Framework

The framework is the foundation of the GUI and is built with [Astro]. These
files are located under `./src/themes/default`. ' The starting point for these
imports are pages. Pages are simple, they consist of a single component wrapped
inside a layout. *We suggest not modifying the page files*. Instead, create your
own theme, for example `./src/themes/my-theme`. You can still reuse components
from the original theme in your new theme and mix and match the imports from your
custom theme.

Then update tsconfig.json

```diff
{
  "extends": "astro/tsconfigs/strict",
  "include": [".astro/types.d.ts", "**/*"],
  "exclude": ["dist"],
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "@/*": ["./src/*"],
-     "@theme/*": ["./src/themes/default/*"]
+     "@theme/*": ["./src/themes/my-theme/*"]
    }
  }
}
```

### Interactive components

All interactive components are built with [Svelte]. These files are located under
`./src/lib/components`. These are referenced from Astro components. We have tried
to make the components as self-contained as possible, but some components may
have dependencies on other components. In most cases you won't need to modify
these files. A better approach is to modify the CSS.

If you absolutely need to modify these. We suggest creating new components in
`./src/lib/components/my-theme` and reference them from the Astro components.
These interactive components contain important functionality that needs to be
carefully considered when modifying.

You might be better off creating a new component from scratch and integrate it
with the RPCAPI yourself.

## Headless mode

For major customizations or when you need complete control over the GUI, you can
use the "headless mode" approach. This involves using the Zonemaster API client
directly without the GUI components.

For detailed information about headless mode, please refer to the [UI.md]
documentation.

## Testing and troubleshooting

### Testing your theme changes

When making theme changes, it's important to test them across different pages and
components to ensure consistency. Here are some tips:

1. **Test on different screen sizes**: Use your browser's developer tools to test
   responsive behavior.
2. **Check all interactive states**: Verify hover, focus, active, and disabled
   states for interactive elements.
3. **Test with different content**: Make sure your theme works well with both
   short and long content.
4. **Verify accessibility**: Ensure sufficient color contrast and that focus
   states are visible.

### Common issues and solutions

- **Changes not appearing**: Make sure your `custom.css` file is being loaded.
  Check the browser's developer tools to verify.
- **Specificity issues**: If your styles aren't overriding the defaults, you
  might need to increase specificity or use `!important` (sparingly).
- **Responsive issues**: Check that your customizations work well at all
  breakpoints.
- **Component styling conflicts**: If styling a specific component, target the
  component's class directly rather than modifying global variables.

### Development workflow

For a smoother development experience:
1. Start the development server with `npm run dev`
2. Make changes to your `custom.css` file
3. The changes will be applied immediately thanks to hot module reloading
4. Use browser developer tools to inspect elements and test different values


[Advanced build-time configuring Zonemaster-GUI using "tsconfig.json"]:  configuring-using-tsconfig-json.md
[Build a custom Zonemaster-GUI installation package]:                    building-custom-gui.md
[Astro]:                                                                 https://astro.build/
[Configuration of GUI]:                                                  https://doc.zonemaster.net/latest/configuration/gui/README.html
[Svelte]:                                                                https://svelte.dev/
[UI.md]:                                                                 https://github.com/zonemaster/zonemaster-gui/blob/master/docs/UI.md#headless-mode

