package Giraffa::Translator v0.0.1;

use 5.14.2;
use strict;
use warnings;

use Moose;
use Carp;

use File::ShareDir qw[dist_dir];
use File::Slurp;
use JSON;

# Not necessary if a filename is given
has 'lang' => ( is => 'ro', isa => 'Str', required => 0 );

# Can be auto-generated from language code
has 'file' => ( is => 'ro', isa => 'Maybe[Str]', lazy => 1, builder => 'find_file' );

# Loaded from file
has 'data' => ( is => 'ro', isa => 'HashRef', lazy => 1, builder => 'load_language' );

around 'new' => sub {
    my $orig  = shift;
    my $class = shift;

    my $obj = $class->$orig( @_ );

    croak 'Must have at least one of lang and file'
      if not( $obj->lang or $obj->file );

    return $obj;
};

###
### Builder Methods
###

sub find_file {
    my ( $self ) = @_;

    return unless defined( $self->lang );

    my $filename = sprintf( '%s/language_%s.json', dist_dir( 'Giraffa' ), $self->lang );
    if ( not -r $filename ) {
        croak "Cannot read translation file " . $filename . "\n";
    }

    return $filename;
}

sub load_language {
    my ( $self ) = @_;

    return decode_json read_file $self->file;
}

###
### Working methods
###

sub translate {
    my ( $self, $entry ) = @_;

    my $string = $self->data->{ $entry->module }{ $entry->tag };

    if ( not $string ) {
        return $entry->string;
    }

    foreach my $arg ( keys %{ $entry->args } ) {
        if ( not $string =~ s/\{$arg\}/$entry->args->{$arg}/e ) {
            warn "Unused entry argument '$arg";
        }
    }

    while ( $string =~ /\{(\w+)\}/g ) {
        warn "Expected argument $1 not provided";
    }

    return sprintf( "%7.2f %-7s %s", $entry->timestamp, $entry->level, $string );
}

1;
