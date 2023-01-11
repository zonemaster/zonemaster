# Using the CLI

## Table of contents
* [Docker or local installation](#Docker-or-local-installation)
* [Invoking the command line tool using Docker](#Invoking-the-command-line-tool-using-Docker)
* [Invoking the command line tool using local installation](#Invoking-the-command-line-tool-using-local-installation)
* [More details on the command line tool invocation](#More-details-on-the-command-line-tool-invocation)
* [Test reports](#Test-reports)
* [Translation]
* [Advanced use](#Advanced-use)
* [Docker on Mac with M1 chip](#Docker-on-Mac-with-M1-chip)


## Docker or local installation

The `zonemaster-cli` tool can be run from the command line of any computer that
meets one of the following requirements:

* Docker is installed on the computer, or
* Zonemaster-CLI has been installed on the computer.

### Using Docker

To run Zonemaster-CLI on Docker you have to make sure that Docker is installed
on the computer and that you can run Docker on it.
* Instructions for installation are found on Docker [get started] page.
* Run the command `docker ps` on the command line to verify that you can run
  Docker on the computer.

When Docker has been correctly installed, no more installation is needed to run
`zonemaster-cli`. Just follow the examples below.

There is a limitation in Docker regarding IPv6. Unless IPv6 has been enabled in
the Docker daemon, there is no support for IPv6. To avoid meaningless errors,
use `--no-ipv6` if there is no IPv6 support. Also see "[Enable IPv6 support]".

### Local installation

To have an local installation of Zonemaster-CLI follow the
[installation instruction]. When installed, the examples below can be followed.

If the network has no IPv6 support (common in home networks) then turn off IPv6.
Use `--no-ipv6` to avoid meaningless errors if there is no IPv6 support.


## Invoking the command line tool using Docker

The most basic use of the `zonemaster-cli` command is to just test a domain, e.g.
"zonemaster.net".

```sh
docker run -t --rm zonemaster/cli zonemaster.net --no-ipv6
```
or
```sh
docker run -t --rm zonemaster/cli zonemaster.net
```

To make sure that Docker uses the latest version, add `--pull always`, e.g.

```sh
docker run -t --rm --pull always zonemaster/cli zonemaster.net --no-ipv6
```

If `--pull always` is skipped, the invocation is quicker. The recommendation is
to include `--pull always` in the first command of a session to make sure latest
version is used, and then to exclude it to improve performance.


## Invoking the command line tool using local installation

The most basic use of the `zonemaster-cli` command is to just test a domain, e.g.
"zonemaster.net".

```sh
zonemaster-cli zonemaster.net
```
or
```sh
zonemaster-cli zonemaster.net --no-ipv6
```

## More details on the command line tool invocation

The output of any of the commands above comes continuously as the tests (test
cases) are performed.

```
Seconds Level     Message
======= ========= =======
  21.39 WARNING   The DNSKEY with tag 54636 uses an algorithm number 5 (RSA/SHA1) which is not recommended to be used.
  21.80 WARNING   DNSKEY with tag 26280 and using algorithm 5 (RSA/SHA1) has a size (1024) smaller than the recommended one (2048).
  23.61 NOTICE    SOA 'refresh' value (10800) is less than the recommended one (14400).
```

The test and output can be modified with different options:

* If your machine is not configured for use with IPv6 you want to disable the
  use of IPv6 with the `--no-ipv6` option.
* If you want to have the test case from which the message is printed then
  include the `--show-testcase` option.
* If you want to see the messages translated into another language (see
  "[Translation]" section below) then include e.g. `--locale da` (Docker) or
  `--locale da_DK.UTF-8` (local installation).

The same test as above with the three options included:

```sh
docker run -t --rm zonemaster/cli zonemaster.net --no-ipv6 --show-testcase --locale=da
```
```sh
zonemaster-cli zonemaster.net --no-ipv6 --show-testcase --locale=da_DK.UTF-8
```

To see all available command line options, use the `--help` command.

```
zonemaster-cli --help
```

### Using Docker or local installation

The difference between running `zonemaster-cli` on Docker or local installation
is the invocation string, `docker run -t --rm zonemaster/cli` vs.
`zonemaster-cli`. To simplify this document, from now on the shorter
`zonemaster-cli` will be used and for Docker the longer string will be assumed.
To simplify repeated invocation on Docker an alias can be created for the shell.


## Test reports

The severity level of the different messages is CRITICAL, ERROR, WARNING, NOTICE,
INFO, DEBUG, DEBUG2 or DEBUG3. The default reporting level is NOTICE and higher.
To change the level of reporting you can use a command line option, e.g
`--level=INFO` includes level INFO and higher in the report. See
"[Severity Level Definitions]" for more information on the levels.

By default the output is formatted as plain text in English (or some other
language), but other more "technical" output formats are also available with
options `--raw` and `json`, respectively.


## Translation

### In Docker

By default all messages are in English. By using the `--locale=LANG` option
another language can be selected. Select "LANG" from the table below to have
Zonemaster translated into that language.

LANG | Language
-----|---------
da   | Danish
en   | English
fi   | Finnish
fr   | French
nb   | Norwegian
es   | Spanish
sv   | Swedish

E.g.:
```sh
docker run -t --rm zonemaster/cli zonemaster.net --locale=da
```

An alternative is to set the `LC_ALL` environment variable with correct language
value when the command is invoked, which can be useful if a shell alias is
created. E.g.
```sh
docker run -e LC_ALL=da -t --rm zonemaster/cli zonemaster.net
```

If environment variable `LC_ALL` is set in the local shell with the correct
"LANG" or with the equivalent "LOCALE" in from next section, then the following
command will export `LC_ALL` with the that value to the docker container.
```sh
docker run -e LC_ALL -t --rm zonemaster/cli zonemaster.net
```

Environment vaiables `LANG` and `LC_MESSAGES` can be used in the same way as
`LC_ALL`.


### In local installation

By default all messages are in the language set in the local environment (if
available in Zonemaster) or else in English. By using the `--locale=LOCALE`
option another language can be selected. Select "LOCALE" from the table below to
have Zonemaster translated into that language.

LOCALE      | Language
------------|---------
da_DK.UTF-8 | Danish
en_US.UTF-8 | English
fi_FI.UTF-8 | Finnish
fr_FR.UTF-8 | French
nb_NO.UTF-8 | Norwegian
es_ES.UTF-8 | Spanish
sv_SE.UTF-8 | Swedish

E.g.:
```sh
docker run -t --rm zonemaster/cli zonemaster.net --locale=da_DK.UTF-8
```

If the environment variable `LANGUAGE` is set with correct LOCALE then no option
is needed, e.g. `LANGUAGE=da_DK.UTF-8`. `zonemaster-cli` also respects `LC_ALL`,
`LC_MESSAGES` and `LANG`. `LANGUAGE` takes precedence over the other, and then
the order is `LC_ALL`, `LC_MESSAGES` and last `LANG`.

## Advanced use

There are some nice features available that can be of some use for advanced
users.

### Only run specific test cases

If you only want to run a specific test case rather than the whole suite of
tests, you can do that as well. E.g. test only test case [Connectivity03]:
```sh
zonemaster-cli --test Connectivity/connectivity03 example.com
```

Or all test case in the Connectivity test level:
```sh
zonemaster-cli --test Connectivity example.com
```

For more information on the available tests, you can list them right from
the command line tool:
```sh
zonemaster-cli --list_tests
```

### Use custom root hints

You can override the built-in list of root servers that `zonemaster-cli` uses
by providing a path to a custom root hints file with the `--hints HINTS-FILE`
option. For example:

```sh
zonemaster-cli --hints /path/to/custom.hints example.com
```

If you are running `zonemaster-cli` using Docker, you must mount your custom
root hints file inside the container using a volume so that `zonemaster-cli`
can access it, like so:

```sh
docker run -t --rm \
    -v /path/to/custom.hints:/hints \
    zonemaster/cli --hints /hints example.com
```

## Undelegated test

Before you do any delegation change at the parent, either changing the NS
records, glue address records or DS records, you might want to perform a
check of your new child zone configuration so that everything you plan to
change is in order. Zonemaster can do this for you. All you have to do
is give Zonemaster all the parent data you plan to have for your new
configuration. Any DNS lookups going for the parent will instead be
answered by the data you entered. E.g.

```sh
zonemaster-cli --ns ns1.example.com/192.168.23.23 \
  --ns ns2.example.com/192.168.24.24 \
  --ds 12345,3,1,123456789abcdef67890123456789abcdef67890
```

Any number of NS records and DS records can be given multiple times.
The syntax of the NS records is name/address, and the address can be
both IPv4 and IPv6. The DS syntax is keytag,algorithm,type,digest.

You can also choose to do a undelegated test using only the new DS
record, but keep the NS records from the parent by only specifying the
DS record and no NS records on the command line.


## Docker on Mac with M1 chip

If you run the Docker commands above on a Mac computer with the M1 chip, then you
will get the following warning:

> WARNING: The requested image's platform (linux/amd64) does not match the
> detected host platform (linux/arm64/v8) and no specific platform was requested

The warning says that the image is created for Intel/AMD64 architecture, and that
is not what your computer has. To get rid of the warning, add
`--platform linux/amd64` to `docker run`, e.g.

```sh
docker run --platform linux/amd64 -t --rm zonemaster/cli zonemaster.net --no-ipv6
```

If you search for the error messages you will get suggestions for how to
automatically include the `--platform linux/amd64` option every time you run
`docker run`.


[Connectivity03]:                  https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/Connectivity-TP/connectivity03.md
[Get started]:                     https://www.docker.com/get-started
[Installation instruction]:        docs/Installation.md
[Severity Level Definitions]:      https://github.com/zonemaster/zonemaster/blob/master/docs/specifications/tests/SeverityLevelDefinitions.md
[Translation]:                     #Translation
[Enable IPv6 support]:             https://docs.docker.com/config/daemon/ipv6/
