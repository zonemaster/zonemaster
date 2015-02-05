# Zonemaster users guide

## How to get started

In order to use any of the Zonenaster tools you need access to the tools.
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
       1.16 NOTICE    No illegal characters in the domain name (example.com).
       2.01 WARNING   SOA 'refresh' value (10800) is less than the recommended one (14400).
      13.86 CRITICAL  All nameservers are in the same AS (12345).
      13.87 NOTICE    123.456.789.0 returned no DS records for example.com.

If your machine is for some reason not configured for use with IPv6 you
want to disable the use of IPv6 with the `--no-ipv6` option. If you want
to see how your domain is configured to be used with no IPv4 available
for the client there is also the `--no-ipv4` option - however, both cannot
be used at the same time.

To see all command line options, use the `--help` command.

### Test reports

The different message levels are CRITICAL, ERROR, WARNING, NOTICE, INFO,
DEBUG, DEBUG2 and DEBUG3. The default reporting level is NOTICE and higher.
To change the level of reporting you can use the command line switch
--level=LEVEL. The DEBUG levels are mainly used by developers, and are
useful to debug the different test cases.

The default level reporting is in plain english, but other output formats
are also available. The `--lang=raw` option will give you the technical
language output; instead of english the messages will be displayed as a
combination of test level and test case message for easy mapping into each
test case executed by Zonemaster. This means that the output is not
dependent on any language changes, and better suited for automatic parsing
of the output.

For even better automatic parsing of the output, the option to have the
output reported in JSON might can be used. Use `--lang=json` to have the
output in JSON format. The JSON format is described in the
[JSON Output](json-output.md) document.

More detailed documentation can by found in the [manual page](zonemaster-cli.md)

### Advanced use

There are some nice features available that can be of some use for advanced
users.

**Save and restore**

You can record all data from a test session using the `--save
filename` option to record all DNS data. This can later be replayed for
Zonemaster using `--restore filename`, and this will make Zonemaster to
use the saved DNS traffic for testing rather than using the live DNS tree.
You can use this if you change your policy (see Policy configuration below)
and see how this change will affect any previous tests, or if you find a
strange error in a DNS configuration that is hard to duplicate - then this
saved file can be sent to a developer that can take a closer look into the
issue.

**Only run specific test**

If you only want to run a specific test rather than the whole suite of
tests, you can do that as well. If you want to see if the name servers for
a domain are in enough different ASNs, you can run this test case:

    $ zonemaster-cli --test Connectivity/connectivity03 example.com

For more information on the available tests, you can list them right from
the command line tool:

    $ zonemaster-cli --list_tests

**Halt early**

If you want to check a domain for some problem, but do not wish to wait
until all tests are finished you can have Zonemaster exit when the first
error of a certain severity level has been reached:

    $ zonemaster-cli --stop_level NOTICE example.com

This will halt execution as soon as a NOTICE or higher message is received.

### Pre-delegation Testing

Before you do any delegation change at the level of the parent, either
changing the NS records, glue address records or DS records, you might
want to perform a check of your new child zone configuration so that
everything you plan to change is in order. Zonemaster can do this for
your, all you have to do is give Zonemaster all the parent data you
plan to have for your new configuration. Any DNS lookups going for
the parent will instead be answered by the data you entered.

    $ zonemaster-cli --ns ns1.example.com/192.168.23.23 \
	  --ns ns2.example.com/192.168.24.24 \
	  --ds 12345,3,1,123456789abcdef67890123456789abcdef67890

Any number of NS records and DS records can be given multiple times.
The syntax of the NS records is name/address, and the address can be
both IPv4 and IPv6. The DS syntax is keytag/algorithm/type/digest.

You can also choose to do a Pre-delegation test using only the new DS
record, but keep the NS records from the parent by only specifying the
DS record and no NS records on the command line.

## Configuration

### Policy Configuration

## Using the Web Interface

The web interface allow to run the Zonemaster Engine tests on domains from a simple web interface.

The interface has 2 main tabs and one tab with a FAQ/Documentation.

The first tab called "Domain check" in the English version of the interface allows to enter a domain name in an input field and start the test. The user can enable or disable IPv4 or IPv6 transport protocol if he checks the advanced options check-box.

The second tab called "Pre-delegated domain" in the English version of the interface allow to run the Zonemaster Engine on a domain and offers the user the possibility to change Nameservers and Digests.
To start a test in this tab the user must first enter the domain name he wants to test and then press the “Fetch data from parent zone” button. He can then change the nameservers and digests.
Another way to run start the test is to manually input at least one namesterver.

After starting the test a progress bar appears. Once it reaches 100% (usually a test takes around 30 seconds to complete) the test results are displayed. 

The test result component has 4 tabs. The first tab (named “Basic”) shows the results categories each category can e extended to see the tests it contains. Each category is either green if all tests it contains finished without error nor warning, orange if it contains at least one warning or red if it contains at least one “error” or “critical” result for a test.
The advanced tab contains the results all extended. 
The export tab allows to download the results in text format.
The History tab shows previously run tests on this domain.

## Test Results



-------

Copyright (c) 2013, 2014, 2015, .SE (The Internet Infrastructure Foundation)  
Copyright (c) 2013, 2014, 2015, AFNIC  
Creative Commons Attribution 4.0 International License

You should have received a copy of the license along with this
work.  If not, see <http://creativecommons.org/licenses/by/4.0/>.
