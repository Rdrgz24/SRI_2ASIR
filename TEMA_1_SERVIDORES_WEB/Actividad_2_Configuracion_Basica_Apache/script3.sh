#!/bin/bash

read -p "Introduce el título de la página -> " titulo
read -p "Introduce la cabecera de la página -> " cabecera
read -p "Introduce un mensaje a mostrar en la página -> " msg
read -p "Introduce el nombre del archivo para la web -> " file

web="/var/www/html/$file.html"

echo "<html>" > $web
echo "<head><title>$titulo</title></head>" >> $web
echo "<body>" >> $web
echo "<h1>$cabecera</h1>" >> $web
echo "<p>$msg</p>" >> $web
echo "</body></html>" >> $web

echo "Página creada en $web"