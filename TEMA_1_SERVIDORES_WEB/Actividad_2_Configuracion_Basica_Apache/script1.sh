#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Uso: $0 <puerto>"
    exit 1
fi

port=$1
file="/etc/apache2/ports.conf"

# Hago uso de grep -q por si encuentra una línea que corresponda no la muestre por pantalla.

if grep -q "Listen $port" "$file"; then
    echo "El puerto $port ya existe en $file"
else
    echo "Listen $port >> "$file"
    echo "Puerto $port añadido a $file"
fi
