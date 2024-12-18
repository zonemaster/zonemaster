#!/usr/bin/env perl

use 5.16.0;
use warnings;
use Zonemaster::Engine;
use File::Basename;

# page header
print '<!-- File generated by ', basename ($0), ", script in zonemaster/zonemaster util directory.\n";
print "Use that script to generate a new file for each release of Zonemaster when \n";
print "Zonemaster-Engine also has been updated.-->\n\n";
print "# Implemented Test Cases\n\n";
print "Index of Text Case specifications is also found in [README](README.md).\n";
print "[Zonemaster-Engine] is the repository of the implementation of the Test Cases (the methods).\n";
print "\n\n";

# table header
print '|Test level (linked to Perl code at CPAN)|Method name in Perl code|',
    "Test Case Identifier (linked to specification)|\n";
print '|:---------------------------------------|:-----------------------|',
    "----------------------------------------------|\n";


# table content
foreach my $module ( sort { fc $a cmp fc $b } Zonemaster::Engine::Test->modules ) {
    my $full = "Zonemaster::Engine::Test::$module";
    my $ref  = $full->metadata;
    my $modulelink = "https://metacpan.org/pod/Zonemaster::Engine::Test::$module";
    for my $method (sort keys %$ref) {
        my $testcase = uc ($method);
        my $testcaselink = "${module}-TP/${method}.md";
        printf "| [%s](%s) | %s | [%s](%s) |\n", $module, $modulelink, $method, $testcase, $testcaselink;
    }
}

print "\n[Zonemaster-Engine]: https://github.com/zonemaster/zonemaster-engine\n";

