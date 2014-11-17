package Zonemaster::Zone v0.1.0;

use 5.14.2;
use strict;
use warnings;

use Moose;
use Carp;
use List::MoreUtils qw[uniq];

use Zonemaster::DNSName;
use Zonemaster::Recursor;
use Zonemaster::NSArray;

has 'name' => ( is => 'ro', isa => 'Zonemaster::DNSName', required => 1, coerce => 1 );
has 'parent' => ( is => 'ro', isa => 'Maybe[Zonemaster::Zone]', lazy_build => 1 );
has [ 'ns', 'glue' ] => ( is => 'ro', isa => 'ArrayRef', lazy_build => 1 );
has [ 'ns_names', 'glue_names' ] => ( is => 'ro', isa => 'ArrayRef[Zonemaster::DNSName]', lazy_build => 1 );
has 'glue_addresses' => ( is => 'ro', isa => 'ArrayRef[Net::LDNS::RR]', lazy_build => 1 );

###
### Builders
###

sub _build_parent {
    my ( $self ) = @_;

    if ( $self->name eq '.' ) {
        return $self;
    }

    my $pname = Zonemaster::Recursor->parent( '' . $self->name );
    return if not $pname;
    ## no critic (Modules::RequireExplicitInclusion)
    return __PACKAGE__->new( { name => $pname } );
}

sub _build_glue_names {
    my ( $self ) = @_;

    if (not $self->parent) {
        return [];
    }

    my $p = $self->parent->query_one( $self->name, 'NS' );

    return [] if not defined $p;

    return [ uniq sort map {Zonemaster::DNSName->new(lc($_->nsdname))} $p->get_records_for_name('ns', $self->name->string)];
}

sub _build_glue {
    my ( $self ) = @_;

    my $aref = [];
    tie @$aref, 'Zonemaster::NSArray', @{$self->glue_names};

    return $aref;
}

sub _build_ns_names {
    my ( $self ) = @_;

    if ( $self->name eq '.' ) {
        my %u;
        $u{$_} = $_ for map {$_->name} @{$self->ns};
        return [sort values %u];
    }

    my $p;
    my $i = 0;
    while (my $s = $self->glue->[$i] ) {
        $p = $s->query( $self->name, 'NS' );
        last if defined( $p );
        $i += 1;
    }
    return [] if not defined $p;

    return [ uniq sort map {Zonemaster::DNSName->new(lc($_->nsdname))} $p->get_records_for_name('ns', $self->name->string)];
}

sub _build_ns {
    my ( $self ) = @_;

    if ( $self->name eq '.' ) {    # Root is a special case
        return [ Zonemaster::Recursor->root_servers ];
    }

    my $aref = [];
    tie @$aref, 'Zonemaster::NSArray', @{$self->ns_names};

    return $aref;
}

sub _build_glue_addresses {
    my ( $self ) = @_;

    if (not $self->parent) {
        return [];
    }

    my $p = $self->parent->query_one( $self->name, 'NS' );
    croak "Failed to get glue addresses" if not defined( $p );

    return [ $p->get_records( 'a' ), $p->get_records( 'aaaa' ) ];
}

###
### Public Methods
###

sub query_one {
    my ( $self, $name, $type, $flags ) = @_;

    # Return response from the first server that gives one
    my $i = 0;
    while( my $ns = $self->ns->[$i] ) {
        if (not Zonemaster->config->ipv4_ok and $ns->address->version == 4) {
            Zonemaster->logger->add( SKIP_IPV4_DISABLED => { ns => "$ns"} );
            next;
        }

        if (not Zonemaster->config->ipv6_ok and $ns->address->version == 6) {
            Zonemaster->logger->add( SKIP_IPV6_DISABLED => { ns => "$ns"} );
            next;
        }

        my $p = $ns->query( $name, $type, $flags );
        return $p if defined( $p );
    }
    continue {
        $i += 1;
    }

    return;
}

sub query_all {
    my ( $self, $name, $type, $flags ) = @_;

    my @servers = @{ $self->ns };

    if (not Zonemaster->config->ipv4_ok) {
        my @nope = grep { $_->address->version == 4 } @servers;
        @servers = grep { $_->address->version != 4 } @servers;
        Zonemaster->logger->add( SKIP_IPV4_DISABLED => { ns => (join ';', map {"$_"} @nope) } );
    }

    if (not Zonemaster->config->ipv6_ok) {
        my @nope = grep { $_->address->version == 6 } @servers;
        @servers = grep { $_->address->version != 6 } @servers;
        Zonemaster->logger->add( SKIP_IPV6_DISABLED => { ns => (join ';', map {"$_"} @nope) } );
    }

    return [ map { $_->query( $name, $type, $flags ) } @servers ];
}

sub query_auth {
    my ( $self, $name, $type, $flags ) = @_;

    # Return response from the first server that replies with AA set
    my $i = 0;
    while ( my $ns = $self->ns->[$i] ) {
        if (not Zonemaster->config->ipv4_ok and $ns->address->version == 4) {
            Zonemaster->logger->add( SKIP_IPV4_DISABLED => { ns => "$ns"} );
            next;
        }

        if (not Zonemaster->config->ipv6_ok and $ns->address->version == 6) {
            Zonemaster->logger->add( SKIP_IPV6_DISABLED => { ns => "$ns"} );
            next;
        }

        my $p = $ns->query( $name, $type, $flags );
        if ($p and $p->aa) {
            return $p
        }
    }
    continue {
        $i += 1;
    }

    return;
}

sub query_persistent {
    my ( $self, $name, $type, $flags ) = @_;

    # Return response from the first server that has a record like the one asked for
    my $i = 0;
    while ( my $ns = $self->ns->[$i] ) {
        if (not Zonemaster->config->ipv4_ok and $ns->address->version == 4) {
            Zonemaster->logger->add( SKIP_IPV4_DISABLED => { ns => "$ns"} );
            next;
        }

        if (not Zonemaster->config->ipv6_ok and $ns->address->version == 6) {
            Zonemaster->logger->add( SKIP_IPV6_DISABLED => { ns => "$ns"} );
            next;
        }

        my $p = $ns->query( $name, $type, $flags );
        if ($p and scalar($p->get_records_for_name($type, $name)) > 0) {
            return $p
        }
    }
    continue {
        $i += 1;
    }

    return;
}

sub is_in_zone {
    my ( $self, $name ) = @_;

    if ( not ref( $name ) or ref( $name ) ne 'Zonemaster::DNSName' ) {
        $name = Zonemaster::DNSName->new( $name );
    }

    if ( scalar( @{ $self->name->labels } ) != $self->name->common( $name ) ) {
        return 0;    # Zone name cannot be a suffix of tested name
    }

    my $p = $self->query_auth( "$name", 'SOA' );
    if (not $p) {
        return;
    }

    if ( $p->is_redirect ) {
        return 0;    # Authoritative servers redirect us, so name must be out-of-zone
    }

    my ( $soa ) = $p->get_records( 'SOA' );

    if (not $soa) {
        return 0;    # Auth server is broken, call it a "no".
    }

    if ( Zonemaster::DNSName->new($soa->name) eq $self->name ) {
        return 1;
    }
    else {
        return 0;
    }
} ## end sub is_in_zone

no Moose;
__PACKAGE__->meta->make_immutable;

1;

=head1 NAME

Zonemaster::Zone - Object representing a DNS zone

=head1 SYNOPSIS

    my $zone = Zonemaster::Zone->new({ name => 'nic.se' });
    my $packet = $zone->parent->query_one($zone->name, 'NS');

=head1 ATTRIBUTES

=over

=item name

A L<Zonemaster::DNSName> object representing the name of the zone.

=item parent

A L<Zonemaster::Zone> object for this domain's parent domain.

=item ns_names

A reference to an array of L<Zonemaster::DNSName> objects, holding the names of
the nameservers for the domain, as returned by the first responding nameserver
in the glue list.

=item ns

A reference to an array of L<Zonemaster::Nameserver> objects for the domain,
built by taking the list returned from L<ns_names()> and looking up addresses
for the names. One element will be added to this list for each unique name/IP
pair. Names for which no addresses could be found will not be in this list.

=item glue_names

A reference to a an array of L<Zonemaster::DNSName> objects, holding the names
of this zones nameservers as listed at the first responding nameserver of the
parent zone.

=item glue

A reference to an array of L<Zonemaster::Nameserver> objects for the domain,
built by taking the list returned from L<glue_names()> and looking up addresses
for the names. One element will be added to this list for each unique name/IP
pair. Names for which no addresses could be found will not be in this list.

=item glue_addresses

A list of L<Net::LDNS::RR::A> and L<Net::LDNS::RR::AAAA> records returned in
the Additional section of an NS query to the first listed nameserver for the
parent domain.

=back

=head1 METHODS

=over 

=item query_one($name[, $type[, $flags]])

Sends (or retrieves from cache) a query for the given name, type and flags sent to the first nameserver in the zone's ns list. If there is a
response, it will be returned in a L<Zonemaster::Packet> object. If the type arguments is not given, it defaults to 'A'. If the flags are not given, they default to C<class> IN and C<dnssec>, C<usevc> and C<recurse> according to configuration (which is by default off on all three).

=item query_persistent($name[, $type[, $flags]])

Identical to L<query_one>, except that instead of returning the packet from the
first server that returns one, it returns the first packet that actually
contains a resource record matching the requested name and type.

=item query_auth($name[, $type[, $flags]])

Identical to L<query_one>, except that instead of returning the packet from the
first server that returns one, it returns the first packet that has the AA flag set.

=item query_all($name, $type, $flags)

Sends (or retrieves from cache) queries to all the nameservers listed in the zone's ns list, and returns a reference to an array with the
responses. The responses can be either L<Zonemaster::Packet> objects or C<undef> values. The arguments are the same as for L<query_one>.

=item is_in_zone($name)

Returns true if the given name is in the zone, false if not. If it could not be
determined with a sufficient degree of certainty if the name is in the zone or
not, C<undef> is returned.

=back

=cut
