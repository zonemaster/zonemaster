Zonemaster
==========

1.	What is ZoneMaster?
2. 	Who is behind ZoneMaster?
3. 	Why a new tool instead of modifying existing ones?
4.	What is DNS?
5.	How does ZoneMaster work?
6.	How can ZoneMaster help me?
7.	ZoneMaster goes "Error"/"Warning" on my domain, what does it mean?
8.	How can ZoneMaster judge what is right and wrong?
9.	Does ZoneMaster handle IPv6?
10.	Does ZoneMaster handle DNSSEC? 
11.	What makes ZoneMaster differ from other zone controlling software?
12.	Will ZoneMaster work for my non-.se/.fr-domain?
13.	DNSCheck and privacy
14.	How come I can't test my domain?
15.	What kind of queries does DNSCheck generate?
16.	What is an undelegated domain test?
17. 	How can I test a "reverse" zone with ZoneMaster?

ZoneMaster
----------

**1. What is ZoneMaster?**  

ZoneMaster is a program that was designed to help people check, measure and
hopefully also understand the workings of the DNS (Domain Name System). When a
domain (aka zone) is submitted to ZoneMaster it will investigate the domain’s
general health by traversing the DNS from root (.) to the TLD (Top Level Domain,
like .SE) to eventually the nameserver(s) that holds the information about the
specified domain (like iis.se). Some other sanity checks, for example measuring
host connectivity, validity of IP-addresses and control of DNSSEC signatures
will also be performed.

**2. Who is behind ZoneMaster?**

ZoneMaster is a joint project between .SE (registry operator of .se and .nu TLD) and Afnic (registry
operator of .fr TLD and those of the overseas territories of France). 

**3. Why a new tool instead of modifying existing ones?**

Similar to Zonemaster, both Afnic and .SE have already their respective delegation
checking tools - ZoneCheck (http://zonecheck.fr) and DNSCheck
(http://dnscheck.iis.se), which has been in use for a number of years. The
decision to create a new tool is to incorporate all the good functionalities
from both the existing tools and outperform them in speed and resource use.

The first part of the ZoneMaster project involved a thourough investigation of
the tools we had. During this we asked ourselves what the pros and cons would be
to either improve or redesign one of the existing tools versus building one from
scratch. After long discussions we came to the conclusion that neither tool
could be improved as much as we wanted and still retain much of the modularity
and reusability we wanted so we decided to make something better than either
with a much more transparent design. 

**4. What is DNS?**  

The Domain Name System (DNS in short) is what could be called the "phone book"
of the Internet. It keeps track of the mapping of, for example, a human-readable
website name (like www.iis.se) to the slightly more arcane form of an IP-address
that the computer needs to initiate communication (in this case 212.247.7.229). 
Besides browsing the Internet with your web browser using website names instead
of IP-addresses the DNS also makes sure your emails find their way to the right
recipient. In short, a stable DNS is vital for most companies to maintain a
working and efficient operation.

**5. How does ZoneMaster work?**  

If you want the technical information about how ZoneMaster operates, you are
advised to check the [specification of the tests](https://github.com/dotse/zonemaster/tree/master/docs/specifications/tests).
If you want a less technical answer you should check the first FAQ-question: “What
is ZoneMaster”.

**6. How can ZoneMaster help me?**  

ZoneMaster was made for technicians or at least people who are interested to
learn more about how the DNS operates. If you merely want to show whoever is in
charge of your domain (the tech-c or technical staff at your name server
provider) that there in fact is a problem with your domain you can use the link
that appears on the bottom of the page after each test. So if you have run a
test and want to show someone the result of that specific test you can just copy
the link at the bottom of the page that displays your test results. The link
below, for example, points at a previous test on "iis.se":

 http://zonemaster.net/test/200 [Verify Link later]

**7. ZoneMaster goes "Error"/"Warning" on my domain, what does it mean?**  

Of course, this depends on what kind of test failed for your zone. In most cases
you can press the actual error/warning-message and in so doing get more detailed
information about what kind of problem that was found.

As an example if we test the domain "iis.se" and recieve an error titled "Name
server ns.nic.se (212.247.7.228) does not answer queries over UDP". What does
this mean? After we click this message more detailed information become visible.
More specific this: "The name server failed to answer queries sent over UDP.
This is probably due to the name server not correctly set up or due to
misconfigured filtering in a firewall." Luckily this was just an example, that
error would basically mean the name server is down so it's not the most harmless
error around.

**8. How can DNSCheck judge what is right and wrong?**  

There is no final judgement of the health of a domain that can be bestowed by
anyone. This is very important. .SE, Afnic and the people behind ZoneMaster do
not claim that ZoneMaster is correct in every aspect. Sometimes opinions differ,
especially between countries, but sometimes also locally. We've done our very
best to create a default policy for found errors within this project. Hopefully
this have made sure of a good compromise between what is an actual potentially
dangerous error and what could be merely seen as a notice or warning.

But as with all things as evolving as DNS the situation is most likely
changing, what is a notice today could be an error tomorrow. If you really think
we've made a mistake in our judgement please don't hesitate to drop us an email
at zonemaster-devel@lists.iis.se with a link to your test and an explanation why you think it
shows something that you consider incorrect. ( If you don't know how to find the
link to your test, check the "How can ZoneMaster help me"-part of this FAQ ).

**9. Does ZoneMaster handle IPv6?**  

Yes, it does. All tests run over IPv4 will also be run over IPv6 if ZoneMsater
is configured to do so.

**10. Does ZoneMaster handle DNSSEC?**  

Yes, if DNSSEC is available on a domain that is sent to ZoneMaster it will be
checked automatically.

**11. What makes ZoneMaster differ from other zone controlling software?**  

First of all ZoneMaster saves all history from earlier tests based on the tested
domain, which means you can go back to a test you did a week ago and compare it
to the test you ran a moment ago.

ZoneMaster will also try and explain the error/warning to you in a good way,
although these messages can be difficult to understand for a non-technician. 

There's an "advanced" tab for technicians who might want to use ZoneMaster
without the "basic" view.

Lastly, this open source version of ZoneMaster was built using modular code
which, basically, means you can use parts of it in your systems, if you'd want
to. It's quite rare that you'd want a complete program just to check for example
redelegations.

**12.	Will ZoneMaster work for my non-.se/.fr-domain?**  

Yes. All the checks that occur for .SE/.FR-domains will be used on your zone as
well. 

**13. ZoneMaster and privacy**  

Since ZoneMaster is open to everyone it is possible for anyone to check your
domain and also see history from previous tests, however there is no way to tell
who has run a specific test since nothing is logged except the time of the test.

**14. How come I can't test my domain?**  

If we skip the situation where the domain doesn't exist, as in you input a
non-existing domain to ZoneMaster, there are 2 other possibilites: 

 - To protect the engine from multiple identical inputs, that is the same IP
   checking the same zone several times, there is a delay of 5 minutes between
identical subsequent tests. Which practically means that you can only test the
same domain once every 5 minutes, if you try and test it again within 5 minutes
the last results will be displayed instead.

 - Because ZoneMaster was made to check domains (like iis.se) and not hostnames
   in a domain (like www.iis.se) the ZoneMaster webpage will do a pre-check of
your domain before it sends it on to the engine for testing. This shouldn't
effect the great majority of domains out there but it CAN do so, because if the
webpage decides a domain doesn't exist the check wont run. So far the only time
we've seen this is when a domains' nameservers all lie within the domain that's
being tested and these are very broken. We need to fix this, and please do
report if you cannot check your domain so that we can see if anything else is
wrong. This control will be improved, that's a promise.

**15. What kind of queries does ZoneMaster generate?**  

This question is very hard to answer since ZoneMaster will generate different
queries depending on how your name servers answer. The easiest way to get a full
view of what queries and results are generated is to run the
"zonemaster-cli"-command. This will result in quite thorough information on what
is happening. However the output from this CLI-tool is quite heavily technical
so unless you're into bits and bytes you might want to skip this step. :)

**16. What is an undelegated domain test?**  

An undelegated domain test is a test performed on a domain that may, or may not,
be fully published in the DNS. This can be quite useful if you are going to move
your domain from one registrar to another. For example, let us say that you want
to move your zone example.se from the nameserver "ns.nic.se" to the nameserver
"ns.iis.se". In this scenario you could perform an undelegated domain test
providing the zone (example.se) and the nameserver you are moving to (ns.iis.se)
BEFORE you move your domain. When this test shows a green light you can be
fairly certain that the new location for your domain at least knows that it is
supposed to be replying to queries about your domain. However there might still
be other problems in the zone data itself that this test is unaware of.

**17. How can I test a "reverse" zone with ZoneMaster?**

ZoneMaster can be used to check various technical points before installing a
zone. It can also be used to check a reverse zone. To do this with an IPv4
network address, you need to know the network address of your system, which
almost always ends with a 0. You need to remove the 0 at the end of address, to
reverse the numbers in your IP address and add a suffix: in-addr.arpa. This
gives you your "reverse zone".
To test the reverse zone of an IPv6 network, just as for IPv4, take the network
address, reverse the bytes and add the suffix ip6.arpa.

 *Example 1* - Reverse for an IPv4 network: network address of the installation:
194.98.30.0. The corresponding reverse zone is: 30.98.194.in-addr.arpa. This
reverse zone can be tested by the ZoneMaster tool to check its operation.

 *Example 2* - Reverse for an IPv6 network: network address of the installation:
2001:660:3003::/24. The corresponding reverse zone is:
3.0.0.3.0.6.6.0.1.0.0.2.ip6.arpa. This reverse zone can be tested by the
ZoneMaster tool to check its operation.


