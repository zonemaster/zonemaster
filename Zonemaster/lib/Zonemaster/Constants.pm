package Zonemaster::Constants;

use strict;
use warnings;

use parent 'Exporter';
use Net::IP::XS;
use Readonly;

our @EXPORT_OK = qw[
  $ALGO_STATUS_DEPRECATED
  $ALGO_STATUS_PRIVATE
  $ALGO_STATUS_RESERVED
  $ALGO_STATUS_UNASSIGNED
  $ALGO_STATUS_VALID
  $DURATION_12_HOURS_IN_SECONDS
  $DURATION_180_DAYS_IN_SECONDS
  $FQDN_MAX_LENGTH
  $LABEL_MAX_LENGTH
  $IP_VERSION_4
  $IP_VERSION_6
  $MAX_SERIAL_VARIATION
  $MINIMUM_NUMBER_OF_NAMESERVERS
  $SOA_DEFAULT_TTL_MAXIMUM_VALUE
  $SOA_DEFAULT_TTL_MINIMUM_VALUE
  $SOA_EXPIRE_MINIMUM_VALUE
  $SOA_REFRESH_MINIMUM_VALUE
  $SOA_RETRY_MINIMUM_VALUE
  $UDP_PAYLOAD_LIMIT
  @IPV4_SPECIAL_ADDRESSES
  @IPV6_SPECIAL_ADDRESSES
];

our %EXPORT_TAGS = (
    all  => \@EXPORT_OK,
    algo => [
        qw($ALGO_STATUS_DEPRECATED $ALGO_STATUS_PRIVATE $ALGO_STATUS_RESERVED $ALGO_STATUS_UNASSIGNED $ALGO_STATUS_VALID)
    ],
    name => [qw($FQDN_MAX_LENGTH $LABEL_MAX_LENGTH)],
    ip   => [qw($IP_VERSION_4 $IP_VERSION_6)],
    soa  => [
        qw($SOA_DEFAULT_TTL_MAXIMUM_VALUE $SOA_DEFAULT_TTL_MINIMUM_VALUE $SOA_EXPIRE_MINIMUM_VALUE $SOA_REFRESH_MINIMUM_VALUE $SOA_RETRY_MINIMUM_VALUE $DURATION_12_HOURS_IN_SECONDS $DURATION_180_DAYS_IN_SECONDS $MAX_SERIAL_VARIATION)
    ],
    misc => [qw($UDP_PAYLOAD_LIMIT $MINIMUM_NUMBER_OF_NAMESERVERS)],
    addresses => [qw(@IPV4_SPECIAL_ADDRESSES @IPV6_SPECIAL_ADDRESSES)],
);

Readonly our $ALGO_STATUS_DEPRECATED => 1;
Readonly our $ALGO_STATUS_PRIVATE    => 4;
Readonly our $ALGO_STATUS_RESERVED   => 2;
Readonly our $ALGO_STATUS_UNASSIGNED => 3;
Readonly our $ALGO_STATUS_VALID      => 5;

Readonly our $DURATION_12_HOURS_IN_SECONDS => 12 * 60 * 60;
Readonly our $DURATION_180_DAYS_IN_SECONDS => 180 * 24 * 60 * 60;

# Maximum length of ASCII version of a domain name, with trailing dot.
Readonly our $FQDN_MAX_LENGTH  => 254;
Readonly our $LABEL_MAX_LENGTH => 63;

Readonly our $IP_VERSION_4 => 4;
Readonly our $IP_VERSION_6 => 6;

Readonly our $MAX_SERIAL_VARIATION => 0;

Readonly our $MINIMUM_NUMBER_OF_NAMESERVERS => 2;

Readonly our $SOA_DEFAULT_TTL_MAXIMUM_VALUE => 86_400;     # 1 day
Readonly our $SOA_DEFAULT_TTL_MINIMUM_VALUE => 300;        # 5 minutes
Readonly our $SOA_EXPIRE_MINIMUM_VALUE      => 604_800;    # 1 week
Readonly our $SOA_REFRESH_MINIMUM_VALUE     => 14_400;     # 4 hours
Readonly our $SOA_RETRY_MINIMUM_VALUE       => 3_600;      # 1 hour

Readonly our $UDP_PAYLOAD_LIMIT => 512;

Readonly::Array our @IPV4_SPECIAL_ADDRESSES => (
    { ip => Net::IP::XS->new( q{0.0.0.0/8} ),          name => q{This host on this network}, reference => q{RFC 1122} },
    { ip => Net::IP::XS->new( q{10.0.0.0/8} ),         name => q{Private-Use},               reference => q{RFC 1918} },
    { ip => Net::IP::XS->new( q{192.168.0.0/16} ),     name => q{Private-Use},               reference => q{RFC 1918} },
    { ip => Net::IP::XS->new( q{172.16.0.0/12} ),      name => q{Private-Use},               reference => q{RFC 1918} },
    { ip => Net::IP::XS->new( q{100.64.0.0/10} ),      name => q{Shared Address Space},      reference => q{RFC 6598} },
    { ip => Net::IP::XS->new( q{127.0.0.0/8} ),        name => q{Loopback},                  reference => q{RFC 1122} },
    { ip => Net::IP::XS->new( q{169.254.0.0/16} ),     name => q{Link Local},                reference => q{RFC 3927} },
    { ip => Net::IP::XS->new( q{192.0.0.0/24} ),       name => q{IETF Protocol Assignments}, reference => q{RFC 6890} },
    { ip => Net::IP::XS->new( q{192.0.0.0/29} ),       name => q{DS Lite},                   reference => q{RFC 6333} },
    { ip => Net::IP::XS->new( q{192.0.0.170/32} ),     name => q{NAT64/DNS64 Discovery},     reference => q{RFC 7050} },
    { ip => Net::IP::XS->new( q{192.0.0.171/32} ),     name => q{NAT64/DNS64 Discovery},     reference => q{RFC 7050} },
    { ip => Net::IP::XS->new( q{192.0.2.0/24} ),       name => q{Documentation},             reference => q{RFC 5737} },
    { ip => Net::IP::XS->new( q{198.51.100.0/24} ),    name => q{Documentation},             reference => q{RFC 5737} },
    { ip => Net::IP::XS->new( q{203.0.113.0/24} ),     name => q{Documentation},             reference => q{RFC 5737} },
    { ip => Net::IP::XS->new( q{192.88.99.0/24} ),     name => q{6to4 Relay Anycast},        reference => q{RFC 3068} },
    { ip => Net::IP::XS->new( q{198.18.0.0/15} ),      name => q{Benchmarking},              reference => q{RFC 2544} },
    { ip => Net::IP::XS->new( q{240.0.0.0/4} ),        name => q{Reserved},                  reference => q{RFC 1112} },
    { ip => Net::IP::XS->new( q{255.255.255.255/32} ), name => q{Limited Broadcast},         reference => q{RFC 919} },
    { ip => Net::IP::XS->new( q{224.0.0.0/4} ),        name => q{IPv4 multicast addresses},  reference => q{RFC 5771} },
);

Readonly::Array our @IPV6_SPECIAL_ADDRESSES => (
    { ip => Net::IP::XS->new( q{::1/128} ),       name => q{Loopback Address},           reference => q{RFC 4291} },
    { ip => Net::IP::XS->new( q{::/128} ),        name => q{Unspecified Address},        reference => q{RFC 4291} },
    { ip => Net::IP::XS->new( q{::ffff:0:0/96} ), name => q{IPv4-mapped Address},        reference => q{RFC 4291} },
    { ip => Net::IP::XS->new( q{64:ff9b::/96} ),  name => q{IPv4-IPv6 Translation},      reference => q{RFC 6052} },
    { ip => Net::IP::XS->new( q{100::/64} ),      name => q{Discard-Only Address Block}, reference => q{RFC 6666} },
    { ip => Net::IP::XS->new( q{2001::/23} ),     name => q{IETF Protocol Assignments},  reference => q{RFC 2928} },
    { ip => Net::IP::XS->new( q{2001::/32} ),     name => q{TEREDO},                     reference => q{RFC 4380} },
    { ip => Net::IP::XS->new( q{2001:2::/48} ),   name => q{Benchmarking},               reference => q{RFC 5180} },
    { ip => Net::IP::XS->new( q{2001:db8::/32} ), name => q{Documentation},              reference => q{RFC 3849} },
    { ip => Net::IP::XS->new( q{2001:10::/28} ),  name => q{Deprecated (ORCHID)},        reference => q{RFC 4843} },
    { ip => Net::IP::XS->new( q{2002::/16} ),     name => q{6to4},                       reference => q{RFC 3056} },
    { ip => Net::IP::XS->new( q{fc00::/7} ),      name => q{Unique-Local},               reference => q{RFC 4193} },
    { ip => Net::IP::XS->new( q{fe80::/10} ),     name => q{Linked-Scoped Unicast},      reference => q{RFC 4291} },
    { ip => Net::IP::XS->new( q{::/96} ),     name => q{Deprecated (IPv4-compatible Address)}, reference => q{RFC 4291} },
    { ip => Net::IP::XS->new( q{5f00::/8} ),  name => q{unallocated (ex 6bone)},               reference => q{RFC 3701} },
    { ip => Net::IP::XS->new( q{3ffe::/16} ), name => q{unallocated (ex 6bone)},               reference => q{RFC 3701} },
    { ip => Net::IP::XS->new( q{ff00::/8} ),  name => q{IPv6 multicast addresses},             reference => q{RFC 4291} },
);

1;

=head1 NAME

Zonemaster::Constants - module holding constants used in test modules

=head1 SYNOPSIS

   use Zonemaster::Constants ':all';

=head1 EXPORTED GROUPS

=over

=item all

All exportable names.

=item algo

DNSSEC algorithms.

=item asn

Constants used by the ASN test module.

=item name

Label and name lengths.

=item ip

IP version constants.

=item soa

SOA value limits.

=item misc

UDP payload limit and minimum number of nameservers per zone.

=item addresses

Address classes for IPv4 and IPv6.

=back

=head1 EXPORTED NAMES

=over

=item *

C<$ALGO_STATUS_DEPRECATED>

=item *

C<$ALGO_STATUS_PRIVATE>

=item *

C<$ALGO_STATUS_RESERVED>

=item *

C<$ALGO_STATUS_UNASSIGNED>

=item *

C<$ALGO_STATUS_VALID>

=item *

C<$ASN_CHECKING_ROUTE_VIEWS_SERVICE_NAME>

=item *

C<$ASN_CHECKING_SERVICE_USED>

=item *

C<$ASN_CHECKING_ZONEMASTER_SERVICE_NAME>

=item *

C<$ASN_IPV4_CHECKING_SERVICE_ROUTE_VIEWS_DOMAIN>

=item *

C<$ASN_IPV4_CHECKING_SERVICE_ZONEMASTER_DOMAIN>

=item *

C<$ASN_IPV6_CHECKING_SERVICE_ROUTE_VIEWS_DOMAIN>

=item *

C<$ASN_IPV6_CHECKING_SERVICE_ZONEMASTER_DOMAIN>

=item *

C<$ASN_UNASSIGNED_UNANNOUNCED_ADDRESS_SPACE_VALUE>

=item *

C<$DURATION_12_HOURS_IN_SECONDS>

=item *

C<$DURATION_180_DAYS_IN_SECONDS>

=item *

C<$FQDN_MAX_LENGTH>

=item *

C<$LABEL_MAX_LENGTH>

=item *

C<$IP_VERSION_4>

=item *

C<$IP_VERSION_6>

=item *

C<$MAX_SERIAL_VARIATION>

=item *

C<$MINIMUM_NUMBER_OF_NAMESERVERS>

=item *

C<$SOA_DEFAULT_TTL_MAXIMUM_VALUE>

=item *

C<$SOA_DEFAULT_TTL_MINIMUM_VALUE>

=item *

C<$SOA_EXPIRE_MINIMUM_VALUE>

=item *

C<$SOA_REFRESH_MINIMUM_VALUE>

=item *

C<$SOA_RETRY_MINIMUM_VALUE>

=item *

C<$UDP_PAYLOAD_LIMIT>

=item *

C<@IPV4_SPECIAL_ADDRESSES>

=item *

C<@IPV6_SPECIAL_ADDRESSES>

=back
