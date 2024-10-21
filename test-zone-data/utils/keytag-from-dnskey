#!/usr/bin/env perl


=pod

=head1 SUMMARY

This script calculates and reports the key tag of provided DNSKEY
records.

=head1 SYNOPSIS

cat data-file | keytag-from-dnskey.pl

keytag-from-dnskey.pl

=head1 DATA FILE

Create a file with the complete DNSKEY records. The key tag of the DNSKEY
records will be reported in the order they are provided. You can freely add
comment lines starting with "#" anywhere.

=head1 EXAMPLE FILE

=begin text

nsec3-nodata-missing-soa-1.dnssec10.xa.	86400 IN DNSKEY	256 3 13 UXX/6XrJ3E9AX9X+4wAYzSJYLzvndC8Ga6EtZ3uRT2VDBM5fcWwXK4Sj TEpCSIjSo5Vd3PwxLDOfd6KQXDxsTA==
nsec3-nodata-missing-soa-1.dnssec10.xa.	86400 IN DNSKEY	257 3 13 2WNTg518FYvoS+z1975+VslncFZRfSrd6nX+mQXOT1fycnoa7OU0RURW 846oEfXCdBzfIGwiemQZm4S3kxMrsA==

=end text

=cut


use 5.16.0;
use warnings;

use Net::DNS::SEC 1.26;
use Net::DNS 1.47;

use Getopt::Long;
use Pod::Usage;

my ( $key, $exp, $inc, $help );
GetOptions( 'help'  => \$help
          );

if ( $help ) {
    pod2usage(-verbose => 99);
    exit 0;
}

while( my $line = <> ) {
    chomp ( $line );
    next if $line =~ /^\s*$/;
    next if $line =~ /^#/;
    my $rrref = Net::DNS::RR->new( $line );
    say $rrref->keytag;
    
}

