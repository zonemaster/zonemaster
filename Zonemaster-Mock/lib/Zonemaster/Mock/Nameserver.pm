package Zonemaster::Mock::Nameserver;

use 5.14.2;
use Moose;
use Moose::Util::TypeConstraints;
use Time::HiRes qw[time];

use Zonemaster;

has 'name'    => ( is => 'ro', isa => 'Zonemaster::DNSName', coerce => 1, required => 1 );
has 'address' => ( is => 'ro', isa => 'Zonemaster::Net::IP', coerce => 1, required => 1 );

has 'db'       => ( is => 'ro', isa => 'HashRef', default => sub { {} } );
has 'zones'    => ( is => 'ro', isa => 'HashRef', default => sub { {} } );
has 'subzones' => ( is => 'ro', isa => 'HashRef', default => sub { {} } );

our $id = 1;

sub dname { Zonemaster::DNSName->new(@_)}
sub next_id { return $id++}

sub load {
    my ( $self, @rrs ) = @_;

    my $soa      = $rrs[0];
    my $zonename = dname( $soa->name );

    $self->zones->{$zonename} = $soa;
    foreach my $rr ( @rrs ) {
        my $n = dname( $rr->name );
        push @{ $self->db->{$n}{ $rr->class }{ $rr->type } }, $rr;
        if ( $rr->type eq 'NS' and $n ne $zonename ) {
            $self->subzones->{$n} = $n;
        }
    }

    return;
}

sub query {
    my ( $self, $name, $type, $href ) = @_;
    my $class = $href->{class} // 'IN';
    my $p = Net::LDNS::Packet->new( "$name", $type, $class );
    $p->answerfrom($self->address->short);
    $p->id(next_id());
    $p->timestamp(time());

    $name = dname( $name );

    my $rrset = $self->db->{$name}{ uc( $class ) }{ uc( $type ) };

    if ($rrset and @$rrset > 0) { # Found data, so answer with it
        return $self->answer( $rrset, $p );
    }
    elsif (my $sub = $self->in_subzone($name)) {
        my $rrset = $self->db->{$sub}{'IN'}{'NS'};
        return $self->referral($p,$rrset);
    }
}

sub in_subzone {
    my ( $self, $name ) = @_;

    foreach my $sn (keys %{$self->subzones}) {
        if ($name =~ /\Q$sn\E$/) {
            return $self->subzones->{$sn};
        }
    }

    return;
}

sub empty_response {
    my ( $self, $p ) = @_;

    ...;
}

sub referral {
    my ( $self, $p, $rrset ) = @_;

    foreach my $rr (@$rrset) {
        $p->unique_push('authority', $rr);
    }

    return $p;
}

sub nxdomain {
    my ( $self, $p ) = @_;

    ...;
}

sub answer {
    my ( $self, $rrset, $p ) = @_;

    foreach my $rr (@$rrset) {
        $p->unique_push('answer', $rr);
    }

    $p->aa(1);
    return $p;
}

1;
