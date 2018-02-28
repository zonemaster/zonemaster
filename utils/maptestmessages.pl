#!/usr/bin/env perl

use 5.16.0;
use warnings;
use Zonemaster::Engine;

# page header
print "# Mapping test messages to test module\n\n";

# table header
print "| Log message identifier        | Implemented test case         |\n";
print "|:------------------------------|:------------------------------|\n";

# table content
foreach my $module ( 'Basic', sort { fc $a cmp fc $b } Zonemaster::Engine::Test->modules ) {
    my $full = "Zonemaster::Engine::Test::$module";
    my $ref  = $full->metadata;
    for my $key (sort keys %$ref) {
        my $list = $ref->{$key};
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
