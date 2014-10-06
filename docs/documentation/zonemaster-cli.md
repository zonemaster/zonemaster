<?xml version="1.0" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link rev="made" href="mailto:called@necronomicon-ii.local" />
</head>

<body>



<ul id="index">
  <li><a href="#NAME">NAME</a></li>
  <li><a href="#SYNOPSIS">SYNOPSIS</a></li>
  <li><a href="#DESCRIPTION">DESCRIPTION</a></li>
  <li><a href="#OPTIONS">OPTIONS</a></li>
  <li><a href="#SEE-ALSO">SEE ALSO</a></li>
  <li><a href="#AUTHOR">AUTHOR</a></li>
</ul>

<h1 id="NAME">NAME</h1>

<p>zonemaster-cli - run Zonemaster tests from the command line</p>

<h1 id="SYNOPSIS">SYNOPSIS</h1>

<pre><code>    zonemaster-cli nic.se
    zonemaster-cli --test=delegation --level=debug --no-time afnic.fr
    zonemaster-cli --list_tests</code></pre>

<h1 id="DESCRIPTION">DESCRIPTION</h1>

<p><a>zonemaster-cli</a> is a command-line interface to the <a>Zonemaster</a> test engine. It does nothing itself except take the instructions the user provides as command line arguments, transform them into suitable API calls to the engine, run the requested test and print the resulting messages. The messages will be translated by the engine&#39;s translation module, and possibly have a timestamp and a module name prepended when printed.</p>

<h1 id="OPTIONS">OPTIONS</h1>

<dl>

<dt id="h-----usage---help">-h -? --usage --help</dt>
<dd>

<p>Any of these print a rather too long summary of the command line switches, then quits the program.</p>

</dd>
<dt id="version">--version</dt>
<dd>

<p>Prints the versions of this program, the <a>Zonemaster</a> framework and the loaded test modules.</p>

</dd>
<dt id="level-LEVEL">--level=LEVEL</dt>
<dd>

<p>Specify the minimum level that a message needs to have in order to be printed. That is, messages with this level or higher will be printed. The levels are, in order from highest to lowest, CRITICAL, ERROR, WARNING, NOTICE, INFO, DEBUG, DEBUG2 and DEBUG3. The lowest two levels show some of the internal workings of the test engine, and are probably not useful for ordinary users.</p>

</dd>
<dt id="locale-LOCALE">--locale=LOCALE</dt>
<dd>

<p>Specifies which locale to tell the translation system to use. If not given, the translation system itself will look at environment variables to try to guess. If the requested translation does not exist, it will fallback to the local locale, and if that doesn&#39;t exist either to English.</p>

</dd>
<dt id="json">--json</dt>
<dd>

<p>Print results as JSON instead of human language.</p>

</dd>
<dt id="raw">--raw</dt>
<dd>

<p>Print messages as raw dumps instead of passing them through the translation system.</p>

</dd>
<dt id="time---no-time">--time, --no-time</dt>
<dd>

<p>Turn the printing of timestamps on or off (default on).</p>

</dd>
<dt id="show_level---no-show_level">--show_level, --no-show_level</dt>
<dd>

<p>Turn the printing of the message severity level on or off (default on).</p>

</dd>
<dt id="show_module---no-show_module">--show_module, --no-show_module</dt>
<dd>

<p>Turn the printing of which module produced a message on or off (default off).</p>

</dd>
<dt id="ns-NAME-IP">--ns=NAME/IP</dt>
<dd>

<p>Provide information about a nameserver, for undelegated tests. The argument must be a domain name and an IP address (v4 or v6) separated by a single slash character (/). This switch can (and probably should) be given multiple times. As long as any of these switches are present, their aggregate content will be used as the entirety of the parent-side delegation information.</p>

</dd>
<dt id="save-FILENAME">--save=FILENAME</dt>
<dd>

<p>After the entire test has finished running, write the contents of the accumulated packet cache to a file with the given name.</p>

</dd>
<dt id="restore-FILENAME">--restore=FILENAME</dt>
<dd>

<p>Before starting the test, prime the packet cache with the contents from the file with the given name. The format of the file should be that produced by the save functions.</p>

</dd>
<dt id="ipv4---no-ipv4">--ipv4, --no-ipv4</dt>
<dd>

<p>Allow or disallow the sending of IPv4 packets (default on).</p>

</dd>
<dt id="ipv6---no-ipv6">--ipv6, --no-ipv6</dt>
<dd>

<p>Allow or disallow the sending of IPv6 packets (default on).</p>

</dd>
<dt id="list_tests">--list_tests</dt>
<dd>

<p>Instead of running a test, list all the tests presented by the testing modules.</p>

</dd>
<dt id="test-MODULE---test-MODULE-METHOD">--test=MODULE, --test=MODULE/METHOD</dt>
<dd>

<p>Run only the specified tests. You can either give the name of a testing module, in which case that module will be asked to run all its tests, or you can give the name of a module followed by a slash and the name of a method in that module. The specified method will be called with a zone object as its single argument. It&#39;s up to the user to make sure that that is the kind of argument the method expects.</p>

</dd>
<dt id="stop_level-LEVEL">--stop_level=LEVEL</dt>
<dd>

<p>As soon as a message of the given level or higher is logged, terminate the testing process.</p>

</dd>
<dt id="config-FILE">--config=FILE</dt>
<dd>

<p>Load configuration from the file with the given name.</p>

</dd>
<dt id="policy-FILE">--policy=FILE</dt>
<dd>

<p>Load policy information from the file with the given name.</p>

</dd>
<dt id="ds-KEYTAG-ALGORITHM-TYPE-DIGEST">--ds=KEYTAG,ALGORITHM,TYPE,DIGEST</dt>
<dd>

<p>Provide a DS record for undelegated testing (that is, a test where the delegating nameserver information is given via --ns switches). The four pieces of data should be in the same format they would have in a zone file.</p>

</dd>
<dt id="count---no-count">--count, --no-count</dt>
<dd>

<p>After the test run is finished, turn on or off the printing of a summary with the numbers of messages of the various levels that were logged during the run (default off).</p>

</dd>
<dt id="progress---no-progress">--progress, --no-progress</dt>
<dd>

<p>Turn on or off the printing of a &quot;spinner&quot; showing that something is happening during the test run. The default is to print it if the process&#39; standard output is a TTY, and to not print otherwise.</p>

</dd>
<dt id="encoding-ENCODING">--encoding=ENCODING</dt>
<dd>

<p>Specify the character encoding that is used for command line arguments. This will be used to convert non-ASCII names to IDNA format, on which the tests will then be run.</p>

<p>The default value will be taken from the <code>LC_CTYPE</code> environment variable if possible, and set to UTF-8 if not.</p>

</dd>
</dl>

<h1 id="SEE-ALSO">SEE ALSO</h1>

<p><a>Zonemaster</a></p>

<h1 id="AUTHOR">AUTHOR</h1>

<p>Calle Dybedahl &lt;calle@init.se&gt;</p>


</body>

</html>