use Test::More;

BEGIN {
    use_ok( q{Zonemaster} );
    use_ok( q{Zonemaster::Nameserver} );
    use_ok( q{Zonemaster::DNSName} );
    use_ok( q{Zonemaster::Zone} );
    use_ok( q{Zonemaster::Test::Syntax} );
}

sub gives {
    my ( $test, $name, $gives ) = @_;

    my @res = Zonemaster->test_method( q{Syntax}, $test, $name );
    ok( ( grep { $_->tag eq $gives } @res ), "$name gives $gives" );
}

sub gives_not {
    my ( $test, $name, $gives ) = @_;

    my @res = Zonemaster->test_method( q{Syntax}, $test, $name );
    ok( !( grep { $_->tag eq $gives } @res ), "$name does not give $gives" );
}

my $datafile = q{t/Test-syntax.data};
if ( not $ENV{ZONEMASTER_RECORD} ) {
    die q{Stored data file missing} if not -r $datafile;
    Zonemaster::Nameserver->restore( $datafile );
    Zonemaster->config->no_network(1);
}

my $dn_ok = Zonemaster::DNSName->new( q{www.nic.se} );
my $dn_ko = Zonemaster::DNSName->new( q{www.nic&nac.se} );
gives( q{syntax01}, $dn_ok, q{ONLY_ALLOWED_CHARS} );
gives_not( q{syntax01}, $dn_ko, q{ONLY_ALLOWED_CHARS} );
gives( q{syntax01}, $dn_ko, q{NON_ALLOWED_CHARS} );
gives_not( q{syntax01}, $dn_ok, q{NON_ALLOWED_CHARS} );

$dn_ko = Zonemaster::DNSName->new( q{www.-nic.se} );
gives( q{syntax02}, $dn_ko, q{INITIAL_HYPHEN} );
gives_not( q{syntax02}, $dn_ok, q{INITIAL_HYPHEN} );

$dn_ko = Zonemaster::DNSName->new( q{www.nic-.se} );
gives( q{syntax02}, $dn_ko, q{TERMINAL_HYPHEN} );
gives_not( q{syntax02}, $dn_ok, q{TERMINAL_HYPHEN} );

my $dn_idn_ok = Zonemaster::DNSName->new( q{www.xn--nic.se} );
$dn_ko = Zonemaster::DNSName->new( q{www.ni--c.se} );
gives( q{syntax03}, $dn_ko, q{DISCOURAGED_DOUBLE_DASH} );
gives_not( q{syntax03}, $dn_ok,     q{DISCOURAGED_DOUBLE_DASH} );
gives_not( q{syntax03}, $dn_idn_ok, q{DISCOURAGED_DOUBLE_DASH} );

my $ns_ok       = Zonemaster::DNSName->new( q{ns1.nic.fr} );
my $ns_too_long = Zonemaster::DNSName->new(
q{ns123456789012345678901234567890123456789012345678901234567890.dn123456789012345678901234567890123456789012345678901234567890.dn123456789012345678901234567890123456789012345678901234567890.dn123456789012345678901234567890123456789012345678901234567890.tld123456789012345678901234567890123456789012345678901234567890}
);
gives( q{syntax04}, $ns_too_long, q{NAMESERVER_NAME_TOO_LONG} );
gives_not( q{syntax04}, $ns_ok, q{NAMESERVER_NAME_TOO_LONG} );

my $ns_double_dash = Zonemaster::DNSName->new( q{ns1.ns--nic.fr} );
gives( q{syntax04}, $ns_double_dash, q{NAMESERVER_DISCOURAGED_DOUBLE_DASH} );
gives_not( q{syntax04}, $ns_ok, q{NAMESERVER_DISCOURAGED_DOUBLE_DASH} );

my $ns_num_tld = Zonemaster::DNSName->new( q{ns1.nic.47} );
gives( q{syntax04}, $ns_num_tld, q{NAMESERVER_NUMERIC_TLD} );
gives_not( q{syntax04}, $ns_ok, q{NAMESERVER_NUMERIC_TLD} );

my $ns_label_too_long =
  Zonemaster::DNSName->new( q{ns1234567890123456789012345678901234567890123456789012345678901234567890.nic.fr} );
gives( q{syntax04}, $ns_label_too_long, q{NAMESERVER_LABEL_TOO_LONG} );
gives_not( q{syntax04}, $ns_ok, q{NAMESERVER_LABEL_TOO_LONG} );

if ( $ENV{ZONEMASTER_RECORD} ) {
    Zonemaster::Nameserver->save( $datafile );
}

done_testing;
