package Zonemaster::Config v0.0.1;

use 5.14.2;
use Moose;
use JSON;
use File::ShareDir qw[dist_file];
use File::Slurp;
use Hash::Merge;

use Zonemaster;

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

our $policy = decode_json read_file dist_file( 'Zonemaster', 'policy.json' );

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
    my $default = eval { decode_json read_file dist_file( 'Zonemaster', 'config.json' ) };

    $internal = $merger->merge( $internal, $default ) if $default;

    $config = $internal;
}

sub load_config_file {
    my ( $class, $filename ) = @_;
    my $new = decode_json read_file $filename;
    $config = $merger->merge( $config, $new ) if $new;

    return !!$new;
}

sub load_policy_file {
    my ( $class, $filename ) = @_;
    my $new = decode_json read_file $filename;
    $policy = $merger->merge( $policy, $new ) if $new;

    return !!$new;
}

sub no_network {
    my ( $class, $value ) = @_;

    if (defined($value)) {
        $class->get->{no_network} = $value;
    }

    return $class->get->{no_network};
}

sub ipv4_ok {
    my ( $class, $value ) = @_;

    if ( defined($value) ) {
        $class->get->{net}{ipv4} = $value;
    }

    return $class->get->{net}{ipv4};
}

sub ipv6_ok {
    my ( $class, $value ) = @_;

    if ( defined($value) ) {
        $class->get->{net}{ipv6} = $value;
    }

    return $class->get->{net}{ipv6};
}

sub resolver_defaults {
    my ( $class ) = @_;

    return $class->get->{resolver}{defaults};
}

sub logfilter {
    my ( $class ) = @_;

    return $class->get->{logfilter};
}

sub asnroots {
    my ( $class ) = @_;

    return $class->get->{asnroots};
}

1;

=head1 NAME

Zonemaster::Config - configuration access module for Zonemaster

=head1 SYNOPSIS

    Zonemaster->config->no_network(1); # Forbid network traffic

    my $value = Zonemaster::Config->get->{key}{subkey}; # Not really recommended way to access config data

=head1 METHODS FOR CONFIGURATION ITEMS

=over

=item no_network([$value])

Returns the value of the C<no_network> flag. If given a defined value, sets the value to that value.

=item ipv4_ok([$value])

Returns the value of the C<ipv4> flag. If given a defined value, sets the value to that value.

=item ipv6_ok([$value])

Returns the value of the C<ipv6> flag. If given a defined value, sets the value to that value.

=item resolver_defaults()

Returns a reference to the resolver_defaults hash.

=item logfilter()

Returns a reference to the logfilter hash.

=item asnroots()

Returns a reference to the list of ASN lookup domains.

=back

=head1 METHODS

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

=head1 CONFIGURATION DATA

The configuration data is stored internally in a nested hash (possibly with arrays as values in places). As of this writing, the file format used is JSON.

The interesting keys are as follows.

=head2 resolver

=head3 defaults

These are the default flag and timing values used for the resolver objects used to actually send DNS queries.

=over

=item usevc

If set, only use TCP. Default not set.

=item retrans

The number of seconds between retries. Default 3.

=item dnssec

If set, sets the DO flag in queries. Default not set.

=item recurse

If set, sets the RD flag in queries. Default not set (and almost certainly should remain that way).

=item retry

The number of times a query is sent before we give up. Can be set to zero, although that's not very useful (since no queries will be sent at all). Defaults to 2.

=item igntc

If set, queries that get truncated UDP responses will be automatically retried over TCP. Default not set.

=back

=head2 net

=over

=item ipv4

If set, resolver objects are allowed to send queries over IPv4. Default set.

=item ipv6

If set, resolver objects are allowed to send queries over IPv6. Default set.

=back

=head2 no_network

If set to a true value, network traffic is forbidden. Use when you want to be sure that any data is only taken from a preloaded cache.

=head2 asnroots

This key must be a list of hashes. In the hashes the keys should be domain
suffixes, and the value the new suffix to replace the first one with. Normally,
there should be two keys, C<in-addr.arpa.> and C<ip6.arpa.>, that get replaced
with Team Cymru-style DNS zones for IP to AS lookup. The ASN lookup code will
try to use each hash in turn, and quit when one answers.

=head2 logfilter

By using this key, the log level of messages can be set in a much more fine-grained way than by the policy file. The intended use is to remove known erroneous results. If you, for example, know that a certain name server is recursive and for some reason should be, you can use this functionality to lower the severity of the complaint about it to a lower level than normal.

The the data under the C<logfilter> key should be structured like this:

   Module
      Tag
         "when"
            Hash with conditions
         "set"
            Level to set if all conditions match

The hash with conditions should have keys matching the attributes of the log entry that's being filtered (check the translation files to see what they are). The values for the keys should be either a single value that the attribute should be, or an array of values any one of which the attribute should be.

A complete entry might could look like this:

       "SYSTEM": {
           "FILTER_THIS": {
               "when": {
                   "count": 1,
                   "type": ["this", "or"]
               },
               "set": "INFO"
           }
       }

This would set the level to C<INFO> for any C<SYSTEM:FILTER_THIS> messages that had a C<count> attribute set to 1 and a C<type> attribute set to either C<this> or C<or>.

=cut

__DATA__
{
   "asnroots" : [
      {
         "in-addr.arpa." : "origin.asnlookup.iis.se",
         "ip6.arpa." : "origin6.asnlookup.iis.se"
      },
      {
         "in-addr.arpa." : "origin.asn.cymru,com",
         "ip6.arpa." : "origin6.asn.cymru.com"
      }
   ],
   "net" : {
      "ipv4" : 1,
      "ipv6" : 1
   },
   "no_network" : 0,
   "resolver" : {
      "defaults" : {
         "debug" : 0,
         "dnssec" : 0,
         "edns_size" : 0,
         "igntc" : 0,
         "recurse" : 0,
         "retrans" : 3,
         "retry" : 2,
         "usevc" : 0
      }
   }
}