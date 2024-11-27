#!/usr/bin/env perl

=pod

=head1 SUMMARY

This script verifies that the provided RRSIG signs the
the provided RRset by checking against the provided
DNSKEY.

=head1 SYNOPSIS

cat data-file | verify-rrset.pl

verify-rrset.pl --help

=head1 DATA FILE

Create a file with the entire RRset, the RRSIG record
and the matching DNSKEY record. The records must be
in that specific order.

=over 3

=item *
All records in an RRset must have the same type and the same
owner name.

=item *
There must be at least one record in the RRset, but there may
be multiple records. Some records such as NSEC must normally
not be more than one of in a RRset, but here that is permitted.

=item *
There must be exactly one RRSIG, and its owner name must be
the same as the RRset.

=item *
There must be exactly one DNSKEY.

=item *
Comment lines starting with "#" are permitted.

=back

=head1 EXAMPLE FILE

=begin text

err-mult-nsec-1.dnssec10.xa. 86400 IN	NSEC	ns1.err-mult-nsec-1.dnssec10.xa. NS SOA RRSIG NSEC DNSKEY TYPE65534
err-mult-nsec-1.dnssec10.xa. 86400 IN	NSEC	www.err-mult-nsec-1.dnssec10.xa. NS SOA RRSIG NSEC DNSKEY TYPE65534
err-mult-nsec-1.dnssec10.xa. 86400 IN RRSIG NSEC 13 3 86400 20320923032719 20240925135938 58097 err-mult-nsec-1.dnssec10.xa. loXyRdLZF9LWOOMLBl9Y8O4lRjoCiZVnnczuvlPxblX34Jy3tM+6IFmtHAUyU/6hLuoZ1H2BwYjN MSx2n95/lg==
err-mult-nsec-1.dnssec10.xa. 86400 IN	DNSKEY	256 3 13 5H2z0t6sesAGCzY5ayLWpN5s2y7HUq/TWFeZ4tAEvAPhmX6rtM5AkEAm G3QnVSfQN3u5wirEC9/JDqm2G3wJkA==

=end text

=cut

use 5.16.0;
use warnings;

use Net::DNS::SEC 1.26;
use Net::DNS 1.47;

use Getopt::Long;
use Pod::Usage;

my ( $help );
GetOptions( 'help'  => \$help
          );

if ( $help ) {
    pod2usage(-verbose => 99);
    exit 0;
}

my ( $section ) = 'RRSET';
my ( $rrsig );
my ( @rrsetref );
my ( $keyrr );
my ( $rrsettype ) = '';
my ( $ownername ) = '';

my ( $rrsetfound ) = 0;
my ( $rrsigfound ) = 0;
my ( $keyrrfound ) = 0;
while( my $line = <> ) {
    chomp ( $line );
    next if $line =~ /^\s*$/;
    next if $line =~ /^#/;
    my $rr = Net::DNS::RR->new( $line );
    # say "DEBUG: " . $rr->type;
    if ( $rr->type eq 'RRSIG' ) {
        die "ERROR: The RRset must be listed before the RRSIG.\n" unless $rrsetfound;
        die "ERROR: Only one RRSIG may be included.\n" if $rrsigfound;
        if ($rr->owner ne $ownername ) {
            die "ERROR: RRSIG must have the same owner name as the RRset.\n";
        }
        $rrsig = $rr;
        $rrsigfound = 1;
    } elsif ( $rr->type eq 'DNSKEY' and $rrsigfound ) {
        die "ERROR: Only one DNSKEY may be included.\n" if $keyrrfound;
        $keyrr = $rr;
        $keyrrfound = 1;
    } elsif ($keyrrfound) {
        die "ERROR: DNSKEY must be the last record.\n" if $keyrrfound;        
    } else {
        if ( $rrsettype) {
            if ($rr->type ne $rrsettype ) {
                die "ERROR: All records in the RRset must have the same type.\n";
            }
            if ($rr->owner ne $ownername ) {
                die "ERROR: All records in the RRset must have the same owner name.\n";
            }
        } else {
            $rrsettype = $rr->type;
            $ownername = $rr->owner;
            $rrsetfound = 1;
        };
        push ( @rrsetref, $rr );
    }
}
die "ERROR: Missing RRset\n" unless $rrsetfound;
die "ERROR: Missing RRSIG\n" unless $rrsigfound;
die "ERROR: Missing DNSKEY\n" unless $keyrrfound;

my $verify = $rrsig->verify( \@rrsetref, $keyrr );

if ($verify) {
    say 'Verified.';
} else {
    say 'Verify ERROR: ' . $rrsig->vrfyerrstr;
}
