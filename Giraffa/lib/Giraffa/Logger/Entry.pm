package Giraffa::Logger::Entry v0.0.1;

use 5.14.2;
use Time::HiRes qw[time];
use JSON::PP;
use Moose;

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

    foreach my $e (@{$self->trace}) {
        if ($e->[1] eq 'Giraffa::Util::info' and $e->[0] =~ /^Giraffa::Test::(.*)$/) {
            return uc $1;
        }
    }

    return 'SYSTEM';
}

sub string {
    no warnings 'uninitialized';
    my ( $self ) = @_;
    my $argstr = '';

    $argstr = join( ', ',
        map { $_ . '=' . ( ref( $self->args->{$_} ) ? encode_json( $self->args->{$_} ) : $self->args->{$_} ) }
        sort keys %{ $self->args } )
      if $self->args;

    return sprintf( '%2.2f %s:%s %s', $self->timestamp, $self->module, $self->tag, $argstr );
}

1;
