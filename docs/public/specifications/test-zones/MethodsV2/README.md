# Specification of test zones for MethodsV2

This document structure contains test zone specifications for [MethodsV2], which
is not a Test Case module. Instead it is a collection of Method specifications referred
to by the Test Case specifications and implemented by Perl methods used in the
implementations of the Test Cases, respectively.

The purpose of the test zones for [MethodsV2] is to verify that the implementation
of the methods matches the specifications.

Test zone specifications for the following methods are available:

[Get parent NS IP addresses](get-parent-ns-ip-addresses.md)
[Get delegation NS names and IP addresses]
[Get delegation NS names]
[Get delegation NS IP addresses]
[Get zone NS names]
[Get zone NS names and IP addresses]
[Get zone NS IP addresses]
[Get delegation]
[Get in-bailiwick address records in zone]
[Get out-of-bailiwick ip addresses (Internal)

Test zones for [Test Case] implementations are not found in this structure.
They are found in the following directories (work in progress):

* [Address-TP](../Address-TP/README.md)
* [Basic-TP](../Basic-TP/README.md)
* [Connectivity-TP](../Connectivity-TP/README.md)
* [Consistency-TP](../Consistency-TP/README.md)
* [DNSSEC-TP](../DNSSEC-TP/README.md)
* [Delegation-TP](../Delegation-TP/README.md)
* [Nameserver-TP](../Nameserver-TP/README.md)
* [Syntax-TP](../Syntax-TP/README.md)
* [Zone-TP](../Zone-TP/README.md)

Test zones for Perl modules in Zonemaster-Engine are also not found in this
structure. They are found in the following directories (work in prgogress):

* [Engine](../Engine/README.md)


[Test Case]:                                       ../../tests/README.md 
[MethodsV2]:                                       ../../tests/MethodsV2.md 

