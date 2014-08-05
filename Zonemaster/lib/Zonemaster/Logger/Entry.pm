package Zonemaster::Logger::Entry v0.0.1;

use 5.14.2;
use Time::HiRes qw[time];
use JSON;
use Moose;
use Zonemaster;

use overload '""' => \&string;

our %numeric = (
    DEBUG3   => -2,
    DEBUG2   => -1,
    DEBUG    => 0,
    INFO     => 1,
    NOTICE   => 2,
    WARNING  => 3,
    ERROR    => 4,
    CRITICAL => 5,
);

our $start_time = time();

my $json = JSON::XS->new->allow_blessed->convert_blessed;

has 'module'    => ( is => 'ro', isa => 'Str',                lazy_build => 1 );
has 'tag'       => ( is => 'ro', isa => 'Str',                required   => 1 );
has 'args'      => ( is => 'ro', isa => 'Maybe[HashRef]',     required   => 0 );
has 'timestamp' => ( is => 'ro', isa => 'Num',                default    => sub { time() - $start_time } );
has 'trace'     => ( is => 'ro', isa => 'ArrayRef[ArrayRef]', builder    => '_build_trace' );
has 'level'     => ( is => 'ro', isa => 'Str',                lazy_build => 1, writer => '_set_level' );

sub _build_trace {
    my ( $self ) = @_;
    my @trace;

    my $i = 0;

    #        0          1      2            3         4           5          6            7       8         9         10
    # $package, $filename, $line, $subroutine, $hasargs, $wantarray, $evaltext, $is_require, $hints, $bitmask, $hinthash
    while ( my @line = caller( $i++ ) ) {
        next unless $line[3] =~ /^Zonemaster/;
        push @trace, [ @line[ 0, 3 ] ];
    }

    return \@trace;
}

sub _build_module {
    my ( $self ) = @_;

    foreach my $e ( @{ $self->trace } ) {
        if (    $e->[1] eq 'Zonemaster::Util::info'
            and $e->[0] =~ /^Zonemaster::Test::(.*)$/ )
        {
            return uc $1;
        }
    }

    return 'SYSTEM';
}

sub _build_level {
    my ( $self ) = @_;
    my $string;

    if ( Zonemaster->config->policy->{ $self->module }{ $self->tag } ) {
        $string = uc Zonemaster->config->policy->{ $self->module }{ $self->tag };
    }
    else {
        $string = 'DEBUG';
    }

    if ( defined $numeric{$string} ) {
        return $string;
    }
    else {
        die "Unknown level string: $string";
    }
}

sub numeric_level {
    my ( $self ) = @_;

    return $numeric{ $self->level };
}

sub levels {
    return %numeric;
}

sub string {
    my ( $self ) = @_;
    my $argstr = '';
    ## no critic (TestingAndDebugging::ProhibitNoWarnings)
    no warnings 'uninitialized';

    $argstr = join( ', ',
        map { $_ . '=' . ( ref( $self->args->{$_} ) ? $json->encode( $self->args->{$_} ) : $self->args->{$_} ) }
        sort keys %{ $self->args } )
      if $self->args;

    return sprintf( '%s:%s %s', $self->module, $self->tag, $argstr );
}


###
### Class method
###

sub start_time_now {
    $start_time = time();
}

1;

=head1 NAME

Zonemaster::Logger::Entry - module for single log entries

=head1 SYNOPSIS

    Zonemaster->logger->add( TAG => { some => 'arguments' });

There should never be a need to create a log entry object in isolation. They should always be associated with and created via a logger object.

=head1 CLASS METHOD

=over

=item levels

Returns a hash where the keys are log levels as strings and the corresponding values their numeric value.

=back

=head1 ATTRIBUTES

=over

=item module

An auto-generated identifier of the module that created the log entry. If it was generated from a module under Zonemaster::Test, it will be an
uppercased version of the part of the name after "Zonemaster::Test". For example, "Zonemaster::Test::Basic" gets the module identifier "BASIC". If the
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

=item numeric_level

Returns the log level of the entry in numeric form.

=back

=head1 CLASS METHOD

=over

=item start_time_now()

Set the logger's start time to the current time.

=back

=cut
