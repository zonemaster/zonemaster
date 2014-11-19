use strict;                                                                                                                                                                                                                                                                    
use warnings;                                                                                                                                                                                                                                                                  
use utf8;                                                                                                                                                                                                                                                                      
use Data::Dumper;                                                                                                                                                                                                                                                              
use Encode;                                                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                                                               
use DBI qw(:utils);                                                                                                                                                                                                                                                            
                                                                                                                                                                                                                                                                               
my $connection_string = "DBI:Pg:database=zonemaster;host=localhost";
my $dbh = DBI->connect($connection_string, "zonemaster", "zonemaster", {RaiseError => 1, AutoCommit => 1});

sub create_db{

        ####################################################################
        # TEST RESULTS
        ####################################################################
        $dbh->do('DROP TABLE IF EXISTS test_specs CASCADE');
        $dbh->do('DROP SEQUENCE IF EXISTS test_specs_id_seq');

        $dbh->do('DROP TABLE IF EXISTS test_results CASCADE');
        $dbh->do('DROP SEQUENCE IF EXISTS test_results_id_seq');

        $dbh->do('CREATE SEQUENCE test_results_id_seq
                                        INCREMENT BY 1
                                        NO MAXVALUE
                                        NO MINVALUE
                                        CACHE 1
        ');

        $dbh->do('ALTER TABLE public.test_results_id_seq OWNER TO zonemaster');

        $dbh->do('CREATE TABLE test_results (
                        id integer DEFAULT nextval(\'test_results_id_seq\'::regclass) primary key,
                        batch_id integer DEFAULT NULL,
                        creation_time timestamp without time zone DEFAULT NOW() NOT NULL,
                        test_start_time timestamp without time zone DEFAULT NULL,
                        test_end_time timestamp without time zone DEFAULT NULL,
                        priority integer DEFAULT 10,
                        progress integer DEFAULT 0,
                        params_deterministic_hash character varying(32),
                        params json NOT NULL,
                        results json DEFAULT NULL
                )
        ');
        $dbh->do('ALTER TABLE test_results OWNER TO zonemaster');

        ####################################################################
        # BATCH JOBS
        ####################################################################
        $dbh->do('DROP TABLE IF EXISTS batch_jobs CASCADE');
        $dbh->do('DROP SEQUENCE IF EXISTS batch_jobs_id_seq');

        $dbh->do('CREATE SEQUENCE batch_jobs_id_seq
                                        INCREMENT BY 1
                                        NO MAXVALUE
                                        NO MINVALUE
                                        CACHE 1
        ');

        $dbh->do('ALTER TABLE public.batch_jobs_id_seq OWNER TO zonemaster');

        $dbh->do('CREATE TABLE batch_jobs (
                        id integer DEFAULT nextval(\'batch_jobs_id_seq\'::regclass) primary key,
                        username character varying(50) NOT NULL,
                        creation_time timestamp without time zone DEFAULT NOW() NOT NULL
                )
        ');
        $dbh->do('ALTER TABLE batch_jobs OWNER TO zonemaster');

        ####################################################################
        # USERS
        ####################################################################
        $dbh->do('DROP TABLE IF EXISTS users CASCADE');
        $dbh->do('DROP SEQUENCE IF EXISTS users_id_seq');

        $dbh->do('CREATE SEQUENCE users_id_seq
                                        INCREMENT BY 1
                                        NO MAXVALUE
                                        NO MINVALUE
                                        CACHE 1
        ');

        $dbh->do('ALTER TABLE public.users_id_seq OWNER TO zonemaster');

        $dbh->do('CREATE TABLE users (
                        id integer DEFAULT nextval(\'users_id_seq\'::regclass) primary key,
                        user_info json DEFAULT NULL
                )
        ');
        $dbh->do('ALTER TABLE users OWNER TO zonemaster');

}

create_db();
