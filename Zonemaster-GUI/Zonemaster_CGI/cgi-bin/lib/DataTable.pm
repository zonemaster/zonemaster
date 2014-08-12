package DataTable;
use strict;
use warnings;
use Carp;
use base qw/ DataBase /;

sub new {
    my $this  = shift;
    my $class = ref($this) || $this;
    my $self  = $class->SUPER::new(shift);
    $self->{table} = shift;
    croak 'Invalid table name'
      unless ( defined( $self->{table} ) && $self->{table} =~ m/\w/ );
    $self->{table} =~ s/^\s+|\s+$//sg;
    return $self;
}

sub table {
    my $self = shift;
    croak 'Invalid object' unless ( defined($self) && ref($self) );
    return $self->{table};
}

sub all {
    my $self = shift;
    croak 'Invalid object' unless ( defined($self) && ref($self) );
    return $self->SUPER::all( $self->table, @_ );
}

sub find {
    my $self = shift;
    croak 'Invalid object' unless ( defined($self) && ref($self) );
    return $self->SUPER::find( $self->table, @_ );
}

sub select {
    my $self = shift;
    croak 'Invalid object' unless ( defined($self) && ref($self) );
    return $self->SUPER::select( $self->table, @_ );
}

sub insert {
    my $self = shift;
    croak 'Invalid object' unless ( defined($self) && ref($self) );
    return $self->SUPER::insert( $self->table, @_ );
}

sub update {
    my $self = shift;
    croak 'Invalid object' unless ( defined($self) && ref($self) );
    $self->SUPER::update( $self->table, @_ );
}

sub delete {
    my $self = shift;
    croak 'Invalid object' unless ( defined($self) && ref($self) );
    $self->SUPER::delete( $self->table, @_ );
}

1;
