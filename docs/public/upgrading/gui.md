# Upgrade GUI

## Overview

This document documents manual steps needed to keep customizations, if any, from
one version of Zonemaster-GUI to a later version. If no such customizations exist
nothing special has to be done.

| Current Zonemaster-GUI version | Comments                                                 |
|--------------------------------|----------------------------------------------------------|
| version < v5.0.0               | Any `assets/app.config.json` could be migrated to v5.0.0 |

## Find version of GUI

Go to the start web page of Zonemaster. In the lower left corner you can find the
the Zonemaster-GUI version.

## Migrating pre-v5.0.0 to v5.0.0

If `assets/app.config.json` is found in installed Zonemaster-GUI go to the
following documents to migrates its content:
* [Configuring Zonemaster GUI using "config.json"]
* [Configuring Zonemaster GUI using "config.ts"]


[Configuring Zonemaster GUI using "config.json"]:                    ../configuration/gui/configuring-using-config-json.md
[Configuring Zonemaster GUI using "config.ts"]:                      ../configuration/gui/configuring-using-config-ts.md
