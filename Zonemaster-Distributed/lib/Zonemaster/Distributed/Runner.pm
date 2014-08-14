package Zonemaster::Distributed::Runner;

use 5.014002;
use warnings;

our $VERSION = '0.01';

use Moose;
use IPC::Run qw( start pump finish );
use Zonemaster;
use Storable qw[nfreeze thaw];
use MIME::Base64 qw[encode_base64url decode_base64url];
use Time::HiRes qw[sleep];
use Net::LibIDN qw[idn_to_ascii];
use Carp;

has 'children' => ( is => 'ro', isa => 'HashRef', default => sub { {} } );
has 'entry_cb'    => ( is => 'rw', isa => 'CodeRef',        required => 1 );
has 'finished_cb' => ( is => 'rw', isa => 'Maybe[CodeRef]', required => 0 );
has 'delay'       => ( is => 'rw', isa => 'Num',            default  => 0.1 );
has 'limit'       => ( is => 'rw', isa => 'Int',            default  => 10 );

###
### Modifier
###

# Fuzz delay by plus or minus up to 10% as lockstep prevention
around 'delay' => sub {
    my ( $orig, $self, $delay ) = @_;

    $self->$orig( $delay ) if $delay;
    my $val = $self->$orig();
    return ( $val * ( 0.9 + rand( 0.2 ) ) );
};

###
### Instance Methods
###

sub active_count {
    my ( $self ) = @_;

    return scalar( keys( %{ $self->children } ) );
}

sub has_free_slot {
    my ( $self ) = @_;

    return !!( $self->active_count < $self->limit );
}

# VAR1 = {
#           'name' => 'nrj.se',
#           '_rev' => '2-04dc5f456d61b9c332891a62abd87806',
#           '_id' => '3abd52649016e0aeba9558170229aa5e',
#           'results' => [
#                          {
#                            'start_time' => '1409032786.60485',
#                            'alabel' => 'nrj.se',
#                            'ulabel' => 'nrj.se',
#                            'nodename' => 'Necronomicon-II.local'
#                          }
#                        ],
#           'request' => {}
#         };

sub start_child {
    my ( $self, $doc, $setup_cref ) = @_;

    if ( not $self->has_free_slot ) {
        croak "Tried to start child in runner with no free slots";
    }

    my $out;
    my $err;
    my $harness = start( sub { _scan( $doc, $setup_cref ) }, \undef, \$out, \$err );

    my %entry;
    $entry{doc}     = $doc;
    $entry{harness} = $harness;
    $entry{out}     = \$out;
    $entry{err}     = \$err;

    $self->children->{ $doc->{_id} } = \%entry;

    return 1;
}

sub terminate {
    my ( $self, $id ) = @_;

    $self->children->{$id}{harness}->kill_kill;
}

sub process_once {
    my ( $self ) = @_;
    my $href = $self->children;

    my @ids = keys %$href;

    foreach my $id ( @ids ) {
        my $harness = $href->{$id}{harness};
        my $out     = $href->{$id}{out};
        my $err     = $href->{$id}{err};

        if ( not $harness ) {
            delete $href->{$id};
            next;
        }

        my $more = $harness->pump_nb;
        while ( index( $$out, "\n" ) >= 0 ) {
            my ( $raw, $rest ) = split( /\n/, $$out, 2 );
            my $e = thaw( decode_base64url( $raw ) );

            $self->entry_cb->( $id, $e );
            $$out = $rest;
        }
        if ( not $more ) {
            finish $harness;
            delete $href->{$id};
            if ( $self->finished_cb ) {
                $self->finished_cb->( $id, $href->{$id}{err} );
            }
        }
    }

    return;
}

sub loop {
    my ( $self ) = @_;

    while ( $self->active_count > 0 ) {
        $self->process_once;
        sleep( $self->delay );
    }

    return;
}

###
### Helper functions
###

sub _scan {
    my ( $doc, $setup ) = @_;
    my $name = $doc->{results}[0]{alabel};

    die "No name to scan" if not $name;

    if ( defined( $setup ) and ref( $setup ) and ref( $setup ) eq 'CODE' ) {
        $setup->();
    }

    Zonemaster->logger->callback(
        sub {
            my ( $e ) = @_;

            if ( $e->numeric_level >= 0 ) {
                say encode_base64url( nfreeze( $e ) );
            }
        }
    );
    Zonemaster->test_zone( $name );
}

1;
