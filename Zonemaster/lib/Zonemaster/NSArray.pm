package Zonemaster::NSArray;

use 5.14.2;
use warnings;
use Carp;
use Zonemaster::Recursor;
use Zonemaster::Nameserver;

use Moose;

has 'names' => ( is => 'ro', isa => 'ArrayRef', required => 1);
has 'ary' => ( is => 'ro', isa => 'ArrayRef', default => sub { [] });

sub TIEARRAY {
    my ( $class, @names ) = @_;

    return $class->new({ names => [sort {$a cmp $b} @names] });
}

sub STORE {
    my ( $self, $index, $value ) = @_;

    croak "STORE forbidden for this type of array.";
}

sub STORESIZE {
    my ( $self, $index, $value ) = @_;

    croak "STORESIZE forbidden for this type of array.";
}

sub FETCH {
    my ( $self, $index ) = @_;

    if (exists $self->ary->[$index]) {
        return $self->ary->[$index];
    }
    elsif (scalar(@{$self->names}) == 0) {
        return;
    }
    else {
        $self->_load_name(shift @{$self->names});
        return $self->FETCH($index);
    }
}

sub FETCHSIZE {
    my ( $self ) = @_;

    while (my $name = shift @{$self->names}) {
        $self->_load_name($name)
    }

    return scalar(@{$self->ary});
}

sub EXISTS {
    my ( $self, $index ) = @_;

    if ($self->FETCH($index)) {
        return 1;
    } else {
        return;
    }
}

sub DELETE {
    my ( $self, $index ) = @_;

    croak "DELETE forbidden for this type of array.";
}

sub CLEAR {
    my ( $self ) = @_;

    croak "CLEAR forbidden for this type of array.";
}

sub PUSH {
    my ( $self, @values ) = @_;

    croak "PUSH forbidden for this type of array.";
}

sub UNSHIFT {
    my ( $self, @values ) = @_;

    croak "UNSHIFT forbidden for this type of array.";
}

sub POP {
    my ( $self ) = @_;

    croak "POP forbidden for this type of array.";
}

sub SHIFT {
    my ( $self ) = @_;

    croak "SHIFT forbidden for this type of array.";
}

sub SPLICE {
    my ( $self, $offset, $length, @values ) = @_;

    croak "SPLICE forbidden for this type of array.";
}

sub UNTIE {
    my ( $self ) = @_;

    return;
}

sub _load_name {
    my ( $self, $name ) = @_;
    my @addrs = Zonemaster::Recursor->get_addresses_for($name);
    foreach my $addr (sort {$a->ip cmp $b->ip} @addrs) {
        my $ns = Zonemaster::Nameserver->new({ name => $name, address => $addr });
        if ( not grep {"$ns" eq "$_"} @{$self->ary}) {
            push @{$self->ary}, $ns;
        }
    }

    return;
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;

=head1 NAME

Zonemaster::NSArray - Class implementing arrays that lazily looks up name server addresses from their names

=head1 SYNOPSIS

    tie @ary, 'Zonemaster::NSArray', @ns_names

=head1 DESCRIPTION

This class is used for the C<glue> and C<ns> attributes of the L<Zonemaster::Zone> class.

=head1 METHODS

These are all methods implementing the Perl tie interface. They have no independent use.

=over

=item TIEARRAY

=item STORE

=item STORESIZE

=item FETCH

=item FETCHSIZE

=item EXISTS

=item DELETE

=item CLEAR

=item PUSH

=item UNSHIFT

=item POP

=item SHIFT

=item SPLICE

=item UNTIE

=back

=head1 AUTHOR

Calle Dybedahl, C<< <calle at init.se> >>

=cut