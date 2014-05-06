use Test::More;

BEGIN { use_ok( 'Giraffa::Util' ) }

isa_ok( config, 'HASH' );
isa_ok( ns( 'name', '::1' ), 'Giraffa::Nameserver' );
isa_ok( info( 'TAG', {} ), 'Giraffa::Logger::Entry' );
isa_ok( name( "foo.bar.com" ), 'Giraffa::DNSName' );

my $dref = pod_extract_for( 'DNSSEC' );
isa_ok( $dref, 'HASH' );
ok( scalar( keys %$dref ) > 3, 'At least four keys' );
like( $dref->{dnssec01}, qr/Verifies that all DS records have digest types registered with IANA/, 'Expected content.' );

done_testing;
