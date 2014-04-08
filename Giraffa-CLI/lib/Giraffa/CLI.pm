package Giraffa::CLI;

use 5.014002;
use warnings;

our $VERSION = '0.01';

use Moose;
with 'MooseX::Getopt';

use Giraffa;
use Giraffa::Logger::Entry;
use Giraffa::Translator;

our %numeric = Giraffa::Logger::Entry->levels;

has 'level' => ( is => 'ro', isa => 'Str', required => 0, default => 'NOTICE' );
has 'lang' => ( is => 'ro', isa => 'Str', required => 0, default => 'tech' );

sub run {
    my ( $self ) = @_;

    my ( $domain ) = @{ $self->extra_argv };
    if ( not $domain ) {
        die "Must give the name of a domain to test.\n";
    }

    my $translator;
    $translator = Giraffa::Translator->new({ lang => $self->lang }) unless $self->lang eq 'raw';

    Giraffa->logger->callback(
        sub {
            my ( $entry ) = @_;

            return if $numeric{ uc $entry->level } < $numeric{ uc $self->level };

            if ($translator) {
                say $translator->translate($entry);
            } else {
                say "$entry";
            }
        }
    );
    Giraffa->test_zone( $domain );

    return;
}

1;
