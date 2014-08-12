use strict;
use warnings;
use utf8;
use 5.10.1;

use Data::Dumper;
use DBI qw(:utils);
use JSON;
use String::ShellQuote;
use IO::CaptureOutput qw/capture_exec/;

my $connection_string = "DBI:Pg:database=zonemaster;host=localhost";
my $dbh = DBI->connect($connection_string, "zonemaster", "zonemaster", {RaiseError => 1, AutoCommit => 1});

$dbh->do( "UPDATE test_results SET progress=1, test_start_time=NOW() WHERE id=$ARGV[0]" );

my ($id, $params) = $dbh->selectrow_array( "SELECT id, params FROM test_results WHERE id=$ARGV[0] LIMIT 1" );

$params = decode_json($params);

my ($ip_v4, $ip_v6) = ('', '');
if (defined $params->{ipv4}) {
	$ip_v4 = ($params->{ipv4})?('--ipv4'):('--no-ipv4');
}
if (defined $params->{ipv4}) {
	$ip_v6 = ($params->{ipv6})?('--ipv6'):('--no-ipv6');
}

my @ns;
if ($params->{nameservers}) {
	foreach my $ns (@{$params->{nameservers}}) {
		if ((keys %$ns)[0] ne 'empty') {
			push(@ns, "--ns='".(keys %$ns)[0]."'");
		}
		else {
#			push(@ns, "--ns='".$ns->{(keys %$ns)[0]}."'");
		}
	}
}
#my $ns = join(' ', @ns);
my $ns = '';

my $command = "/home/toma/perl5/perlbrew/perls/perl-5.20.0/bin/perl -I/home/toma/PROD/Zonemaster/Zonemaster-CLI/lib -I/home/toma/REPOSITORY/zonemaster/Zonemaster/lib /home/toma/PROD/Zonemaster/Zonemaster-CLI/script/zonemaster-cli --show_module --level=INFO --lang=json $ns $ip_v4 $ip_v6";
$command .= " ".shell_quote($params->{domain});
say $command;

my ($zm_answer, $stderr, $success, $exit_code) = capture_exec( $command );

say "stderr: $stderr";

eval {decode_json($zm_answer)};
$zm_answer = '[{"tag":"CANNOT_CONTINUE","module":"SYSTEM","timestamp":0.322033882141113,"args":{"zone":"'.$params->{domain}.'"},"level":"CRITICAL"}]' if $@;

$dbh->do( "UPDATE test_results SET progress=100, test_end_time=NOW(), results = ".$dbh->quote($zm_answer)." WHERE id=$ARGV[0] " );
