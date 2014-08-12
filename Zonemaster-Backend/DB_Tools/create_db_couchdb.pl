use 5.14.0;
use strict;                                                                                                                                                                                                                                                                    
use warnings;                                                                                                                                                                                                                                                                  
use utf8;                                                                                                                                                                                                                                                                      
use Data::Dumper;                                                                                                                                                                                                                                                              
use Encode;                                                                                                                                                                                                                                                                    
                  
use Store::CouchDB;

sub create_db{
	# Unusable without debug => 1
	my $sc = Store::CouchDB->new(host => 'localhost', debug => 1);
	
	say Dumper($sc);
	
#	say Dumper( $sc->delete_db('zonemaster') );
#	say Dumper( $sc->create_db('zonemaster') );
# Kills CouchDB 1.0.4 (hangs, restart necesserry)

	my @dbs = $sc->all_dbs;
	foreach my $db (@dbs) {
 		say "FOUND DB:$db";
		if ($db eq 'zonemaster') {
			say Dumper( $sc->delete_db('zonemaster') );
		}
	}
	
	say Dumper( $sc->create_db('zonemaster') );
	
	# To create a new document dont put the _revision parameter
	my ($id, $rev) = $sc->put_doc({ dbname => 'zonemaster', doc => {
					"_id" => "_design/application",
					"views" => {
						"users" => {
							"map" => "function(doc) {
								if(doc.username) {
									emit(doc.username, null);
								}
							}"
						}
					}
				}});

	say "id: $id";
	say "rev: $rev";

	$hashref = $sc->get_view({
		view => 'application/users',
		opts => { username => 'user1' },
	});
    
	print Dumper($hashref);
}

create_db();
