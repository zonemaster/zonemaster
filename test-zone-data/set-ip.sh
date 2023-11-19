#!/bin/bash

set -u

# This script will read address-plan.md and extract registered IPv4 addresses.
# From the extracted IPv4 the matching IPv6 address is created. All addresses
# are configured on the loopback interface (lo). If the address is already
# configured, a  message is outputted by ip().

# Make sure you can be root or run sudo
if ! sudo echo ; then
    echo "You must be to be root via sudo"
fi


usage() { echo "Usage: $0 [-o] [-v]" 1>&2;
          echo 1>&2;
          echo "-o  only output to standard output the command to add the address" 1>&2;
          echo "-v  be verbose when adding the address" 1>&2;
          exit 1; }

printstdout=false
verbose=false
while getopts "ov" o; do
    case "${o}" in
        o)
            printstdout=true
            ;;
        v)
            verbose=true
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))


# Get path to this script
path=$(dirname $0)


# address-plan.md must be in the same folder as this script
datafile="$path/address-plan.md"


# Function to add IPv4 address
add_ipv4_address() {
  local ip=$1
  cmd="sudo ip addr add $ip/32 dev lo"
  if $printstdout; then
      echo $cmd
  else
      if $verbose; then
          echo "Adding IPv4 address: $ip"
      fi
      $cmd
  fi
}


# Function to add IPv6 address
add_ipv6_address() {
  local ip=$1
  local ipv6=$(echo $ip | sed 's/\./:/g') # Convert colon to dot
    cmd="sudo ip addr add fda1:b2:c3::$ipv6/128 dev lo"
  if $printstdout; then
      echo $cmd
  else
      if $verbose; then
          echo "Adding IPv6 address: fda1:b2:c3::$ipv6"
      fi
      $cmd
  fi  
}


# Read every line in the data file (markdown)
while IFS= read -r line; do
  # Get IP addresses without prefix (e.g. /24)
  if [[ $line =~ ^\|\ ([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)\ +\| ]]; then
    ip_address=${BASH_REMATCH[1]}
    # Add address for both IPv4 and IPv6
    add_ipv4_address $ip_address
    add_ipv6_address $ip_address
  fi
done < $datafile


