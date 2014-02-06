package Giraffa::Logger::Entry v0.0.1;

use 5.14.2;
use Time::HiRes qw[time];
use JSON;
use Moose;
use Giraffa;

use overload '""' => \&string;

our $start_time;

INIT {
    $start_time = time();
}

has 'module'    => ( is => 'ro', isa => 'Str',                lazy_build => 1 );
has 'tag'       => ( is => 'ro', isa => 'Str',                required   => 1 );
has 'args'      => ( is => 'ro', isa => 'Maybe[HashRef]',     required   => 0 );
has 'timestamp' => ( is => 'ro', isa => 'Num',                default    => sub { time() - $start_time } );
has 'trace'     => ( is => 'ro', isa => 'ArrayRef[ArrayRef]', builder    => '_build_trace' );
has 'level'     => ( is => 'ro', isa => 'Str',                lazy_build => 1 );

sub _build_trace {
    my ( $self ) = @_;
    my @trace;

    my $i = 0;

    #        0          1      2            3         4           5          6            7       8         9         10
    # $package, $filename, $line, $subroutine, $hasargs, $wantarray, $evaltext, $is_require, $hints, $bitmask, $hinthash
    while ( my @line = caller( $i++ ) ) {
        next unless $line[3] =~ /^Giraffa/;
        push @trace, [ @line[ 0, 3 ] ];
    }

    return \@trace;
}

sub _build_module {
    my ( $self ) = @_;

    foreach my $e ( @{ $self->trace } ) {
        if (    $e->[1] eq 'Giraffa::Util::info'
            and $e->[0] =~ /^Giraffa::Test::(.*)$/ )
        {
            return uc $1;
        }
    }

    return 'SYSTEM';
}

sub _build_level {
    my ( $self ) = @_;

    if ( Giraffa->config->policy->{ $self->module }{ $self->tag } ) {
        return Giraffa->config->policy->{ $self->module }{ $self->tag };
    }
    else {
        return 'DEBUG';
    }
}

sub string {
    my ( $self ) = @_;
    my $argstr = '';
    ## no critic (TestingAndDebugging::ProhibitNoWarnings)
    no warnings 'uninitialized';

    $argstr = join( ', ',
        map { $_ . '=' . ( ref( $self->args->{$_} ) ? encode_json( $self->args->{$_} ) : $self->args->{$_} ) }
        sort keys %{ $self->args } )
      if $self->args;

    return sprintf( '%7.2f %-7s %s:%s %s', $self->timestamp, $self->level, $self->module, $self->tag, $argstr );
}

1;

=head1 NAME

Giraffa::Logger::Entry - module for single log entries

=head1 SYNOPSIS

    Giraffa->logger->add( TAG => { some => 'arguments' });

There should never be a need to create a log entry object in isolation. They should always be associated with and created via a logger object.

=head1 ATTRIBUTES

=over

=item module

An auto-generated identifier of the module that created the log entry. If it was generated from a module under Giraffa::Test, it will be an
uppercased version of the part of the name after "Giraffa::Test". For example, "Giraffa::Test::Basic" gets the module identifier "BASIC". If the
entry was generated from anywhere else, it will get the module identifier "SYSTEM".

=item tag

The tag that was set when the entry was created.

=item args

The argument hash reference that was provided when the entry was created.

=item timestamp

The time after the current program started running when this entry was created. This is a floating-point value with the precision provided by
L<Time::HiRes>. 

=item trace

A partial stack trace for the call that created the entry. Used to create the module tag. Almost certainly not useful for anything else.

=back

=head1 METHODS

=over

=item string

Simple method to generate a string representation of the log entry. Overloaded to the stringification operator.

=back

=cut
