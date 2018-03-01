#!/usr/bin/env perl

use 5.14.2;
use warnings;
use Zonemaster::Engine;

# page header
print "# Mapping test messages to test module\n\n";

# table header
print "| Log message identifier        | Implemented test case         |\n";
print "|:------------------------------|:------------------------------|\n";

# table content
foreach my $module ( 'Basic', sort { $a cmp $b } Zonemaster::Engine::Test->modules ) {
    my $full = "Zonemaster::Engine::Test::$module";
    my $ref  = $full->metadata;
    while ( my ($key, $list) = each %$ref ) {
        for my $tag (map { uc( $module ) . ':' . $_ } sort { $a cmp $b } @$list) {
            # printf "%46s -> %s::%s\n", $tag, $module, $key;
            my $testmodule = sprintf("%s::%s", $module, $key);
            my $testlevel = "$module-TP";
            my $testcase = "$key.md";
            my $testlink = "$testlevel/$testcase";
            printf "| %-30s | [%s](%s) |\n", $tag, $testmodule, $testlink;
        }
    }
}
