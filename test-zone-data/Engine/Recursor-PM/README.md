# Recursor.pm

[This directory](.), i.e. the same directory as this README file, holds
zone files and `coredns` configuration files for scenarios for the
CNAME function in [Recursor.pm].

* GOOD-CNAME-1
* GOOD-CNAME-2
* GOOD-CNAME-CHAIN
* GOOD-CNAME-OUT-OF-ZONE
* NXDOMAIN-VIA-CNAME
* NODATA-VIA-CNAME
* MULT-CNAME
* LOOPED-CNAME-IN-ZONE-1
* LOOPED-CNAME-IN-ZONE-2
* LOOPED-CNAME-OUT-OF-ZONE

See [CNAME.md] for specification of the scenarios.


## zonemaster-cli commands and their output for each test scenario

Scenario name                | Expected output
:----------------------------|:---------------------------------------------------------------------------------------------
GOOD-CNAME-1                 | True
```
; <<>> DiG 9.18.18-0ubuntu0.22.04.1-Ubuntu <<>> @127.30.1.31 good-cname-1.cname.recursor.engine.xa
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 15606
;; flags: qr aa rd; QUERY: 1, ANSWER: 2, AUTHORITY: 1, ADDITIONAL: 1
;; WARNING: recursion requested but not available

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
; COOKIE: 0eb313f823f10bdc (echoed)
;; QUESTION SECTION:
;good-cname-1.cname.recursor.engine.xa. IN A

;; ANSWER SECTION:
good-cname-1.cname.recursor.engine.xa. 3600 IN CNAME good-cname-1-target.cname.recursor.engine.xa.
good-cname-1-target.cname.recursor.engine.xa. 3600 IN A	127.0.0.1

;; AUTHORITY SECTION:
cname.recursor.engine.xa. 3600	IN	NS	ns1.cname.recursor.engine.xa.

;; Query time: 0 msec
;; SERVER: 127.30.1.31#53(127.30.1.31) (UDP)
;; WHEN: Wed Nov 22 21:27:07 UTC 2023
;; MSG SIZE  rcvd: 299
```

Scenario name                | Expected output
:----------------------------|:---------------------------------------------------------------------------------------------
GOOD-CNAME-2                 | True
```
; <<>> DiG 9.18.18-0ubuntu0.22.04.1-Ubuntu <<>> @127.30.1.31 good-cname-2.cname.recursor.engine.xa
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 695
;; flags: qr aa rd; QUERY: 1, ANSWER: 3, AUTHORITY: 1, ADDITIONAL: 1
;; WARNING: recursion requested but not available

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
; COOKIE: 9219874eb4a37f1d (echoed)
;; QUESTION SECTION:
;good-cname-2.cname.recursor.engine.xa. IN A

;; ANSWER SECTION:
good-cname-2.cname.recursor.engine.xa. 3600 IN CNAME good-cname-2-target.cname.recursor.engine.xa.
good-cname-2-target.cname.recursor.engine.xa. 3600 IN A	127.0.0.1
good-cname-2-target.cname.recursor.engine.xa. 3600 IN A	127.0.0.2

;; AUTHORITY SECTION:
cname.recursor.engine.xa. 3600	IN	NS	ns1.cname.recursor.engine.xa.

;; Query time: 4 msec
;; SERVER: 127.30.1.31#53(127.30.1.31) (UDP)
;; WHEN: Wed Nov 22 21:28:01 UTC 2023
;; MSG SIZE  rcvd: 359
```

Scenario name                | Expected output
:----------------------------|:---------------------------------------------------------------------------------------------
GOOD-CNAME-CHAIN             | True
```
; <<>> DiG 9.18.18-0ubuntu0.22.04.1-Ubuntu <<>> @127.30.1.31 good-cname-chain.cname.recursor.engine.xa
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 48298
;; flags: qr aa rd; QUERY: 1, ANSWER: 4, AUTHORITY: 1, ADDITIONAL: 1
;; WARNING: recursion requested but not available

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
; COOKIE: 92cdff40d48d9bc4 (echoed)
;; QUESTION SECTION:
;good-cname-chain.cname.recursor.engine.xa. IN A

;; ANSWER SECTION:
good-cname-chain.cname.recursor.engine.xa. 3600	IN CNAME good-cname-chain-two.cname.recursor.engine.xa.
good-cname-chain-two.cname.recursor.engine.xa. 3600 IN CNAME good-cname-chain-three.cname.recursor.engine.xa.
good-cname-chain-three.cname.recursor.engine.xa. 3600 IN CNAME good-cname-chain-target.cname.recursor.engine.xa.
good-cname-chain-target.cname.recursor.engine.xa. 3600 IN A 127.0.0.1

;; AUTHORITY SECTION:
cname.recursor.engine.xa. 3600	IN	NS	ns1.cname.recursor.engine.xa.

;; Query time: 0 msec
;; SERVER: 127.30.1.31#53(127.30.1.31) (UDP)
;; WHEN: Wed Nov 22 21:28:47 UTC 2023
;; MSG SIZE  rcvd: 527
```

Scenario name                | Expected output
:----------------------------|:---------------------------------------------------------------------------------------------
GOOD-CNAME-OUT-OF-ZONE       | True
```
; <<>> DiG 9.18.18-0ubuntu0.22.04.1-Ubuntu <<>> @127.30.1.31 good-cname-out-of-zone.cname.recursor.engine.xa
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 63315
;; flags: qr aa rd; QUERY: 1, ANSWER: 1, AUTHORITY: 1, ADDITIONAL: 3
;; WARNING: recursion requested but not available

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
; COOKIE: 8764b78a2607dfdc (echoed)
;; QUESTION SECTION:
;good-cname-out-of-zone.cname.recursor.engine.xa. IN A

;; ANSWER SECTION:
good-cname-out-of-zone.cname.recursor.engine.xa. 3600 IN CNAME target.goodsub.cname.recursor.engine.xa.

;; AUTHORITY SECTION:
goodsub.cname.recursor.engine.xa. 3600 IN NS	ns1.goodsub.cname.recursor.engine.xa.

;; ADDITIONAL SECTION:
ns1.goodsub.cname.recursor.engine.xa. 3600 IN A	127.30.1.34
ns1.goodsub.cname.recursor.engine.xa. 3600 IN AAAA fda1:b2:c3:0:127:30:1:34

;; Query time: 0 msec
;; SERVER: 127.30.1.31#53(127.30.1.31) (UDP)
;; WHEN: Wed Nov 22 21:31:19 UTC 2023
;; MSG SIZE  rcvd: 386
```

```
; <<>> DiG 9.18.18-0ubuntu0.22.04.1-Ubuntu <<>> @127.30.1.34 target.goodsub.cname.recursor.engine.xa
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 13094
;; flags: qr aa rd; QUERY: 1, ANSWER: 1, AUTHORITY: 1, ADDITIONAL: 1
;; WARNING: recursion requested but not available

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
; COOKIE: 150e50a5d8ba5cfa (echoed)
;; QUESTION SECTION:
;target.goodsub.cname.recursor.engine.xa. IN A

;; ANSWER SECTION:
target.goodsub.cname.recursor.engine.xa. 3600 IN A 127.0.0.1

;; AUTHORITY SECTION:
goodsub.cname.recursor.engine.xa. 3600 IN NS	ns1.goodsub.cname.recursor.engine.xa.

;; Query time: 0 msec
;; SERVER: 127.30.1.34#53(127.30.1.34) (UDP)
;; WHEN: Wed Nov 22 21:34:13 UTC 2023
;; MSG SIZE  rcvd: 217
```

Scenario name                | Expected output
:----------------------------|:---------------------------------------------------------------------------------------------
NXDOMAIN-VIA-CNAME           | Undefined
```
; <<>> DiG 9.18.18-0ubuntu0.22.04.1-Ubuntu <<>> @127.30.1.31 nxdomain-via-cname.cname.recursor.engine.xa
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 34237
;; flags: qr aa rd; QUERY: 1, ANSWER: 1, AUTHORITY: 1, ADDITIONAL: 1
;; WARNING: recursion requested but not available

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
; COOKIE: dfcee7963f535f91 (echoed)
;; QUESTION SECTION:
;nxdomain-via-cname.cname.recursor.engine.xa. IN	A

;; ANSWER SECTION:
nxdomain-via-cname.cname.recursor.engine.xa. 3600 IN CNAME nxdomain-via-cname-target.cname.recursor.engine.xa.

;; AUTHORITY SECTION:
cname.recursor.engine.xa. 3600	IN	SOA	ns1.cname.recursor.engine.xa. root.cname.recursor.engine.xa. 2023111502 86400 14400 3600000 3600

;; Query time: 0 msec
;; SERVER: 127.30.1.31#53(127.30.1.31) (UDP)
;; WHEN: Wed Nov 22 21:55:26 UTC 2023
;; MSG SIZE  rcvd: 308
```

Scenario name                | Expected output
:----------------------------|:---------------------------------------------------------------------------------------------
NODATA-VIA-CNAME             | Undefined
```
; <<>> DiG 9.18.18-0ubuntu0.22.04.1-Ubuntu <<>> @127.30.1.31 nodata-via-cname.cname.recursor.engine.xa
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 32832
;; flags: qr aa rd; QUERY: 1, ANSWER: 1, AUTHORITY: 1, ADDITIONAL: 1
;; WARNING: recursion requested but not available

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
; COOKIE: 9ba3e3e19d477cce (echoed)
;; QUESTION SECTION:
;nodata-via-cname.cname.recursor.engine.xa. IN A

;; ANSWER SECTION:
nodata-via-cname.cname.recursor.engine.xa. 3600	IN CNAME nodata-via-cname-target.cname.recursor.engine.xa.

;; AUTHORITY SECTION:
cname.recursor.engine.xa. 3600	IN	SOA	ns1.cname.recursor.engine.xa. root.cname.recursor.engine.xa. 2023111502 86400 14400 3600000 3600

;; Query time: 4 msec
;; SERVER: 127.30.1.31#53(127.30.1.31) (UDP)
;; WHEN: Wed Nov 22 21:59:03 UTC 2023
;; MSG SIZE  rcvd: 302
```

Scenario name                | Expected output
:----------------------------|:---------------------------------------------------------------------------------------------
MULT-CNAME                   | Undefined and tag `CNAME_MULTIPLE_FOR_NAME`
```
; <<>> DiG 9.18.18-0ubuntu0.22.04.1-Ubuntu <<>> @127.30.1.31 mult-cname.cname.recursor.engine.xa
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 63988
;; flags: qr aa rd; QUERY: 1, ANSWER: 4, AUTHORITY: 0, ADDITIONAL: 1
;; WARNING: recursion requested but not available

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
; COOKIE: 9f3ce697902993cf (echoed)
;; QUESTION SECTION:
;mult-cname.cname.recursor.engine.xa. IN	A

;; ANSWER SECTION:
mult-cname.cname.recursor.engine.xa. 3600 IN CNAME mult-cname-target-1.cname.recursor.engine.xa.
mult-cname-target-1.cname.recursor.engine.xa. 3600 IN A	127.0.0.1
mult-cname.cname.recursor.engine.xa. 3600 IN CNAME mult-cname-target-2.cname.recursor.engine.xa.
mult-cname-target-2.cname.recursor.engine.xa. 3600 IN A	127.0.0.2

;; Query time: 0 msec
;; SERVER: 127.30.1.31#53(127.30.1.31) (UDP)
;; WHEN: Wed Nov 22 21:16:02 UTC 2023
;; MSG SIZE  rcvd: 382
```

Scenario name                | Expected output
:----------------------------|:---------------------------------------------------------------------------------------------
LOOPED-CNAME-IN-ZONE-1       | Undefined and tag `CNAME_LOOP_INNER`
```
; <<>> DiG 9.18.18-0ubuntu0.22.04.1-Ubuntu <<>> @127.30.1.31 looped-cname-in-zone-1.cname.recursor.engine.xa
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 30714
;; flags: qr aa rd; QUERY: 1, ANSWER: 10, AUTHORITY: 1, ADDITIONAL: 1
;; WARNING: recursion requested but not available

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
; COOKIE: cad349bcae7b7ae5 (echoed)
;; QUESTION SECTION:
;looped-cname-in-zone-1.cname.recursor.engine.xa. IN A

;; ANSWER SECTION:
looped-cname-in-zone-1.cname.recursor.engine.xa. 3600 IN CNAME looped-cname-in-zone-1.cname.recursor.engine.xa.
looped-cname-in-zone-1.cname.recursor.engine.xa. 3600 IN CNAME looped-cname-in-zone-1.cname.recursor.engine.xa.
looped-cname-in-zone-1.cname.recursor.engine.xa. 3600 IN CNAME looped-cname-in-zone-1.cname.recursor.engine.xa.
looped-cname-in-zone-1.cname.recursor.engine.xa. 3600 IN CNAME looped-cname-in-zone-1.cname.recursor.engine.xa.
looped-cname-in-zone-1.cname.recursor.engine.xa. 3600 IN CNAME looped-cname-in-zone-1.cname.recursor.engine.xa.
looped-cname-in-zone-1.cname.recursor.engine.xa. 3600 IN CNAME looped-cname-in-zone-1.cname.recursor.engine.xa.
looped-cname-in-zone-1.cname.recursor.engine.xa. 3600 IN CNAME looped-cname-in-zone-1.cname.recursor.engine.xa.
looped-cname-in-zone-1.cname.recursor.engine.xa. 3600 IN CNAME looped-cname-in-zone-1.cname.recursor.engine.xa.
looped-cname-in-zone-1.cname.recursor.engine.xa. 3600 IN CNAME looped-cname-in-zone-1.cname.recursor.engine.xa.
looped-cname-in-zone-1.cname.recursor.engine.xa. 3600 IN CNAME looped-cname-in-zone-1.cname.recursor.engine.xa.

;; AUTHORITY SECTION:
cname.recursor.engine.xa. 3600	IN	NS	ns1.cname.recursor.engine.xa.

;; Query time: 0 msec
;; SERVER: 127.30.1.31#53(127.30.1.31) (UDP)
;; WHEN: Wed Nov 22 21:42:06 UTC 2023
;; MSG SIZE  rcvd: 246
```


Scenario name                | Expected output
:----------------------------|:---------------------------------------------------------------------------------------------
LOOPED-CNAME-IN-ZONE-2       | Undefined and tag `CNAME_LOOP_INNER`
```
; <<>> DiG 9.18.18-0ubuntu0.22.04.1-Ubuntu <<>> @127.30.1.31 looped-cname-in-zone-2.cname.recursor.engine.xa
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 49961
;; flags: qr aa rd; QUERY: 1, ANSWER: 10, AUTHORITY: 1, ADDITIONAL: 1
;; WARNING: recursion requested but not available

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
; COOKIE: ae5d5bc049bae7b0 (echoed)
;; QUESTION SECTION:
;looped-cname-in-zone-2.cname.recursor.engine.xa. IN A

;; ANSWER SECTION:
looped-cname-in-zone-2.cname.recursor.engine.xa. 3600 IN CNAME looped-cname-in-zone-2-a.cname.recursor.engine.xa.
looped-cname-in-zone-2-a.cname.recursor.engine.xa. 3600	IN CNAME looped-cname-in-zone-2-b.cname.recursor.engine.xa.
looped-cname-in-zone-2-b.cname.recursor.engine.xa. 3600	IN CNAME looped-cname-in-zone-2-a.cname.recursor.engine.xa.
looped-cname-in-zone-2-a.cname.recursor.engine.xa. 3600	IN CNAME looped-cname-in-zone-2-b.cname.recursor.engine.xa.
looped-cname-in-zone-2-b.cname.recursor.engine.xa. 3600	IN CNAME looped-cname-in-zone-2-a.cname.recursor.engine.xa.
looped-cname-in-zone-2-a.cname.recursor.engine.xa. 3600	IN CNAME looped-cname-in-zone-2-b.cname.recursor.engine.xa.
looped-cname-in-zone-2-b.cname.recursor.engine.xa. 3600	IN CNAME looped-cname-in-zone-2-a.cname.recursor.engine.xa.
looped-cname-in-zone-2-a.cname.recursor.engine.xa. 3600	IN CNAME looped-cname-in-zone-2-b.cname.recursor.engine.xa.
looped-cname-in-zone-2-b.cname.recursor.engine.xa. 3600	IN CNAME looped-cname-in-zone-2-a.cname.recursor.engine.xa.
looped-cname-in-zone-2-a.cname.recursor.engine.xa. 3600	IN CNAME looped-cname-in-zone-2-b.cname.recursor.engine.xa.

;; AUTHORITY SECTION:
cname.recursor.engine.xa. 3600	IN	NS	ns1.cname.recursor.engine.xa.

;; Query time: 0 msec
;; SERVER: 127.30.1.31#53(127.30.1.31) (UDP)
;; WHEN: Wed Nov 22 21:42:52 UTC 2023
;; MSG SIZE  rcvd: 296
```


Scenario name                | Expected output
:----------------------------|:---------------------------------------------------------------------------------------------
LOOPED-CNAME-OUT-OF-ZONE     | Undefined and tag `CNAME_LOOP_OUTER`
```
; <<>> DiG 9.18.18-0ubuntu0.22.04.1-Ubuntu <<>> @127.30.1.31 looped-cname-out-of-zone.sub2.cname.recursor.engine.xa
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 54910
;; flags: qr rd; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 3
;; WARNING: recursion requested but not available

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
; COOKIE: 888e7ca1a80bc2f8 (echoed)
;; QUESTION SECTION:
;looped-cname-out-of-zone.sub2.cname.recursor.engine.xa.	IN A

;; AUTHORITY SECTION:
sub2.cname.recursor.engine.xa. 3600 IN	NS	ns1.sub2.cname.recursor.engine.xa.

;; ADDITIONAL SECTION:
ns1.sub2.cname.recursor.engine.xa. 3600	IN A	127.30.1.32
ns1.sub2.cname.recursor.engine.xa. 3600	IN AAAA	fda1:b2:c3:0:127:30:1:32

;; Query time: 0 msec
;; SERVER: 127.30.1.31#53(127.30.1.31) (UDP)
;; WHEN: Wed Nov 22 21:43:49 UTC 2023
;; MSG SIZE  rcvd: 281
```

```
; <<>> DiG 9.18.18-0ubuntu0.22.04.1-Ubuntu <<>> @127.30.1.32 looped-cname-out-of-zone.sub2.cname.recursor.engine.xa
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 23787
;; flags: qr aa rd; QUERY: 1, ANSWER: 1, AUTHORITY: 1, ADDITIONAL: 1
;; WARNING: recursion requested but not available

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
; COOKIE: 5c10d02a24f656d9 (echoed)
;; QUESTION SECTION:
;looped-cname-out-of-zone.sub2.cname.recursor.engine.xa.	IN A

;; ANSWER SECTION:
looped-cname-out-of-zone.sub2.cname.recursor.engine.xa.	3600 IN	CNAME looped-cname-out-of-zone.sub3.cname.recursor.engine.xa.

;; AUTHORITY SECTION:
sub2.cname.recursor.engine.xa. 3600 IN	NS	ns1.sub2.cname.recursor.engine.xa.

;; Query time: 0 msec
;; SERVER: 127.30.1.32#53(127.30.1.32) (UDP)
;; WHEN: Wed Nov 22 21:45:24 UTC 2023
;; MSG SIZE  rcvd: 293
```

```
; <<>> DiG 9.18.18-0ubuntu0.22.04.1-Ubuntu <<>> @127.30.1.31 looped-cname-out-of-zone.sub3.cname.recursor.engine.xa.
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 36301
;; flags: qr rd; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 3
;; WARNING: recursion requested but not available

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
; COOKIE: 63d0ce8b86dec736 (echoed)
;; QUESTION SECTION:
;looped-cname-out-of-zone.sub3.cname.recursor.engine.xa.	IN A

;; AUTHORITY SECTION:
sub3.cname.recursor.engine.xa. 3600 IN	NS	ns1.sub3.cname.recursor.engine.xa.

;; ADDITIONAL SECTION:
ns1.sub3.cname.recursor.engine.xa. 3600	IN A	127.30.1.33
ns1.sub3.cname.recursor.engine.xa. 3600	IN AAAA	fda1:b2:c3:0:127:30:1:33

;; Query time: 0 msec
;; SERVER: 127.30.1.31#53(127.30.1.31) (UDP)
;; WHEN: Wed Nov 22 21:46:29 UTC 2023
;; MSG SIZE  rcvd: 281
```

```
; <<>> DiG 9.18.18-0ubuntu0.22.04.1-Ubuntu <<>> @127.30.1.33 looped-cname-out-of-zone.sub3.cname.recursor.engine.xa.
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 51489
;; flags: qr aa rd; QUERY: 1, ANSWER: 1, AUTHORITY: 1, ADDITIONAL: 1
;; WARNING: recursion requested but not available

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
; COOKIE: 8782d3de032e92ce (echoed)
;; QUESTION SECTION:
;looped-cname-out-of-zone.sub3.cname.recursor.engine.xa.	IN A

;; ANSWER SECTION:
looped-cname-out-of-zone.sub3.cname.recursor.engine.xa.	3600 IN	CNAME looped-cname-out-of-zone.sub2.cname.recursor.engine.xa.

;; AUTHORITY SECTION:
sub3.cname.recursor.engine.xa. 3600 IN	NS	ns1.sub3.cname.recursor.engine.xa.

;; Query time: 0 msec
;; SERVER: 127.30.1.33#53(127.30.1.33) (UDP)
;; WHEN: Wed Nov 22 21:47:03 UTC 2023
;; MSG SIZE  rcvd: 293
```

To be completed.



[CNAME.md]:                            ../../../docs/public/specifications/test-zones/Engine/Recursor-PM/CNAME.md
[Recursor.pm]:                         https://github.com/zonemaster/zonemaster-engine/blob/master/lib/Zonemaster/Engine/Recursor.pm
