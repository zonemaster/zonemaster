#!/usr/bin/env python3

"""
Fetched 2024-09-25 from https://gist.github.com/wido/4c6288b2f5ba6d16fce37dca3fc2cb4a.
Pulished by by Wido den Hollander.

Updated by Mats Dufberg 2024-09-25 to read one line (a DNSKEY RR) from standard input.
"""

"""
Generate a DNSSEC DS record based on the incoming DNSKEY record

The DNSKEY can be found using for example 'dig':

$ dig DNSKEY secure.widodh.nl

The output can then be parsed with the following code to generate a DS record
for in the parent DNS zone

Author: Wido den Hollander <wido@widodh.nl>

Many thanks to this blogpost: https://www.v13.gr/blog/?p=239
"""

import struct
import base64
import hashlib
import sys
import re

data = sys.stdin.readlines()
line = data[0]
line.rstrip()

if re.match("([a-zA-Z0-9.-]+).+DNSKEY[ \t](.*)", line):
    # print("True matched")
    parts = re.compile("([a-zA-Z0-9.-]+).+DNSKEY[ \t](.*)").split(line)
    # print(parts)
else:
    print("ERROR no match")
    sys.exit()
    
DOMAIN = parts[1]
DNSKEY = parts[2]


def _calc_keyid(flags, protocol, algorithm, dnskey):
    st = struct.pack('!HBB', int(flags), int(protocol), int(algorithm))
    st += base64.b64decode(dnskey)

    cnt = 0
    for idx in range(len(st)):
        s = struct.unpack('B', st[idx:idx+1])[0]
        if (idx % 2) == 0:
            cnt += s << 8
        else:
            cnt += s

    return ((cnt & 0xFFFF) + (cnt >> 16)) & 0xFFFF


def _calc_ds(domain, flags, protocol, algorithm, dnskey):
    if domain.endswith('.') is False:
        domain += '.'

    signature = bytes()
    for i in domain.split('.'):
        signature += struct.pack('B', len(i)) + i.encode()

    signature += struct.pack('!HBB', int(flags), int(protocol), int(algorithm))
    signature += base64.b64decode(dnskey)

    return {
        'sha1':    hashlib.sha1(signature).hexdigest().upper(),
        'sha256':  hashlib.sha256(signature).hexdigest().upper(),
    }


def dnskey_to_ds(domain, dnskey):
    dnskeylist = dnskey.split(' ', 3)

    flags = dnskeylist[0]
    protocol = dnskeylist[1]
    algorithm = dnskeylist[2]
    key = dnskeylist[3].replace(' ', '')

    keyid = _calc_keyid(flags, protocol, algorithm, key)
    ds = _calc_ds(domain, flags, protocol, algorithm, key)

    ret = list()
    ret.append(str(keyid) + ' ' + str(algorithm) + ' ' + str(1) + ' '
               + ds['sha1'].lower())
    ret.append(str(keyid) + ' ' + str(algorithm) + ' ' + str(2) + ' '
               + ds['sha256'].lower())
    return ret


print(dnskey_to_ds(DOMAIN, DNSKEY))
