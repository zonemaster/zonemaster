#!/bin/bash

set -u

# Make sure you can be root or run sudo
if ! sudo echo ; then
    echo "You must be able to be root via sudo"
fi

usage() { (echo "Usage: $0" 1>&2;
           echo
           echo "Start CoreDNS for Zonemaster test zone environment" 
           echo )1>&2;
          exit 1;
        }

while getopts "h" o; do
    case "${o}" in
        h)
            usage
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

# Get path to this script
path=$(dirname $0)

# Go to the directory of the script
cd $path || exit 1

# main.cfg must be in the same folder as this script
maincfg="main.cfg"

# Is CoreDNS already running? One instance at a time.
if ps --no-headers -fC coredns | grep coredns ; then
    echo "Only one instance of CoreDNS must be run at a time."
    echo "Kill old instances or break with CTRL-C."
    echo
    sudo killall -s 9 -i coredns
    sleep 2
fi

if ps --no-headers -fC coredns | grep coredns ; then
    echo "Cannot start CoreDNS since it is already running. Exit."
else
    sudo coredns --conf ${maincfg}
fi


