use Test::More;
use Test::Fatal;

use 5.14.2;
use strict;
use warnings;

BEGIN { use_ok( 'Zonemaster::Nameserver' ); }
use Zonemaster::Util;
use Net::LDNS;

my $datafile = 't/nameserver-axfr.data';
my %saved_axfr;

setup( $datafile );

# This should be a successful AXFR
my $ns = Zonemaster::Nameserver->new( { name => 'kennedy.faerywicca.se', address => '46.21.106.227' } );
my $counter = 0;
is(
    exception {
        $ns->axfr( 'cyberpomo.com', sub { $counter += 1; return 1; } );
    },
    undef,
    'No exception'
);
ok( ( $counter > 10 ), 'At least ten records seen' );

# This should be a refused AXFR
$counter = 0;
my $ns2 = Zonemaster::Nameserver->new( { name => 'ns.nic.se', address => '212.247.7.228' } );
like(
    exception {
        $ns2->axfr( 'iis.se', sub { $counter += 1; return 1; } );
    },
    qr/REFUSED/,
    'AXFR was refused'
);
is( $counter, 0, 'No records seen' );

finish( $datafile );

done_testing;

###
### Functions to record and replay AXFRs.
###

sub setup {
    my ( $datafile ) = @_;
    my $meta = Class::MOP::Class->initialize( 'Zonemaster::Nameserver' );
    if ( not $ENV{ZONEMASTER_RECORD} ) {
        # Replay
        die "Stored data file missing" if not -r $datafile;
        open my $fh, '<', $datafile or die "Failed to open $datafile for reading: $!\n";
        while ( my $line = $fh->getline ) {
            my ( $domain, $type, $str ) = split( /\t/, $line, 3 );
            if ( $type eq 'RR' ) {
                my $rr = eval { Net::LDNS::RR->new( $str ) };
                if ( $rr ) {
                    push @{ $saved_axfr{$domain} }, $rr;
                }
                else {
                    warn "Failed to parse: $str\n";
                }
            }
            elsif ( $type eq 'EXCEPTION' ) {
                $saved_axfr{$domain} = $str;
            }
        }
        Zonemaster->config->no_network(1);
        $meta->add_around_method_modifier(
            'axfr',
            sub {
                my ( $method, $self, $domain, $callback, $class ) = @_;
                if ( exists $saved_axfr{$domain} ) {
                    if ( ref( $saved_axfr{$domain} ) ) {
                        while ( my $rr = pop @{ $saved_axfr{$domain} } ) {
                            $callback->( $rr );
                        }
                    }
                    else {
                        die $saved_axfr{$domain};
                    }
                }
                else {
                    die "AXFR Request for domain that has not been saved.";
                }
            }
        );
    } ## end if ( not $ENV{ZONEMASTER_RECORD...})
    else {
        # Record
        $meta->add_around_method_modifier(
            'axfr',
            sub {
                my ( $method, $self, $domain, $callback, $class ) = @_;
                my @rrs;
                my $new_cb = sub {
                    push @rrs, $_[0];
                    $callback->( $_[0] );
                };
                my $result = eval { $method->( $self, $domain, $new_cb, $class ) };
                if ( $@ ) {
                    $saved_axfr{$domain} = "$@";
                    die $@;
                }
                else {
                    $saved_axfr{$domain} = \@rrs;
                }
            }
        );
    } ## end else [ if ( not $ENV{ZONEMASTER_RECORD...})]
} ## end sub setup

sub finish {
    my ( $datafile ) = @_;
    if ( $ENV{ZONEMASTER_RECORD} ) {
        open my $fh, '>', $datafile or die "Failed to open $datafile for writing: $!\n";
        while ( my ( $domain, $aref ) = each %saved_axfr ) {
            if ( ref $aref ) {
                say $fh $domain . "\tRR\t" . $_->string for @$aref;
            }
            else {
                chomp( $aref );
                say $fh $domain . "\tEXCEPTION\t$aref";
            }
        }
        close $fh;
    }
}
