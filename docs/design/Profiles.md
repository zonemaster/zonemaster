# Profiles

## Overview

Profiles is a configuration format and feature of Zonemaster Engine.
Each of Zonemaster CLI, Backend and GUI allow users and administrators to configure Zonemaster Engine with different profiles.


## Background

The Zonemaster requirements and specification documents speak of user-configurable profiles and policies for Zonemaster Engine and CLI.
The Profiles feature integrates both of those into a single data structure.


## Profiles in Zonemaster Engine

Zonemaster Engine has an effective profile that guides how it performs its tests and analyzes their results.
It comes with a sensible default profile while allowing applications to override the default behvior.
This is described in greater detail in the [Zonemaster::Engine::Config] documentation.


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
[Zonemaster Backend RPC-API]: https://github.com/dotse/zonemaster-backend/blob/master/docs/API.md
[Zonemaster Backend configuration]: https://github.com/dotse/zonemaster-backend/blob/master/docs/Configuration.md#profiles-section
[Zonemaster::Engine::Config]: https://metacpan.org/pod/Zonemaster::Engine::Config


Copyright (c) 2017, IIS (The Internet Foundation in Sweden)\
Copyright (c) 2017, AFNIC\
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work. If not, see <https://creativecommons.org/licenses/by/4.0/>.
