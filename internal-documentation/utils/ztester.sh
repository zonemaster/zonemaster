#!/bin/bash

OUTPUT='results'

TLDs=( `dig . axfr @xfr.lax.dns.icann.org | awk '$4=="NS" { print $1}' | sort -u` )

[ -d $OUTPUT ] || mkdir $OUTPUT

for tld in "${TLDs[@]}"
do
    if [ "$tld" == "." ]
    then
	continue
    fi
    CLEANTLD=$(echo $tld|tr -d '.\n')
    echo Testing $CLEANTLD
    zonemaster-cli --raw --level INFO $CLEANTLD > $OUTPUT/$CLEANTLD
done
