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
and the matching DNSKEY record.

=over 3

=item *
Create a line with just "%RRSET%".

=item *
List all DNS records in the RRset after the "%RRSET%" line.

=item *
Create a line with just "%SIG%".

=item *
Add one RRSIG record after the "%SIG%" line.

=item *
Create a line with just "%KEY%".

=item *
Add one DNSKEY record after the "KEY%" line.

=item *
You can freely add comment lines starting with "#" anywhere.

=back

=head1 EXAMPLE FILE

=begin text

%RRSET%
err-mult-nsec-1.dnssec10.xa. 86400 IN	NSEC	ns1.err-mult-nsec-1.dnssec10.xa. NS SOA RRSIG NSEC DNSKEY TYPE65534
err-mult-nsec-1.dnssec10.xa. 86400 IN	NSEC	www.err-mult-nsec-1.dnssec10.xa. NS SOA RRSIG NSEC DNSKEY TYPE65534
%SIG%
err-mult-nsec-1.dnssec10.xa. 86400 IN RRSIG NSEC 13 3 86400 20320923032719 20240925135938 58097 err-mult-nsec-1.dnssec10.xa. loXyRdLZF9LWOOMLBl9Y8O4lRjoCiZVnnczuvlPxblX34Jy3tM+6IFmtHAUyU/6hLuoZ1H2BwYjN MSx2n95/lg==
%KEY%
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
my ( $sigrr );
my ( @rrsetref );
my ( $keyrr );

while( my $line = <> ) {
    chomp ( $line );
    next if $line =~ /^\s*$/;
    next if $line =~ /^#/;
    if ($line =~ /^%SIG%/) {
        $section = 'SIG';
        next;
    }
    if ($line =~ /^%KEY%/) {
        $section = 'KEY';
        next;
    }
    if ($line =~ /^%RRSET%/) {
        $section = 'RRSET';
        next;
    }
    if ($section eq 'SIG') {
        die 'An RRSIG when $sigrr is already defined' if $sigrr;
        $sigrr = Net::DNS::RR->new( $line );
    }
    if ($section eq 'KEY') {
        die 'A DNSKEY when $keyrr is already defined' if $keyrr;
        $keyrr = Net::DNS::RR->new( $line );
    }
    if ($section eq 'RRSET') {
        my $rrref = Net::DNS::RR->new( $line );
        push ( @rrsetref, $rrref );
    }
}
my $verify = $sigrr->verify( \@rrsetref, $keyrr );

if ($verify) {
    say 'Verified.';
} else {
    say 'Verify error: ' . $sigrr->vrfyerrstr;
}
