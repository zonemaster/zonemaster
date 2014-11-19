package BackendTranslator;

use 5.14.0;

use Moose;
use Locale::TextDomain 'Zonemaster';
use Encode;

use FindBin qw($RealScript $Script $RealBin $Bin);
##################################################################
my $PROJECT_NAME = "Zonemaster-Backend";

my $SCRITP_DIR = __FILE__;
$SCRITP_DIR = $Bin unless ($SCRITP_DIR =~ /^\//);

#warn "SCRITP_DIR:$SCRITP_DIR\n";
#warn "RealScript:$RealScript\n";
#warn "Script:$Script\n";
#warn "RealBin:$RealBin\n";
#warn "Bin:$Bin\n";
#warn "__PACKAGE__:".__PACKAGE__;
#warn "__FILE__:".__FILE__;

my ($PROD_DIR) = ($SCRITP_DIR =~ /(.*?\/)$PROJECT_NAME/);
#warn "PROD_DIR:$PROD_DIR\n";

my $PROJECT_BASE_DIR = $PROD_DIR.$PROJECT_NAME."/";
#warn "PROJECT_BASE_DIR:$PROJECT_BASE_DIR\n";
unshift(@INC, $PROJECT_BASE_DIR);
##################################################################

unshift(@INC, $PROD_DIR."Zonemaster/lib") unless $INC{$PROD_DIR."Zonemaster/lib"};
# Zonemaster Modules
require Zonemaster::Translator;

extends 'Zonemaster::Translator';

sub translate_tag {
    my ( $self, $entry ) = @_;

    my $string = $self->data->{ $entry->{module} }{ $entry->{tag} };

    if ( not $string ) {
        return $entry->{string};
    }

	my $str = decode_utf8(__x( $string, %{ $entry->{args} } ));

	return $str;
}

1;