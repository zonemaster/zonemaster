use Test::More;
use Test::Fatal;

use Zonemaster::Logger::Entry;
use POSIX qw[setlocale :locale_h];

BEGIN { use_ok( 'Zonemaster::Translator' ) }

my $trans = new_ok( 'Zonemaster::Translator' => [ { locale => 'sv_SE.UTF8' } ] );
is(setlocale(LC_MESSAGES), 'sv_SE.UTF-8');

ok( exists $trans->data->{BASIC}{NO_GLUE},       'expected key from file exists' );
ok( exists $trans->data->{DNSSEC}{ALGORITHM_OK}, 'expected key from module exists' );

my $entry = Zonemaster::Logger::Entry->new(
    {
        module => 'BASIC',
        tag    => 'NO_GLUE',
        args   => { parent => 'se', rcode => 'SERVFAIL' }
    }
);
like(
    $trans->to_string( $entry ),
    qr'   0.\d\d CRITICAL  Nameservers for "se" provided no NS records for tested zone. RCODE given was SERVFAIL.',
    'string to_stringd as expected'
);

done_testing;
