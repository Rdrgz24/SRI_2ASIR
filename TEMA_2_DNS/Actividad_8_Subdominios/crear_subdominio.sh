#!/bin/bash

# Validación de que se introduce el subdominio.
if [ -z "$1" ]; then
	echo "Uso $0 <subdominio>"
	echo "Ejemplo: $0 informatica"
	exit 1
fi

echo "Los subdominios de este script se crearán sobre el dominio marisma.intranet"

# Definimos variables fijas
DOMINIO="marisma.intranet"
RUTA="/etc/bind"
IP="192.168.195.27"
ZONA="/etc/bind/db.$DOMINIO"

# Definimos variables dinámicas
SUBDOMINIO=$1
ARCHIVO_INCLUDE="$RUTA/db.$SUBDOMINIO.$DOMINIO.hosts"

echo "Creando el subdominio $SUBDOMINIO.$DOMINIO..."

# Aquí creamos el archivo include e insertamos sus registros
# Uso de cat <<EOF > ... EOF porque nos ahorra tantos echo.

echo "Creando registros dentro de $ARCHIVO_INCLUDE"
cat <<EOF > $ARCHIVO_INCLUDE
; Registros para $SUBDOMINIO
\$ORIGIN $SUBDOMINIO.$DOMINIO.
@	IN	A	$IP
www	IN	A	$IP
ftp	IN	A	$IP
smtp	IN	A	$IP
EOF

# Vinculamos el archivo include con la zona principal usando la directiva $INCLUDE.

# Si ya existe, lo menciona, y tendrías que usar otro subdominio.
if grep -q "$ARCHIVO_INCLUDE" "$ZONA"; then
	echo "El subdominio ya está incluido en la zona padre."
# De lo contrario, si no existe, lo crea con la sentencia INCLUDE.
else
	echo "Añadiendo \$INCLUDE a $ZONA"
	echo "$INCLUDE $ARCHIVO_INCLUDE" >> "$ZONA"
	# Aplicamos los cambios reiniciando.
	systemctl restart bind9
	echo "Subdominio $SUBDOMINIO creado y BIND9 reiniciado."
fi
