package Zonemaster::Config v0.0.2;

use 5.14.2;
use Moose;
use JSON;
use File::ShareDir qw[dist_dir dist_file];
use File::Slurp;
use Hash::Merge;
use File::Spec;

use Zonemaster;

has 'cfiles' => ( is => 'ro', isa => 'ArrayRef', default => sub {[]});
has 'pfiles' => ( is => 'ro', isa => 'ArrayRef', default => sub {[]});

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

our $policy = {};

sub BUILD {
    my ( $self ) = @_;

    foreach my $dir (_config_directory_list()) {
        my $cfile = File::Spec->catfile($dir, 'config.json');
        my $new = eval { decode_json read_file $cfile };
        if ($new) {
            $config = $merger->merge( $config, $new );
            push @{$self->cfiles}, $cfile;
        }

        my $pfile = File::Spec->catfile($dir, 'policy.json');
        $new = eval { decode_json read_file $pfile };
        if ($new) {
            $policy = $merger->merge( $policy, $new );
            push @{$self->pfiles}, $pfile;
        }

    }
}

sub get {
    my ( $class ) = @_;

    return $config;
}

sub policy {
    my ( $class ) = @_;

    if (not $policy) {
        _load_base_policy();
    }

    return $policy;
}

sub _config_directory_list {
    my @dirlist;

    push @dirlist, dist_dir( 'Zonemaster' );
    push @dirlist, '/etc/zonemaster';
    push @dirlist, '/usr/local/etc/zonemaster';

    my $dir = (getpwuid($>))[7];
    if ($dir) {
        push @dirlist, $dir . '/.zonemaster';
    }

    return @dirlist;
}

sub _load_base_config {
    my $internal = decode_json( join( '', <DATA> ) );
    # my $filename = dist_file( 'Zonemaster', 'config.json' );
    # my $default = eval { decode_json read_file $filename };
    # 
    # $internal = $merger->merge( $internal, $default ) if $default;

    $config = $internal;
}

sub load_module_policy {
    my ($class, $mod) = @_;

    my $m = 'Zonemaster::Test::' . $mod;
    if ($m->can('policy') and $m->policy) {
        $policy = $merger->merge($policy, {$mod => $m->policy});
    }

    return;
}

sub load_config_file {
    my ( $class, $filename ) = @_;
    my $new = decode_json read_file $filename;
    $config = $merger->merge( $config, $new ) if $new;

    return !!$new;
}

sub load_policy_file {
    my ( $self, $filename ) = @_;

    if (not -r $filename) {
        foreach my $dir (_config_directory_list()) {
            my $name = File::Spec->catfile($dir, $filename);
            if (-r $name) {
                $filename = $name;
                last;
            } else {
                if (-r $name . '.json') {
                    $filename = $name . '.json';
                    last;
                }
            }
        }
    }

    my $new = decode_json read_file $filename;
    if ($new) {
        $policy = $merger->merge( $policy, $new );
        push @{$self->pfiles}, $filename if (ref($self) and $self->isa(__PACKAGE__));
    }

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

no Moose;
__PACKAGE__->meta->make_immutable;

1;

=head1 NAME

Zonemaster::Config - configuration access module for Zonemaster

=head1 SYNOPSIS

    Zonemaster->config->no_network(1); # Forbid network traffic

    my $value = Zonemaster::Config->get->{key}{subkey}; # Not really recommended way to access config data

=head1 LOADING CONFIGURATION

Configuration data is loaded in several stages, each one overlaying the result
from the previous one (that is, the later in the list take priority over the
earlier). The first stage is hardcoded into the source code and loaded while it
is being compiled, to make sure that there will always be some basic
information available. Later, when the configuration object is first used, the
system will look for a file named F<config.json> in each of a list of
directories. If the file exists, is readable and contains proper JSON data, it
will be loaded and overlaid on the current internal config. The directories
are, in order from first checked to last:

=over

=item The L<Zonemaster> perl module installation directory

This is where the installation process puts the default configuration. It is
not meant to be modified by the user, and it will be overwritten when the
module is upgraded (or reinstalled for any other reason). If you really need to
know where it is, you can either check the log message left when loading it or
run this command to find the path:

    perl -MFile::ShareDir=dist_dir -E 'say dist_dir( "Zonemaster" )'

=item /etc/zonemaster

Intended to hold system-global configuration changes.

=item /usr/local/etc/zonemaster

Basically the same as the previous one, but for those who like to keep their
locally installed software inside F</usr/local>.

=item ~/.zonemaster

That is, a F<.zonemaster> directory in the home directory of the current user.
Intended, obviously, for configuration changes local to one particular user.

=back

The possible contents of the JSON data is described further down in this manual
page.

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

Load policy information from the given file and merge it into the pre-loaded
policy. Information from the loaded file overrides the pre-loaded information
when the same keys exist in both places.

If the given name does not lead directly to a readable file, each of the usual
directories will be checked if the name is there. If the plain name isn't, the
suffix C<.json> will be appended and another try will be done. For example, a
file F<$HOME/.zonemaster/Example.json> will be loaded by calling this method
with the string C<"Example">.

=item load_config_file($filename)

Load configuration information from the given file and merge it into the pre-loaded config. Information from the loaded file overrides the pre-loaded information when the same keys exist in both places.

=item load_module_policy($module)

Loads policy data included in a test module. The argument must be the short
form (without the initial C<Zonemaster::Test::>) and correctly capitalized.

=item BUILD

Internal method only mentioned here to please L<Pod::Coverage>.

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

This key must be a list of domain names. The domains will be assumed to be
Cymru-style AS lookup zones. Normally only the first name in the list will be
used, the rest are backups in case the earlier ones don't work.

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
   "asnroots" : [ "asnlookup.zonemaster.net", "asnlookup.iis.se", "asn.cymru,com"],
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