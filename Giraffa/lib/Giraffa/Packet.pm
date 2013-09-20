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

1;
