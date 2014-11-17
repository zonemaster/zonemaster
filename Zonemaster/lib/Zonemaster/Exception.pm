package Zonemaster::Exception v0.1.0;

use 5.14.2;
use Moose;

use overload '""' => \&string;

has 'message' => ( is => 'ro', isa => 'Str', required => 1 );

sub string {
    my ( $self ) = @_;

    return $self->message;
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;

=head1 NAME

Zonemaster::Exception -- base class for Zonemaster exceptions

=head1 SYNOPSIS

   die Zonemaster::Exception->new({ message => "This is an exception" });

=head1 ATTRIBUTES

=over

=item message

A string attribute holding a message for possible human consumption.

=back

=head1 METHODS

=over

=item string()

Method that stringifies the object by returning the C<message> attribute.
Stringification is overloaded to this.

=back

=cut
