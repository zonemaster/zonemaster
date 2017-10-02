# Zonemaster components installation instruction before release for Debian/Ubuntu


The documentation covers the following operating systems:

 * [1] <a href="#Debian">Debian Wheezy (version 7)</a>


The Engine Perl module name is 'Zonemaster'.

## Prerequisite

   No other Zonemaster component is required by the engine.

### <a name="Debian"></a> Instructions for Debian 7

1) On a clean installation we might need adding an user and required access rights

`adduser username`
- Provide the passworda
- Add user to the sudoer list using `visudo`
- copy the contents of the ‘root’ in 'visudo' and change ‘root’ to ‘username’
- exit


2) Make sure the package database is up to date.

`sudo apt-get update`

2) Install all necessary packages.

`sudo apt-get install build-essential libfile-slurp-perl libjson-perl
liblist-moreutils-perl libio-socket-inet6-perl libmodule-find-perl libmoose-perl
libfile-sharedir-perl libhash-merge-perl libreadonly-perl
libmail-rfc822-address-perl libintl-xs-perl libssl-dev libdevel-checklib-perl
libtest-fatal-perl libtie-simple-perl libio-capture-perl
libgeography-countries-perl libidn11-dev`

3) Install/Configure Git 

`sudo apt-get install git`

`git clone https://github.com/dotse/zonemaster-engine.git` from your home
directory

`cd zonemaster-engine`

4) Locale Issues fix 

`sudo locale-gen en_US.UTF-8 (e.g. change to your locale)`

`sudo dpkg-reconfigure locales`

5) Install modules from CPAN 

`sudo cpan install Module::Install`
`sudo cpan install Net::IP`
`sudo cpan install Net::LDNS`

6) Build the source code

`perl Makefile.PL`
`make`
`make test`

While running `make test` if you get “msgfmt: Command not found” run the
following command
`sudo apt-get install gettext`

`sudo make install`


### Installing the CLI

1) Install/Configure Git 
`git clone https://github.com/dotse/zonemaster-cli.git` from your home directory

`cd zonemaster-cli`

2) Install all necessary packages.

`sudo apt-get install libmoosex-getopt-perl libtext-reflow-perl
libmodule-install-perl`

3) Build the source code

`perl Makefile.PL`
`make`
`make test`
`sudo make install`

 
### Verify the CLI and Engine works 

zoenmaster-cli afnic.fr

### Installing the backend

1) Install package dependencies

    
`sudo apt-get install git libmodule-install-perl libconfig-inifiles-perl
libdbd-sqlite3-perl starman libio-captureoutput-perl libproc-processtable-perl
libstring-shellquote-perl librouter-simple-perl libclass-method-modifiers-perl
libtext-microtemplate-perl libdaemon-control-perl` 


2) Install CPAN dependencies

`sudo cpan -i Plack::Middleware::Debug Parallel::ForkManager JSON::RPC
Net::IP::XS`

3) Get the source code

From your home directory

`git clone https://github.com/dotse/zonemaster-backend.git`

4) Build source code

`cd zonemaster-backend`
`perl Makefile.PL`
`make`
`make test`

Both these steps produce quite a bit of output. As long as it ends by
printing `Result: PASS`, everything is OK.

5) Install 

`sudo make install`

This too produces some output. The `sudo` command may not be necessary,
if you normally have write permissions to your Perl installation.

### Using MySQL as database for the backend

1) Create a directory 

`sudo mkdir /etc/zonemaster`

2) Edit the file `share/backend_config.ini`

    engine           = MySQL
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

    # Modify the path to the filter config file accordingly which
    # is usually in the Zonemaster_Engine repository
    config_logfilter_1=/full/path/to/a/config_file.json

3)  Copy the `backend_config.ini` file to `/etc/zonemaster`

`sudo cp share/backend_config.ini /etc/zonemaster`

4) Install MySQL packages.

`sudo apt-get install mysql-server libdbd-mysql-perl`

5) Using a database adminstrator user (called root in the example below), run
the setup file:
    
`mysql --user=root --password < docs/initial-mysql.sql`
    
This creates a database called `zonemaster`, as well as a user called
"zonemaster" with the password "zonemaster" (as stated in the config file). This
user has just enough permissions to run the backend software.

If, at some point, you want to delete all traces of Zonemaster in the database,
you can run the file `docs/cleanup-mysql.sql` as a database administrator. It
removes the user and drops the database (obviously taking all data with it).

### Starting the backend

1) Create a log directory. 

`cd ~/`
`mkdir logs`

2) In all the examples below, replace **`/home/user`** with the path to your own
homedirectory (or, of course, wherever you want).

`starman --error-log=/home/user/logs/backend_starman.log --listen=127.0.0.1:5000
--pid=/home/user/logs/starman.pid --daemonize
/usr/local/bin/zonemaster_webbackend.psgi`

3) To verify starman has started:

`cat ~/logs/backend_starman.log`

4) If you would like to kill the starman process, you can issue this command:

`kill `cat /home/user/logs/starman.pid`` [Be sure to modify the path
accordingly]

### Starting the starman part that listens for and answers the JSON::RPC
requests 

1)  Copy the file `share/zm-backend.sh` to the directory `/etc/init`.

From the Zonemaster-backend directory

`sudo cp share/zm-backend.sh /etc/init.d/`

2)  Make it an executable file

`sudo chmod +x /etc/init.d/zm-backend.sh`

3)  Add the file to start up script

`sudo update-rc.d zm-backend.sh defaults`

4)  Start the process

`sudo cpan -i Parallel::ForkManager`

`sudo service zm-backend.sh start`

This only needs to be run as root in order to make sure the log file can be
opened. The `starman` process will change to the `www-data` user as soon as it
can, and all of the real work will be done as that user.

## Testing the setup

You can look into the [API documentation](API.md) to see how you can use the
API for your use. If you followed the instructions to the minute, you should
be able to use the API och localhost port 5000, like this:

`sudo apt-get install curl`

`curl -H "Content-Type: application/json" -d
'{"params":"","jsonrpc":"2.0","id":140715758026879,"method":"version_info"}'
http://localhost:5000/`

The response should be something like this:

    {"id":140715758026879,"jsonrpc":"2.0","result":"Zonemaster Test Engine
Version: v1.0.2"}

### Installing the GUI

1) Move to your home directory 
`cd ~/`

2) Install added prerequisite packages:

`sudo apt-get install libdancer-perl libtext-markdown-perl libtemplate-perl
libjson-any-perl`

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

`sudo mkdir -p /usr/share/doc/zonemaster`
`sudo cp -a zm_app /usr/share/doc/zonemaster`

6) Start the server:

`sudo starman --listen=:80 /usr/share/doc/zonemaster/zm_app/bin/app.pl`


