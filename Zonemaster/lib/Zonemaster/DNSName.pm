package Zonemaster::DNSName v0.0.1;

use 5.14.2;
use Moose;
use Moose::Util::TypeConstraints;

coerce 'Zonemaster::DNSName', from 'Str', via { Zonemaster::DNSName->new( $_ ) };

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
    elsif (ref($_[0]) and ref($_[0]) eq __PACKAGE__) {
        return $_[0];
    }
    elsif (ref($_[0]) and ref($_[0]) eq 'Zonemaster::Zone') {
        return $_[0]->name;
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

sub fqdn {
    my ( $self ) = @_;

    return join( '.', @{$self->labels}) . '.';
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
        return Zonemaster::DNSName->new( labels => \@l );
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

sub prepend {
    my ( $self, $label ) = @_;
    my @labels = ( $label, @{ $self->labels } );

    return $self->new( { labels => \@labels } );
}

sub TO_JSON {
    my ( $self ) = @_;

    return $self->string;
}

## no critic (Modules::RequireExplicitInclusion)
__PACKAGE__->meta->make_immutable;

1;

=head1 NAME

Zonemaster::DNSName - class representing DNS names

=head1 SYNOPSIS

    my $name1 = Zonemaster::Name->new('www.example.org');
    my $name2 = Zonemaster::Name->new('ns.example.org');
    say "Yay!" if $name1->common($name2) == 2;

=head1 ATTRIBUTES

=over

=item labels

A reference to a list of strings, being the labels the DNS name is made up from.

=back

=head1 METHODS

=over

=item new($input) _or_ new({ labels => \@labellist})

The constructor can be called with either a single argument or with a reference
to a hash as in the example above.

If there is a single argument, it must be either a non-reference, a
L<Zonemaster::DNSName> object or a L<Zonemaster::Zone> object.

If it's a non-reference, it will be split at period characters (possibly after
stringification) and the resulting list used as the name's labels.

If it's a L<Zonemaster::DNSName> object it will simply be returned.

If it's a L<Zonemaster::Zone> object, the value of its C<name> attribute will
be returned.

=item string()

Returns a string representation of the name. The string representation is created by joining the labels with dots. If there are no labels, a
single dot is returned. The names created this way do not have a trailing dot.

The stringification operator is overloaded to this function, so it should rarely be necessary to call it directly.

=item fqdn()

Returns the name as a string complete with a trailing dot.

=item str_cmp($other)

Overloads string comparison. Comparison is made after converting the names to upper case, and ignores any trailing dot on the other name.

=item next_higher()

Returns a new L<Zonemaster::DNSName> object, representing the name of the called one with the leftmost label removed.

=item common($other)

Returns the number of labels from the rightmost going left that are the same in both names. Used by the recursor to check for redirections going
up the DNS tree.

=item prepend($label)

Returns a new L<Zonemaster::DNSName> object, representing the called one with the given label prepended.

=item TO_JSON

Helper method for JSON encoding.

=over

=cut
