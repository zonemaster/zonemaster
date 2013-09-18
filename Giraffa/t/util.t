use Test::More;

BEGIN { use_ok( 'Giraffa::Util' ) }

isa_ok( config, 'HASH' );
isa_ok( ns( 'name', '::1' ), 'Giraffa::Nameserver' );
isa_ok( info( 'TAG', {} ), 'Giraffa::Logger::Entry' );
isa_ok( name( "foo.bar.com" ), 'Giraffa::DNSName' );

done_testing;
