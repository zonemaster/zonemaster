use Test::More;

use 5.14.2;
use strict;
use warnings;

use Giraffa;
use File::Find;

eval { require Pod::Coverage };
if ($@) {
    plan skip_all => "Need Pod::Coverage to run these tests.";
    exit(0);
}

my @modules;

find( sub {
    if ($File::Find::name =~ m|lib/(.*)\.pm|) {
        my $name = $1;
        $name =~ s|/|::|g;

        push @modules, $name;
    }
}, 'lib');

foreach my $name (@modules) {
    my $pc = Pod::Coverage->new( package => $name);
    if ($pc->coverage) {
        is($pc->coverage, 1.0, $name);
    } else {
        diag $pc->why_unrated . ' for ' . $name;
    }
}

done_testing;