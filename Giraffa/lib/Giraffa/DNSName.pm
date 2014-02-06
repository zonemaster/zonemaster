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
} ## end sub common

__PACKAGE__->meta->make_immutable;

1;

=head1 NAME

Giraffa::DNSName - class representing DNS names

=head1 SYNOPSIS

    my $name1 = Giraffa::Name->new('www.example.org');
    my $name2 = Giraffa::Name->new('ns.example.org');
    say "Yay!" if $name1->common($name2) == 2;

=head1 ATTRIBUTES

=over

=item labels

A reference to a list of strings, being the labels the DNS name is made up from.

=back

=head1 METHODS

=over

=item new($string) _or_ new({ labels => \@labellist})

The constructor can be called with either a single non-reference argument, which will be split at dot characters to create the label list, or with
a reference to a hash as in the example above.

=item string()

Returns a string representation of the name. The string representation is created by joining the labels with dots. If there are no labels, a
single dot is returned. The names created this way do not have a trailing dot.

The stringification operator is overloaded to this function, so it should rarely be necessary to call it directly.

=item str_cmp($other)

Overloads string comparison. Comparison is made after converting the names to upper case, and ignores any trailing dot on the other name.

=item next_higher()

Returns a new L<Giraffa::DNSName> object, representing the name of the called one with the leftmost label removed.

=item common($other)

Returns the number of labels from the rightmost going left that are the same in both names. Used by the recursor to check for redirections going
up the DNS tree.

=over

=cut
