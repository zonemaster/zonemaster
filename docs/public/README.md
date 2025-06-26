# Public documentation

*Click on [SUMMARY](SUMMARY.md) to view a linked tree structure of the public
documentation.*

<!-- A copy of the text below is found in ../README-for-doc.zonemaster.net.md
and if any update is done here, make sure to update there too. -->

The public documentation is divided into the following main categories:

* [Release information](RELEASE.md) gives release information of latest release.
* [Installation](installation/README.md) contains documents that explain how to
  install the different components of Zonemaster.
* [Upgrading](upgrading/README.md) contains documents that explain how to upgrade
  a Zonemaster installation.
* [Configuration](configuration/README.md) contains documents that explain how a
  Zonemaster installation can be configured.
* [Using](using/README.md) contains user guides to the different components of
  Zonemaster.
* [Specifications](specifications/README.md) contains specifications of the
  Zonemaster test cases, test types and test zones.
* [Development](development/README.md) contains information for developers both
  in and outside the Zonemaster project.
* [License](LICENSE.md) gives the license information for Zonemaster.

## Rendering

Renderings of the public documentation are published to [doc.zonemaster.net] for
every release version since v2023.1. It can be built locally using [mdbook], its
[mdbook-linkcheck] plugin.

1. Get a copy of the source tree by cloning the [repository] or downloading an
archive of one of the [releases]).
2. Change to the `docs/public` directory and build the book.
```
cd docs/public
mdbook build
```
3. To view the content there are a few options:

* Open the index file if your OS has support for it:
```
open book/index.html
```
* Let mdbook serve it on local computer. Run the following command and open
  [localhost:3000] in your browser.
```
mdbook serve
```
* Copy the `book` directory with all files to your laptop and go directly to
  that directory and open `book/index.html`.


[doc.zonemaster.net]: https://doc.zonemaster.net
[localhost:3000]: http://localhost:3000
[releases]: https://github.com/zonemaster/zonemaster/releases
[repository]: https://github.com/zonemaster/zonemaster
[mdbook]:                              https://rust-lang.github.io/mdBook/
[mdbook-linkcheck]:                    https://github.com/Michael-F-Bryan/mdbook-linkcheck
