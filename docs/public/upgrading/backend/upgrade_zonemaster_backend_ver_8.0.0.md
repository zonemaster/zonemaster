# Upgrade to 8.0.0

On FreeBSD run the following command first to become root:

```sh
su -l
```

## New dependencies

Zonemaster::Backend requires new dependencies. Depending on the used OS, run
the corresponding command.

### Rocky Linux

```sh
sudo dnf install perl-libintl perl-Mojolicious
```

```sh
sudo cpanm Plack::Middleware::ReverseProxy
```

### Debian / Ubuntu

```sh
sudo apt-get install libplack-middleware-reverseproxy-perl libintl-perl libmojolicious-perl
```

#### Specific to Ubuntu

```sh
sudo cpanm JSON::Validator
```

### FreeBSD

```sh
pkg install p5-Plack-Middleware-ReverseProxy p5-Locale-libintl p5-Mojolicious
```


## Changes in the ini file

New sections and properties have been added to the `backend_config.ini` file.
By default the `add_api_user` method is disabled. To enable it, add the
following to your `backend_config.ini` file:

```
[RPCAPI]
enable_add_api_user = yes
```

> See the [Configuration document] for more information.


## Upgrading init scripts

The `zm-rpcapi` (`zm_rpcapi` on FreeBSD) init script has been updated. It needs
to be reinstalled.

### Rocky Linux

```
cd `perl -MFile::ShareDir=dist_dir -E 'say dist_dir("Zonemaster-Backend")'`
sudo install -v -m 755 ./zm-rpcapi.lsb /etc/init.d/zm-rpcapi
```

### Debian / Ubuntu

```
cd `perl -MFile::ShareDir=dist_dir -E 'say dist_dir("Zonemaster-Backend")'`
sudo install -v -m 755 ./zm-rpcapi.lsb /etc/init.d/zm-rpcapi
```

### FreeBSD

```
cd `perl -MFile::ShareDir=dist_dir -E 'say dist_dir("Zonemaster-Backend")'`
install -v -m 755 ./zm_rpcapi-bsd /usr/local/etc/rc.d/zm_rpcapi
```


## Upgrading the database

If your Zonemaster database was created by a Zonemaster-Backend version smaller
than v8.0.0, and not upgraded, use the following instructions.

> Depending on the database size this upgrade can take some time (around
> 30 minutes for a database with 1 million entries)

> You may need to run the command with `sudo`.

### SQLite

Run
```sh
cd `perl -MFile::ShareDir -le 'print File::ShareDir::dist_dir("Zonemaster-Backend")'`
perl patch/patch_sqlite_db_zonemaster_backend_ver_8.0.0.pl
```

### MySQL (or MariaDB)

First update the privileges of the `zonemaster` user:
* Linux
  ```sh
  sudo mysql -e "GRANT ALL ON zonemaster.* TO 'zonemaster'@'localhost';"
  ```
* FreeBSD
  ```sh
  mysql -u root -p -e "GRANT ALL ON zonemaster.* TO 'zonemaster'@'localhost';"
  ```


then run
```sh
cd `perl -MFile::ShareDir -le 'print File::ShareDir::dist_dir("Zonemaster-Backend")'`
perl patch/patch_mysql_db_zonemaster_backend_ver_8.0.0.pl
```

### PostgreSQL

Run
```sh
cd `perl -MFile::ShareDir -le 'print File::ShareDir::dist_dir("Zonemaster-Backend")'`
perl patch/patch_postgresql_db_zonemaster_backend_ver_8.0.0.pl
```

[Configuration document]: ../../configuration/backend.md
