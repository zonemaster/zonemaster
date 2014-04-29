package Giraffa::Config v0.0.1;

use 5.14.2;
use Moose;
use JSON;
use File::ShareDir qw[dist_file];
use File::Slurp;
use Hash::Merge;

use Giraffa;

my $merger = Hash::Merge->new;
$merger->specify_behavior(
    {
        'SCALAR' => {
            'SCALAR' => sub { $_[1] },
            'ARRAY'  => sub { [ $_[0], @{ $_[1] } ] },
            'HASH'   => sub { $_[1] },
        },
        'ARRAY' => {
            'SCALAR' => sub { $_[1] },
            'ARRAY'  => sub { [ @{ $_[1] } ] },
            'HASH'   => sub { $_[1] },
        },
        'HASH' => {
            'SCALAR' => sub { $_[1] },
            'ARRAY'  => sub { [ values %{ $_[0] }, @{ $_[1] } ] },
            'HASH'   => sub { Hash::Merge::_merge_hashes( $_[0], $_[1] ) },
        },
    }
);

our $config;
_load_base_config();

our $policy = decode_json read_file dist_file( 'Giraffa', 'policy.json' );

sub get {
    my ( $class ) = @_;

    return $config;
}

sub policy {
    my ( $class ) = @_;

    return $policy;
}

sub _load_base_config {
    my $internal = decode_json( join( '', <DATA> ) );
    my $default = eval { decode_json read_file dist_file( 'Giraffa', 'config.json') };

    $internal = $merger->merge($internal, $default) if $default;

    $config = $internal;
}

sub load_config_file {
    my ( $class, $filename ) = @_;
    my $new = decode_json read_file $filename;
    $config = $merger->merge($config,$new) if $new;

    return;
}

sub load_policy_file {
    my ( $class, $filename ) = @_;
    my $new = decode_json read_file $filename;
    $policy = $merger->merge($policy, $new) if $new;

    return;
}

1;

=head1 NAME

Giraffa::Config - configuration access module for Giraffa

=head1 SYNOPSIS

    my $value = Giraffa::Config->get->{key}{subkey};

=METHODS

=over

=item get()

Returns a reference to a hash with configuration values. As of this writing, this is simply seeded from static values hardcoded into the module.
This is intended to change.

=item policy()

Returns a reference to the current policy data. The format of that data is yet to be decided on.

=item load_policy_file($filename)

Load policy information from the given file and merge it into the pre-loaded policy. Information from the loaded file overrides the pre-loaded information when the same keys exist in both places.

=item load_config_file($filename)

Load configuration information from the given file and merge it into the pre-loaded config. Information from the loaded file overrides the pre-loaded information when the same keys exist in both places.

=back

=cut

__DATA__
{
    "resolver": {
        "defaults":
            {
                "usevc" : 0,
                "retrans" : 3,
                "dnssec" : 0,
                "debug" : 0,
                "recurse" : 0,
                "retry" : 2,
                "igntc" : 0
            }
        },
    "net": {
        "ipv4": 1,
        "ipv6": 1
    },
    "no_network": 0
}
