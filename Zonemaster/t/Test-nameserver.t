use Test::More;

BEGIN {
    use_ok( q{Zonemaster} );
    use_ok( q{Zonemaster::Test::Nameserver} );
}

my $checking_module = q{Nameserver};

sub zone_gives {
    my ( $test, $zone, $gives_ref ) = @_;

    Zonemaster->logger->clear_history();
    my @res = Zonemaster->test_method( $checking_module, $test, $zone );
    foreach my $gives (@{$gives_ref}) {
        ok( ( grep { $_->tag eq $gives } @res ), $zone->name->string." gives $gives" );
    }
    return scalar( @res );
}

sub zone_gives_not {
    my ( $test, $zone, $gives_ref ) = @_;

    Zonemaster->logger->clear_history();
    my @res = Zonemaster->test_method( $checking_module, $test, $zone );
    foreach my $gives (@{$gives_ref}) {
        ok( !( grep { $_->tag eq $gives } @res ), $zone->name->string." does not give $gives" );
    }
    return scalar( @res );
}

my $datafile = q{t/Test-nameserver.data};
if ( not $ENV{ZONEMASTER_RECORD} ) {
    die q{Stored data file missing} if not -r $datafile;
    Zonemaster::Nameserver->restore( $datafile );
    Zonemaster->config->no_network( 1 );
}

my $zone;
my @res;
my %tag;

# nameserver01
$zone = Zonemaster->zone( 'dyad.se' );
zone_gives( 'nameserver01', $zone, [q{NO_RECURSOR}] );
zone_gives_not( 'nameserver01', $zone, [q{IS_A_RECURSOR}] );

$zone = Zonemaster->zone( 'vasa.se' );
zone_gives_not( 'nameserver01', $zone, [q{NO_RECURSOR}] );
zone_gives( 'nameserver01', $zone, [q{IS_A_RECURSOR}] );

# nameserver03
$zone = Zonemaster->zone( 'nameserver03-axfr-failure.zut-root.rd.nic.fr' );
zone_gives( 'nameserver03', $zone, [q{AXFR_FAILURE}] );
zone_gives_not( 'nameserver03', $zone, [q{AXFR_AVAILABLE}] );

# nameserver04
$zone = Zonemaster->zone( 'afnic.fr' );
zone_gives( 'nameserver04', $zone, [q{SAME_SOURCE_IP}] );

# nameserver05
$zone = Zonemaster->zone( 'afnic.fr' );
zone_gives( 'nameserver05', $zone, [q{AAAA_WELL_PROCESSED}] );

# nameserver06
$zone = Zonemaster->zone( 'nameserver06-can-not-be-resolved.zut-root.rd.nic.fr' );
zone_gives( 'nameserver06', $zone, [q{CAN_NOT_BE_RESOLVED}] );

$zone = Zonemaster->zone( 'nameserver06-no-resolution.zut-root.rd.nic.fr' );
zone_gives( 'nameserver06', $zone, [q{NO_RESOLUTION}] );

$zone = Zonemaster->zone( 'scanjack.se' );
zone_gives( 'nameserver02', $zone, ['EDNS0_BAD_QUERY']);

$zone = Zonemaster->zone( 'dyad.se' );
zone_gives( 'nameserver02', $zone, ['EDNS0_SUPPORT']);

$zone = Zonemaster->zone( 'traxia.se' );
zone_gives( 'nameserver05', $zone, ['QUERY_DROPPED']);

$zone = Zonemaster->zone( 'escargot.se' );
zone_gives( 'nameserver05', $zone, ['ANSWER_BAD_RCODE']);

$zone = Zonemaster->zone( 'nameserver06-can-be-resolved.zut-root.rd.nic.fr' );
zone_gives( 'nameserver06', $zone, [q{CAN_BE_RESOLVED}] );

TODO: {
    local $TODO = "Need to find/create zones with that error";

    # zone_gives( 'nameserver02', $zone, ['EDNS0_BAD_ANSWER']);

    # nameserver03 does not work with saved data ???
#    $zone = Zonemaster->zone( 'nameserver03-axfr-available.zut-root.rd.nic.fr' );
#    zone_gives( 'nameserver03', $zone, [q{AXFR_AVAILABLE}] );

    # nameserver04
    ok( $tag{DIFFERENT_SOURCE_IP}, q{DIFFERENT_SOURCE_IP} );
}

if ( $ENV{ZONEMASTER_RECORD} ) {
    Zonemaster::Nameserver->save( $datafile );
}

done_testing;
