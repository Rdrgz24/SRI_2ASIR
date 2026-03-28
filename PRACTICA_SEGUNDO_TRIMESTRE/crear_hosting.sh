#!/bin/bash

# Comprobación inicial para verificar sintaxis del comando introducido

if [ $# -ne 2 ]; then # Si los argumentos pasados tras $0 son menores que 2...
	echo "Error de sintaxis. Uso: sudo bash $0 usuario contraseña" # Muestra por pantalla el error y como debe usarse.
	exit 1 # Nos salimos del script para no continuarlo.
fi

# Variables fijas
usuario=$1 # El primer argumento pertenece al usuario y lo recogemos en la variable
pass=$2 # El segundo argumento pertenece a la contraseña y lo recogemos en la variable
ip="192.168.195.5" # Dirección IP del servidor guardada
dominio="hosting2asir.intranet" # Dominio que aloja el servidor
subdominio="$usuario"."$dominio" # Subdominio que se forma en parte al nombre del usuario y el dominio que aloja el servidor
# Estructura de archivos por subdominio
dir_principal="/var/www/html/$usuario" # Estructura principal y privada del usuario
dir_publico="$dir_principal/public_html" # Estructura publica del usuario
dir_logs="$dir_principal/logs" # Estructura de eventos del usuario

#Estructura de archivos DNS
dns_directa="/etc/bind/db.$dominio" # Asignamos el archivo de zona DNS directa en la variable
dns_inversa="/etc/bind/db.192.168.195" # Asignamos el archivo de zona DNS inversa en la variable

# 1. Creación del usuario y directorios
echo "Creando usuario de sistema y carpetas:" # Indicamos que se creará el usuario y carpetas

# Creamos el usuario con su directorio home en la carpeta del hosting
useradd -m -d "$dir_principal" -s /bin/bash "$usuario" # -m permite asignar el directorio home del usuario y con -d el directorio a asignar
# con -s indicamos el shell que usará el usuario, en este caso bin/bash y por último el nombre del usuario.

# Asignamos la contraseña de forma segura con chpasswd usando el operador Here-string (<<<) para
# insertar la variable directamente, evitando que la pwd sea visible en la lista de procesos.
chpasswd <<< "$usuario:$pass" # Metemos dentro de chpasswd con nombre de usuario y su contraseña, luego se hashea

# Crear lista de carpetas
mkdir -p "$dir_publico" # Creamos la carpeta indicada en la variable dir_publico
mkdir -p "$dir_logs" # Creamsos la carpeta indicada en la variable dir_logs

# Archivos por defecto HTML y PHP
echo "<h1>Bienvenido al subdominio $subdominio</h1>" > "$dir_publico/index.html" # Metemos dentro del archivo index.html un encabezado de bienvenida identificativo
echo "<?php phpinfo(); ?>" > "$dir_publico/info.php" # Metemos dentro del archivo info.php la sintaxis para ver la información de PHP del servidor

# Script Python WSGI
cat <<EOF > "$dir_principal/app.wsgi" # Indicamos donde se insertará el siguiente contenido dentro de app.wsgi
def application(environ, start_response): # Ambos parámetros que se recogerán
	status = '200 OK' # Status 200 OK en variable
	output = b'App de Python WSGI en $subdominio' # Salida que mostrará dentro de la web
	response_headers = [('Content-type', 'text/plain'), ('Content-Length', str(len(output)))] # Indicando las cabeceras el tipo de texto y salida.
	start_response(status, response_headers) # Indicamos respuesta de estado y cabeceras
	return [output] # Retornamos la respuesta
EOF # Cerramos EOF

chown -R "$usuario":"$usuario" "$dir_principal" # Cambio de propietario recursivo en base al usuario insertado y su directorio principal
chmod -R 755 "$dir_principal" # Cambio de permisos recursivo en el directorio principal

# 2. Configuración DNS
echo "Actualizando registros DNS" # Mostramos que se insertarán registros DNS
echo "$usuario IN A $ip" >> "$dns_directa" # Insertamos el texto introducido en echo (subdominio IN A ip_servidor) hacia archivo zona DNS directa.
echo "5 IN PTR $subdominio." >> "$dns_inversa" # Insertamos el texto introducido en echo (5 IN PTR subdominio) hacia archivo zona DNS inversa.

systemctl restart bind9 # Reiniciamos servicio DNS

# 3. Configuración Apache (HTTP/s + Python)
echo "Creando VirtualHosts 80 y 443" # Mostramos que se crearán los VirtualHosts
conf_file="/etc/apache2/sites-available/$usuario.conf" # Indicamos el archivo de configuración que tendrá cada subdominio ($usuario.conf)

cat <<EOF > "$conf_file" # Indicamos donde se insertará el contenido dentro del archivo de configuración
<VirtualHost *:80> # Host virtual por puerto 80, solo redirigirá al 443
	ServerName $subdominio # Indicamos nombre del servidor
	ServerAlias www.$subdominio # Indicamos su Alias
	DocumentRoot $dir_publico # Indicamos el DocumentRoot, donde guardará info publica del servidor

	# Redirección para forzar HTTPS
	RewriteEngine on # Habilitamos Rewrite
	RewriteCond %{HTTPS} off # Indicamos HTTPS off dentro de HTTP
	RewriteRule ^(.*)$ https://%{HTTP_POST}%{REQUEST_URI} [L,R=301] # Regla para sobreescribir con redirección 301 cuando se haga petición HTTP
</VirtualHost>

<VirtualHost *:443> # Host virtual por puerto 443 (HTTPS)
	ServerName $subdominio # Indicamos nombre del servidor
	ServerAlias www.$subdominio # Indicamos su Alias
	DocumentRoot $dir_publico # Indicamos el DocumentRoout, guarda información del servidor (hasta ahora index.html e info.php)

	SSLEngine on # Habilitamos SSL
	SSLCertificateFile /etc/ssl/certs/ssl-cert-snakeoil.pem # Indicamos la clave pública de certificado SSL
	SSLCertificateKeyFile /etc/ssl/private/ssl-cert-snakeoil.key # Indicamos la clave privada de certificado SSL

	# Soporte Python WSGI apuntando a raíz del usuario
	WSGIScriptAlias /py $dir_principal/app.wsgi # Redirección de /py hacia $dir_principal/app.wsgi

	<Directory $dir_publico> # Directorio principal del sitio
		AllowOverride All # Permite sobreescritura
		Require all granted # De manera predeterminada todo permitido
	</Directory>

	ErrorLog $dir_logs/error.log # Indicamos el archivo log
	CustomLog $dir_logs/access.log combined # Indicamos archivo log personalizado
</VirtualHost>
EOF

a2enmod rewrite > /dev/null # Ya está habilitado pero mejor prevenir que curar
a2ensite "$usuario.conf" > /dev/null # Habilitamos archivo de configuración del usuario
systemctl restart apache2 # Restablecemos el servicio de apache para aplicar cambios

# 4. Configuración de la base de datos
echo "Creando la Base de datos y usuario SQL" # Mostrar por pantalla que se hará
db="${usuario}_db" # Guardar dentro de la variable db como se llamará la Base de datos de cada usuario

mysql -u rafael -p'PWD5QL5€CURe' <<EOF # Nos conectamos con el usuario Rafael y su contraseña, usamos EOF para escribir por multi línea
CREATE DATABASE IF NOT EXISTS \`$db\`; # Usamos \` por tema de sintaxis con EOF, de lo contrario deberíamos usar echo con -e
CREATE USER IF NOT EXISTS '$usuario'@'localhost' IDENTIFIED BY '$pass'; # Creamos el usuario si no existe, identificado con su contraseña
GRANT ALL PRIVILEGES ON \`$db\`.* TO '$usuario'@'localhost'; # Permitimos todos los privilegios sobre su base de datos al usuario
FLUSH PRIVILEGES; # Recargamos privilegios
EOF

echo "HOSTING PARA $usuario creado con éxito." # Si todo se completa, indica creado.
echo "Acceso web: https://$subdominio" # Mostramos el acceso web
echo "Carpeta pública: $dir_publico" # Mostramos la carpeta pública
echo "Carpeta de logs: $dir_logs" # Mostramos carpeta de logs
# Aquí se podría añadir echo Usuario para SSH y SFTP: $usuario , pero lo podemos descartar porque se puede intuir
