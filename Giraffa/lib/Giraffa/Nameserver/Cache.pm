package Giraffa::Nameserver::Cache v0.0.1;

use 5.14.2;
use warnings;
use Moose;
use Giraffa;

our %object_cache;

has 'data' => ( is => 'ro', isa => 'HashRef', default => sub { {} } );
has 'address' => ( is => 'ro', isa => 'Net::IP', required => 1 );

around 'new' => sub {
    my $orig = shift;
    my $self = shift;

    my $obj  = $self->$orig( @_ );

    if ( not exists $object_cache{ $obj->address->ip } ) {
        Giraffa->logger->add( CACHE_CREATED => { ip => $obj->address->ip } );
        $object_cache{ $obj->address->ip } = $obj;
    }

    Giraffa->logger->add( CACHE_FETCHED => { ip => $obj->address->ip } );
    return $object_cache{ $obj->address->ip };
};

1;

=head1 NAME

Giraffa::Nameserver::Cache - shared caches for nameserver objects

=head1 SYNOPSIS

    This class should not be used directly.

=head1 ATTRIBUTES

=over

=item address

A L<Net::IP> object holding the nameserver's address.

=item data

A reference to a hash holding the cache of sent queries. Not meant for external use.

=back

=cut
