#!/usr/bin/env perl

use 5.16.0;
use warnings;
use Zonemaster::Engine;

# page header
print "# Mapping test messages to test module\n\n";

# table header
print "| Log message identifier                         | Implemented test case          |\n";
print "|:-----------------------------------------------|:-------------------------------|\n";

# table content
my %links;
foreach my $module ( 'Basic', sort { fc $a cmp fc $b } Zonemaster::Engine::Test->modules ) {
    my $full = "Zonemaster::Engine::Test::$module";
    my $ref  = $full->metadata;
    for my $key (sort keys %$ref) {
        my $list = $ref->{$key};
        for my $tag (map { uc( $module ) . ':' . $_ } sort { $a cmp $b } @$list) {
            # printf "%46s -> %s::%s\n", $tag, $module, $key;
            my $link = sprintf("[%s::%s]", $module, $key);
            my $target = sprintf("%s-TP/%s.md", $module, $key);
            $links{$link} = $target;
            printf "| %-46s | %-30s |\n", $tag, $link;
        }
    }
}

# links footer
print "\n";
for my $link (sort keys %links) {
    my $target = $links{$link};
    printf "%s: %s\n", $link, $target;
}
