# ZoneMaster users guide

## How to get started

In order to use any of the ZoneMaster tools you need access to the tools.
Please refer to the [installation document](installation.md) on how to
install the software.

## Using the CLI

### Invoking the command line tool

The most basic use of the `zonemaster-cli` command is to just test a domain
like this:

    $ zonemaster-cli example.com

The output comes continously as the tests are performed.

    Seconds Level     Message
    ======= ========= =======
       1.16 NOTICE    No illegal chatacters in the domain name (example.com).
       2.01 WARNING   SOA 'refresh' value (10800) is less than the recommended one (14400).
      13.86 CRITICAL  All nameservers are in the same AS (12345).
      13.87 NOTICE    123.456.789.0 returned no DS records for example.com.

### Test reports

The different message levels are CRITICAL, ERROR, WARNING, NOTICE, INFO,
DEBUG, DEBUG2 and DEBUG3. The default reporting level is NOTICE and higher.
To change the level of reporting you can use the command line switch
--level=LEVEL.

The default level reporting is in plain english, but other output formats
are also available. The `--lang=raw` option will give you the technical
language output; instead of english the messages will be displayed as a
combination of test level and test case message for easy mapping into each
test case executed by ZoneMaster.

For automatic parsing of the output, the option to have the output reported
in JSON might be better suited. Use `--lang=json` to have the output in JSON
format. The JSON format is described in the [JSON Output](json-output.md)
document.

### Advanced use

## Using the Web Interface

## Test results
