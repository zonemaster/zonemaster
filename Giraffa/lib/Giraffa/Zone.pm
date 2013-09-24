package Giraffa::Zone v0.0.1;

use 5.14.2;
use strict;
use warnings;

use Moose;
use Carp;

use Giraffa::DNSName;
use Giraffa::Recursor;

has 'name' => ( is => 'ro', isa => 'Giraffa::DNSName', required => 1, coerce => 1 );
has 'parent' => ( is => 'ro', isa => 'Giraffa::Zone', lazy_build => 1);
has ['ns', 'glue'] => ( is => 'ro', isa => 'ArrayRef[Giraffa::Nameserver]', lazy_build => 1);
has 'glue_addresses' => ( is => 'ro', isa => 'ArrayRef[Net::DNS::RR]', lazy_build => 1);

###
### Builders
###

sub _build_parent {
    my ( $self ) = @_;

    if ($self->name eq '.') {
        return $self;
    }

    my $pname = Giraffa::Recursor->parent( ''.$self->name );
    croak "failed to find parent" if not $pname;
    return __PACKAGE__->new({ name => $pname });
}

sub _build_glue {
    my ( $self ) = @_;
    my @res;

    my $p = $self->parent->query_one($self->name, 'NS');
    croak "Failed to get glue" if not defined($p);

    return Giraffa::Recursor->get_ns_from( $p );
}

sub _build_ns {
    my ( $self ) = @_;

    if ($self->name eq '.') { # Root is a special case
        return [Giraffa::Recursor->root_servers];
    }

    my $p = $self->glue->[0]->query($self->name, 'NS');
    croak "Failed to get nameservers" if not defined($p);

    return Giraffa::Recursor->get_ns_from( $p );
}

sub _build_glue_addresses {
    my ( $self ) = @_;

    my $p = $self->parent->query_one($self->name, 'NS');
    croak "Failed to get glue addresses" if not defined($p);

    return [ $p->get_records('a'), $p->get_records('aaaa') ];
}

###
### Public Methods
###

sub query_one {
    my ( $self, $name, $type, $class ) = @_;

    # Return response from the first server that gives one
    foreach my $ns ( @{$self->ns}) {
        my $p = $ns->query( $name, $type, $class );
        return $p if defined($p);
    }

    return;
}

sub query_all {
    my ( $self, $name, $type, $class ) = @_;

    return [ map {$_->query($name,$type,$class) } @{$self->ns}];
}

1;

=head1 NAME

Giraffa::Zone - Object representing a DNS zone

=head1 SYNOPSIS

    my $zone = Giraffa::Zone->new({ name => 'nic.se' });
    my $packet = $zone->parent->query_one($zone->name, 'NS');

=head1 ATTRIBUTES

=over

=item name

A L<Giraffa::DNSName> object representing the name of the zone.

=item parent

A L<Giraffa::Zone> object for this domain's parent domain.

=item ns

A reference to an array of L<Giraffa::Nameserver> objects for the domain. The list is based on the NS records returned from a query to the first
listed glue server for the domain.

=item glue

A reference to an array of L<Giraffa::Nameserver> objects for the domain. The list is based on the NS records returned from a query to the first
listed nameserver for the parent domain.

=item glue_addresses

A list of L<Net::DNS::RR::A> and L<Net::DNS::RR::AAAA> records returned in the Additional section of an NS query to the first listed nameserver
for the parent domain.

=back

=head1 METHODS

=over 

=item query_one($name[, $type[, $class]])

Sends (or retrieves from cache) a query for the given name, type and class sent to the first nameserver in the zone's ns list. If there is a
response, it will be returned in a L<Giraffa::Packet> object. If the type and/or class arguments aren't given, they default to 'A' and 'IN'.

=item query_all($name, $type, $class)

Sends (or retrieves from cache) queries to all the nameservers listed in the zone's ns list, and returns a reference to an array with the
responses. The responses can be either L<Giraffa::Packet> objects or C<undef> values.

=back

=cut