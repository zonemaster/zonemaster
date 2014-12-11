Zonemaster
==========

1. [What is Zonemaster?](#q1)
2. [Who is behind Zonemaster?](#q2)
3. [How can Zonemaster help me?](#q3)
4. [Zonemaster goes "Error"/"Warning" on my domain, what does it mean?](#q4)
5. [How can Zonemaster judge what is right and wrong?](#q5)
6. [Does Zonemaster handle IPv6?](#q6)
7. [Does Zonemaster handle DNSSEC?](#q7) 
8. [What makes Zonemaster differ from other DNS zone validating software?](#q8)
9. [Zonemaster and privacy](#q9)
10. [How come I can't test my domain?](#q10)
11. [What kind of queries does Zonemaster generate?](#q11)
12. [What is an undelegated domain test?](#undelegated)
13. [How can I test a reverse zone with Zonemaster?](#q13)

Zonemaster
----------
#### 1. What is Zonemaster? <a name="q1"></a>
Zonemaster is a program that was designed to help people check, measure and
hopefully also understand the workings of the DNS (Domain Name System). 
It consists of three basic modules: 
  - Engine (a test framework that supports all functionality to perform DNS tests)
  - The CLI interface and 
  - The web interface 

When a domain (such as "zonemaster.net") is submitted to Zonemaster interfaces (CLI or
Web) it will investigate the domain’s general health by traversing the DNS from root 
(.) to the TLD (Top Level Domain, like .net) to eventually the nameserver(s) that holds 
the information about the specified domain (zonemaster.net). The different sanity checks 
conducted by the zonemaster tool is documented in the [Test Requirements
document](https://github.com/dotse/zonemaster/blob/master/docs/requirements/TestRequirements.md)

#### 2. Who is behind Zonemaster? <a name="q2"></a>
Zonemaster is a joint project between .SE (registry operator of .se and .nu TLD) and Afnic 
(registry operator of .fr TLD and those of the overseas territories of France). 

#### 3. How can Zonemaster help me? <a name="q3"></a>
The Zonemaster tool is oriented towards two types of population: 

  - People who are knowledgable about the DNS protocol and 
  - People who just want to know whether the domain's owned/used by them did not have any issues

The second category population described above should contact the first
category population once they have the results other than in green for any
debugging of their DNS zones.

#### 4. Zonemaster goes "Error"/"Warning" on my domain, what does it mean? <a name="q4"></a>
Of course, this depends on what kind of test failed for your zone. In most cases
you can press the actual error/warning-message and in so doing get more detailed
information about what kind of problem that was found.

#### 5. How can Zonemaster judge what is right and wrong? <a name="q5"></a>
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

####6. Does Zonemaster handle IPv6? <a name="q6"></a>
Yes, it does. All tests run over IPv4 will also be run over IPv6 if ZoneMsater
is configured to do so.

####7. Does Zonemaster handle DNSSEC? <a name="q7"></a>
Yes, if DNSSEC is available on a domain that is sent to Zonemaster, it will be
checked automatically.

####8. What makes Zonemaster differ from other DNS zone validating software? <a name="q8"></a>
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

####9. Zonemaster and privacy <a name="q9"></a>
Since Zonemaster is open to everyone it is possible for anyone to check your
domain and also see history from previous tests, however there is no way to tell
who has run a specific test since nothing is logged except the time of the test.

####10. How come I can't test my domain? <a name="q10"></a>
If we skip the situation where the domain doesn't exist, as in you input a
non-existing domain to Zonemaster, there are 2 other possibilites: 
  - To protect the engine from multiple identical inputs, that is the same IP
    checking the same zone several times, there is a delay of 5 minutes between
    identical subsequent tests. Which practically means that you can only test the
    same domain once every 5 minutes, if you try and test it again within 5 minutes
    the last results will be displayed instead </li>
  - Because Zonemaster was made to check domains (like zonemaster.net) and not hostnames
    in a domain (like www.zonemaster.net) the Zonemaster web interface will do a pre-check of
    your domain before it sends it on to the engine for testing 

This shouldn't effect the great majority of domains out there but it CAN do so, because if the
webpage decides a domain doesn't exist the check wont run. So far the only time
we've seen this is when a domains' nameservers all lie within the domain that's
being tested and these are very broken. We need to fix this, and please do
report if you cannot check your domain so that we can see if anything else is
wrong. This control will be improved, that's a promise.

####11. What kind of queries does Zonemaster generate? <a name="q11"></a>
This question is very hard to answer since Zonemaster will generate different
queries depending on how your name servers answer. The easiest way to get a full
view of what queries and results are generated is to run the
CLI interface (In order to run the CLI interface you need to download the
complete package and install it). This will result in quite thorough information on what
is happening. However the output from this CLI-tool is quite heavily technical
so unless you're into bits and bytes you might want to skip this step.

####12. What is an undelegated domain test? <a name="undelegated"></a>
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

####13. How can I test a "reverse" zone with Zonemaster? <a name="q13"></a>
To check a reverse zone with zonemaster one need to first know the network
address (i.e. IPv4 or IPv6) of your system. Then find the subnet mask. Then
follow the procedure explained below for IPv4 and IPv6

For IPv4 addresses:
  - If the subnet mask is /24 and the network address is for example is
    "1.2.3.0", remove the last digit (here '0') and revese the numbers and add a suffix :
    "in-addr.arpa". The resulting is the "reverse zone" which is
    "3.2.1.in-addr.arpa".
  - If the subnet mask is smaller that /24 such as /28, and the network address
    for example is "1.2.3.4", the reverse zone is obtained by reversing the IP
    address as it is and add the suffix such as "4.3.2.1.in-addr.arpa"

The reverse zone can then be introduced to the zonemaster tool for verification

For IPv6 addresses:
  - Reverse the IPV6 address and add the suffix "ip6.arpa" 
  - One trick to find the reverse IPv6 address is to use the tool "dig"
  - for example "dig -x 2001:660:3003:2::4:1" results in a response
  - Copy the "authority section" from the response which is the reverse zone - "6.0.1.0.0.2.ip6.arpa"

The reverse zone can then be introduced to the Zonemaster tool for verification



