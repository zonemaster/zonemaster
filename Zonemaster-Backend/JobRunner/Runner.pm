package Runner;
our $VERSION = '0.01';

use strict;
use warnings;
use utf8;
use 5.14.1;

use Data::Dumper;
use Encode;
use DBI qw(:utils);
use JSON;

use Net::LDNS;

use FindBin qw($RealScript $Script $RealBin $Bin);
FindBin::again();
##################################################################
my $PROJECT_NAME = "Zonemaster-Backend";

my $SCRITP_DIR = __FILE__;
$SCRITP_DIR = $Bin unless ($SCRITP_DIR =~ /^\//);

#warn "SCRITP_DIR:$SCRITP_DIR\n";
#warn "RealScript:$RealScript\n";
#warn "Script:$Script\n";
#warn "RealBin:$RealBin\n";
#warn "Bin:$Bin\n";
#warn "__PACKAGE__:".__PACKAGE__;
#warn "__FILE__:".__FILE__;

my ($PROD_DIR) = ($SCRITP_DIR =~ /(.*?\/)$PROJECT_NAME/);
#warn "PROD_DIR:$PROD_DIR\n";

my $PROJECT_BASE_DIR = $PROD_DIR.$PROJECT_NAME."/";
#warn "PROJECT_BASE_DIR:$PROJECT_BASE_DIR\n";
unshift(@INC, $PROJECT_BASE_DIR);
##################################################################

unshift(@INC, $PROD_DIR."Zonemaster/lib") unless $INC{$PROD_DIR."Zonemaster/lib"};
require Zonemaster;
require Zonemaster::Translator;

unshift(@INC, $PROD_DIR."Zonemaster-Backend") unless $INC{$PROD_DIR."Zonemaster-Backend"};
require BackendConfig;

sub new{
	my ($class, $params) = @_;
	my $self = {};

	if ($params && $params->{db}) {
		eval{
			say "using DB:[$params->{db}]";
			eval "require $params->{db}";
			die $@ if $@;
			$self->{db} = "$params->{db}"->new();
		};
		die $@ if $@;
	}
	else {
		eval{
			my $backend_module = "ZonemasterDB::".BackendConfig->BackendDBType();
			say "using BackendDBType:[$backend_module]";
			eval "require $backend_module";
			die $@ if $@;
			$self->{db} = $backend_module->new();
		};
		die $@ if $@;
	}


	bless($self,$class);
	say "Runner::New OK";
	return $self;
}

sub run {
    my ( $self, $test_id ) = @_;
    my @accumulator;
    my %counter;
    my %counter_for_progress_indicator;

	my $params;

	my $progress = $self->{db}->test_progress($test_id, 1);
	say "test [$test_id] test_progress returned [$progress]";
	
	$params = $self->{db}->get_test_params($test_id);

	my %methods = Zonemaster->all_methods;
    
    foreach my $module (keys %methods) {
		foreach my $method (@{ $methods{$module} }) {
			$counter_for_progress_indicator{planned}{$module.'::'.$method} = $module.'::';
		}
    }
    
    my ( $domain ) = $params->{domain};
    if ( !$domain ) {
        die "Must give the name of a domain to test.\n";
    }
    $domain = $self->to_idn($domain);

    Zonemaster->config->get->{net}{ipv4} = ($params->{ipv4})?(1):(0);
    Zonemaster->config->get->{net}{ipv6} = ($params->{ipv6})?(1):(0);

    # used for progress indicator
    my ($previous_module, $previous_method) = ('', '') ; 
    
    # Callback defined here so it closes over the setup above.
    Zonemaster->logger->callback(
        sub {
            my ( $entry ) = @_;

			foreach my $trace (reverse @{$entry->trace}) {
				foreach my $module_method (keys %{$counter_for_progress_indicator{planned}}) {
					if (index($trace->[1], $module_method) > -1) {
						my $percent_progress = 0;
						my ($module) = ($module_method =~ /(.+::)[^:]+/);
						if ($previous_module eq $module) {
							$counter_for_progress_indicator{executed}{$module_method}++;
						}
						elsif ($previous_module) {
							foreach my $planned_module_method (keys %{$counter_for_progress_indicator{planned}}) {
								$counter_for_progress_indicator{executed}{$planned_module_method}++ if ($counter_for_progress_indicator{planned}{$planned_module_method} eq $previous_module);
							}
						}
						$previous_module = $module;
						
						if ($previous_method ne $module_method) {
							$percent_progress = sprintf("%.0f", 100*(scalar( keys %{$counter_for_progress_indicator{executed}}) / scalar( keys %{$counter_for_progress_indicator{planned}})));
							$self->{db}->test_progress($test_id, $percent_progress);
#							print STDERR "$percent_progress% / running method $module_method\n";#."\t".$translator->translate_tag( $entry )."\n";
							$previous_method = $module_method;
						}
					}
				}
			}

            $counter{ uc $entry->level } += 1;
        }
    );

    if ( $params->{nameservers} && @{ $params->{nameservers} } > 0 ) {
        $self->add_fake_delegation( $domain, $params->{nameservers} );
    }

    if ( $params->{ds_digest_pairs} && @{ $params->{ds_digest_pairs} } > 0 ) {
        $self->add_fake_ds( $domain, $params->{ds_digest_pairs} );
    }

    # Actually run tests!
    eval {
		Zonemaster->test_zone( $domain );
    };
    if ( $@ ) {
        my $err = $@;
        if ( blessed $err and $err->isa( "NormalExit" ) ) {
            say STDERR "Exited early: " . $err->message;
        }
        else {
            die $err;    # Don't know what it is, rethrow
        }
    }

    $self->{db}->test_results($test_id, Zonemaster->logger->json('INFO'));

    return;
} ## end sub run

sub add_fake_delegation {
    my ( $self, $domain, $nameservers ) = @_;
    my %data;

    foreach my $ns_ip_pair ( @$nameservers ) {
        push(@{ $data{$self->to_idn($ns_ip_pair->{ns})} }, $ns_ip_pair->{ip}) if ($ns_ip_pair->{ns} && $ns_ip_pair->{ip});
    }

    Zonemaster->add_fake_delegation( $domain => \%data );

    return;
}

sub add_fake_ds {
    my ( $self, $domain, $ds_digests ) = @_;
    my @data;
=coment
    foreach my $str ( @{ $ds_digests } ) {
        my ( $tag, $algo, $type, $digest ) = ;
        push @data, { keytag => $tag, algorithm => $algo, type => $type, digest => $digest };
    }

    Zonemaster->add_fake_ds( $domain => \@data );
=cut
    return;
}


sub to_idn {
    my ( $self, $str ) = @_;

    if ($str =~ m/^[[:ascii:]]+$/) {
        return $str;
    }

    if (Net::LDNS::has_idn()) {
        return Net::LDNS::to_idn(encode_utf8($str));
    }
    else {
        warn __("Warning: Net::LDNS not compiled with libidn, cannot handle non-ASCII names correctly.");
        return $str;
    }
}

1;
