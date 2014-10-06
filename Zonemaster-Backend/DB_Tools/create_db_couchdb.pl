use 5.14.0;
use strict;                                                                                                                                                                                                                                                                    
use warnings;                                                                                                                                                                                                                                                                  
use utf8;                                                                                                                                                                                                                                                                      
use Data::Dumper;                                                                                                                                                                                                                                                              
use Encode;                                                                                                                                                                                                                                                                    
                  
use Store::CouchDB;

sub create_db{
	# Unusable without debug => 1
	my $sc = Store::CouchDB->new(host => '127.0.0.1', debug => 1);
	
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
	
	say "------------ Create Views START -------------------";
	# To create a new document dont put the _revision parameter
	my ($id, $rev) = $sc->put_doc({ dbname => 'zonemaster', 
				doc => {
					"_id" => "_design/application", 
					"views" => {
							"users" => {
								"map" => "function(doc) {
									if(doc.doc_type == 'user' && doc.username) {
										emit(doc.username, null);
									}
								}"
							},

							"tests_by_deterministic_hash" => {
								"map" => "function(doc) {
									if(doc.doc_type == 'test') {
										emit(doc.deterministic_hash, { 'doc_id' : doc.doc_id, 'creation_time' : doc.creation_time });
									}
								}"
							}
						}
					}
				});

	say "id: $id";
	say "rev: $rev";
	say "------------ Create Views END -------------------";
	
	say "------------ Search Documet 1 START -------------------";
	my $hashref = $sc->get_view({
		view => 'application/users',
		opts => { key => 'user1' },
	});
	print Dumper($hashref);
	say "------------ Search Documet 1 END -------------------";
    
	say "------------ INSERT Documet 1 START -------------------";
	($id, $rev) = $sc->put_doc({ dbname => 'zonemaster', doc => { doc_type => 'user', username => 'user1' } } );
	say "------------ INSERT Documet 1 STOP -------------------";

	say "------------ Search Documet 1 START -------------------";
	$hashref = $sc->get_view({
		view => 'application/users',
		opts => { key => 'user1' },
	});
	print Dumper($hashref);
	say "------------ Search Documet 1 STOP -------------------";

}

create_db();
