package Giraffa::Zone v0.0.1;

use 5.14.2;
use strict;
use warnings;

use Moose;
use Moose::Util::TypeConstraints;
use Carp;

use Giraffa::DNSName;
use Giraffa::Recursor;

subtype 'Giraffa::Type::Address', as 'Object', where { $_->isa( 'Net::DNS::RR::A' or $_->isa('Net::DNS::RR::AAAA') ) };

has 'name' => ( is => 'ro', isa => 'Giraffa::DNSName', required => 1, coerce => 1 );
has 'parent' => ( is => 'ro', isa => 'Giraffa::Zone', lazy_build => 1);
has ['ns', 'glue'] => ( is => 'ro', isa => 'ArrayRef[Giraffa::Nameserver]', lazy_build => 1);
has 'glue_addresses' => ( is => 'ro', isa => 'ArrayRef[Giraffa::Type::Address]', lazy_build => 1);

###
### Builders
###

sub _build_parent {
    my ( $self ) = @_;

    if ($self->name eq '.') {
        return $self;
    }

    return __PACKAGE__->new({ name => scalar Giraffa::Recursor->parent( ''.$self->name )});
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