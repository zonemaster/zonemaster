use Test::More;

BEGIN {
    use_ok( q{Zonemaster} );
    use_ok( q{Zonemaster::Nameserver} );
    use_ok( q{Zonemaster::Test::Consistency} );
}

my $datafile = q{t/Test-consistency.data};
if ( not $ENV{ZONEMASTER_RECORD} ) {
    die q{Stored data file missing} if not -r $datafile;
    Zonemaster::Nameserver->restore( $datafile );
    Zonemaster->config->no_network( 1 );
}

my %res;

#%res = map { $_->tag => 1 } Zonemaster->test_module( q{consistency}, q{bonk.tf} );
%res = map { $_->tag => 1 } Zonemaster->test_module( q{consistency}, q{consistency01.zut-root.rd.nic.fr} );
ok( $res{SOA_SERIAL_VARIATION}, q{Big variation between multiple SOA serials} );
ok( $res{MULTIPLE_SOA_SERIALS}, q{Multiple SOA serials} );
ok( $res{SOA_SERIAL},                      q{SOA serial details} );

%res = map { $_->tag => 1 } Zonemaster->test_module( q{consistency}, q{consistency02.zut-root.rd.nic.fr} );
ok( $res{MULTIPLE_SOA_RNAMES},             q{Multiple SOA rname} );
ok( $res{SOA_RNAME},                       q{SOA rname details} );

%res = map { $_->tag => 1 } Zonemaster->test_module( q{consistency}, q{consistency03.zut-root.rd.nic.fr} );
ok( $res{MULTIPLE_SOA_TIME_PARAMETER_SET}, q{Multiple SOA time parameters} );
ok( $res{SOA_TIME_PARAMETER_SET},          q{SOA time parameters details} );

%res = map { $_->tag => 1 } Zonemaster->test_module( q{consistency}, q{afnic.fr} );
ok( $res{ONE_SOA_SERIAL},             q{One SOA serial} );
ok( $res{ONE_SOA_RNAME},              q{One SOA rname} );
ok( $res{ONE_SOA_TIME_PARAMETER_SET}, q{One SOA time parameters set} );

if ( $ENV{ZONEMASTER_RECORD} ) {
    Zonemaster::Nameserver->save( $datafile );
}

done_testing;
