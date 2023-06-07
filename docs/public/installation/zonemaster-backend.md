# Installation: Zonemaster-Backend

## Table of contents

* [1. Overview](#1-overview)
* [2. Prerequisites](#2-prerequisites)
* [3. Installation on Rocky Linux](#3-installation-on-rocky-linux)
  * [3.1 Install Zonemaster::Backend and related dependencies (Rocky Linux)](#31-install-zonemasterbackend-and-related-dependencies-rocky-linux)
  * [3.2 Database engine installation (Rocky Linux)](#32-database-engine-installation-rocky-linux)
  * [3.3 Database configuration (Rocky Linux)](#33-database-configuration-rocky-linux)
  * [3.4 Service configuration and startup (Rocky Linux)](#34-service-configuration-and-startup-rocky-linux)
  * [3.5 Post-installation (Rocky Linux)](#35-post-installation-rocky-linux)
* [4. Installation on Debian and Ubuntu](#4-installation-on-debian-and-ubuntu)
  * [4.1 Install Zonemaster::Backend and related dependencies (Debian/Ubuntu)](#41-install-zonemasterbackend-and-related-dependencies-debianubuntu)
  * [4.2 Database engine installation (Debian/Ubuntu)](#42-database-engine-installation-debianubuntu)
  * [4.3 Database configuration (Debian/Ubuntu)](#43-database-configuration-debianubuntu)
  * [4.4 Service configuration and startup (Debian/Ubuntu)](#44-service-configuration-and-startup-debianubuntu)
  * [4.5 Post-installation (Debian/Ubuntu)](#45-post-installation-debianubuntu)
* [5. Installation on FreeBSD](#5-installation-on-freebsd)
  * [5.1 Install Zonemaster::Backend and related dependencies (FreeBSD)](#51-install-zonemasterbackend-and-related-dependencies-freebsd)
  * [5.2 Database engine installation (FreeBSD)](#52-database-engine-installation-freebsd)
  * [5.3 Database configuration (FreeBSD)](#53-database-configuration-freebsd)
  * [5.4 Service startup (FreeBSD)](#54-service-startup-freebsd)
  * [5.5 Post-installation (FreeBSD)](#55-post-installation-freebsd)
* [6. Post-installation][Post-installation]
  * [6.1 Smoke test](#61-smoke-test)
  * [6.2 Troubleshooting installation](#62-troubleshooting-installation)
  * [6.3 What to do next?](#63-what-to-do-next)
* [7. Installation with MariaDB](#7-installation-with-mariadb)
  * [7.1 MariaDB (Rocky Linux)][MariaDB instructions Rocky Linux]
  * [7.2. MariaDB (Debian/Ubuntu)][MariaDB instructions Debian]
  * [7.3. MySQL (FreeBSD)][MariaDB instructions FreeBSD]
* [8. Installation with PostgreSQL](#9-installation-with-postgresql)
  * [8.1. PostgreSQL (Rocky Linux)][PostgreSQL instructions Rocky Linux]
  * [8.2. PostgreSQL (Debian/Ubuntu)][PostgreSQL instructions Debian]
  * [8.3. PostgreSQL (FreeBSD)][PostgreSQL instructions FreeBSD]
* [9. Cleaning up the database][Removing database]
  * [9.1. MariaDB and MySQL](#91-mariadb-and-mysql)
  * [9.2. PostgreSQL](#92-postgresql)
  * [9.3. SQLite](#93-sqlite)
* [10. Optional features](#10-optional-features)
  * [10.1. Metrics](#101-metrics)

## 1. Overview

This document contains all steps needed to install Zonemaster::Backend. For an overview of the
Zonemaster product, please see the [main Zonemaster Repository].

If you upgrade your Zonemaster installation with a newer version of
Zonemaster::Backend instead, and want to keep the database, then see the
[Upgrade document]. Otherwise [remove the database][Removing database] and
continue with this installation document.


## 2. Prerequisites

Before installing Zonemaster::Backend, you should [install Zonemaster::Engine][
Zonemaster::Engine installation].

> **Note:** [Zonemaster::Engine] and [Zonemaster::LDNS] are dependencies of
> Zonemaster::Backend. Zonemaster::LDNS has a special installation requirement,
> and Zonemaster::Engine has a list of dependencies that you may prefer to
> install from your operating system distribution (rather than CPAN).
> We recommend following the Zonemaster::Engine installation instruction.

Prerequisite for FreeBSD is that the package system is updated and activated
(see the FreeBSD section of [Zonemaster::Engine installation]).

For details on supported versions of Perl, database engine and operating system
for Zonemaster::Backend, see the [declaration of prerequisites].


## 3. Installation on Rocky Linux

### 3.1 Install Zonemaster::Backend and related dependencies (Rocky Linux)

> **Note:** Zonemaster::LDNS and Zonemaster::Engine are not listed here as they
> are dealt with in the [prerequisites](#prerequisites) section.

Install dependencies available from binary packages:

```sh
sudo dnf -y install jq perl-Class-Method-Modifiers perl-Config-IniFiles perl-DBD-SQLite perl-DBI perl-HTML-Parser perl-JSON-RPC perl-libwww-perl perl-Log-Dispatch perl-Mojolicious perl-Parallel-ForkManager perl-Plack perl-Plack-Middleware-ReverseProxy perl-Plack-Test perl-Role-Tiny perl-Router-Simple perl-Test-Differences perl-Test-Exception perl-Test-Mojo perl-Test-NoWarnings perl-Try-Tiny perl-libintl redhat-lsb-core
```

Install dependencies not available from binary packages:

```sh
sudo cpanm --notest Daemon::Control JSON::Validator Log::Any Log::Any::Adapter::Dispatch Starman
```

Install Zonemaster::Backend:

```sh
sudo cpanm --notest Zonemaster::Backend
```

> The command above might try to install "DBD::Pg" and "DBD::mysql".
> You can ignore if it fails. The relevant libraries are installed further down in these instructions.

Add Zonemaster user (unless it already exists):

```sh
sudo useradd -r -c "Zonemaster daemon user" zonemaster
```

Install files to their proper locations:

```sh
cd `perl -MFile::ShareDir=dist_dir -E 'say dist_dir("Zonemaster-Backend")'`
sudo install -v -m 755 -d /etc/zonemaster
sudo install -v -m 640 -g zonemaster ./backend_config.ini /etc/zonemaster/
sudo install -v -m 775 -g zonemaster -d /var/log/zonemaster
sudo install -v -m 755 ./zm-rpcapi.lsb /etc/init.d/zm-rpcapi
sudo install -v -m 755 ./zm-testagent.lsb /etc/init.d/zm-testagent
sudo install -v -m 755 ./tmpfiles.conf /usr/lib/tmpfiles.d/zonemaster.conf
```

### 3.2 Database engine installation (Rocky Linux)

Check the [declaration of prerequisites] to make sure your preferred combination
of operating system version and database engine version is supported.

The installation instructions below assumes that this is a new installation.


#### 3.2.1 Instructions for SQLite (Rocky Linux)

> **Note:** Zonemaster with SQLite is not meant for an installation with heavy
> load.

Create database directory:

```sh
sudo install -v -m 755 -o zonemaster -g zonemaster -d /var/lib/zonemaster
```

> Some parameters can be changed, see the [backend configuration] documentation
> for details.


#### 3.2.2 Instructions for other engines (Rocky Linux)

See sections for [MariaDB][MariaDB instructions Rocky Linux] and
[PostgreSQL][PostgreSQL instructions Rocky Linux].


### 3.3 Database configuration (Rocky Linux)

Create the database tables:

```sh
sudo -u zonemaster $(perl -MFile::ShareDir -le 'print File::ShareDir::dist_dir("Zonemaster-Backend")')/create_db.pl
```


### 3.4 Service configuration and startup (Rocky Linux)

Make sure our tmpfiles configuration takes effect:

```sh
sudo systemd-tmpfiles --create /usr/lib/tmpfiles.d/zonemaster.conf
```

Enable services at boot time and start them:

```sh
sudo systemctl enable zm-rpcapi
sudo systemctl enable zm-testagent
sudo systemctl start zm-rpcapi
sudo systemctl start zm-testagent
```


### 3.5 Post-installation (Rocky Linux)

See the [post-installation] section for post-installation matters.


## 4. Installation on Debian and Ubuntu

### 4.1 Install Zonemaster::Backend and related dependencies (Debian/Ubuntu)

> **Note:** Zonemaster::LDNS and Zonemaster::Engine are not listed here as they
> are dealt with in the [prerequisites](#prerequisites) section.

Install required locales:

```sh
sudo perl -pi -e 's/^# (da_DK\.UTF-8.*|en_US\.UTF-8.*|es_ES\.UTF-8.*|fi_FI\.UTF-8.*|fr_FR\.UTF-8.*|nb_NO\.UTF-8.*|sv_SE\.UTF-8.*)/$1/' /etc/locale.gen
sudo locale-gen
```

After the update, `locale -a` should at least list the following locales:
```
da_DK.utf8
en_US.utf8
es_ES.utf8
fi_FI.utf8
fr_FR.utf8
nb_NO.utf8
sv_SE.utf8
```

Install dependencies available from binary packages:

```sh
sudo apt install jq libclass-method-modifiers-perl libconfig-inifiles-perl libdbd-sqlite3-perl libdaemon-control-perl libdbi-perl libfile-sharedir-perl libfile-slurp-perl libhtml-parser-perl libmojolicious-perl libio-stringy-perl libjson-pp-perl libjson-rpc-perl libjson-validator-perl liblog-any-adapter-dispatch-perl liblog-any-perl liblog-dispatch-perl libmoose-perl libparallel-forkmanager-perl libplack-perl libplack-middleware-debug-perl libplack-middleware-reverseproxy-perl librole-tiny-perl librouter-simple-perl libtest-nowarnings-perl libtest-differences-perl libtest-exception-perl libtry-tiny-perl libintl-perl perl-doc starman
```
> **Note**: libio-stringy-perl is listed here even though it's not a direct
> dependency. It's an undeclared dependency of libconfig-inifiles-perl.

For Ubuntu 20.04 only, install JSON::Validator from CPAN as the one in the system packages repository is too old:

```sh
sudo cpanm --notest JSON::Validator
```

Install Zonemaster::Backend:

```sh
sudo cpanm --notest Zonemaster::Backend
```

> The command above might try to install "DBD::Pg" and "DBD::mysql".
> You can ignore if it fails. The relevant libraries are installed further down in these instructions.

Add Zonemaster user (unless it already exists):

```sh
sudo useradd -r -c "Zonemaster daemon user" zonemaster
```

Install files to their proper locations:

```sh
cd `perl -MFile::ShareDir=dist_dir -E 'say dist_dir("Zonemaster-Backend")'`
sudo install -v -m 755 -d /etc/zonemaster
sudo install -v -m 775 -g zonemaster -d /var/log/zonemaster
sudo install -v -m 640 -g zonemaster ./backend_config.ini /etc/zonemaster/
sudo install -v -m 755 ./zm-rpcapi.lsb /etc/init.d/zm-rpcapi
sudo install -v -m 755 ./zm-testagent.lsb /etc/init.d/zm-testagent
sudo install -v -m 755 ./tmpfiles.conf /usr/lib/tmpfiles.d/zonemaster.conf
```

> If this is an update of Zonemaster-Backend, you should remove any
> `/etc/init.d/zm-backend.sh` (script from previous version of Zonemaster-Backend).


### 4.2 Database engine installation (Debian/Ubuntu)

Check the [declaration of prerequisites] to make sure your preferred combination
of operating system version and database engine version is supported.

The installation instructions below assumes that this is a new installation.


#### 4.2.1 Instructions for SQLite (Debian/Ubuntu)

> **Note:** Zonemaster with SQLite is not meant for an installation with heavy
> load.

Create database directory:

```sh
sudo install -v -m 755 -o zonemaster -g zonemaster -d /var/lib/zonemaster
```

> Some parameters can be changed, see the [backend configuration] documentation
> for details.


#### 4.2.2 Instructions for other engines (Debian/Ubuntu)

See sections for [MariaDB][MariaDB instructions Debian] and
[PostgreSQL][PostgreSQL instructions Debian].


### 4.3 Database configuration (Debian/Ubuntu)

Create the database tables:

```sh
sudo -u zonemaster $(perl -MFile::ShareDir -le 'print File::ShareDir::dist_dir("Zonemaster-Backend")')/create_db.pl
```


### 4.4 Service configuration and startup (Debian/Ubuntu)

Make sure our tmpfiles configuration takes effect:

```sh
sudo systemd-tmpfiles --create /usr/lib/tmpfiles.d/zonemaster.conf
```

Enable services at boot time and start them:

```sh
sudo systemctl enable zm-rpcapi
sudo systemctl enable zm-testagent
sudo systemctl start zm-rpcapi
sudo systemctl start zm-testagent
```


### 4.5 Post-installation (Debian/Ubuntu)

See the [post-installation] section for post-installation matters.


## 5. Installation on FreeBSD

For all commands below, acquire privileges, i.e. become root:

```sh
su -l
```

### 5.1 Install Zonemaster::Backend and related dependencies (FreeBSD)

> **Note:** Zonemaster::LDNS and Zonemaster::Engine are not listed here as they
> are dealt with in the [prerequisites](#prerequisites) section.

Install dependencies available from binary packages:

```sh
pkg install jq p5-Class-Method-Modifiers p5-Config-IniFiles p5-Daemon-Control p5-DBI p5-File-ShareDir p5-File-Slurp p5-HTML-Parser p5-JSON-PP p5-JSON-RPC p5-Mojolicious p5-Moose p5-Parallel-ForkManager p5-Plack p5-Plack-Middleware-ReverseProxy p5-Role-Tiny p5-Router-Simple p5-Starman p5-DBD-SQLite p5-Log-Dispatch p5-Log-Any p5-Log-Any-Adapter-Dispatch p5-JSON-Validator p5-YAML-LibYAML p5-Test-NoWarnings p5-Test-Differences p5-Test-Exception p5-Locale-libintl gmake
```
<!-- JSON::Validator requires YAML::PP, but p5-JSON-Validator currently lacks a dependency on p5-YAML-LibYAML -->

Install Zonemaster::Backend:

```sh
cpanm --notest Zonemaster::Backend
```

> The command above might try to install "DBD::Pg" and "DBD::mysql".
> You can ignore if it fails. The relevant libraries are installed further down in these instructions.

Unless they already exist, add `zonemaster` user and `zonemaster` group
(the group is created automatically):

```sh
cd `perl -MFile::ShareDir -le 'print File::ShareDir::dist_dir("Zonemaster-Backend")'`
pw useradd zonemaster -C freebsd-pwd.conf -s /sbin/nologin -d /nonexistent -c "Zonemaster daemon user"
```

Install files to their proper locations:

```sh
cd `perl -MFile::ShareDir -le 'print File::ShareDir::dist_dir("Zonemaster-Backend")'`
install -v -m 755 -d /usr/local/etc/zonemaster
install -v -m 640 -g zonemaster ./backend_config.ini /usr/local/etc/zonemaster/
install -v -m 775 -g zonemaster -d /var/log/zonemaster
install -v -m 775 -g zonemaster -d /var/run/zonemaster
install -v -m 755 ./zm_rpcapi-bsd /usr/local/etc/rc.d/zm_rpcapi
install -v -m 755 ./zm_testagent-bsd /usr/local/etc/rc.d/zm_testagent
```

### 5.2 Database engine installation (FreeBSD)

Check the [declaration of prerequisites] to make sure your preferred combination
of operating system version and database engine version is supported.

The installation instructions below assumes that this is a new installation.

#### 5.2.1 Instructions for SQLite (FreeBSD)

> **Note:** Zonemaster with SQLite is not meant for an installation with heavy
> load.

Configure Zonemaster::Backend to use the correct database path:

```sh
sed -i '' '/[[:<:]]database_file[[:>:]]/ s:=.*:= /var/db/zonemaster/db.sqlite:' /usr/local/etc/zonemaster/backend_config.ini
```

Create database directory:

```sh
install -v -m 755 -o zonemaster -g zonemaster -d /var/db/zonemaster
```

> Some parameters can be changed, see the [backend configuration] documentation
> for details.

#### 5.2.2 Instructions for other engines (FreeBSD)

See sections for [MariaDB][MariaDB instructions FreeBSD] and
[PostgreSQL][PostgreSQL instructions FreeBSD].


### 5.3 Database configuration (FreeBSD)

Create the database tables:

```sh
su -m zonemaster -c "`perl -MFile::ShareDir -le 'print File::ShareDir::dist_dir(qw(Zonemaster-Backend))'`/create_db.pl"
```


### 5.4 Service startup (FreeBSD)

Enable services at startup and start service:

```sh
sysrc zm_rpcapi_enable="YES"
sysrc zm_testagent_enable="YES"
service zm_rpcapi start
service zm_testagent start
```

### 5.5 Post-installation (FreeBSD)

To check that the running daemons run:

```sh
service zm_rpcapi status
service zm_testagent status
```

See the [post-installation] section for post-installation matters.


## 6. Post-installation

### 6.1 Smoke test

If you have followed the installation instructions for Zonemaster::Backend above,
you should be able to use the API on localhost port 5000 as below.

```sh
zmtest zonemaster.net
```

The command is expected to immediately print out a testid,
followed by a percentage ticking up from 0% to 100%.
Once the number reaches 100% a JSON object is printed and zmtest terminates.

### 6.2 Troubleshooting installation

If you have any issue with installation, and installed with `cpanm`, redo the
installation above but without the `--notest` and with the `--verbose` option.
Installation will take longer time.

### 6.3. What to do next?

* For a web interface, follow the [Zonemaster::GUI installation] instructions.
* For a command line interface, follow the [Zonemaster::CLI installation] instruction.
* For a JSON-RPC API, see the Zonemaster::Backend [JSON-RPC API] documentation.


## 7. Installation with MariaDB

First follow the installation instructions for the OS in question, and then go
to this section to install MariaDB.

### 7.1. MariaDB (Rocky Linux)

Configure Zonemaster::Backend to use the correct database engine:

```sh
sudo sed -i '/\bengine\b/ s/=.*/= MySQL/' /etc/zonemaster/backend_config.ini
```

> **Note:** See the [backend configuration] documentation for details.

Install, configure and start database engine:

```sh
sudo dnf -y install mariadb-server
sudo systemctl enable mariadb
sudo systemctl start mariadb
```

To create the database and the database user (unless you keep an old database).
Edit the commands first if you want a non-default database name, user name or
password. To be safe, run the commands one by one.

```sh
sudo mysql -e "CREATE DATABASE zonemaster;"
```
```sh
sudo mysql -e "CREATE USER 'zonemaster'@'localhost' IDENTIFIED BY 'zonemaster';"
```
```sh
sudo mysql -e "GRANT ALL ON zonemaster.* TO 'zonemaster'@'localhost';"
```

Update the `/etc/zonemaster/backend_config.ini` file with database name,
username and password if non-default values are used.

Now go back to "[Database configuration](#33-database-configuration-rocky-linux)"
to create the database tables and then continue with the steps after that.


### 7.2. MariaDB (Debian/Ubuntu)

Configure Zonemaster::Backend to use the correct database engine:

```sh
sudo sed -i '/\bengine\b/ s/=.*/= MySQL/' /etc/zonemaster/backend_config.ini
```

> **Note:** See the [backend configuration] documentation for details.

Install the database engine and its dependencies:

```sh
sudo apt install mariadb-server libdbd-mysql-perl
```

To create the database and the database user (unless you keep an old database).
Edit the commands first if you want a non-default database name, user name or
password. To be safe, run the commands one by one.

```sh
sudo mysql -e "CREATE DATABASE zonemaster;"
```
```sh
sudo mysql -e "CREATE USER 'zonemaster'@'localhost' IDENTIFIED BY 'zonemaster';"
```
```sh
sudo mysql -e "GRANT ALL ON zonemaster.* TO 'zonemaster'@'localhost';"
```

Update the `/etc/zonemaster/backend_config.ini` file with database name, username
and password if non-default values are used.

Now go back to "[Database configuration](#43-database-configuration-debianubuntu)"
to create the database tables and then continue with the steps after that.


### 7.3. MySQL (FreeBSD)

> MariaDB is not compatible with Zonemaster on FreeBSD. MySQL is used instead.

Configure Zonemaster::Backend to use the correct database engine:

```sh
sed -i '' '/[[:<:]]engine[[:>:]]/ s/=.*/= MySQL/' /usr/local/etc/zonemaster/backend_config.ini
```
> **Note:** See the [backend configuration] documentation for details.

Install, configure and start database engine (and Perl bindings):

```sh
pkg install mysql57-server p5-DBD-mysql
```

```sh
sysrc mysql_enable="YES"
service mysql-server start
```

Read the current root password for MySQL (unless it has been changed
already).

```sh
cat /root/.mysql_secret
```

Set password for MySQL root (required by MySQL). Use the password from
`/root/.mysql_secret` when prompted for password, and then the new password
when prompted for that.

```sh
/usr/local/bin/mysqladmin -u root -p password '<selected root password>'
```

To create the database and the database user (unless you keep an old database).
Edit the command first if you want a non-default database name, user name or
password. Run the command on one line.  Use the MySQL root password when
prompted.

```sh
mysql -u root -p -e "CREATE DATABASE zonemaster;" -e "CREATE USER 'zonemaster'@'localhost' IDENTIFIED BY 'zonemaster';" -e "GRANT ALL ON zonemaster.* TO 'zonemaster'@'localhost';"
```

Update the `/usr/local/etc/zonemaster/backend_config.ini` file with database
name, username and password if non-default values are used.

Now go back to "[Database configuration](#53-database-configuration-freebsd)"
to create the database tables and then continue with the steps after that.


## 8. Installation with PostgreSQL

First follow the installation instructions for the OS in question, and then go
to this section to install PostgreSQL.

### 8.1. PostgreSQL (Rocky Linux)

Configure Zonemaster::Backend to use the correct database engine:

```sh
sudo sed -i '/\bengine\b/ s/=.*/= PostgreSQL/' /etc/zonemaster/backend_config.ini
```

> **Note:** See the [backend configuration] documentation for details.

Install, configure and start database engine:

```sh
sudo dnf -y install postgresql-server perl-DBD-Pg
sudo postgresql-setup --initdb --unit postgresql
sudo sed -i '/^[^#]/ s/ident$/md5/' /var/lib/pgsql/data/pg_hba.conf
sudo systemctl enable postgresql
sudo systemctl start postgresql
```

To create the database and the database user (unless you keep an old database).
Edit the command first if you want a non-default database name, user name or
password. To be safe run the commands one by one.

```sh
sudo -u postgres psql -c "CREATE USER zonemaster WITH PASSWORD 'zonemaster';"
```
```sh
sudo -u postgres psql -c "CREATE DATABASE zonemaster WITH OWNER 'zonemaster' ENCODING 'UTF8';"
```

> **Note:** You may get error messages from these commands about lack of
> permission to change directory. You can safely ignore those messages.

Update the `/etc/zonemaster/backend_config.ini` file with database name, username
and password if non-default values are used.

Now go back to "[Database configuration](#33-database-configuration-rocky-linux)"
to create the database tables and then continue with the steps after that.


### 8.2. PostgreSQL (Debian/Ubuntu)

Configure Zonemaster::Backend to use the correct database engine:

```sh
sudo sed -i '/\bengine\b/ s/=.*/= PostgreSQL/' /etc/zonemaster/backend_config.ini
```

Install the database engine and Perl bindings:

```sh
sudo apt install postgresql libdbd-pg-perl
```

> **Note:** See the [backend configuration] documentation for details.

To create the database and the database user (unless you keep an old database).
Edit the command first if you want a non-default database name, user name or
password. To be safe run the commands one by one.

```sh
sudo -u postgres psql -c "CREATE USER zonemaster WITH PASSWORD 'zonemaster';"

```
```sh
sudo -u postgres psql -c "CREATE DATABASE zonemaster WITH OWNER 'zonemaster' ENCODING 'UTF8';"

```

Update the `/etc/zonemaster/backend_config.ini` file with database name, username
and password if non-default values are used.

Now go back to "[Database configuration](#43-database-configuration-debianubuntu)"
to create the database tables and then continue with the steps after that.


### 8.3. PostgreSQL (FreeBSD)

Configure Zonemaster::Backend to use the correct database engine:

```sh
sed -i '' '/[[:<:]]engine[[:>:]]/ s/=.*/= PostgreSQL/' /usr/local/etc/zonemaster/backend_config.ini
```
> **Note:** See the [backend configuration] documentation for details.

Install, configure and start database engine and Perl bindings:

```sh
pkg install p5-DBD-Pg
```

The Perl bindings library (`p5-DBD-Pg`) has a dependency to a specific version
of `postgresql-client`. Determine what version was installed:

```sh
pkg info | grep postgresql | grep client
```
If the installed client is not version `13` then adjust the following command to
install `postgresql-server` with the same version as `postgresql-client`
installed.

```sh
pkg install postgresql13-server
```

Enable daemon, initiate and start:

```sh
sysrc postgresql_enable="YES"
service postgresql initdb
service postgresql start
```

To create the database and the database user (unless you keep an old database).
Edit the commands first if you want a non-default database name, user name or
password.

```sh
psql -U postgres -c "CREATE USER zonemaster WITH PASSWORD 'zonemaster';"
psql -U postgres -c "CREATE DATABASE zonemaster WITH OWNER 'zonemaster' ENCODING 'UTF8';"
```

Update the `/usr/local/etc/zonemaster/backend_config.ini` file with database
name, username and password if non-default values are used.

Now go back to "[Database configuration](#53-database-configuration-freebsd)"
to create the database tables and then continue with the steps after that.


## 9. Cleaning up the database

If, at some point, you want to delete all traces of Zonemaster in the database,
you can run the file `cleanup-mysql.sql` or file `cleanup-postgres.sql`
as a database administrator. Commands
for locating and running the file are below. It removes the user and drops the
database (obviously taking all data with it).

> Each script uses default values, you may need to adapt them to your setup.

### 9.1. MariaDB and MySQL

Rocky Linux, Debian and Ubuntu:

```sh
sudo mysql --user=root < `perl -MFile::ShareDir -le 'print File::ShareDir::dist_dir("Zonemaster-Backend")'`/cleanup-mysql.sql
```

FreeBSD (you will get prompted for MySQL password):

```sh
mysql --user=root -p < `perl -MFile::ShareDir -le 'print File::ShareDir::dist_dir("Zonemaster-Backend")'`/cleanup-mysql.sql
```

### 9.2. PostgreSQL

Rocky Linux, Debian and Ubuntu:

```sh
sudo -u postgres psql -f $(perl -MFile::ShareDir=dist_dir -E 'say dist_dir("Zonemaster-Backend")')/cleanup-postgres.sql
```

FreeBSD (as root):

```sh
psql -U postgres -f `perl -MFile::ShareDir -le 'print File::ShareDir::dist_dir("Zonemaster-Backend")'`/cleanup-postgres.sql
```

### 9.3. SQLite

Remove the database file and recreate it following the installation instructions above.

## 10. Optional features

### 10.1 Metrics

Statsd metrics are available, to enable the feature install the additional
`Net::Statsd` module. See the [configuration][Backend configuration] to
configure the receiver.

The list of metrics is available in the [Telemetry document][metrics].

### 10.1.1 Installation on Rocky Linux

```sh
sudo cpanm --notest Net::Statsd
```

### 10.1.2 Installation on Debian / Ubuntu


```sh
sudo apt install libnet-statsd-perl
```

### 10.1.3 Installation on Freebsd

```sh
cpanm --notest Net::Statsd
```

-------

[Backend configuration]:              ../configuration/backend.md
[Declaration of prerequisites]:       prerequisites.md
[JSON-RPC API]:                       ../using/backend/api.md
[Main Zonemaster repository]:         https://github.com/zonemaster/zonemaster/blob/master/README.md
[MariaDB instructions Rocky Linux]:   #71-mariadb-rocky-linux
[MariaDB instructions Debian]:        #72-mariadb-debianubuntu
[MariaDB instructions FreeBSD]:       #73-mysql-freebsd
[metrics]:                            ../using/backend/telemetry.md#metrics
[Post-installation]:                  #6-post-installation
[PostgreSQL instructions Rocky Linux]:#81-postgresql-rocky-linux
[PostgreSQL instructions Debian]:     #82-postgresql-debianubuntu
[PostgreSQL instructions FreeBSD]:    #83-postgresql-freebsd
[Removing database]:                  #9-cleaning-up-the-database
[Upgrade document]:                   ../upgrade/backend.md
[Zonemaster::CLI installation]:       zonemaster-cli.md
[Zonemaster::Engine installation]:    zonemaster-engine.md
[Zonemaster::Engine]:                 https://github.com/zonemaster/zonemaster-engine/blob/master/README.md
[Zonemaster::GUI installation]:       zonemaster-gui.md
[Zonemaster::LDNS]:                   https://github.com/zonemaster/zonemaster-ldns/blob/master/README.md
