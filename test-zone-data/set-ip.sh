#!/bin/bash

set -u

# This script will read address-plan.md and extract registered IPv4 addresses.
# From the extracted IPv4 address the matching IPv6 address is created.
#
# Since loopback (lo) is already configured with 127.0.0.0/8 there is no need
# to the configure the loopback interface with the IPv4 addresses for the test
# zones (all are within 127.0.0.0/8).
#
# The IPv6 addresses are configured on the loopback interface (lo) with this
# script. If the address is already configured, an error message is outputted by
# ip(), but can be ignored.


usage() { echo "Usage: sudo $0" 1>&2;
          echo 1>&2;
          exit 1; }

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

# Get path of this script
path=$(dirname $0)


# address-plan.md must be in the same folder as this script
datafile="$path/address-plan.md"


# Function to add IPv4 address
add_ipv4_address() {
  local ip=$1
  cmd="ip addr add $ip/32 dev lo"
  echo -n "Adding $ip : "
  $cmd && echo "added"
}


# Function to add IPv6 address
add_ipv6_address() {
  local ip=$1
  local ipv6=$(echo $ip | sed 's/\./:/g') # Convert colon to dot
    cmd="ip addr add fda1:b2:c3::$ipv6/128 dev lo"
    echo -n "Adding fda1:b2:c3::$ipv6 : "
    $cmd && echo "added"
}


# Read every line in the data file (markdown)
while IFS= read -r line; do
  # Get IP addresses without prefix (e.g. /24)
  if [[ $line =~ ^\|\ ([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)\ +\| ]]; then
      ip_address=${BASH_REMATCH[1]}
      # Add address for IPv4
      add_ipv4_address $ip_address
      # Add address for IPv6
      add_ipv6_address $ip_address
  fi
done < $datafile


# An alternative approach is to run the following two commands to make all IPv6
# addresses in the /64 range be available.
#
# $ sudo ip -6 route add to local fda1:b2:c3::/64 dev lo
# $ sudo sysctl -w net.ipv6.ip_nonlocal_bind=1
#
# Migration to that approach should be combined with an update of the  address
# plan file (address-plan.md) and probably combined with specific address plans
# with each test case.
