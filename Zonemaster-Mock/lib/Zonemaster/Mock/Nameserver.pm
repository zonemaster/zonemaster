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

    my $rrset;
    if ($self->db->{$name} and $self->db->{$name}{ uc( $class ) } and $self->db->{$name}{ uc( $class ) }{ uc( $type ) }) {
        $rrset = $self->db->{$name}{ uc( $class ) }{ uc( $type ) };
    }

    # Found data, so answer with it
    if ($rrset and @$rrset > 0) {
        return $self->answer( $rrset, $p );
    }
    # It's in a subzone, so refer to that
    elsif (my $sub = $self->in_subzone($name)) {
        my $rrset = $self->db->{$sub}{'IN'}{'NS'};
        return $self->referral($p,$rrset);
    }
    # Should it be in one of our zones?
    elsif ( my $soa = $self->in_zone($name)) {
        if ($self->db->{$name}) {
            return $self->empty_response($p, $soa);
        } else {
            return $self->nxdomain($p, $soa);
        }
    }
}

sub in_zone {
    my ( $self, $name ) = @_;

    foreach my $sn (keys %{$self->zones}) {
        if ($name =~ /\Q$sn\E$/) {
            return $self->zones->{$sn};
        }
    }

    return;
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
    my ( $self, $p, $soa ) = @_;

    $p->unique_push('authority', $soa);
    $p->aa(1);
    return $p;
}

sub referral {
    my ( $self, $p, $rrset ) = @_;

    foreach my $rr (@$rrset) {
        $p->unique_push('authority', $rr);
    }

    return $p;
}

sub nxdomain {
    my ( $self, $p, $soa ) = @_;

    $p->unique_push('authority', $soa);
    $p->rcode('NXDOMAIN');
    $p->aa(1);
    return $p;
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
