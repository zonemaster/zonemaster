Modifying the default features in Zonemaster
=============================================

We have different ways of modifying the default features in Zonemaster:

## 1. Config

Wherever in the code, when the configuration object is used, the system will
look for a file named "config.json"

```sh
{
   "asnroots" : [ "asnlookup.zonemaster.net", "asnlookup.iis.se",
"asn.cymru.com"],
   "net" : {
      "ipv4" : 1,
      "ipv6" : 1
   },
   "no_network" : 0,
   "resolver" : {
      "defaults" : {
         "debug" : 0,
         "dnssec" : 0,
         "edns_size" : 0,
         "igntc" : 0,
         "recurse" : 0,
         "retrans" : 3,
         "retry" : 2,
         "usevc" : 0
      }
   }
}
```
Examples of overriding the config file:
 * 1. "no_network" : 0 (use network traffic)
 * 2. "no_network" : 1 (Forbid network traffic)
 * 3. "retry" : 2  (retry twice) etc..

If one wants to override the internal configurations, they should modify the
"values" in the "config.json" file. The possibility of overriding basic
configuration using the "config.json" file is limited to basic features such as
the "resolver", "log filters", "network features", "IPv4", "IPv6"and "asnroots".

There are three places for config.json:

 * 1. The default place (installed by package) is in
/usr/local/share/perl/5.18.2/auto/share/dist/Zonemaster on Ubuntu (perl
-MFile::ShareDir=dist_dir -E 'say dist_dir( "Zonemaster" )').
 * 2. A config.json in /etc/zonemaster will override the default file. This the place
to do local settings.
 * 3. A config.json in ~/.zonemaster will override the the other. This is for personal
settings, or settings for a system user.

To override the three files, a config file can be loaded with
load_config_file().

When overriding, only the defined keys will be replaced with new value.

The "config.json" file under the directory "/t" is for the unnit tests.

## 2. Policy

Zonemaster engine runs a certain number of tests. It is possible to configure
which tests needs to be run and also the severity level of the results that will
be reported via the "policy" files. 

There are two places where we find "policy" related files in the engine:

 * 1. In the "t/policies directory/" there are a number of policy files. Those are only
used by the unit tests. There are two ways that the policy files in this directory can be overridden. 

a). To decide which tests to run: 
In the "t/policies/" directory, we have a file which groups all the tests for each test case category (such as "nameserver, dnssec etc..). For example, for "nameserver" category,  we have
"Test-nameserver-all.json". In this file, the top-level key is "__testcases__".
The value of that must be a hash, where the keys are names (e.g. "syntax01") of
test cases from the test specifications, and the corresponding values are
booleans specifying if the test case in question should be executed or not. If 
the boolean value is "0", the particular test will not be run.

```sh
{
    "__testcases__": {
        "syntax01": 1,
        "syntax02": 1,
        "syntax03": 1,
        "syntax04": 1,
        "syntax05": 1,
        "syntax06": 0,
        "syntax07": 1,
        "syntax08": 1
    }
}
```

Any missing test cases are treated as if they had the value true set.

b). To decide on the severity of the results of the tests:
Once, these tests are run, they either fail or succeed. In the event of a test
being failed, they are classified into different error levels : "NOTICE",
"INFO", "WARNING", "ERROR", "CRITICAL" etc. This classification of the severity
level is done in the file "policy.json". An example for a test category
("syntax") is as follows:

```sh
 "SYNTAX" : {
      "DISCOURAGED_DOUBLE_DASH" : "WARNING",
      "INITIAL_HYPHEN" : "ERROR",
      "MNAME_DISCOURAGED_DOUBLE_DASH" : "WARNING",
      "MNAME_NON_ALLOWED_CHARS" : "WARNING",
      "MNAME_NUMERIC_TLD" : "WARNING",
      "MNAME_SYNTAX_OK" : "INFO",
[...]
```

The top-level keys (e.g. "SYNTAX") are upper-case-only versions of test module
names, and under them is all the policy data for that particular module. The
keys in the next level down are, with one exception, logger tags
("DISCOURAGED_DOUBLE_DASH").  The exception is the special key DISABLED, which
if given a true value will prevent the module from being executed. The values
for the tag keys should be the severity level ("WARNING") for that tag.

 * 2. In the "/share/" directory, there is a "policy.json" file. The paramters
 to decide which tests to run and the severity of the results of the tests are
 grouped in the same file:
  

```sh
{
   "ADDRESS" : {
      "NAMESERVER_IP_PRIVATE_NETWORK" : "ERROR",
      "NAMESERVER_IP_PTR_MISMATCH" : "NOTICE",
      "NAMESERVER_IP_PTR_MATCH" : "INFO",
      "NAMESERVER_IP_WITHOUT_REVERSE" : "WARNING",
      "NAMESERVERS_IP_WITH_REVERSE" : "INFO",
      "NO_IP_PRIVATE_NETWORK" : "INFO",
      "NO_RESPONSE_PTR_QUERY" : "WARNING"
   },
   "BASIC" : {
      "A_QUERY_NO_RESPONSES" : "INFO",
      "DOMAIN_NAME_LABEL_TOO_LONG" : "CRITICAL",
      "DOMAIN_NAME_ZERO_LENGTH_LABEL" : "CRITICAL",
      "DOMAIN_NAME_TOO_LONG" : "CRITICAL",
      "HAS_A_RECORDS" : "ERROR",
[..]
```
The top-level keys (e.g. "ADDRESS") are upper-case-only versions of test module
names, and under them is all the policy data for that particular module. The
keys in the next level down are, severity levels ("INFO").

```sh
 "__testcases__": {
        "address01": true,
        "address02": true,
        "address03": true,
        "basic03": true,
        "connectivity01": true,
        "connectivity02": true,
        "connectivity03": true,
        "consistency01": true,
        "consistency02": true,
        "consistency03": true,
        "consistency04": true,
        "consistency05": true,
        "dnssec01": true,
        "dnssec02": true,
        "dnssec03": true,
        "dnssec04": true,
        "dnssec05": true,
        "dnssec07": true,
```
In this file, the top-level key is "testcases". The value of that must be a
hash, where the keys are names (e.g. "address01") of test cases from the test
specifications, and the corresponding values specifying if the test
case in question should be executed or not. If the value is "false", the
particular test will not be run.

## 3. Profile  

The "engine" is the core which runs the tests. The engine is called by different
interfaces (CLI, Web, API etc..). Also, the "engine" could be accessed by
different users in different manner. 

E.g:1 A user accesses using the "public" web interface (zonemaster.net): 
In this case, the zonemaster service provider could provide different choices of
test to the user. The "choices" being the tests being run and the severity level
as defined in the "Policy" section. Thus, there could be different profiles
(such as Afnic_Profile, IANA profile, IIS profile RIPE profile etc..). The
profile file will actually be a policy file which mentions what tests to run and
the severity level for each of the test being run. Here, the user can only
choose from the different profiles available via the web interface and he does
not have the possibility of running the tests with his own choice.

E.g:2 A user installs the engine and the CLI in his own machine. He can add his
own "profile " file (e.g. my_profile.json). In that case he should be able to
override the default "config" and "policy" files. He should add this profile
file in the appropriate directory following the default "config" and "profile"
format. The easiest way to create a modified policy/config is to copy the
default one and change the relevant values. He should be able to load the
profile file using the following command from the command line:

```sh
zonemaster-cli --profile "profilename"
```


E.g:3 A user installs the engine, the CLI (optional), the backend and the GUI in
his own machine. Now he can access his own web interface (e.g:
http://localhost). He can add his own profile as described in e.g:2. The web
interface should be able to load this profile file in the appropriate drop down
menu and run the appropriate tests.

E.g:4 A user installs the engine, the CLI (optional) and the backend. He can add
his own profile as described in e.g:2. He should be able to load the profile
through the API call as follows:

```sh
{
  "jsonrpc": "2.0",
  "id": 4,
  "method": "start_domain_test",
  "params": {
    "client_id": "Zonemaster Dancer Frontend",
    "domain": "zonemaster.net",
    "profile": "my_profile",
    "client_version": "1.0.1",
    "nameservers": [
      {
        "ip": "2001:67c:124c:2007::45",
        "ns": "ns3.nic.se"
      },
      {
        "ip": "192.93.0.4",
        "ns": "ns2.nic.fr"
      }
    ],
    "ds_info": [],
    "advanced": true,
    "ipv6": true,
    "ipv4": true
  }
}
```


## 4. Translator: 

This section is useful in the case, when an user wants to add a new language
(english, French and Swedish are already available) and have the results of the
tests in the newly added language.

The translation files live in the subdirectory share in the Zonemaster source
directory, and are named as {language_code}.po (for example, en.po, sv.po or
fr.po). The master file is en.po. All other translations should be based on that
file, and that file should never be edited. It is produced by running the script
util/extract_po.pl, which will walk through all installed Zonemaster test
modules, pull out their provided English translations and make these into a
valid "po" file. 

In order to make a new translation usable, it must be compiled to "mo" format
and installed. The first step needs the "msgfmt" program from the GNU gettext
package to be installed and available in the shell path. As long as it is, it
should be enough to go to the share directory and run make.

For the new translation to actually be installed, the "mo" file must be added to
the "MANIFEST" file. At the end of the make run, it should have printed a list
of all the paths that has to be there. Just open "MANIFEST" in a text editor,
check that all the lines are in there and add any that are missing (if you just
added a new translation, that will be missing, for example).

Once the new translation is compiled and added to "MANIFEST", the normal Perl
make install process will install it.

Don't forget to commit the new po and mo files to git.

## 5. Filter

This feature is intended to allow more fine-grained control over certain tests,
which cannot be done by the "policy" file.  The intended use is to remove known
erroneous results. If you, for example, know that a certain name server is
recursive and for some reason should be, you can use this functionality to lower
the severity of the complaint about it to a lower level than normal (for e.g.
from CRITICAL to WARNING).


The config file for the filter feature lives in the "share" directory of the
engine.  

This filter feature will not be accessible for an end-user using the public web
GUI. It can be accessible via the CLI as follows:

```sh
zonemaster-cli --config filter_config_file 
```


To access this file from the backend, modify the following line in the
"backend_config.ini" file in the backend by providing the appropriate path ot
your filter config file. 

```sh
config_logfilter_1=/full/path/to/a/config_file.json
```

The top-level key is the "loggilter". The keys in the next level down (e.g.
"BASIC") are upper-case-only versions of test module names and then logger tags
("IPV6_ENABLED")

The the data under the logfilter key should be structured like this:

```sh
Module
    Tag
       "when"
          Hash with conditions
        "set"
          Level to set if all conditions match
```

The hash with conditions should have keys matching the attributes of the log
entry that's being filtered (check the translation files to see what they are).
The values for the keys should be either a single value that the attribute
should be, or an array of values any one of which the attribute should be.

A complete entry might could look like this:

```sh
"logfilter" : {
      "BASIC" : {
         "IPV6_ENABLED" : [
            {
               "when" : {
                  "rrtype" : "NS",
                  "ns" : "f.ext.nic.fr",
                  "address" : "2001:67c:1010:11::53"
               },
               "set" : "WARNING"
            },
            {
               "when" : {
                  "ns" : "h.ext.nic.fr"
               },
               "set" : "ERROR"
            }
         ]
      },
```
It is worth mentioning that the filtering is defined in the same config file as
described in the "config" section. This means that system wide filtering could be achieved by
creating or updating e.g. /etc/zonemaster/config.json.

 * [1]. https://github.com/dotse/zonemaster-engine/blob/master/docs/ConfigAndPolicy.pod
 * [2]. http://search.cpan.org/~znmstr/Zonemaster-v1.0.16/lib/Zonemaster/Config.pm
 * [3] . https://github.com/dotse/zonemaster-engine/blob/master/docs/Translation.pod
 * [4]. http://search.cpan.org/~znmstr/Zonemaster-v1.0.16/lib/Zonemaster/Config.pm#logfilter

