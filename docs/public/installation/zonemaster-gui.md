# Installation: Zonemaster-GUI

## Prerequisites

Before installing Zonemaster-GUI, you should [install Zonemaster::Engine
][Zonemaster::Engine installation] and [Zonemaster::Backend][Zonemaster::Backend
installation].

Prerequisite for FreeBSD is that the package system is updated and activated,
see FreeBSD section of [install Zonemaster::Engine][Zonemaster::Engine
installation].

## Upgrading or installation of custom built Zonemaster-GUI

### Upgrading

If this installation is an upgrade or reinstallation of Zonemaster-GUI and if
changes were made to the shipped configuration files
(`/var/www/html/zonemaster-web-gui/dist/config.json` and the `zonemaster.conf`
Apache configuration file), make sure to back up these files beforehand.

You should also consider saving the old version under a new path instead of
just removing it.

Else upgrading is as simple as removing the old version and installing the new
version in the same way as a new installation.

### Installing a custom built Zonemaster-GUI

If you have done a custom build of Zonemaster-GUI following the instructions in
[building GUI] you will have a zip file that you will use instead of downloading
it from GitHub. Else you can follow the instructions below.

## Installation

This instruction covers the following operating systems:

 1. [Rocky Linux](#1-rocky-linux)
 2. [Debian and Ubuntu](#2-debian-and-ubuntu)
 3. [FreeBSD](#3-freebsd)


### 1. Rocky Linux

#### Install Apache

```sh
sudo dnf update
sudo dnf -y install httpd unzip
```

#### Remove old Zonemaster-GUI

If an old version is installed, remove it first:
```sh
sudo rm -r /var/www/html/zonemaster-web-gui
```

#### Install Zonemaster-GUI

```sh
curl -L -O https://github.com/zonemaster/zonemaster-gui/releases/download/v5.0.0/zonemaster_web_gui_v5.0.0.zip
sudo install -vd /var/www/html/zonemaster-web-gui
sudo install -vd /var/log/zonemaster
sudo unzip -d /var/www/html/zonemaster-web-gui zonemaster_web_gui_v5.0.0.zip
rm -f zonemaster_web_gui_v5.0.0.zip
```

#### Configure Apache site

```sh
sudo chcon -R -t httpd_sys_content_t /var/www/html/zonemaster-web-gui/dist
sudo chcon -R -t httpd_sys_rw_content_t /var/log/zonemaster
sudo setsebool -P httpd_can_network_connect=1
sudo install -v /var/www/html/zonemaster-web-gui/zonemaster.conf-example /etc/httpd/conf.d/zonemaster.conf
```

Optionally update the zonemaster.conf.
E.g. if Zonemaster-Backend RPCAPI runs on another server or on another port (not
port 5000), update ProxyPass and ProxyPassReserve.
Or if you want provide your own settings for ServerName, ServerAlias and ServerAdmin.

```sh
sudoedit /etc/httpd/conf.d/zonemaster.conf
```

#### Start Apache and allow remote access

```sh
sudo systemctl enable httpd
sudo systemctl start httpd
sudo firewall-cmd --add-service http --permanent
sudo firewall-cmd --reload
```

### 2. Debian and Ubuntu

#### Install Apache

```sh
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y apache2 unzip
```

#### Basic Apache configuration

```sh
sudo a2enmod proxy proxy_http rewrite
sudo a2dissite 000-default
sudo systemctl enable apache2
sudo systemctl restart apache2
```

#### Remove old Zonemaster-GUI

If an old version is installed, remove it first:
```sh
sudo rm -r /var/www/html/zonemaster-web-gui
```

#### Install Zonemaster-GUI

```sh
wget https://github.com/zonemaster/zonemaster-gui/releases/download/v5.0.0/zonemaster_web_gui_v5.0.0.zip -O zonemaster_web_gui_v5.0.0.zip
sudo unzip -d /var/www/html/zonemaster-web-gui zonemaster_web_gui_v5.0.0.zip
sudo install -vd /var/log/zonemaster
sudo install -v /var/www/html/zonemaster-web-gui/zonemaster.conf-example /etc/apache2/sites-available/zonemaster.conf
rm -f zonemaster_web_gui_v5.0.0.zip
```

#### Configure Zonemaster-GUI

```sh
sudo a2ensite zonemaster #Activate the website
```
Then update the zonemaster.conf file with your own ServerName, ServerAlias and ServerAdmin.
For testing on a local machine, you can edit zonemaster.conf and change the "*:80" part of
to the host's IP or using localhost as ServerName if that is appropriate.


#### Reload Apache

```sh
sudo systemctl reload apache2
```

### 3. FreeBSD

For all commands below become root:

```sh
su -l
```

#### Update list of package repositories
Create the file `/usr/local/etc/pkg/repos/FreeBSD.conf` with the following
content, unless it is already updated:

```
FreeBSD: {
url: "pkg+http://pkg.FreeBSD.org/${ABI}/latest",
}
```

#### Check or activate the package system

Run the following command, and accept the installation of the `pkg` package
if suggested.

```
pkg info -E pkg
```

Update local package repository:

```
pkg update -f
```

#### Install Apache and its dependencies

See [tutorial on Apache on FreeBSD].

```sh
pkg install apache24
```

#### Enable Apache as a service

```sh
sysrc apache24_enable=yes
```

#### Enable three apache modules in Apache configuration file

```sh
perl -pi -e 's/^#(LoadModule (proxy_module|proxy_http_module|rewrite_module) libexec)/$1/' /usr/local/etc/apache24/httpd.conf
```

#### Start Apache

```sh
service apache24 start
```

If you want Apache to listen to an external IP address and it says that it only
listens to localhost (127.0.0.1/::1) then you have to set `ServerName` in
`/usr/local/etc/apache24/httpd.conf`, e.g. `ServerName 192.0.2.246:80`, and
restart Apache.

#### Remove old Zonemaster-GUI

If an old version is installed, remove it first:
```sh
rm -r /var/www/html/zonemaster-web-gui
```

#### Install Zonemaster-GUI

```sh
fetch https://github.com/zonemaster/zonemaster-gui/releases/download/v5.0.0/zonemaster_web_gui_v5.0.0.zip
mkdir -p /var/www/html/zonemaster-web-gui
mkdir -p /var/log/zonemaster
unzip -d /var/www/html/zonemaster-web-gui zonemaster_web_gui_v5.0.0.zip
rm zonemaster_web_gui_v5.0.0.zip
```

#### Basic Apache configuration

```sh
install /var/www/html/zonemaster-web-gui/zonemaster.conf-example /usr/local/etc/apache24/Includes/zonemaster.conf
```
Then update `/usr/local/etc/apache24/Includes/zonemaster.conf` with your own ServerAdmin.
If Zonemaster-Backend RPCAPI runs on another server or on another port (not port 5000)
then update the URL for the `ProxyPass` and `ProxyPassReverse` keys in the same
file so that it points to correct IP address or server name and correct port.


#### Restart Apache
```sh
service apache24 restart
```


## Post-installation sanity check

Make sure Zonemaster-GUI is properly installed.

1. Point your browser at `http://localhost/` (or the address of the server where
   you installed Zonemaster-GUI).

2. Verify that the Zonemaster-GUI is shown with the text "Program versions" in
   its page footer.

3. Verify that when you mouse over this text the versions of the following
   Zonemaster components are shown: Zonemaster-LDNS, Zonemaster-Engine,
   Zonemaster-Backend and Zonemaster-GUI.

## What to do next?

 * For a JSON-RPC API, see the Zonemaster::Backend [JSON-RPC API] documentation.
 * For a command line interface, follow the [Zonemaster::CLI installation] instruction.
 * For a Perl API, see the [Zonemaster::Engine API] documentation.
 * For HTTPS, see [Let's Encrypt / Certbot] or providers of public certificates.

## Configuring and customizing GUI

It is possible to change the behavior and visual aspects of GUI. See
section [configuring GUI] for how to customize the GUI.


[building GUI]:                     ../configuration/gui/building-custom-gui.md
[JSON-RPC API]:                     ../using/backend/rpcapi-reference.md
[Let's Encrypt / Certbot]:          https://certbot.eff.org/instructions
[Main Zonemaster repository]:       https://github.com/zonemaster/zonemaster/blob/master/README.md
[Tutorial on Apache on FreeBSD]:    https://www.digitalocean.com/community/tutorials/how-to-install-an-apache-mysql-and-php-famp-stack-on-freebsd-10-1
[Zonemaster::Backend installation]: zonemaster-backend.md
[Zonemaster::Backend]:              https://github.com/zonemaster/zonemaster-backend/blob/master/README.md
[Zonemaster::CLI installation]:     zonemaster-cli.md
[Zonemaster::Engine API]:           https://metacpan.org/dist/Zonemaster-Engine/view/lib/Zonemaster/Engine/Overview.pod
[Zonemaster::Engine installation]:  zonemaster-engine.md
[Zonemaster::Engine]:               https://github.com/zonemaster/zonemaster-engine/blob/master/README.md
[Zonemaster::LDNS]:                 https://github.com/zonemaster/zonemaster-ldns/blob/master/README.md
[Configuring GUI]:                  ../configuration/gui/README.md
