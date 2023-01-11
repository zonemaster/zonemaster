# Profiles

## Default profile

The default profile is documented in the [profile properties] section
of the Zonemaster::Engine::Profile module.

The default profile is stored in a default profile file, [profile.json],
always loaded by Zonemaster-Engine.

## Creating profiles

Some properties are empty by default such as `logfilter` and
`test_cases_vars`. Those properties are not present in the default
profile. For an example of their usage, refer to the additional file,
[profile_additional_properties.json].

The content of the two files, as-is or modified, can be merged into a custom
profile file that can be loaded by Zonemaster-Engine. Both Zonemaster-CLI and
Zonemaster-Backend have direct options for loading a custom profile file.

A custom profile file only has to contain those properties that are changed
in comparison to the default profile file.

You are adviced not to modify the default profile file in the default path on
installed Zonemaster, since such modifications will be overwritten by updates
of Zonemaster.


[profile.json]:                        ../share/profile.json
[profile_additional_properties.json]:  ../share/profile_additional_properties.json
[Profile properties]:                  https://metacpan.org/pod/Zonemaster::Engine::Profile#PROFILE-PROPERTIES
