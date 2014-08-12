package DataRecord;
use strict qw/vars subs/;
use warnings;
use Carp;
use Fields;
use Data::Dumper;
use base qw/ DataTable /;

sub new {
    my $this   = shift;
    my $class  = ref($this) || $this;
    my $self   = $class->SUPER::new( splice @_, 0, 2 );
    my @fields = Fields->get_table_fields( $self->table );
    return $self unless @fields;
    $self->{fields} = {};
    no warnings 'redefine';

    foreach my $field (@fields) {
        $self->{fields}{$field} = '';
        *{ __PACKAGE__ . '::' . $field } = sub {
            my $self = shift;
            croak 'Invalid object' unless $self && ref($self);
            $self->{fields}{$field} = shift if @_;
            return $self->{fields}{$field};
          }
          unless __PACKAGE__->can($field);
    }
    $self->{id} = undef;
    return $self unless @_;
    my $record = $self->find(@_);
    return $self unless $record;
    $self->{id} = $record->{id};
    foreach ( keys %$record ) {
        $self->{fields}{$_} = $record->{$_} unless $_ eq 'id';
    }
    return $self;
}

sub clone {
    my $self = shift;
    croak 'Invalid object' unless $self && ref($self);
    while (@_) {
        my $key = shift;
        my $val = shift;
        croak 'Odd number of elements in hash' unless defined($val);
        $key =~ s/^\s+|\s+$//sg;
        $val =~ s/^\s+|\s+$//sg;
        unless ( $key eq 'id' ) {
            $self->{fields}{$key} = $val;
        }
        else {
            $self->{id} = $val;
        }
    }
    return $self;
}

sub as_hash {
    my $self = shift;
    croak 'Invalid object' unless $self && ref($self);
    my $parsed_hash = $self->{id} ? { id => $self->{id} } : {};
    my @fields = Fields->get_table_fields( $self->table );
    foreach my $field (@fields) {
        $parsed_hash->{$field} = $self->{fields}{$field};
    }
    return $parsed_hash;
}

sub id {
    my $self = shift;
    croak 'Invalid object' unless $self && ref($self);
    return $self->{id};
}

sub fields {
    my $self = shift;
    croak 'Invalid object' unless $self && ref($self);
    return Fields->get_table_fields( $self->table );
}

sub save {
    my $self = shift;
    croak 'Invalid object' unless $self && ref($self);
    unless ( $self->id ) {
        $self->created( $self->env->now )      if $self->can('created');
        $self->last_updated( $self->env->now ) if $self->can('last_updated');
        $self->{id} = $self->SUPER::insert( %{ $self->{fields} } );
    }
    else {
        $self->last_updated( $self->env->now ) if $self->can('last_updated');
        $self->SUPER::update( $self->{fields}, $self->id );
    }
    return $self->{id};
}

sub delete {
    my $self = shift;
    croak 'Invalid object' unless $self && ref($self);
    croak 'Attempt to delete undefined object' unless $self->id;
    $self->SUPER::delete( $self->id );
    $self->{id} = '';
}

sub now {
    my $self = shift;
    croak 'Invalid object' unless $self && ref($self);
    return $self->env->now();
}

1;
