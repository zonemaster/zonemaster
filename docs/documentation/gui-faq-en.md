Zonemaster
==========

1. [What is Zonemaster?](#what-is-zonemaster)
2. [Who is behind Zonemaster?](#who-is-behind-zonemaster)
3. [How can Zonemaster help me?](#how-can-zonemaster-help-me)
4. [Zonemaster goes "Error"/"Warning" on my domain, what does it
mean?](#zonemaster-goes-errorwarning-on-my-domain-what-does-it-mean)
5. [How can Zonemaster judge what is right and wrong?](#how-can-zonemaster-judge-what-is-right-and-wrong)
6. [Does Zonemaster handle IPv6?](#does-zonemaster-handle-ipv6)
7. [Does Zonemaster handle DNSSEC?](#does-zonemaster-handle-dnssec) 
8. [What makes Zonemaster differ from other DNS zone validating
software?](#what-makes-zonemaster-differ-from-other-dns-zone-validating-software)
9. [Zonemaster and privacy](#zonemaster-and-privacy)
10. [How come I can't test my domain?](#how-come-i-cant-test-my-domain)
11. [What kind of queries does Zonemaster generate?](#what-kind-of-queries-does-zonemaster-generate)
12. [What is an undelegated domain test?](#what-is-an-undelegated-domain-test)
13. [How can I test a reverse zone with Zonemaster?](#how-can-i-test-a-reverse-zone-with-zonemaster)

Zonemaster
----------

#### 1. What is Zonemaster?
Zonemaster is a program that was designed to help people check, measure and
hopefully also understand the workings of the DNS (Domain Name System). 
It consists of three basic modules: 
<ol>
 <li> Engine (a test framework that supports all functionality to perform DNS
   tests)</li>
 <li> The CLI interface and </li>
 <li> The web interface </li>
</ol>
When a domain (such as "zonemaster.net") is submitted to Zonemaster interfaces (CLI or
Web) it will investigate the domain’s general health by traversing the DNS from root 
(.) to the TLD (Top Level Domain, like .net) to eventually the nameserver(s) that holds 
the information about the specified domain (zonemaster.net). The different sanity checks 
conducted by the zonemaster tool is documented in the [Test Requirements
document](https://github.com/dotse/zonemaster/blob/master/docs/requirements/TestRequirements.md)

#### 2. Who is behind Zonemaster?
Zonemaster is a joint project between .SE (registry operator of .se and .nu TLD) and Afnic 
(registry operator of .fr TLD and those of the overseas territories of France). 

#### 3. How can Zonemaster help me?  
The Zonemaster tool is oriented towards two types of population: 
<ol>
 <li> People who are knowledgable about the DNS protocol and </li>
 <li> People who just want to know whether the domain's owned/used by them did
not have any issues </li>
</ol>
The second category population described above should contact the first
category population once they have the results other than in green for any
debugging of their DNS zones.

#### 4. Zonemaster goes "Error"/"Warning" on my domain, what does it mean?
Of course, this depends on what kind of test failed for your zone. In most cases
you can press the actual error/warning-message and in so doing get more detailed
information about what kind of problem that was found.

#### 5. How can Zonemaster judge what is right and wrong?  
There is no final judgement of the health of a domain that can be bestowed by
anyone. The people behind Zonemaster do not claim that the tool is correct in 
every aspect. Sometimes opinions differ, especially between countries, but sometimes 
also locally. We've done our very best to create a default policy for found errors within 
this project. Hopefully this have made sure of a good compromise between what is an actual 
potentially dangerous error and what could be merely seen as a notice or warning.
The added advantage of the tool is that one can add a policy file suited to
one's necessity to a specified directory and ask the tool to use that policy
file for running the tests.
But as with all things as evolving as DNS the situation is most likely
changing, what is a notice today could be an error tomorrow. If you really think
we've made a mistake in our judgement please don't hesitate to drop us an email
at zonemaster-devel@lists.iis.se with a link to your test and an explanation why you think it
shows something that you consider incorrect. ( If you don't know how to find the
link to your test, check the "How can Zonemaster help me"-part of this FAQ ).

####6. Does Zonemaster handle IPv6?
Yes, it does. All tests run over IPv4 will also be run over IPv6 if ZoneMsater
is configured to do so.

####7. Does Zonemaster handle DNSSEC?
Yes, if DNSSEC is available on a domain that is sent to Zonemaster, it will be
checked automatically.

####8. What makes Zonemaster differ from other DNS zone validating software?
First of all Zonemaster saves all history from earlier tests based on the tested
domain, which means you can go back to a test you did a week ago and compare it
to the test you ran a moment ago.
Zonemaster will also try and explain the error/warning to you in a good way,
although these messages can be difficult to understand for a non-technician. 
There's an "advanced" tab for technicians who might want to use Zonemaster
without the "basic" view. 
Zonemaster could be used to test undelegated domains [More about undelegated
domain in Question 12].
Lastly, this open source version of Zonemaster was built using modular code
which, basically, means you can use parts of it in your systems, if you'd want
to. It's quite rare that you'd want a complete program just to check for example
redelegations.

####9. Zonemaster and privacy
Since Zonemaster is open to everyone it is possible for anyone to check your
domain and also see history from previous tests, however there is no way to tell
who has run a specific test since nothing is logged except the time of the test.

####10. How come I can't test my domain?
If we skip the situation where the domain doesn't exist, as in you input a
non-existing domain to Zonemaster, there are 2 other possibilites: 
<ol>
 <li>To protect the engine from multiple identical inputs, that is the same IP
   checking the same zone several times, there is a delay of 5 minutes between
identical subsequent tests. Which practically means that you can only test the
same domain once every 5 minutes, if you try and test it again within 5 minutes
the last results will be displayed instead </li>
 <li> Because Zonemaster was made to check domains (like zonemaster.net) and not hostnames
   in a domain (like www.zonemaster.net) the Zonemaster web interface will do a pre-check of
your domain before it sends it on to the engine for testing </li>
</ol>
This shouldn't effect the great majority of domains out there but it CAN do so, because if the
webpage decides a domain doesn't exist the check wont run. So far the only time
we've seen this is when a domains' nameservers all lie within the domain that's
being tested and these are very broken. We need to fix this, and please do
report if you cannot check your domain so that we can see if anything else is
wrong. This control will be improved, that's a promise.

####11. What kind of queries does Zonemaster generate?
This question is very hard to answer since Zonemaster will generate different
queries depending on how your name servers answer. The easiest way to get a full
view of what queries and results are generated is to run the
CLI interface (In order to run the CLI interface you need to download the
complete package and install it). This will result in quite thorough information on what
is happening. However the output from this CLI-tool is quite heavily technical
so unless you're into bits and bytes you might want to skip this step.

####12. What is an undelegated domain test?
An undelegated domain test is a test performed on a domain that may, or may not,
be fully published in the DNS. This can be quite useful if one is going to move
one's domain from one registrar to another. 
For example, if you want to move your zone example.com from the nameserver
"ns.example.com" to the nameserver "ns.example.org". In this scenario one could perform 
an undelegated domain test providing the zone (example.com) and the nameserver you are moving to
(ns.example.org) BEFORE you move your domain. 
When the results of the test are colour coded in green one can be fairly certain
that the domain's new location is supposed to be replying to queries . However there 
might still be other problems in the zone data itself that this test is unaware of.

####13. How can I test a "reverse" zone with Zonemaster?
Zonemaster can be used to check various technical points before installing a
zone. It can also be used to check a reverse zone. To do this with an IPv4
network address, you need to know the network address of your system, which
almost always ends with a 0. You need to remove the 0 at the end of address, to
reverse the numbers in your IP address and add a suffix: in-addr.arpa. This
gives you your "reverse zone".
To test the reverse zone of an IPv6 network, just as for IPv4, take the network
address, reverse the bytes and add the suffix ip6.arpa.
<ol>
<li> *Example 1* - Reverse for an IPv4 network: network address of the installation:
194.98.30.0. The corresponding reverse zone is: 30.98.194.in-addr.arpa. This
reverse zone can be tested by the Zonemaster tool to check its operation </li>
<li> *Example 2* - Reverse for an IPv6 network: network address of the installation:
2001:660:3003::/24. The corresponding reverse zone is:
3.0.0.3.0.6.6.0.1.0.0.2.ip6.arpa. This reverse zone can be tested by the
Zonemaster tool to check its operation </li>
</ol>


