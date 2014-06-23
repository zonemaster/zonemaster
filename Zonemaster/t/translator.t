use Test::More;
use Test::Fatal;

use Zonemaster::Logger::Entry;

BEGIN { use_ok( 'Zonemaster::Translator' ) }

my $trans = new_ok( 'Zonemaster::Translator' => [ { lang => 'sv' } ] );

like( exception {Zonemaster::Translator->new}, qr/Must have at least one of lang and file/, 'expected error message' );

is( $trans->lang, 'sv', 'expected language code' );

like(
    exception { $trans->file },
    qr[Cannot read translation file .+/lib/auto/share/dist/Zonemaster/language_sv.json],
    'expected error message'
);

$trans = Zonemaster::Translator->new( { lang => 'tech' } );
is( exception { $trans->data }, undef, 'no error reading translation data' );

ok( exists $trans->data->{BASIC}{NO_GLUE}, 'expected key from file exists' );
ok( exists $trans->data->{DNSSEC}{ALGORITHM_OK}, 'expected key from module exists' );

my $entry = Zonemaster::Logger::Entry->new(
    {
        module => 'BASIC',
        tag    => 'NO_GLUE',
        args   => { parent => 'se', rcode => 'SERVFAIL' }
    }
);
is(
    $trans->to_string( $entry ),
    '   0.00 CRITICAL  Nameservers for "se" provided no NS records for tested zone. RCODE given was SERVFAIL.',
    'string to_stringd as expected'
);

done_testing;
