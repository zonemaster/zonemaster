#!/usr/bin/perl

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
my $levelfile = 'README.md'; # Name of common file for test level

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
            open my $lFile, "$tcDir/$levelfile" or die "cannot open $tcDir/$levelfile: $!";
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
                if ( open my $File, "$tcFile" ) {
                    @content = <$File>;
                    close $File;
                }
                else {
                    warn "cannot open $tcFile: $!";
                }
                
                # TC id and TC desc only on first line of TC file:
                if ( defined $content[0] and $content[0] =~ /^##\s*(.*)\s*\:\s*(.*)/ ) {
                    $tcid   = $1 || "missing";
                    $tcdesc = $2 || "missing";
                    print "$tcid $tcdesc\n" if $DEBUG;
                } else {
                    $tcid = "missing";
                    $tcdesc = "missing";
                }
                
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
                printf "|%3s|%23s|[%10s](%s/%s)|%-10s|%17s|\n",
                $oReqID,$oReqText,$oLevel,$oLevel,$levelfile,$linkID,$otcDesc;
            }
        }
    }
}

main();

=head1 NAME
    
    maprequirement.pl

=head1 DESCRIPTION
    
This tools extracts all requirements from a requirements file and maps
the requirement to a test specification.

=head1 USAGE

./maprequirement.pl --specdir ../docs/specifications/tests \
        --reqfile ../docs/requirements/TestRequirements.md

Mandatory arguments:

  --reqfile  File with the Test Requirements
  --specdir  Directory path of the Test Case directory

Optional arguments:

  --help     This help text
  --debug    Print debug output

=head1 AUTHOR

Patrik Wallstrom <pawal@iis.se>

=cut
