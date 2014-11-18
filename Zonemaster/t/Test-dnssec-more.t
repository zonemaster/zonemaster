use Test::More;

BEGIN {
    use_ok( 'Zonemaster' );
    use_ok( 'Zonemaster::Test::DNSSEC' );
}

my $checking_module = q{DNSSEC};

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

my $datafile = 't/Test-dnssec-more.data';
if ( not $ENV{ZONEMASTER_RECORD} ) {
    die "Stored data file missing" if not -r $datafile;
    Zonemaster::Nameserver->restore( $datafile );
    Zonemaster->config->no_network( 1 );
}

my $zone;
my @res;
my %tag;

#dnssec11
$zone = Zonemaster->zone( 'nic.se' );
zone_gives( 'dnssec11', $zone, ['DELEGATION_SIGNED']);

$zone = Zonemaster->zone( 'seb.se' );
zone_gives( 'dnssec11', $zone, ['DELEGATION_NOT_SIGNED']);

$zone = Zonemaster->zone( 'dnssec07-ds-but-not-dnskey.zut-root.rd.nic.fr' );
zone_gives( 'dnssec11', $zone, ['DELEGATION_NOT_SIGNED']);

$zone = Zonemaster->zone( 'dnssec08-dnskey-not-signed.zut-root.rd.nic.fr' );
zone_gives( 'dnssec11', $zone, ['DELEGATION_NOT_SIGNED']);

$zone = Zonemaster->zone( 'dnssec08-dnskey-signature-not-ok.zut-root.rd.nic.fr' );
zone_gives( 'dnssec11', $zone, ['DELEGATION_NOT_SIGNED']);

if ( $ENV{ZONEMASTER_RECORD} ) {
    Zonemaster::Nameserver->save( $datafile );
}

done_testing;
