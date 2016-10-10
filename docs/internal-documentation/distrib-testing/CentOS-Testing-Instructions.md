## Install Engine

1) Make sure the development environment is installed.

`sudo yum groupinstall "Development Tools`

2) Install packages.

`sudo yum install perl-core perl-ExtUtils-MakeMaker perl-File-ShareDir
perl-File-Slurp perl-IO-Socket-INET6 perl-JSON perl-List-MoreUtils perl-Readonly
perl-Time-HiRes perl-YAML libidn-devel perl-libintl perl-Devel-CheckLib
openssl-devel perl-Test-Fatal`

3) Install CPAN modules.

`sudo cpan -i Module::Install Moose Net::IP Hash::Merge Net::IP::XS Net::LDNS
JSON Module::Find Mail::RFC822::Address`

4) Install/Configure Git 

Install git if it is not installed
`sudo yum install git`

`git clone https://github.com/dotse/zonemaster-engine.git` from your home
directory

`cd zonemaster-engine`

5) Build the source code

`perl Makefile.PL`
`make`
`make test`
`sudo make install`

## Installing the CLI

** Change to your home directory **

1) Install/Configure Git 
`git clone https://github.com/dotse/zonemaster-cli.git`

`cd zonemaster-cli`

2) Install all necessary packages.
`sudo cpan -i Text::Reflow MooseX::Getopt JSON::XS`

3) Build the source code
 `perl Makefile.PL`
 `make`
 `make test`
 `sudo make install`


4) Verify the CLI and Engine works

zoenmaster-cli afnic.fr


## Installing the backend

1) Change to your home directory
2) Install the packages.

    `sudo yum install perl-IO-CaptureOutput perl-String-ShellQuote perl-DBD-Pg`

3) Install modules from CPAN.

    `sudo cpan -i Config::IniFiles Daemon::Control JSON::RPC::Dispatch
Parallel::ForkManager Plack::Builder Plack::Middleware::Debug
Router::Simple::Declare Starman`

4) Fetch the source code.

    `git clone https://github.com/dotse/zonemaster-backend.git`

    `cd zonemaster-backend`

5) Build and install the backend modules.

    `perl Makefile.PL` 
    `make`
    `make test` 
    `sudo make install`



6) ### Using PostgreSQL as database for the backend

a) Create a directory 
  
    `sudo mkdir /etc/zonemaster`

b) Edit the file `share/backend_config.ini` in the `zonemaster-backend`
directory

    engine           = PostgreSQL
    user             = zonemaster
    password         = zonemaster
    database_name    = zonemaster
    database_host    = localhost
    polling_interval = 0.5
    log_dir          = logs/
    interpreter      = perl
    max_zonemaster_execution_time   = 300
    number_of_processes_for_frontend_testing  = 20
    number_of_processes_for_batch_testing     = 20

c) Copy the `backend_config.ini` file to `/etc/zonemaster`

    `sudo cp share/backend_config.ini /etc/zonemaster`

d) Install a database server. PostGreSQL in this example

Make sure that the PostgreSQL version is 9.3 or higher by the following command 

    `psql —version` 

If PostGreSQL  is not installed, then install PostGreSQL using the following
commands

  `sudo rpm -iUvh
https://download.postgresql.org/pub/repos/yum/9.3/redhat/rhel-7-x86_64/pgdg-centos93-9.3-3.noarch.rpm`
  
  `sudo yum -y update`

  `sudo yum -y install postgresql93 postgresql93-server postgresql93-contrib
postgresql93-libs`

Check the PostgreSQL version and make sure that the vversion is 9.3 or higher
  
  `psql --version`

  

e) Start PostgreSQL
    `sudo systemctl enable postgresql-9.3`
    `sudo /usr/pgsql-9.3/bin/postgresql93-setup initdb`
    `sudo systemctl start postgresql-9.3`

f) Modify the file (change contents from "ident" to "trust")
    `vim /var/lib/pgsql/9.4/data/pg_hba.conf`
-----
local   all             postgres                                trust
local   all             myapp_usr                               trust
# IPv4 local connections:
host    all             all             127.0.0.1/32            trust
# IPv6 local connections:
#host    all             all             ::1/128                 trust
-----


f) Check if PostgreSQL has started correctly
    `sudo systemctl status postgresql-9.3`
   
g) Connect to PostgreSQL database for the first time
    `sudo -i -u postgres`

Will bring you to bash prompt. From bash prompt 
    `psql` 

Will move to the postgres prompt

) Connect to Postgres as a user with administrative privileges and set things
up:

    Make sure that ** <user> ** in the above path is modified appropriately
   
    `cp /home/<user>/zonemaster-backend/docs/initial-postgres.sql /tmp`
    `sudo su - postgres`
    `psql -f /tmp/initial-postgres.sql`

    `\q` to exit from Postgres
    `exit` to exit from the bash prompt


This creates a database called `zonemaster`, as well as a user called
"zonemaster" with the password "zonemaster" (as stated in the config file). This
user has just enough permissions to run the backend software.

If, at some point, you want to delete all traces of Zonemaster in the database,
you can run the file `docs/cleanup-postgres.sql` in the `zonemaster-backend`
after copying it to /tmp

directory as a database administrator. It removes the user and drops the
database (obviously taking all data with it).


### Starting the backend

1) Create a log directory. 
    `cd ~/`
    `mkdir logs`


2) In all the examples below, replace **`/home/user`** with the path to your own
homedirectory (or, of course, wherever you want).

    `starman --error-log=/home/user/logs/backend_starman.log
--listen=127.0.0.1:5000 --pid=/home/user/logs/starman.pid --daemonize
/usr/local/bin/zonemaster_webbackend.psgi`

3) To verify starman has started:

    `cat ~/logs/backend_starman.log`

4) If you would like to kill the starman process, you can issue this command:

    `kill `cat /home/user/logs/starman.pid``


### Starting the starman part that listens for and answers the JSON::RPC requests 

sudo /usr/local/bin/zm_wb_daemon --user=sandoche --group=sandoche --pidfile=/tmp/zm_wb_daemon.pid start

## Normally it should be started by the following process (As of now ignore the
following lines)

Move to the zonemaster-backend directory
** Before copying modify "mysql" to "postgresql" in the file "zm-centos.sh"

1)  Copy the file `share/zm-centos.sh` to the directory `/etc/init`.

    `sudo cp share/zm-centos.sh /etc/init.d/`

2)  Make it an executable file

   `sudo chmod +x /etc/init.d/zm-centos.sh`

3). Add to the start up script

   `sudo chkconfig --add zm-centos.sh`

4) Start the services.

   `sudo systemctl start zm-centos`

5) Test that it started OK. The command below should print a JSON string
including some information on the Zonemaster engine version.

   `curl -X POST http://127.0.0.1:5000/ -d '{"method":"version_info"}'`

## Installing the GUI

Go to the home directory

1) Install additional prerequisite packages.

   `sudo cpan -i Dancer Text::Markdown Template JSON`

2) Get the source code.

   `git clone https://github.com/dotse/zonemaster-gui.git`

3) Change to the source code directory.

   `cd zonemaster-gui`

4) Install the Perl modules.

    `perl Makefile.PL`
    `make`
    `make test`
    `sudo make install`

5) Create a directory for the webapp parts, and copy them there.

    `sudo mkdir -p /usr/local/share/zonemaster

    sudo cp -a zm_app /usr/local/share/zonemaster



6) Start the server:



    starman --listen=:1080 --daemonize
/usr/local/share/zonemaster/zm_app/bin/app.pl

## Check whether the GUI works

   http://IPaddress:1080




