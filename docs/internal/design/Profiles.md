# Profiles

## Overview

Profiles is a configuration format and feature of Zonemaster Engine.
Each of Zonemaster CLI, Backend and GUI allow users and administrators to configure Zonemaster Engine with different profiles.

This document provides a high-level view of how profiles are applied across the different Zonemaster components.
For details on how profiles integrate with a given component, refer to the respective component documentations.
Links to the relevant sections are provided below.


## Background

The Zonemaster requirements and specification documents speak of user-configurable profiles and policies 
for Zonemaster Engine and CLI.

In release v2018.2 all of the configurable features "config", "filter", "policy" and "profile" from the 
requirements and specifications were integrated into a single data structure, also called "profile".


## Profiles in Zonemaster Engine

Zonemaster Engine has an effective profile that guides how it performs its tests and analyzes their results.
It comes with a sensible default profile while allowing applications to override the default behavior.
This is described in greater detail in the [Zonemaster::Engine::Profile] documentation.


## Profiles in Zonemaster Backend

Zonemaster Backend allows its administrators to configure available profiles for its users to choose from.
Configuration is described in greater detail in the [Zonemaster Backend configuration] documentation.
The [Zonemaster Backend RPC-API] documentation lists methods that accept profile name arguments.


## Profiles in Zonemaster CLI

Zonemaster CLI allows users to specify the path to a profile to be used when starting a test.
If no profile is specified, the Zonemaster Engine default profile is used.


## Profiles in Zonemaster GUI

Zonemaster GUI allows the user select profile from a set of choices.
The available profile choices are configured in a JSON file that maps profile name strings to description strings.


-------
[Zonemaster Backend RPC-API]: ../../public/using/backend/rpcapi-reference.md
[Zonemaster Backend configuration]: ../../public/configuration/backend.md#public-profiles-and-private-profiles-sections
[Zonemaster::Engine::Profile]: https://metacpan.org/pod/Zonemaster::Engine::Profile

