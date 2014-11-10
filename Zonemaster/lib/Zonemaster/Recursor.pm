package Zonemaster::Recursor v0.0.2;

use 5.14.2;
use Moose;
use JSON::PP;
use Zonemaster::Util;
use Net::IP::XS;
use Zonemaster;

my $seed_data;

our %recurse_cache;

{
    local $/;
    my $json = <DATA>;
    $seed_data = decode_json $json;
}

sub recurse {
    my ( $self, $name, $type, $class ) = @_;
    $name = name($name);
    $type  //= 'A';
    $class //= 'IN';

    Zonemaster->logger->add( RECURSE => { name => $name, type => $type, class => $class } );

    if ( exists $recurse_cache{$name}{$type}{$class} ) {
        return $recurse_cache{$name}{$type}{$class};
    }

    my ( $p, $state ) =
      $self->_recurse( $name, $type, $class,
        { ns => [ root_servers() ], count => 0, common => 0, seen => {}, glue => {} } );
    $recurse_cache{$name}{$type}{$class} = $p;

    return $p;
}

sub parent {
    my ( $self, $name ) = @_;
    $name = name($name);

    my ( $p, $state ) =
      $self->_recurse( $name, 'SOA', 'IN',
        { ns => [ root_servers() ], count => 0, common => 0, seen => {}, glue => {} } );

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
} ## end sub parent

sub _recurse {
    my ( $self, $name, $type, $class, $state ) = @_;
    $name = '' . name($name);

    if ( $state->{in_progress}{$name}{$type} ) {
        return;
    }
    $state->{in_progress}{$name}{$type} = 1;

    while ( my $ns = pop @{ $state->{ns} } ) {
        Zonemaster->logger->add( RECURSE_QUERY => { ns => "$ns", name => $name, type => $type, class => $class } );
        my $p = $self->_do_query( $ns, $name, $type, { class => $class }, $state );

        next if not $p;    # Ask next server if no response

        if ( $p->rcode eq 'REFUSED' or $p->rcode eq 'SERVFAIL' ) {
            # Respond with these if we can't get a better response
            $state->{candidate} = $p;
            next;
        }

        if ( $p->no_such_record ) {    # Node exists, but not record
            return ( $p, $state );
        }

        if ( $p->no_such_name ) {      # Node does not exist
            return ( $p, $state );
        }

        if ( $self->_is_answer( $p ) ) {    # Return answer
            return ( $p, $state );
        }

        # So it's not an error, not an empty response and not an answer

        if ( $p->is_redirect ) {
            my $zname = name(lc(( $p->get_records( 'ns' ) )[0]->name));

            next if $zname eq '.'; # Redirect to root is never right.

            next if $state->{seen}{$zname};    # We followed this redirect before

            $state->{seen}{$zname} = 1;
            my $common = name( $zname )->common( name( $state->{qname} ) );

            next
              if $common < $state->{common};    # Redirect going up the hierarchy is not OK

            $state->{common} = $common;
            $state->{ns} = $self->get_ns_from( $p, $state );    # Follow redirect
            $state->{count} += 1;
            return (undef, $state) if $state->{count} > 20;    # Loop protection
            unshift @{ $state->{trace} }, $zname;

            next;
        }
    } ## end while ( my $ns = pop @{ $state...})
    return ( $state->{candidate}, $state ) if $state->{candidate};

    return (undef, $state);
} ## end sub _recurse

sub _do_query {
    my ( $self, $ns, $name, $type, $opts, $state ) = @_;

    if ( ref( $ns ) and $ns->can('query') ) {
        my $p = $ns->query( $name, $type, $opts );

        if ( $p ) {
            for my $rr ( grep { $_->type eq 'A' or $_->type eq 'AAAA' } $p->answer, $p->additional ) {
                $state->{glue}{ lc(name( $rr->name )) }{ $rr->address } = 1;
            }
        }
        return $p;
    }
    elsif ( my $href = $state->{glue}{ lc(name( $ns )) }) {
        foreach my $addr (keys %$href) {
            my $realns = ns($ns, $addr);
            my $p = $self->_do_query($realns, $name, $type, $opts, $state);
            if ($p) {
                return $p;
            }
        }
    }
    else {
        $state->{glue}{ lc(name( $ns )) } = {};
        my @addr = $self->get_addresses_for( $ns, $state );
        if ( @addr > 0 ) {
            foreach my $addr ( @addr ) {
                $state->{glue}{ lc(name( $ns )) }{$addr->short} = 1;
                my $new = ns( $ns, $addr->short );
                my $p = $new->query( $name, $type, $opts );
                return $p if $p;
            }
        }
        else {
            return;
        }
    }
} ## end sub _do_query

sub get_ns_from {
    my ( $self, $p, $state ) = @_;
    my ( @new, @extra );

    my @names = sort map { name( lc($_->nsdname) ) } $p->get_records( 'ns' );

    $state->{glue}{ lc(name( $_->name )) }{ $_->address } = 1 for ( $p->get_records( 'a' ), $p->get_records( 'aaaa' ) );

    foreach my $name ( @names ) {
        if ( exists $state->{glue}{ lc(name( $name )) } ) {
            for my $addr (keys %{ $state->{glue}{ lc(name( $name )) } }) {
                push @new, ns( $name, $addr );
            }
        }
        else {
            push @extra, $name;
        }
    }

    @new = sort { $a->name cmp $b->name or $a->address->ip cmp $b->address->ip } @new;
    @extra = sort { $a cmp $b } @extra;

    return [ @new, @extra ];
} ## end sub get_ns_from

sub get_addresses_for {
    my ( $self, $name, $state ) = @_;
    my @res;
    $state //=
      { ns => [ root_servers() ], count => 0, common => 0, seen => {} };

    my ( $pa ) = $self->_recurse(
        "$name", 'A', 'IN',
        {
            ns          => [ root_servers() ],
            count       => $state->{count},
            common      => 0,
            in_progress => $state->{in_progress},
            glue        => $state->{glue}
        }
    );

    # Name does not exist, just stop
    if ($pa and $pa->no_such_name) {
        return;
    }

    my ( $paaaa ) = $self->_recurse(
        "$name", 'AAAA', 'IN',
        {
            ns          => [ root_servers() ],
            count       => $state->{count},
            common      => 0,
            in_progress => $state->{in_progress},
            glue        => $state->{glue}
        }
    );

    my @rrs;
    push @rrs, $pa->get_records( 'a' )       if $pa;
    push @rrs, $paaaa->get_records( 'aaaa' ) if $paaaa;

    foreach my $rr (
        sort { $a->address cmp $b->address }
        grep { name( $_->name ) eq $name } @rrs
      )
    {
        push @res, Net::IP::XS->new( $rr->address );
    }

    return @res;
} ## end sub get_addresses_for

sub _is_answer {
    my ( $self, $packet ) = @_;

    return ( $packet->type eq 'answer' );
}

sub clear_cache {
    %recurse_cache = ();
}

sub root_servers {
    return map { Zonemaster::Util::ns( $_->{name}, $_->{address} ) }
      sort { $a->{name} cmp $b->{name} } @{ $seed_data->{'.'} };
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;

=head1 NAME

Zonemaster::Recursor - recursive resolver for Zonemaster

=head1 SYNOPSIS

    my $packet = Zonemaster::Recursor->recurse($name, $type, $class);
    my $pname = Zonemaster::Recursor->parent('example.org');

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

=item clear_cache()

Class method to empty the cache of responses to recursive queries.

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
