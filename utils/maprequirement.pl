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

use Data::Dumper;

# command line options
my $specdir;    # directory for serching test cases
my $reqfile;    # file with test requirements
my $help;
my $DEBUG = 0;

# global variables
my $tcCounter = 0;
#my $reqs = {}; # { 'Rxx' => 'desc' }

sub main {
    GetOptions(
	'help|?'  => \$help,
	'specdir=s' => \$specdir,
	'reqfile=s' => \$reqfile,
	'debug'   => \$DEBUG,
    ) or pod2usage(2);

    if ($help or not defined $specdir or not defined $reqfile) {
	pod2usage(1);
	exit;
    }
	# read files and create data structures
	my $reqs   = readRequirements($reqfile);
	my $levels = readTCLevels($specdir);
	my $tcHash = readTCFiles($levels);
	print "## Report on Requirements to Test Case mapping\n\n";
	outputResult($reqs, $tcHash);
	
	# TODO: output complete data set from requirements to specs in good table

    # print "No test cases found\nUse -d to specify directory\n" if !$tcCounter;
}

# Exctract all the Requirements and describing test from Requirements doc
sub readRequirements {
	my $file = shift;
	my $reqs =   {};   # req
	my $levels = {}; # req->level->tc
	my $tests  = {}; # level->id->descr

	# read file
	print "Reading $file\n" if $DEBUG;
	open my $rFile, "./$file" or die "Cannot open requirements file $file: $!";
	my @content = <$rFile>;
	close $rFile;

	# extract requirements
	foreach my $line (@content) {
	    if ( $line =~ /^\|(R.*)\|(.*)\|(.*)\|$/ ) {
		next if $1 eq 'Req';
		print "$1 $2: ($3)\n" if $DEBUG;
		my $req  = $1;
		my $desc = $2;
		$req  =~ s/\s*$//; # strip whitespace at end of line
		$desc =~ s/\s*$//; # strip whitespace at end of line
		$reqs->{$req} = $desc;
		}
	}

	return $reqs;
}

# get all the Reqs and files from each Test Level
sub readTCLevels {
	my $specdir = shift;
	my $levels = {};
	my $result;
    opendir(my $dir, $specdir) || die "cannot open directory $specdir";
    while (readdir $dir) {
		print "$specdir/$_\n" if $DEBUG;
		next if $_ =~ /^\./;
		if (-d "$specdir/$_") {
			my $tclevel = $_;
			my $tcDir = "$specdir/$tclevel";
		    print "Level $tclevel\n" if $DEBUG;
			open my $lFile, "$tcDir/level.md" or die "cannot open $tcDir/level.md: $!";
			my @content = <$lFile>;
			close $lFile;
			$result->{$tclevel} = TCFileFromLevel(\@content);
		}
    }
	return $result;
}

# given the content of a Test Level file, extract the Reqs and files for the TC
sub TCFileFromLevel {
	my $content = shift;
	my $result;
	print @$content if $DEBUG;
	foreach my $line (@$content) {
		if ( $line =~ /^\|(R.*)\|(.*)\|(.*)\|/ ) {
			next if $1 eq 'Req';
			my $req = $1; # discard $2, we don't need it
			my $tmp = $3;
			$tmp =~ /\((.*)\)/;
			push @{$result->{'file'}->{$req}}, $1 if defined $1;
			print "Mapping Level Rxx to File: $req $1\n" if $DEBUG;
		}
	}
	return $result;
}

# given the hash of Rxx and files from all Test Levels, this retrieves each TC
sub readTCFiles {
	my $fileinfo = shift;
	my $result;
	foreach my $level (keys %{$fileinfo}){
		print "LEVEL $level\n" if $DEBUG;
		foreach my $req ( keys %{ $fileinfo->{$level}->{'file'} } ) {
			my $files = $fileinfo->{$level}->{'file'}->{$req};
			foreach my $file (@$files) {
				my $tcid;   # test case id
				my $tcdesc; # test case desc
				print "LEVEL $level $req $file\n" if $DEBUG;

				my $tcFile = "$specdir/$level/$file";
				my @content = ();
				open my $File, "$tcFile" or warn "cannot open $tcFile: $!";
				@content = <$File>;
				close $File;

				# TC id and TC desc only on first line of TC file:
				if ( defined $content[0] and $content[0] =~ /^##\s*(.*)\s*\:\s*(.*)/ ) {
					$tcid   = $1 || "missing";
					$tcdesc = $2 || "missing";
					print "$tcid $tcdesc\n" if $DEBUG;
				} else {
					$tcid = "missing";
					$tcdesc = "missing";
				}
				
				### OLD code for keying on the level
				# stuff the test case in the result hash
				#if (not defined $result->{$level}->{$req}->{$tcid}) {
				#	$result->{$level}->{$req}->{$tcid} = [];
				#}
				#my $tc = { 'desc' => $tcdesc, 'file' => $tcFile };
				#push $result->{$level}->{$req}->{$tcid}, $tc;

				# key on the Req
				# stuff the test case in the result hash
				if (not defined $result->{$level}->{$req}->{$tcid}) {
					$result->{$req}->{$tcid} = [];
				}
				my $tc = { 'desc' => $tcdesc, 'file' => $tcFile, 'level' => $level };
				push @{ $result->{$req}->{$tcid} }, $tc;
				
			}
		}
	}
	return $result;
}

sub outputResult {
	my $reqs = shift;
	my $tc = shift;
	
	my $oReqID;
	my $oReqText;
	my $oLevel;
	my $otcID;
	my $otcLink;
	my $otcDesc;

	print "|Req|Requirement desription|Level     |Test Case ID|Test Description|\n";
	print "|:--|:---------------------|:---------|:-----------|:---------------|\n";

	# list of all requirents
	foreach my $req ( sort keys %{$reqs} ) {
		$oReqID   = $req;
		$oReqText = $reqs->{$req};

		# fetch all test cases for the requirements
		my $testcount = 0;
		foreach my $test ( keys %{$tc->{$req}} ) {
			$otcID = $test;
			$testcount++;
		}
		# if we have a missing testcase, still output info
		if ($testcount == 0 ) {
			printf "|%-3s|%23s|%10s|%-10s|%17s|\n",
					$oReqID,$oReqText,'**missing**','**missing**','**missing**';
		} else {
			foreach my $testInfo ( @{$tc->{$req}->{$otcID}} ) {
				#print Dumper($testInfo);
				$otcLink = $testInfo->{'file'};
				$otcDesc = $testInfo->{'desc'};
				$oLevel  = $testInfo->{'level'};
				my $linkID = "[$otcID]($otcLink)";
				printf "|%3s|%23s|[%10s](%s/level.md)|%-10s|%17s|\n",
						$oReqID,$oReqText,$oLevel,$oLevel,$linkID,$otcDesc;
			}
		}
	}
}

main();

=head1 NAME

    maprequirement.pl

=head1 DESCRIPTION

This tools extracts all reuquirements from a requirements file and maps
the requirement to a test specification.

=head1 USAGE

maprequirement.pl --specdir docs/specifications --reqfile docs/requirements/Test\ Requirements.md

Mandatory arguments:

  --reqfile  File with the Test Requirements
  --specdir  Directory path of the Test Case directory

Optional arguments:

  --help     This help text
  --debug    Print debug output

=head1 AUTHOR

Patrik Wallstrom <pawal@iis.se>

=cut
