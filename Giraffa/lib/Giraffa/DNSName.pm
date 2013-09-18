package Giraffa::DNSName v0.0.1;

use 5.14.2;
use Moose;
use Moose::Util::TypeConstraints;

coerce 'Giraffa::DNSName', from 'Str', via { Giraffa::DNSName->new( $_ ) };

use overload
  '""'  => \&string,
  'cmp' => \&str_cmp;

has 'labels' => ( is => 'ro', isa => 'ArrayRef[Str]', required => 1 );

around BUILDARGS => sub {
    my $orig  = shift;
    my $class = shift;

    if ( @_ == 1 && !ref $_[0] ) {
        my $name = shift;
        $name = '' if not defined( $name );
        my @labels = split( /\./, $name );
        return $class->$orig( labels => \@labels );
    }
    else {
        return $class->$orig( @_ );
    }
};

sub string {
    my $self = shift;

    my $name = join( '.', @{ $self->labels } );
    $name = '.' if $name eq '';

    return $name;
}

sub str_cmp {
    my ( $self, $other ) = @_;

    $other =~ s/(.+)\.$/$1/;

    return ( uc( "$self" ) cmp uc( $other ) );
}

sub next_higher {
    my $self = shift;
    my @l    = @{ $self->labels };
    if ( @l ) {
        shift @l;
        return Giraffa::DNSName->new( labels => \@l );
    }
    else {
        return;
    }
}

sub common {
    my ( $self, $other ) = @_;

    my @me   = reverse @{ $self->labels };
    my @them = reverse @{ $other->labels };

    my $count = 0;
    while ( @me and @them ) {
        my $m = shift @me;
        my $t = shift @them;
        if ( uc( $m ) eq uc( $t ) ) {
            $count += 1;
            next;
        }
        else {
            last;
        }
    }

    return $count;
}

__PACKAGE__->meta->make_immutable;

1;
