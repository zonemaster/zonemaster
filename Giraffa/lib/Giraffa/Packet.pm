package Giraffa::Packet v0.0.1;

use 5.14.2;
use Moose;

has 'packet' => (
    is       => 'ro',
    isa      => 'Net::DNS::Packet',
    required => 1,
    handles  => [qw(data header question answer authority additional print string answerfrom answersize unique_push)]
);

sub no_such_record {
    my ( $self ) = @_;

    if (    scalar( $self->packet->answer ) == 0
        and $self->packet->header->rcode eq 'NOERROR'
        and scalar( grep { $_->type eq 'SOA' } $self->packet->authority ) == 1
        and $self->packet->header->aa )
    {
        return 1;
    }
    else {
        return;
    }
}

sub no_such_name {
    my ( $self ) = @_;

    if ( $self->packet->header->rcode eq 'NXDOMAIN' and $self->packet->header->aa ) {
        return 1;
    }
    else {
        return;
    }
}

sub is_redirect {
    my ( $self ) = @_;

    if ( scalar( $self->packet->answer ) == 0 and scalar( grep { $_->type eq 'NS' } $self->packet->authority ) > 0 ) {
        return 1;
    }
    else {
        return;
    }
}

sub get_records {
    my ( $self, $type, @section ) = @_;
    my %sec = map { $_ => 1 } @section;
    my @raw;

    if ( !@section ) {
        @raw = ( $self->packet->answer, $self->packet->authority, $self->packet->additional );
    }

    if ( $sec{'answer'} ) {
        push @raw, $self->packet->answer;
    }

    if ( $sec{'authority'} ) {
        push @raw, $self->packet->authority;
    }

    if ( $sec{'additional'} ) {
        push @raw, $self->packet->additional;
    }

    @raw = grep { $_->type eq uc( $type ) } @raw;

    return @raw;
}

sub get_records_for_name {
    my ( $self, $type, $name ) = @_;

    return grep { $_->name eq $name } $self->get_records( $type );
}

sub has_rrs_of_type_for_name {
    my ( $self, $type, $name ) = @_;

    return ( grep { $_->name eq $name } $self->get_records( $type ) ) > 0;
}

1;

=head1 NAME

Giraffa::Packet - wrapping object for L<Net::DNS::Packet> objects

=head1 SYNOPSIS

    my $packet = $ns->query('iis.se', 'NS');
    my @rrs = $packet->get_records('ns');

=head1 ATTRIBUTES

=over

=item packet

Holds the L<Net::DNS::Packet> the object is wrapping.

=back

=head1 METHODS

=over

=item no_such_record

Returns true if the packet represents an existing DNS node lacking any records of the requested type.

=item no_such_name

Returns true if the packet represents a non-existent DNS node.

=item is_redirect

Returns true if the packet is a redirect to another set of nameservers.

=item get_records($type[, $section])

Returns the L<Net::DNS::RR> objects of the requested type in the packet. If the optional C<$section> argument is given, and is one of C<answer>,
C<authority> and C<additional>, only RRs from that section are returned.

=item get_records_for_name($type, $name)

Returns all L<Net::DNS::RR> objects for the given name in the packet.

=item has_rrs_of_type_for_name($type, $name)

Returns true if the packet holds any RRs of the specified type for the given name.

=back