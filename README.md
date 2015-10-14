![Zonemaster](docs/images/zonemaster_logo_black.png)
==========

### Background

DNSCheck from IIS and Zonecheck from AFNIC are two different software
packages that do DNS validation of the quality of a DNS
delegation. AFNIC and IIS decided to develop a new DNS validation tool from the
scratch under the name "Zonemaster". 

### Purpose

The Zonemaster implementation intends to be a major
rewrite of the existing DNS validation tools developed by AFNIC (Zonecheck and
IIS (DNSCheck), and implement the best parts of both. 

The ambition of the Zonemaster project is to develop and maintain an open source
DNS validation tool, offering better performance than the existing tools and
provide extensive documentation which could be re-used by similar projects in
the future. 

### Prerequisites

There are no prerequisites for this repository.

### Installation 

This repository does not need any installation.

### Configuration 

This repository does not need any configuration.

### Documentation

The repository you are looking at is the main project repository. In this
repository, documentation regarding the [design](docs/design),
[requirements](docs/requirements) and [specifications](docs/specifications)
for the zonemaster implementation are available.

Also, in this repository, you can find a brief [user guide](docs/using.md) and
[installation guide](docs/installation.md), where links are provided on how to
install the different components of the Zonemaster software.

### Repositories

The Zonemaaster project has four different repositories.
 
 * [zonemaster-engine](https://github.com/dotse/zonemaster-engine) - which
   contains the test framework. 
 * [zonemaster-cli](https://github.com/dotse/zonemaster-cli) - a Command Line
   Interface for the engine. 
 * [zonemaster-backend](https://github.com/dotse/zonemaster-backend) - which
   interfaces between the GUI and an API with the engine.
 * [zonemaster-gui](https://github.com/dotse/zonemaster-gui) - A graphical user
   interface for the engine.

In order to install and run the different components, have a look at the
installation documentation under each of the repositories below:

### Participation

The core development team are people from IIS and Afnic. However, you
can submit code by forking this repository and create pull requests.

You can follow the project in these two mailinglists:

 * [zonemaster-users](http://lists.iis.se/cgi-bin/mailman/listinfo/zonemaster-users)
 * [zonemaster-devel](http://lists.iis.se/cgi-bin/mailman/listinfo/zonemaster-devel)

### Contact or Bug reporting 

For any contacts or bug reporting, please send a mail to
"contact@zonemaster.net". 
