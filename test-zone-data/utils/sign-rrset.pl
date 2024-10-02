#!/usr/bin/env perl


#
# A file with the private key must be provided with "--key". Date-time
# values must be given with "--exp" and "--inc", repectively.
#
# A RRSIG record is printed out on STDOUT.
#
# Example (on one line):
#
# echo "mixed-nsec-nsec3-1.dnssec10.xa. 86400 IN SOA localhost. root.localhost. 21 3600 1200 2419200 604800" \ 
#     | ~/git/zonemaster/test-zone-data/utils/sign-rrset.pl \
#     --key key-directory-38/Kmixed-nsec-nsec3-1.dnssec10.xa.+013+55355.private \
#     --exp 20320923122409 --inc 20240925112409



=pod

=head1 SUMMARY

This script supports signing an RRset (one or more DNS records)
by the provided private key

=head1 SYNOPSIS

cat data-file | sign-rrset --key KEY --exp DATETIME --inc DATETIME

sign-rrset --help

=over 3

=item *
KEY is the file with the private key matching the intended DNSKEY record.

=item *
DATETIME is the date-time in the format "YYYYMMDDHHMMSS" for RRSIG expiration (--exp)
and RRSIG inception (--inc) respectively.

=back

=head1 DATA FILE

Create a file with the complete RRset to be signed. You can freely add
comment lines starting with "#" anywhere.

=head1 EXAMPLE FILE

=begin text

err-mult-nsec-1.dnssec10.xa. 86400 IN	NSEC	ns1.err-mult-nsec-1.dnssec10.xa. NS SOA RRSIG NSEC DNSKEY TYPE65534
err-mult-nsec-1.dnssec10.xa. 86400 IN	NSEC	www.err-mult-nsec-1.dnssec10.xa. NS SOA RRSIG NSEC DNSKEY TYPE65534

=end text

=cut






use 5.16.0;
use warnings;

use Net::DNS::SEC 1.26;
use Net::DNS 1.47;

use Getopt::Long;
use Pod::Usage;

my ( $key, $exp, $inc, $help );
GetOptions( 'key=s' => \$key,
            'exp=s' => \$exp,
            'inc=s' => \$inc,
            'help'  => \$help
          );

if ( $help ) {
    pod2usage(-verbose => 99);
    exit 0;
}

unless ( $key ) {
    say STDERR "Missing private key file";
    say STDERR "Run with --help to get help";
    exit 1;
}

unless ( $exp and $inc ) {
    say STDERR "Missing expiration and/or inception value";
    say STDERR "Run with --help to get help";
    exit 1;
}

my @rrsetref; # List of references to RRs.

while( my $line = <> ) {
    chomp ( $line );
    next if $line =~ /^\s*$/;
    next if $line =~ /^#/;
    my $rrref = Net::DNS::RR->new( $line );
    push ( @rrsetref, $rrref );
    
}

unless ( @rrsetref ) {
    say "Missing RRset to sign";
    say STDERR "Run with --help to get help";
    exit 1;
};

my $private = Net::DNS::SEC::Private->new($key);

my $sigrr= Net::DNS::RR::RRSIG->create( \@rrsetref, $private, sigex => $exp, sigin => $inc );

say $sigrr->plain;

