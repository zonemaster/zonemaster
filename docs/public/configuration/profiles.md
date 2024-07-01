# Profiles

## Default profile

The default profile is documented in the [profile properties] section
of the Zonemaster::Engine::Profile module.

The default profile can be extracted from Zonemaster-Engine to a file using this command.

```sh
perl -MZonemaster::Engine::Test -E 'say Zonemaster::Engine::Profile->default->to_json' | jq -S . > profile.json
```

## Creating profiles

Some properties are empty by default such as `logfilter` and
`test_cases_vars`. Those properties are not present in the default
profile. For an example of their usage, refer to the additional file,
[profile_additional_properties.json].

The content of the two files, as-is or modified, can be merged into a custom
profile file that can be loaded by Zonemaster-Engine. Both Zonemaster-CLI and
Zonemaster-Backend have direct options for loading a custom profile file.

A custom profile file only has to contain those [properties][profile properties]
that it should override.


[profile_additional_properties.json]:  https://github.com/zonemaster/zonemaster-engine/blob/master/share/profile_additional_properties.json
[Profile properties]:                  https://metacpan.org/pod/Zonemaster::Engine::Profile#PROFILE-PROPERTIES
