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

## Preset profiles

This section describes publicly available "preset" profiles, included in the Zonemaster
installation by default. These reside in the [share/profiles][profiles] directory of
Zonemaster-Engine, whose path can be found with the following command on a default
installation:

```
echo "$(perl -MFile::ShareDir=dist_dir -E 'say dist_dir("Zonemaster-Engine")')/profiles/"
```

### KINDNS

[Knowledge-Sharing and Instantiating Norms for DNS and Naming Security (KINDNS)][KINDNS] is
a program supported by ICANN to develop and promote a framework that focuses on the most
important operational best practices or concrete instances of DNS security best practices.

The following table maps KINDNS practices to the corresponding Zonemaster test cases included in this profile:

KINDNS Practice                                                                                                                  | Zonemaster Test Case equivalence
:--------------------------------------------------------------------------------------------------------------------------------|:-----------------------------------------------------------
Practice 1: Authoritative zones MUST be DNSSEC signed and best practices for key management MUST be followed.                    | DNSSEC07 (DNSSEC Usage), DNSSEC Testplan (DNSSEC Validity) |
Practice 2: Access to zone transfer between authoritative servers MUST be limited. Configure ACLs and TSIG in the DNS Authoritative software package to restrict zone transfers to secondary servers only.                                                                                                                            | Nameserver03                                               |
Practice 3: Zone file integrity MUST be controlled to avoid unexpected modifications (malicious or accidental).                  | N/A                                                        |
Practice 4: Authoritative and recursive DNS service MUST NOT coexist on the same DNS server.                                     | Nameserver01                                               |
Practice 5: At least two distinct nameservers MUST be used for any given zone.                                                   | Delegation01, Delegation02                                 |
Practice 6: There MUST be diversity in the authoritative operations to promote resilience: software, network, geographical       | Software: Nameserver15 - Network: Connectivity03, Connectivity04 - Geographical: None                                                                                                                                                                          |
Practice 7: Monitoring of the services, servers, and network equipment that make up your DNS infrastructure MUST be implemented. | N/A                                                        |

Note that besides the aforementioned test cases in the table above, this profile also includes the Basic Testplan.

[KINDNS]:                              https://kindns.org/
[Profile properties]:                  https://metacpan.org/pod/Zonemaster::Engine::Profile#PROFILE-PROPERTIES
[profile_additional_properties.json]:  https://github.com/zonemaster/zonemaster-engine/blob/master/share/profile_additional_properties.json
[profiles]:                            https://github.com/zonemaster/zonemaster-engine/blob/master/share/profiles/