#!/bin/bash

set -u

# Temporary cfg file used in this script
tmpmaincfg=".temp-coredns-main-scenario.cfg"

# Lagacy main.cfg must be in the same folder as this script
maincfg="main.cfg"

usage() { (echo "Start CoreDNS for Zonemaster test zone environment"
	   echo
	   echo "Usage:"
	   echo "  sudo $0 SCENARIO-CFG [SCENARIO-CFG]"
	   echo "  sudo $0"
           echo
	   echo "Example:"
	   echo "  sudo $0 DNSSEC-TP/dnssec05/dnssec05.cfg"
           echo
	   echo "The second usage loads the legacy main.cfg"
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

# Make sure the script is run by  root
if [ $(id -u) -ne 0 ] ; then
    echo "You must be root." 1>&2
    echo "Run 'sudo $0'" 1>&2
    exit 1
fi

# Get path to this script
path=$(dirname $0)

# Go to the directory of the script
cd $path || exit 1

# Clean the "$tmpmaincfg"
if [ -e $tmpmaincfg ]; then
   rm -f $tmpmaincfg || exit 1
fi

# Make it exist
touch $tmpmaincfg
	
if [ -n "$*" ]; then

    for cfg in "$@"; do
	if [ "${cfg: -4}" == ".cfg" ]; then
	    echo "import $cfg" >> $tmpmaincfg
	else
	    echo "Not a cfg file: $cfg" >&2
	    exit 1
	fi
    done
else
    echo "The legacy $maincfg will be used, which might be what you"
    echo "want. If the scenarios that you want to start are using"
    echo "stand-alone cfg file"
    echo
    read -p "Press return to continue or break with CTRL-C"

    echo "import $maincfg" >> $tmpmaincfg
fi

# Is CoreDNS already running? One instance at a time.
if ps --no-headers -fC coredns | grep coredns ; then
    echo "Only one instance of CoreDNS must be run at a time."
    echo "Kill old instances or break with CTRL-C."
    echo
    killall -s 9 -i coredns
    sleep 2
fi

if ps --no-headers -fC coredns | grep coredns ; then
    echo "Cannot start CoreDNS since it is already running. Exit."
else
    coredns --conf $tmpmaincfg
    rm $tmpmaincfg
fi

