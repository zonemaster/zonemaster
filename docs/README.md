# Documentation

In this repository, most documentation of Zonemaster is found.

* [public] - In the public documentation you will find installation instructions,
  user guides for each Zonemaster component and other documentation.
* [internal] - In the internal tree you can find documentation regarding the
  design and requirements of the Zonemaster implementation.
* [Contact and Mailing lists] - Information on forum and mailing lists for
  Zonemaster.

The [public] documentation can be built using [mdbook], its [mdbook-linkcheck]
plugin and the following commands:

```
cd docs/public
mdbook build
open book/index.html
```

[Contact and Mailing lists]:           contact-and-mailing-lists.md
[Internal]:                            ./internal
[mdbook]:                              https://rust-lang.github.io/mdBook/
[mdbook-linkcheck]:                    https://github.com/Michael-F-Bryan/mdbook-linkcheck
[Public]:                              ./public/README.md
