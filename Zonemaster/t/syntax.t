use Test::More;

use 5.14.2;

BEGIN { use_ok('Zonemaster')}

sub gives {
    my ($test, $name, $gives) = @_;

    my @res = Zonemaster->test_method('Syntax', $test, $name);
    ok((grep {$_->tag eq $gives} @res), "$name gives $gives");
}

sub gives_not {
    my ($test, $name, $gives) = @_;

    my @res = Zonemaster->test_method('Syntax', $test, $name);
    ok(!(grep {$_->tag eq $gives} @res), "$name does not give $gives");
}

sub name_gives       {gives('name_syntax', @_);}
sub name_gives_not   {gives_not('name_syntax', @_);}
sub rname_gives      {gives('rname_syntax', @_);}
sub rname_gives_not  {gives_not('rname_syntax', @_);}
sub serial_gives     {gives('soa_date', @_);}
sub serial_gives_not {gives_not('soa_date', @_);}

name_gives('www.nic.se', 'ONLY_ALLOWED_CHARS');
name_gives('www.nic&nac.se', 'NON_ALLOWED_CHARS');

name_gives('www.-nic.se', 'INITIAL_HYPHEN');
name_gives_not('www.nic.se', 'INITIAL_HYPHEN');

name_gives('www.nic-.se', 'TERMINAL_HYPHEN');
name_gives_not('www.nic.se', 'TERMINAL_HYPHEN');

name_gives('www.ni--c.se', 'DISCOURAGED_DOUBLE_DASH');
name_gives_not('www.xn--c.se', 'DISCOURAGED_DOUBLE_DASH');

name_gives('www.nic.se.17', 'NUMERIC_TLD');
name_gives_not('www.nic.se', 'NUMERIC_TLD');

name_gives('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa.', 'NAME_TOO_LONG');
name_gives_not('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa.', 'NAME_TOO_LONG');

name_gives('www.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa.se', 'LABEL_TOO_LONG');
name_gives_not('www.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa.se', 'LABEL_TOO_LONG');

rname_gives('foo@example.org', 'RNAME_MISUSED_AT_SIGN');
rname_gives_not('foo.example.org', 'RNAME_MISUSED_AT_SIGN');

rname_gives( 'foo\.bar\.se', 'RNAME_RFC822_INVALID');
rname_gives_not( 'foo\.bar.example.org', 'RNAME_RFC822_INVALID');

serial_gives( 17, 'SERIAL_NOT_DATE');
serial_gives( '201x012001', 'SERIAL_NOT_DATE');
serial_gives( 2014023100, 'SERIAL_NOT_DATE');
serial_gives_not( 2014013100, 'SERIAL_NOT_DATE');

# For now, just run this and make sure it does not explode
my @res = Zonemaster->test_module('Syntax', 'iis.se');

done_testing;