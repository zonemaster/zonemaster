package Giraffa::CLI;

use 5.014002;
use warnings;

our $VERSION = '0.01';

use Moose;
with 'MooseX::Getopt';

use Giraffa;
use Giraffa::Logger::Entry;

our %numeric = Giraffa::Logger::Entry->levels;

has 'level' => ( is => 'ro', isa => 'Str', required => 0, default => 'NOTICE' );

sub run {
    my ( $self ) = @_;

    my ( $domain ) = @{ $self->extra_argv };
    if ( not $domain ) {
        die "Must give the name of a domain to test.\n";
    }

    Giraffa->logger->callback(
        sub {
            my ( $entry ) = @_;

            say "$entry" if $numeric{ uc $entry->level } >= $numeric{ uc $self->level };
        }
    );
    Giraffa->test_zone( $domain );

    return;
}

1;
