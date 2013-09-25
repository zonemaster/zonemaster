package Giraffa::Recursor v0.0.1;

use 5.14.2;
use Moose;
use JSON::PP;
use Giraffa::Util;

my $seed_data;

INIT {
    local $/;
    my $json = <DATA>;
    $seed_data = decode_json $json;
}

sub recurse {
    my ( $self, $name, $type, $class ) = @_;
    $type  //= 'A';
    $class //= 'IN';

    my ( $p, $state ) =
      $self->_recurse( $name, $type, $class, { ns => [root_servers()], count => 0, common => 0, seen => {} } );

    return $p;
}

sub parent {
    my ( $self, $name ) = @_;

    my ( $p, $state ) =
      $self->_recurse( $name, 'SOA', 'IN', { ns => [root_servers()], count => 0, common => 0, seen => {} } );

    return if not $p;

    my $pname;
    if ( name( $state->{trace}[0] ) eq name( $name ) ) {
        $pname = name( $state->{trace}[1] );
    }
    else {
        $pname = name( $state->{trace}[0] );
    }

    if ( wantarray() ) {
        return ( $pname, $p );
    }
    else {
        return $pname;
    }
}

sub _recurse {
    my ( $self, $name, $type, $class, $state ) = @_;

    while ( my $ns = pop @{ $state->{ns} } ) {
        my $p = $ns->query( $name, $type, { class => $class } );

        next if not $p;                             # Ask next server if no response
        next if $p->header->rcode eq 'REFUSED';     # Ask next if REFUSED
        next if $p->header->rcode eq 'SERVFAIL';    # Ask next if SERVFAIL

        return ( $p, $state ) if $p->no_such_record;                              # Node exists, but not record
        return ( $p, $state ) if $p->no_such_name;                                # Node does not exist
        return ( $p, $state ) if $self->is_answer( $p, $name, $type, $class );    # Return answer

        # So it's not an error, not an empty response and not an answer

        if ( $p->is_redirect ) {

            # Looks like a redirect
            my $zname = ( $p->get_records( 'ns' ) )[0]->name;
            next if $state->{seen}{$zname};                                       # We followed this redirect before

            $state->{seen}{$zname} = 1;
            my $common = name( $zname )->common( name( $state->{qname} ) );

            next if $common < $state->{common};    # Redirect going up the hierarchy is not OK

            $state->{common} = $common;
            $state->{ns} = $self->get_ns_from( $p, $state );    # Follow redirect
            $state->{count} += 1;
            unshift @{ $state->{trace} }, $zname;
        }

        return if $state->{count} > 20;    # Loop protection
    }

    return;
}

sub get_ns_from {
    my ( $self, $p, $state ) = @_;
    my @new;

    my @names = sort map { name( $_->nsdname ) } $p->get_records( 'ns' );
    $state->{glue}{ $_->name }{ $_->address } = 1 for ( $p->get_records( 'a' ), $p->get_records( 'aaaa' ) );

    foreach my $name ( @names ) {
        if ( $state->{glue}{$name} ) {
            push @new, ns( $name, $_ ) for keys %{ $state->{glue}{$name} };
        }
        else {
            foreach my $a ( $self->get_addresses_for( $name, $state ) ) {
                push @new, ns( $name, $a->short );
            }
        }
    }

    return [sort {$a->name cmp $b->name or $a->address->ip cmp $b->address->ip} @new];
}

sub get_addresses_for {
    my ( $self, $name, $state ) = @_;
    my @res;
    $state //= { ns => [root_servers()], count => 0, common => 0, seen => {} };

    return if $state->{name_seen}{"$name"};
    $state->{name_seen}{"$name"} = 1;

    my ( $pa ) = $self->_recurse(
        "$name", 'A', 'IN',
        {
            ns        => [root_servers()],
            count     => $state->{count},
            common    => 0,
            name_seen => { $name => 1 },
            glue      => $state->{glue}
        }
    );
    my ( $paaaa ) = $self->_recurse(
        "$name", 'AAAA', 'IN',
        {
            ns        => [root_servers()],
            count     => $state->{count},
            common    => 0,
            name_seen => { $name => 1 },
            glue      => $state->{glue}
        }
    );

    my @rrs;
    push @rrs, $pa->get_records( 'a' )       if $pa;
    push @rrs, $paaaa->get_records( 'aaaa' ) if $paaaa;
    foreach my $rr ( sort { $a->address cmp $b->address } grep { $_->name eq $name } @rrs ) {
        push @res, Net::IP->new( $rr->address );
    }

    return @res;
}

sub is_answer {
    my ( $self, $packet, $name, $type, $class ) = @_;

    foreach my $rr ( $packet->answer ) {
        if (    $rr->name eq $name
            and ( $rr->class eq $class or $class eq 'ANY' )
            and ( $rr->type eq $type   or $type eq 'ANY' ) )
        {
            return 1;
        }
        if (    $rr->name eq $name
            and ( $rr->class eq $class or $class eq 'ANY' )
            and $rr->type eq 'CNAME' )
        {
            my $new_packet = $self->recurse( $rr->cname, $type, $class );
            $packet->unique_push( answer => $new_packet->answer ) if $new_packet;
            return 1;
        }
    }
    foreach my $rr ( $packet->authority ) {
        if (    $rr->name eq $name
            and ( $rr->class eq $class or $class eq 'ANY' )
            and ( $rr->type eq $type   or $type eq 'ANY' ) )
        {
            return 1;
        }
    }

    return;
}

sub root_servers {
    return map { Giraffa::Util::ns( $_->{name}, $_->{address} ) } @{ $seed_data->{'.'} };
}

1;

=head1 NAME

Giraffa::Recursor - recursive resolver for Giraffa

=head1 SYNOPSIS

    my $packet = Giraffa::Recursor->recurse($name, $type, $class);
    my $pname = Giraffa::Recursor->parent('example.org');

=head1 METHODS

=over

=item recurse($name, $type, $class)

Does a recursive resolution from the root servers down for the given triplet.

=item parent($name)

Does a recursive resolution from the root down for the given name (using type C<SOA> and class C<IN>). If the resolution is successful, it returns
the domain name of the second-to-last step. If the resolution is unsuccessful, it returns the domain name of the last step.

=item get_ns_from($packet, $state)

Internal method. Takes a packet and a recursion state and returns a list of ns objects. Used to follow redirections.

=item get_addresses_for($name[, $state])

Takes a name and returns a (possibly empty) list of IP addresses for that name. When used internally by the recursor it's passed a recursion state
as its second argument.

=item is_answer($packet, $name, $type, $class)

Internal method. Returns true if the given packet is an answer for a query for the given triplet.

=item root_servers()

Returns a list of ns objects representing the root servers. The list of root servers is hardcoded into this module.

=back

=cut

__DATA__
{
   "." : [
      {
         "name" : "m.root-servers.net",
         "address" : "202.12.27.33"
      },
      {
         "name" : "m.root-servers.net",
         "address" : "2001:dc3:0:0:0:0:0:35"
      },
      {
         "name" : "e.root-servers.net",
         "address" : "192.203.230.10"
      },
      {
         "address" : "199.7.83.42",
         "name" : "l.root-servers.net"
      },
      {
         "address" : "2001:500:3:0:0:0:0:42",
         "name" : "l.root-servers.net"
      },
      {
         "address" : "198.41.0.4",
         "name" : "a.root-servers.net"
      },
      {
         "address" : "2001:503:ba3e:0:0:0:2:30",
         "name" : "a.root-servers.net"
      },
      {
         "address" : "192.5.5.241",
         "name" : "f.root-servers.net"
      },
      {
         "address" : "2001:500:2f:0:0:0:0:f",
         "name" : "f.root-servers.net"
      },
      {
         "address" : "199.7.91.13",
         "name" : "d.root-servers.net"
      },
      {
         "address" : "2001:500:2d:0:0:0:0:d",
         "name" : "d.root-servers.net"
      },
      {
         "address" : "192.58.128.30",
         "name" : "j.root-servers.net"
      },
      {
         "address" : "2001:503:c27:0:0:0:2:30",
         "name" : "j.root-servers.net"
      },
      {
         "address" : "128.63.2.53",
         "name" : "h.root-servers.net"
      },
      {
         "name" : "h.root-servers.net",
         "address" : "2001:500:1:0:0:0:803f:235"
      },
      {
         "name" : "g.root-servers.net",
         "address" : "192.112.36.4"
      },
      {
         "name" : "k.root-servers.net",
         "address" : "193.0.14.129"
      },
      {
         "address" : "2001:7fd:0:0:0:0:0:1",
         "name" : "k.root-servers.net"
      },
      {
         "name" : "b.root-servers.net",
         "address" : "192.228.79.201"
      },
      {
         "address" : "192.33.4.12",
         "name" : "c.root-servers.net"
      },
      {
         "name" : "i.root-servers.net",
         "address" : "192.36.148.17"
      },
      {
         "name" : "i.root-servers.net",
         "address" : "2001:7fe:0:0:0:0:0:53"
      }
   ]
}
