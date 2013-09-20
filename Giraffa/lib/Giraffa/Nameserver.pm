package Giraffa::Nameserver v0.0.1;

use 5.14.2;
use Moose;
use Moose::Util::TypeConstraints;

use Giraffa::DNSName;
use Giraffa;
use Giraffa::Packet;

use Net::DNS;
use Net::IP;
use Time::HiRes qw[time];
use Storable qw[nstore retrieve];
use Module::Find qw[useall];

subtype 'Giraffa::Net::IP', as 'Object', where { $_->isa( 'Net::IP' ) };
coerce 'Giraffa::Net::IP', from 'Str', via { Net::IP->new( $_ ) };

has 'name'    => ( is => 'ro', isa => 'Giraffa::DNSName', coerce => 1, required => 0 );
has 'address' => ( is => 'ro', isa => 'Giraffa::Net::IP', coerce => 1, required => 1 );

has 'dns' => ( is => 'ro', isa => 'Net::DNS::Resolver', lazy_build => 1 );
has 'cache' => ( is => 'ro', isa => 'HashRef', default => sub { {} } );

###
### Variables
###

our %object_cache;

###
### Build methods for attributes
###

around 'new' => sub {
    my $orig = shift;
    my $self = shift;

    my $obj = $self->$orig( @_ );
    my $name = '$$$NONAME' // $obj->name;

    return $object_cache{ '' . $name }{ $obj->address->ip } //= $obj;
};

sub _build_dns {
    my ( $self ) = @_;

    my $res = Net::DNS::Resolver->new(
        nameservers => [ $self->address->ip ],
        recurse     => 0,
        port        => 53,
        defnames    => 0,
        dnsrch      => 0,
    );

    my %defaults = %{ Giraffa->config->get->{resolver}{defaults} };
    foreach my $flag ( keys %defaults ) {
        $res->$flag( $defaults{$flag} );
    }

    return $res;
}

###
### Public Methods (and helpers)
###

sub query {
    my ( $self, $name, $type, $href ) = @_;
    $type //= 'A';

    Giraffa->logger->add( 'query', { name => "$name", type => $type, flags => $href, ip => $self->address->short } );

    my %defaults = %{ Giraffa->config->get->{resolver}{defaults} };
    return $self->cache->{$name}{$type}{ $href->{class} // 'IN' }{ $href->{dnssec}
          // $defaults{dnssec} }{ $href->{usevc} // $defaults{usevc} }{ $href->{recurse} // $defaults{recurse} } //=
      $self->_query( $name, $type, $href );
}

sub _query {
    my ( $self, $name, $type, $href ) = @_;
    my %flags;

    $type //= 'A';
    $href->{class} //= 'IN';

    Giraffa->logger->add( 'external_query', { name => "$name", type => $type, flags => $href, ip => $self->address->short } );

    my %defaults = %{ Giraffa->config->get->{resolver}{defaults} };

    foreach my $flag ( keys %defaults ) {
        $flags{$flag} = $href->{$flag} // $defaults{$flag};
    }

    foreach my $flag ( keys %flags ) {
        $self->dns->$flag( $flags{$flag} );
    }

    my $res = eval { $self->dns->send( "$name", $type, $href->{class} ) };

    foreach my $flag ( keys %defaults ) {
        $self->dns->$flag( $defaults{$flag} );
    }

    if ( $res ) {
        return Giraffa::Packet->new( { packet => $res } );
    }
    else {
        return;
    }
}

sub save {
    my ( $class, $filename ) = @_;

    return nstore \%object_cache, $filename;
}

sub restore {
    my ( $class, $filename ) = @_;

    useall 'Net::DNS::RR';
    %object_cache = %{ retrieve( $filename ) };

    return;
}

1;
