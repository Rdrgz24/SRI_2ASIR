#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Uso: $0 <ip> <dominio>"
  exit 1
fi

ip=$1
domain=$2
file="/etc/hosts"

if grep -q "$domain" "$file"; then
  echo "El dominio $domain ya existe en $file"
else
  echo "$ip $domain" >> "$file"
  echo "Dominio $domain con dirección IP $ip añadidos."
fi