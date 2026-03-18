#!/usr/bin/env python3
import sys
import os

# Realizamos comprobaciones
if len(sys.argv) != 2:
	print("Uso: sudo crear_subdominio.py <subdominio>")
	sys.exit(1)

# Variables fijas
DOMINIO = "marisma.intranet"
RUTA = "/etc/bind"
IP = "192.168.195.27"
ZONA = f"{RUTA}/db.{DOMINIO}"

def crear_subdominio(insercion):
	subdominio = insercion
	archivo_sub = f"{RUTA}/db.{subdominio}.hosts"

	# Contenido de archivo de registros subdominio
	contenido = f"""\
 ; Registros para {subdominio}
 $ORIGIN {subdominio}.{DOMINIO}.
 @	IN	A	$IP
 www	IN	A	$IP
 ftp	IN	A	$IP
 smtp	IN	A	$IP
"""
	# Creamos el archivo con los registros
#	print(f"Creando el archivo.") Era contradictorio pintar este mensaje por pantalla, ya que si el subdominio existe, no puede crearlo.
# 	Se podría completar una excepción que hiciese una comprobación previa, y en base a eso crease una archivo.
	with open(archivo_sub, "w") as f:
		f.write(contenido)

	# Definimos directiva INCLUDE para no repetirla múltiples veces
	dir_inc = f"$INCLUDE {archivo_sub}"

	# Hacemos comprobaciones en base a si el subdominio ya existe en la zona padre o no.
	contiene = 0
	if os.path.exists(ZONA):
		with open(ZONA, "r") as f:
			if dir_inc in f.read():
				contiene = 1

	# Si está dentro, lo indicamos, de lo contrario, insertamos la directiva include dentro de la zona principal.
	if contiene == 0:
		print(f"Vinculando {subdominio} en zona principal.")
		with open(ZONA, "a") as f:
			f.write(f"\n{dir_inc}")
		print("Reiniciando bind9.")
		os.system("sudo systemctl restart bind9")
		print(f"Subdominio {subdominio} creado y bind9 reiniciado.")
	else:
		print(f"El subdominio {subdominio} ya está creado.")

crear_subdominio(sys.argv[1])
