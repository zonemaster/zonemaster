package Giraffa::Recursor v0.0.1;

use 5.14.2;
use Moose;
use JSON::PP;
use Giraffa::Util;

my @root_servers;

INIT {
    local $/;
    my $json = <DATA>;
    my $href = decode_json $json;
    @root_servers = map { ns( $_->{name}, $_->{address} ) } @{ $href->{'.'} };
}

sub recurse {
    my ( $self, $name, $type, $class ) = @_;
    $type  //= 'A';
    $class //= 'IN';

    my ( $p, $state ) =
      $self->_recurse( { qname => $name, qtype => $type, qclass => $class, ns => [@root_servers], count => 0 } );

    return $p;
}

sub parent {
    my ( $self, $name ) = @_;

    my ( $p, $state ) =
      $self->_recurse( { qname => $name, qtype => 'SOA', qclass => 'IN', ns => [@root_servers], count => 0 } );

    if ( name( $state->{trace}[0] ) eq name( $name ) ) {
        return name( $state->{trace}[1] );
    }
    else {
        return name( $state->{trace}[0] );
    }
}

sub _recurse {
    my ( $self, $state ) = @_;

    while ( my $ns = pop @{ $state->{ns} } ) {
        my $p = $ns->query( $state->{qname}, $state->{qtype}, { class => $state->{qclass} } );

        next if not $p;
        next if $p->header->rcode eq 'REFUSED';
        next if $p->header->rcode eq 'SERVFAIL';

        return ( $p, $state ) if $p->no_such_record;
        return ( $p, $state ) if $p->no_such_name;
        return ( $p, $state ) if $self->is_answer( $p, $state->{qname}, $state->{qtype}, $state->{qclass} );

        if ( $p->is_redirect ) {
            $state->{ns} = $self->follow_redirect( $p );
            $state->{counter} += 1;
            unshift @{ $state->{trace} }, ( $p->get_records( 'ns' ) )[0]->name;
        }

        return if $state->{count} > 20;    # Loop protection
    }

    return;
}

sub follow_redirect {
    my ( $self, $p ) = @_;
    my @new;

    my @names = map { name( $_->nsdname ) } $p->get_records( 'ns' );
    my %glue = map { name( $_->name ) => $_->address } ( $p->get_records( 'a' ), $p->get_records( 'aaaa' ) );

    foreach my $name ( @names ) {
        if ( $glue{$name} ) {
            push @new, ns( $name, $glue{$name} );
        }
        else {
            my $pa    = $self->recurse( $name, 'A' );
            my $paaaa = $self->recurse( $name, 'AAAA' );

            foreach my $rr ( grep { $_->name eq $name } ( $pa->get_records( 'a' ), $paaaa->get_records( 'aaaa' ) ) ) {
                push @new, ns( $name, $rr->address );
            }
        }
    }

    return \@new;
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
            $packet->unique_push( answer => $new_packet->answer );
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

1;
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
