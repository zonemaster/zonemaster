use Test::More;

use 5.14.2;
use strict;
use warnings;

use Zonemaster;
use File::Find;

eval { require Pod::Coverage };
if ( $@ ) {
    plan skip_all => "Need Pod::Coverage to run these tests.";
    exit( 0 );
}

my @modules;

find(
    sub {
        if ( $File::Find::name =~ m|lib/(.*)\.pm| ) {
            my $name = $1;
            $name =~ s|/|::|g;

            push @modules, $name;
        }
    },
    'lib'
);

foreach my $name ( @modules ) {
    my $pc = Pod::Coverage->new( package => $name );
    if ( defined $pc->coverage ) {
        my @uncovered = $pc->uncovered;
        if (@uncovered == 1 and $uncovered[0] eq 'LC_MESSAGES') {
            next;
        }

        is( $pc->coverage, 1.0, $name );
        if ( $pc->coverage < 1.0 ) {
            foreach my $name ( @uncovered ) {
                diag "Function '$name' not documented";
            }
        }
    }
    else {
        diag $pc->why_unrated . ' for ' . $name;
    }
}

done_testing;
