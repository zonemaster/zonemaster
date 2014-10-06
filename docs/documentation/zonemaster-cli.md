# NAME

zonemaster-cli - run Zonemaster tests from the command line

# SYNOPSIS

    zonemaster-cli nic.se
    zonemaster-cli --test=delegation --level=debug --no-time afnic.fr
    zonemaster-cli --list_tests

# DESCRIPTION

[zonemaster-cli](https://metacpan.org/pod/zonemaster-cli) is a command-line interface to the [Zonemaster](https://metacpan.org/pod/Zonemaster) test engine.
It does nothing itself except take the instructions the user provides as
command line arguments, transform them into suitable API calls to the engine,
run the requested test and print the resulting messages. The messages will be
translated by the engine's translation module, and possibly have a timestamp
and a module name prepended when printed.

# OPTIONS

- -h -? --usage --help

    Any of these print a rather too long summary of the command line switches, then
    quits the program.

- --version

    Prints the versions of this program, the [Zonemaster](https://metacpan.org/pod/Zonemaster) framework and the loaded
    test modules.

- --level=LEVEL

    Specify the minimum level that a message needs to have in order to be printed.
    That is, messages with this level or higher will be printed. The levels are, in
    order from highest to lowest, CRITICAL, ERROR, WARNING, NOTICE, INFO, DEBUG,
    DEBUG2 and DEBUG3. The lowest two levels show some of the internal workings of
    the test engine, and are probably not useful for ordinary users.

- --locale=LOCALE

    Specifies which locale to tell the translation system to use. If not given, the
    translation system itself will look at environment variables to try to guess.
    If the requested translation does not exist, it will fallback to the local
    locale, and if that doesn't exist either to English.

- --json

    Print results as JSON instead of human language.

- --raw

    Print messages as raw dumps instead of passing them through the translation
    system.

- --time, --no-time

    Turn the printing of timestamps on or off (default on).

- --show\_level, --no-show\_level

    Turn the printing of the message severity level on or off (default on).

- --show\_module, --no-show\_module

    Turn the printing of which module produced a message on or off (default off).

- --ns=NAME/IP

    Provide information about a nameserver, for undelegated tests. The argument
    must be a domain name and an IP address (v4 or v6) separated by a single slash
    character (/). This switch can (and probably should) be given multiple times.
    As long as any of these switches are present, their aggregate content will be
    used as the entirety of the parent-side delegation information.

- --save=FILENAME

    After the entire test has finished running, write the contents of the
    accumulated packet cache to a file with the given name.

- --restore=FILENAME

    Before starting the test, prime the packet cache with the contents from the
    file with the given name. The format of the file should be that produced by the
    save functions.

- --ipv4, --no-ipv4

    Allow or disallow the sending of IPv4 packets (default on).

- --ipv6, --no-ipv6

    Allow or disallow the sending of IPv6 packets (default on).

- --list\_tests

    Instead of running a test, list all the tests presented by the testing modules.

- --test=MODULE, --test=MODULE/METHOD

    Run only the specified tests. You can either give the name of a testing module,
    in which case that module will be asked to run all its tests, or you can give
    the name of a module followed by a slash and the name of a method in that
    module. The specified method will be called with a zone object as its single
    argument. It's up to the user to make sure that that is the kind of argument
    the method expects.

- --stop\_level=LEVEL

    As soon as a message of the given level or higher is logged, terminate the
    testing process.

- --config=FILE

    Load configuration from the file with the given name.

- --policy=FILE

    Load policy information from the file with the given name.

- --ds=KEYTAG,ALGORITHM,TYPE,DIGEST

    Provide a DS record for undelegated testing (that is, a test where the
    delegating nameserver information is given via --ns switches). The four pieces
    of data should be in the same format they would have in a zone file.

- --count, --no-count

    After the test run is finished, turn on or off the printing of a summary with
    the numbers of messages of the various levels that were logged during the run
    (default off).

- --progress, --no-progress

    Turn on or off the printing of a "spinner" showing that something is happening
    during the test run. The default is to print it if the process' standard output
    is a TTY, and to not print otherwise.

- --encoding=ENCODING

    Specify the character encoding that is used for command line arguments. This
    will be used to convert non-ASCII names to IDNA format, on which the tests will
    then be run.

    The default value will be taken from the `LC_CTYPE` environment variable if
    possible, and set to UTF-8 if not.

# SEE ALSO

[Zonemaster](https://metacpan.org/pod/Zonemaster)

# AUTHOR

Calle Dybedahl <calle@init.se>
