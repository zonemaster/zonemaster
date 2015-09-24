#!/usr/bin/perl

# Copyright (c) 2014, IIS (The Internet Infrastructure Foundation)
# Copyright (c) 2014, AFNIC
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification,
# are permitted provided that the following conditions are met:
#
#   Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.
#
#   Redistributions in binary form must reproduce the above copyright notice, this
#   list of conditions and the following disclaimer in the documentation and/or
#   other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
# ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

use strict;
use warnings;

use Pod::Usage;
use Getopt::Long;
use File::Basename;

# command line options
my $dirloc = '.'; # directory for serching test cases
my $help;
my $DEBUG = 0;

# global variables
my $tcCounter = 0;

sub main {
    GetOptions(
	'help|?'  => \$help,
	'dir|d=s' => \$dirloc,
	'debug'   => \$DEBUG,
    ) or pod2usage(2);

    if ($help) {
	pod2usage(1);
	exit;
    }
    opendir(my $dir, $dirloc) || die "cannot open directory $dirloc";
    while (readdir $dir) {
	print "$dirloc/$_\n" if $DEBUG;
	next if $_ =~ /^\./;
	if (-d "$dirloc/$_") {
	    tcList("$dirloc/$_");
	}
    }
    print "No test cases found\nUse -d to specify directory\n" if !$tcCounter;
}

sub tcList
{
    my $tcDir = shift;
    my $tcLevel = basename($tcDir);

    print "Level $tcLevel\n";
    opendir(my $dir, $tcDir);
    while (readdir $dir) {
	next if $_ =~ /^\./;
	next if $_ =~ /^level\.md$/;
	next unless $_ =~ /\.md$/;
	tcName("$tcDir/$_");
    }
}

sub tcName
{
    my $tcPath = shift;
    my $basename = basename($tcPath);

    open my $file, $tcPath or die "Cannot open file $tcPath: $!";
    my $header = <$file>;
    if (defined $header) {
	print $header;
    } else {
	print "$basename: empty\n";
    }
    $tcCounter++; # increase the global counter
    close $file;
}

main();

=head1 NAME

    testcase.pl

=head1 DESCRIPTION

This tools extracts all implemented test cases and prints the header of each.

=head1 USAGE

testcase.pl --dir .

Optional arguments:

  --dir      Directory path of the test case directory
  --help     This help text

=head1 AUTHOR

Patrik Wallstrom <pawal@iis.se>

=cut
