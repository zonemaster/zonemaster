package BackendConfig;
our $VERSION = '0.01';

use strict;
use warnings;
use utf8;
use 5.14.1;

use Data::Dumper;
use Config::IniFiles;

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


sub _load_config {
	my $cfg;
	my $path;
	if (-e '/etc/zonemaster/backend_config.ini') {
		$path = '/etc/zonemaster/backend_config.ini';
	}
	else {
		$path = $PROJECT_BASE_DIR."backend_config.ini";
	}
	$cfg = Config::IniFiles->new( -file => $path );
	
	die "UNABLE TO LOAD $path\n" unless ($cfg);
	
	return $cfg;
}

sub BackendDBType {
	my $cfg = _load_config();
	
	my $result;
	
	if (lc($cfg->val( 'DB', 'engine' )) eq 'sqlite') {
		$result = 'SQLite';
	}
	elsif (lc($cfg->val( 'DB', 'engine' )) eq 'postgresql') {
		$result = 'PostgreSQL';
	}
	elsif (lc($cfg->val( 'DB', 'engine' )) eq 'couchdb') {
		$result = 'CouchDB';
	}
	elsif (lc($cfg->val( 'DB', 'engine' )) eq 'mysql') {
		$result = 'MySQL';
	}
	
	return $result;
}

sub DB_user {
	my $cfg = _load_config();
	
	return $cfg->val( 'DB', 'user' );
}

sub DB_password {
	my $cfg = _load_config();

	return $cfg->val( 'DB', 'password' );
}

sub DB_connection_string {
	my $cfg = _load_config();
	
	my $result;
	
	if (lc($cfg->val( 'DB', 'engine' )) eq 'sqlite') {
		$result = 'DBI:SQLite:database='.$cfg->val( 'DB', 'database_name' );
	}
	elsif (lc($cfg->val( 'DB', 'engine' )) eq 'postgresql') {
		$result = 'DBI:Pg:database='.$cfg->val( 'DB', 'database_name' ).';host='.$cfg->val( 'DB', 'database_host' );
	}
	elsif (lc($cfg->val( 'DB', 'engine' )) eq 'couchdb') {
		$result = 'CouchDB';
	}
	elsif (lc($cfg->val( 'DB', 'engine' )) eq 'mysql') {
		$result = 'MySQL';
	}
	
	return $result;
}

sub LogDir {
	my $cfg = _load_config();

	return $cfg->val( 'LOG', 'log_dir' );
}

sub PerlIntereter {
	my $cfg = _load_config();

	return $cfg->val( 'PERL', 'interpreter' );
}

1;
