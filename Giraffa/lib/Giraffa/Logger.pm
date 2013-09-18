package Giraffa::Logger v0.0.1;

use 5.14.2;
use Moose;

use Giraffa::Logger::Entry;

has 'entries' => ( is => 'ro', isa => 'ArrayRef[Giraffa::Logger::Entry]', default => sub { [] } );

sub add {
    my ( $self, $tag, $argref ) = @_;

    push @{ $self->entries }, Giraffa::Logger::Entry->new( { tag => uc( $tag ), args => $argref } );

    return $self->entries->[-1];
}

1;
