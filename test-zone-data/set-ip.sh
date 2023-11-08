#!/bin/bash

# Funktion för att lägga till IPv4-adresser
add_ipv4_address() {
  local ip=$1
  echo "Adding IPv4 address: $ip"
  sudo ip addr add $ip/32 dev lo
}

# Funktion för att lägga till IPv6-adresser
add_ipv6_address() {
  local ip=$1
  local ipv6=$(echo $ip | sed 's/\./:/g') # Konvertera punkter till kolon
  echo "Adding IPv6 address: fda1:b2:c3::$ipv6"
  sudo ip addr add fda1:b2:c3::$ipv6/128 dev lo
}

# Läs varje rad från markdown-filen
while IFS= read -r line; do
  # Använd regex för att filtrera ut IP-adresser utan "/24" eller liknande
  if [[ $line =~ ^\|\ ([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)\ +\| ]]; then
    ip_address=${BASH_REMATCH[1]}
    # Lägg till IP-adressen för både IPv4 och IPv6
    add_ipv4_address $ip_address
    add_ipv6_address $ip_address
  fi
done < "address-plan.md"

# Notera att du måste byta ut "din_markdown_fil.md" mot den faktiska filvägen till din markdown-fil.
