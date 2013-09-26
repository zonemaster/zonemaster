package Giraffa::Logger v0.0.1;

use 5.14.2;
use Moose;

use Giraffa::Logger::Entry;

has 'entries' => ( is => 'ro', isa => 'ArrayRef[Giraffa::Logger::Entry]', default => sub { [] } );
has 'callback' => ( is => 'rw', isa => 'CodeRef', required => 0 );

sub add {
    my ( $self, $tag, $argref ) = @_;

    my $new = Giraffa::Logger::Entry->new( { tag => uc( $tag ), args => $argref } );
    push @{ $self->entries }, $new;

    if ( $self->callback and ref( $self->callback ) eq 'CODE' ) {
        $self->callback->( $new );
    }

    return $new;
}

1;

=head1 NAME

Giraffa::Logger - class that holds L<Giraffa::Logger::Entry> objects.

=head1 SYNOPSIS

    my $logger = Giraffa::Logger->new;
    $logger->add( TAG => {some => 'arguments'});

=head1 ATTRIBUTES

=over

=item entries

A reference to an array holding L<Giraffa::Logger::Entry> objects.

=back

=head1 METHODS

=over

=item add($tag, $argref)

Adds an entry with the given tag and arguments to the logger object.

=back

=cut
