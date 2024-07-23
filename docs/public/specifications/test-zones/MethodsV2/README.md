# Specification of test zones for MethodsV2

This document structure contains test zone specifications for [MethodsV2], which
is not a Test Case module. Instead it is a collection of Method specifications referred
to by the Test Case specifications and implemented by Perl methods used in the
implementations of the Test Cases, respectively.

The purpose of the test zones for [MethodsV2] is to verify that the implementation
of the methods matches the specifications.

Test zone specifications for the following methods are available:

* [Get parent NS IP addresses]
* [Get delegation NS names and IP addresses]
* [Get zone NS names and IP addresses]

Test zones for [Test Case] implementations are not found in this structure.
They are found in the following directories:

* Address-TP (to be created)
* [Basic-TP](../Basic-TP/README.md)
* Connectivity-TP (to be created)
* [Consistency-TP](../Consistency-TP/README.md)
* [DNSSEC-TP](../DNSSEC-TP/README.md)
* Delegation-TP (to be created)
* [Nameserver-TP](../Nameserver-TP/README.md)
* Syntax-TP (to be created)
* [Zone-TP](../Zone-TP/README.md)

Test zones for Perl modules in Zonemaster-Engine are also not found in this
structure. They are found in the following directories (work in prgogress):

* [Engine](../Engine/README.md)


[Get delegation NS names and IP addresses]:        ../../tests/MethodsV2.md#method-get-delegation-ns-names-and-ip-addresses
[Get parent NS IP addresses]:                      ../../tests/MethodsV2.md#method-get-parent-ns-ip-addresses
[Get zone NS names and IP addresses]:              ../../tests/MethodsV2.md#method-get-zone-ns-names-and-ip-addresses
[MethodsV2]:                                       ../../tests/MethodsV2.md 
[Test Case]:                                       ../../tests/README.md
